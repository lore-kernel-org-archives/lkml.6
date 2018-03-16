Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3511991-1521221417-2-15653804940681108361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221417; b=o3exEetpQHOYXhclJHOI8bBXmwpyi7PFIBDeUq+8j1gRoIm
    wH7trYf4vnj1w2Z37fAfuTrrL4vOe1tZILcNGqyKk8LqeKxpJy8I3AvnNx6Yf03c
    32Qfjwp3B1qtUxSPSRgDSnQ21+iZxn9Jz2Jvz1zDVMjwwAWygsvl0Ru01BPluOpb
    3b2WSLOaDRJLvRA9IQqpHtu2SQlsiJNig2ZTYUZIPnJ9x99ZGW1PnrLPTSm8c/64
    4kLchN+99QGoB8oQgwaaogRXS66pcbizMHfuYHVui5irkzeTdE9QfKE1j1Bgm09a
    KwFbTFCrWTA1K9B+dw+ejhLmX3asWG6DUGROizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221417; bh=m6+dKC10BqRw2plHGeP8d+HrPA
    VC3fnYwLVQXBa9nmA=; b=eS818QQmdCCu6sxSKQqYGttAAzFuP7AuFGtgcgqi8Q
    l+IvVxLgNZ+jG8FWqFYpCncAELbWWSqf9VHT92yz9ztRu+ZzdYup32WtQQm5mqV2
    FTQfZPw7l4DOgAd7E/coO3beeStMFQ0qMX8GqCzVakbAYq5cJMDvkIEbjURawKri
    VvWmdr2unapWl0mI2eoOkgPchQLVXbvYBLyQZ/knPncS9HsGKh4ozCFWy1bsQyPI
    28fARQiJ/TNnqwnHpSEBRV2vo8rpjTl0qfReCsnHEiQqvGtjXW/Iy5dDnwK0gOi2
    5hEHvtTnVY9Ckyutdp4AGtICGhpB9lUj8cxgpxKTSpCQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753917AbeCPP2D (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:28:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754270AbeCPP2B (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:28:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hansverk@cisco.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 33/63] [media] tc358743: fix register i2c_rd/wr function fix
Date: Fri, 16 Mar 2018 16:23:05 +0100
Message-Id: <20180316152303.724604381@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Zabel <p.zabel@pengutronix.de>

commit f2c61f98e0b5f8b53b8fb860e5dcdd661bde7d0b upstream.

The below mentioned fix contains a small but severe bug,
fix it to make the driver work again.

Fixes: 3538aa6ecfb2 ("[media] tc358743: fix register i2c_rd/wr functions")

Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/tc358743.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -226,7 +226,7 @@ static void i2c_wr8(struct v4l2_subdev *
 static void i2c_wr8_and_or(struct v4l2_subdev *sd, u16 reg,
 		u8 mask, u8 val)
 {
-	i2c_wrreg(sd, reg, (i2c_rdreg(sd, reg, 2) & mask) | val, 2);
+	i2c_wrreg(sd, reg, (i2c_rdreg(sd, reg, 1) & mask) | val, 1);
 }
 
 static u16 i2c_rd16(struct v4l2_subdev *sd, u16 reg)
