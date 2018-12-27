Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19257C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D0F20873
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LeVxv/m/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeL0S7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:59:01 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57252 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeL0S7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:59:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id CFE3CD9C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 18:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hXj4Et6FkK0A for <linux-kernel@vger.kernel.org>;
        Thu, 27 Dec 2018 12:58:58 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 3B162D82
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 12:58:12 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id o22so23498345iob.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 10:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hUY2R81IpkxDQV+VP8dNZeYfbpjuKWDQGlzYigVB7HE=;
        b=LeVxv/m/JnwXJsy7LjT4XvlbjtPdB46ZMma3aL13jGK4XzvQ8vU2xk8gMzuvmZv6hw
         EZZwQlIvWe9yEwCwJ5k96k62PDAnFMxWE269wxFpTEWs9lnrxUnKHwzBLrVcwxakMlMo
         JkwSrRcnfJb9rsey07UtNn+lzvR6E+Y/DsyPmDX6joYh9zI3Asa8imsqnlEyE/ixIoNN
         nlrWzox0uIzCqHf8706hMC2Wy6VNzxJwFpipreIT4J+T7c4u8J0NyWbEW9tnNouzz5WF
         Jnyah8lEqqlp08O4NYiVufkrfSNnqGer3M57LVir3mWEk0zSK49WwKqZBc0Z+sMtyNCm
         b6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hUY2R81IpkxDQV+VP8dNZeYfbpjuKWDQGlzYigVB7HE=;
        b=DS/c5KNVpwbDlBGpSyto1VlnNIulLn1ej09nyMijzjDoxFcFGlmTU4EradnEI9hbJk
         K4+553KeM2U7t+WiNEDxGedHcqRA4sNUboCh9JregedxM7pf8VoDf2uSszdaDpyys4j8
         6mB7R+HNcV6B0v8m635xIhJROUTIUc5zVEsMaL/IVwl9AAawwClswOBJJXKLu06iAcJk
         qRe4uo8ovjA5JmCQcYCTqBBv30pSoiK27iKqXVKlSoy23xxzN2E/k1avpLd0cLBTZSZ3
         v8kRePHbc73drGagBRL4ka35409Wl54o9g26Y5nwP1TiEvVMb6ypCYT4ZNNBJTNmCXhU
         p+8g==
X-Gm-Message-State: AA+aEWaOWgFKeJfiwZAINZ6vwydaZ5sHJb3NnSGFdgS24DsuNCX4FW0I
        +vI9spbLyYS9mYCpdBPtlm5K3RCq/lwtXYYoG5zve33+Lxn964rjejHtFDHZjTOOsXRiugXp38r
        q+DZK8V8F5P91q/gX68Z7kX9I5/MD
X-Received: by 2002:a24:9307:: with SMTP id y7mr16295297itd.38.1545937091802;
        Thu, 27 Dec 2018 10:58:11 -0800 (PST)
X-Google-Smtp-Source: AFSGD/V9qzz4f+wJfWaRkvH94ZQr6kQ905CNwOQ4Ma56gBT6+ROr1k19eFUg1H+xN7qaeBe25/xviA==
X-Received: by 2002:a24:9307:: with SMTP id y7mr16295289itd.38.1545937091545;
        Thu, 27 Dec 2018 10:58:11 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id q14sm13609003itb.36.2018.12.27.10.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 10:58:11 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb: Add check on sp8870_readreg
Date:   Thu, 27 Dec 2018 12:58:01 -0600
Message-Id: <20181227185802.24213-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sp8870_set_frontend_parameters, the function sp8870_readreg
may return an error when i2c_transfer fails. The fix checks for
this error and returns upstream consistent with other invocations.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/media/dvb-frontends/sp8870.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/sp8870.c b/drivers/media/dvb-frontends/sp8870.c
index 8d31cf3f4f07..270a3c559e08 100644
--- a/drivers/media/dvb-frontends/sp8870.c
+++ b/drivers/media/dvb-frontends/sp8870.c
@@ -293,7 +293,9 @@ static int sp8870_set_frontend_parameters(struct dvb_frontend *fe)
 	sp8870_writereg(state, 0xc05, reg0xc05);
 
 	// read status reg in order to clear pending irqs
-	sp8870_readreg(state, 0x200);
+	err = sp8870_readreg(state, 0x200);
+	if (err)
+		return err;
 
 	// system controller start
 	sp8870_microcontroller_start(state);
-- 
2.17.1

