Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE35ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 04:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A69B20850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 04:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNWwzLEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A69B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeGVFEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 01:04:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44850 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeGVFEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 01:04:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so9852255pgp.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 21:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aBOWGGXGmvztX84ZmUncjhf4sYbh7PlwPrB43J3sytg=;
        b=VNWwzLExN7TFYKlFsmv0zw6PoolefqG9QdHi0jGJda9/ZuHgLsrzT/Oh8CH6HsEepI
         xQSgZ3gXG+viHJ947UWmBWzZztMSTgzy9YdEeTeh+lE/GA82oSeNJD5VI8M32BD4CEKi
         1blwid6E6XR8HBbLo4GrXAc/UHTRJ210iYmoCSpPR8bB7h1kbxM7yTFnNsmuhnWhti1t
         V4GMdM2gW4yQPCoPN2qsgjWbpGpDzhqnISheur63L+U+UcGA1MaQnLnJPgewQVMTgpWA
         TSc2rSG5tb3BNOAxLxeLdi8auYADU1khKlX7HKlIkBlEEHwVtP78veS9FVYWCMtmlFOA
         nmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aBOWGGXGmvztX84ZmUncjhf4sYbh7PlwPrB43J3sytg=;
        b=Rf3lpZygdGyjv8cEUMxFFgSRraYIqOYYvYnUt/Sp2sJDfcW28pdvyg8eS6iDu3ID5K
         aVr6o31ahAY2bEAIpnr9TVEKUatpcWK7BiPtAxlXynd6eF3LDQ+kSaIsZ4uV0hLqq1BO
         LaFbh5lsTaYZOJDA7SlsDXFJNfMnk6TVptRc8E6n1WRLSyPv3kwfeHEl0m61YmlX2VUE
         zXj5b0EnpAvMK65pxI+HnY9FV+/aNmm6QNFTLW66CG+Zmn+6vfte1UeaWnwAQuiK+XjK
         6qUzDyStc+Bwg+6R2d+PdzFO0G4RzxHaPjX8eRPEciC0Vd1m446ZeKoSt7rB//THyDEi
         5fjw==
X-Gm-Message-State: AOUpUlHFHsE4OLK1Ay1qY67xv4WGKV7Kf4TSiIf2vTdm/h7VRP4Qfycy
        vVXmxObhXLjNvFZCSeq5e1Q=
X-Google-Smtp-Source: AAOMgpdihngz6F2+tDbvU94/m7fVEYkFBOLPLaW9Cb0rgXQmcOhERQGCfOucrCHTECZQBi/PJVBm5A==
X-Received: by 2002:a65:6688:: with SMTP id b8-v6mr7630336pgw.24.1532232565723;
        Sat, 21 Jul 2018 21:09:25 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id b76-v6sm8823593pfj.184.2018.07.21.21.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 21:09:25 -0700 (PDT)
Date:   Sun, 22 Jul 2018 09:39:17 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Lidza Louina <lidza.louina@gmail.com>,
        Mark Hounschell <markh@compro.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: dgnc: dgnc_tty.c: Avoid '(' at the end of line
Message-ID: <20180722040912.GA18833@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring the first argument to the previous line and
align the other lines to match open parenthesis.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/dgnc/dgnc_tty.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index 9f9b9a5b4b27..2135bedc09db 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -883,10 +883,9 @@ static int dgnc_tty_open(struct tty_struct *tty, struct file *file)
 	 * touched safely, the close routine will signal the
 	 * ch_flags_wait to wake us back up.
 	 */
-	rc = wait_event_interruptible(
-				ch->ch_flags_wait,
-				(((ch->ch_tun.un_flags |
-				ch->ch_pun.un_flags) & UN_CLOSING) == 0));
+	rc = wait_event_interruptible(ch->ch_flags_wait,
+				      (((ch->ch_tun.un_flags |
+				      ch->ch_pun.un_flags) & UN_CLOSING) == 0));
 	/* If ret is non-zero, user ctrl-c'ed us */
 	if (rc)
 		return -EINTR;
-- 
2.17.1

