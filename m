Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411753-2-237556195160917530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411752; b=fG3P1BHFwaMErae1RuUrm/VT2OIVzFFU5g4jFgSG8DC36pk
    GeoWvucITgNBHS+V9cwZ4tXoDVgfOzzl/r9Kri+OmydIjV8pAw4WlqvfoABRPGUx
    s3khGFz51bNuc1vIiPEk4p69emazy7XX+Y2A0Ci6f/03UaXd+m62E7d5kKCKaA2T
    +Z8v3efVRMQktEubQxW4R+rnKO/01rgSkJqWo+sSWa0DTEycBKr6MzvY1GDfWmKT
    tbC4LKQkgt/28gcjKFbq5rZlC9Q5FsEQynkbsDA/uDfPDxjAIwiMJb1KjCFQHINN
    iEfUVGm3d8Wx5N9bkyyRJLWuyDCdOymbW/Q9mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411752; bh=o+6mAg6OVndRH6ssaav5B89yew
    rWKAJtQHg8NkHQ+Hs=; b=aLZ35Tzs7LFbtUd8RcyDhwhlwRBzbLwi+b0YWIrYVI
    S6Jhi8admu4zJTwIzb607Aaz3IF5YAO8w6cDGram7qaEw4aZIeR5PEtb/UR58DAv
    MjYqFGTxqmjPYGj8ry0BcqPEVk42eIDWoxHlIRXqXMj9IUgzIrVvd7JGuY3Y6CiH
    shgY8BI4RPrC7p89sn8zs6ZKOHphtHYv2C24oZc8XNEk+/Mbd1AULbMCtvUiB0a6
    1XKBxpZaJFNo7X9fyfrKcSz2qgKS5hilzzTvGn/vC7ESIJb4rGoxUug7pz/iorr7
    iKEAUHwVkG+Peu6n7UfpCOeZno7z3he1j4aFXxXYePDg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934025AbeBWStJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933827AbeBWStH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 127/145] [media] tc358743: fix register i2c_rd/wr functions
Date: Fri, 23 Feb 2018 19:27:13 +0100
Message-Id: <20180223170741.251305784@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3538aa6ecfb2dd727a40f9ebbbf25a0c2afe6226 upstream.

While testing with CONFIG_UBSAN, I got this warning:

drivers/media/i2c/tc358743.c: In function 'tc358743_probe':
drivers/media/i2c/tc358743.c:1930:1: error: the frame size of 2480 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

The problem is that the i2c_rd8/wr8/rd16/... functions in this driver pass
a pointer to a local variable into a common function, and each call to one
of them adds another variable plus redzone to the stack.

I also noticed that the way this is done is broken on big-endian machines,
as we copy the registers in CPU byte order.

To address both those problems, I'm adding two helper functions for reading
a register of up to 32 bits with correct endianess and change all other
functions to use that instead. Just to be sure we don't get the problem
back with changed optimizations in gcc, I'm also marking the new functions
as 'noinline', although my tests with gcc-7 don't require that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/tc358743.c |   46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -193,57 +193,61 @@ static void i2c_wr(struct v4l2_subdev *s
 	}
 }
 
-static u8 i2c_rd8(struct v4l2_subdev *sd, u16 reg)
+static noinline u32 i2c_rdreg(struct v4l2_subdev *sd, u16 reg, u32 n)
 {
-	u8 val;
+	__le32 val = 0;
 
-	i2c_rd(sd, reg, &val, 1);
+	i2c_rd(sd, reg, (u8 __force *)&val, n);
 
-	return val;
+	return le32_to_cpu(val);
+}
+
+static noinline void i2c_wrreg(struct v4l2_subdev *sd, u16 reg, u32 val, u32 n)
+{
+	__le32 raw = cpu_to_le32(val);
+
+	i2c_wr(sd, reg, (u8 __force *)&raw, n);
+}
+
+static u8 i2c_rd8(struct v4l2_subdev *sd, u16 reg)
+{
+	return i2c_rdreg(sd, reg, 1);
 }
 
 static void i2c_wr8(struct v4l2_subdev *sd, u16 reg, u8 val)
 {
-	i2c_wr(sd, reg, &val, 1);
+	i2c_wrreg(sd, reg, val, 1);
 }
 
 static void i2c_wr8_and_or(struct v4l2_subdev *sd, u16 reg,
 		u8 mask, u8 val)
 {
-	i2c_wr8(sd, reg, (i2c_rd8(sd, reg) & mask) | val);
+	i2c_wrreg(sd, reg, (i2c_rdreg(sd, reg, 2) & mask) | val, 2);
 }
 
 static u16 i2c_rd16(struct v4l2_subdev *sd, u16 reg)
 {
-	u16 val;
-
-	i2c_rd(sd, reg, (u8 *)&val, 2);
-
-	return val;
+	return i2c_rdreg(sd, reg, 2);
 }
 
 static void i2c_wr16(struct v4l2_subdev *sd, u16 reg, u16 val)
 {
-	i2c_wr(sd, reg, (u8 *)&val, 2);
+	i2c_wrreg(sd, reg, val, 2);
 }
 
 static void i2c_wr16_and_or(struct v4l2_subdev *sd, u16 reg, u16 mask, u16 val)
 {
-	i2c_wr16(sd, reg, (i2c_rd16(sd, reg) & mask) | val);
+	i2c_wrreg(sd, reg, (i2c_rdreg(sd, reg, 2) & mask) | val, 2);
 }
 
 static u32 i2c_rd32(struct v4l2_subdev *sd, u16 reg)
 {
-	u32 val;
-
-	i2c_rd(sd, reg, (u8 *)&val, 4);
-
-	return val;
+	return i2c_rdreg(sd, reg, 4);
 }
 
 static void i2c_wr32(struct v4l2_subdev *sd, u16 reg, u32 val)
 {
-	i2c_wr(sd, reg, (u8 *)&val, 4);
+	i2c_wrreg(sd, reg, val, 4);
 }
 
 /* --------------- STATUS --------------- */
@@ -1236,7 +1240,7 @@ static int tc358743_g_register(struct v4
 
 	reg->size = tc358743_get_reg_size(reg->reg);
 
-	i2c_rd(sd, reg->reg, (u8 *)&reg->val, reg->size);
+	reg->val = i2c_rdreg(sd, reg->reg, reg->size);
 
 	return 0;
 }
@@ -1262,7 +1266,7 @@ static int tc358743_s_register(struct v4
 	    reg->reg == BCAPS)
 		return 0;
 
-	i2c_wr(sd, (u16)reg->reg, (u8 *)&reg->val,
+	i2c_wrreg(sd, (u16)reg->reg, reg->val,
 			tc358743_get_reg_size(reg->reg));
 
 	return 0;
