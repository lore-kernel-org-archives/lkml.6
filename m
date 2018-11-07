Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB52C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220582081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9pdVTgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220582081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeKGTGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:06:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKGTGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:06:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so6269920wrr.0;
        Wed, 07 Nov 2018 01:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQGegao9zNeFUWhEcMMURli/nhZvxVqW1koxmyGrXEs=;
        b=u9pdVTgB1+KoAklw347BeovvNFFyRpuBjjvL54JdBIpbpWjq560Tzz2Atr0HQlc3uP
         KOfiPW77/VCl7O/vnVqyCjLxmwwIoBLZmbgN106cvjm2C1SilVAofnmUlKynAxk2hDoU
         0mEVDNlfxs+9WrRI88GPZiviIyVGhUII6jRTlvy7SLi2DOAkXBMxW91ZNsvlwiHqGVKK
         BFHa2QYbuU7537x4j7Gqxq129bzewEBRGgEjYW3CrIPMnbxACEwwtfauhtnsbd9RnNfk
         Z590jFzGSESYpj6DUDcAl1gehWMncmllfsWv3uX49oM/ij2ZgdsOF9a+dXzcKtwR0UXv
         v0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQGegao9zNeFUWhEcMMURli/nhZvxVqW1koxmyGrXEs=;
        b=oBT1cENtly9TkUypin5bdetfQCKqaWDWNYBCpemZH8Tj74I9hw51gaW85CHUOcUvkT
         JnhDO0MYMwZDiIJw2RzMUQINS5EPKFNFsjg+4OeFPunFuCRIqPcrLSJRNPfXmNoUjJl8
         vexBPkwDCs67yvZgYBjnpjaXrA1ZhlkqGSZCv82KRIO1vazfy7+U2DF1RneMbjwH01Fd
         3ELhDitVMlInTr1/2ySDmbmv1TLoNxuSoakd9as3TvWXs8F6e2xAESQDfsOFbO9Jjc+q
         43rPoEKhGAbGICsubqlegHinjVpsAeZgCYuK89NWkGo809AD9omGK0p0vhNEXOZtmS6v
         Xe/Q==
X-Gm-Message-State: AGRZ1gIB1RfivZf84G8qX/sNIEzoPgo0j+lPN1lO1/KJda1uvVIPxrIw
        fxv3gF1OEpDNGR8x+J+Ks9XypulLjsZ+hQ==
X-Google-Smtp-Source: AJdET5drwXab/UEhDMYfmw58fDV+uGLRgdSLJ+0I0HBQb9IwUNjGBBn7wZ9PGmAvN/txsP+i+VFNjg==
X-Received: by 2002:adf:8919:: with SMTP id s25-v6mr1099830wrs.44.1541583400877;
        Wed, 07 Nov 2018 01:36:40 -0800 (PST)
Received: from cperon-Latitude-7490.devialet.com (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id c14-v6sm350206wmh.44.2018.11.07.01.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 01:36:40 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suji Velupillai <suji.velupillai@broadcom.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
Date:   Wed,  7 Nov 2018 10:36:13 +0100
Message-Id: <20181107093613.26734-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107093613.26734-1-peron.clem@gmail.com>
References: <20181107093613.26734-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suji Velupillai <suji.velupillai@broadcom.com>

When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
return false, this prevents the backlight being turn on at boot time.

Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 09a95aeb3a70..d991d53c4b38 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -108,8 +108,8 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 	ndelay(400);
 }
 
-static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+static int __pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			 int duty_ns, int period_ns, bool pwmc_enabled)
 {
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
 	u64 val, div, rate;
@@ -155,7 +155,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * always calculated above to ensure the new values are
 	 * validated immediately instead of on enable.
 	 */
-	if (pwm_is_enabled(pwm)) {
+	if (pwm_is_enabled(pwm) || pwmc_enabled) {
 		kona_pwmc_prepare_for_settings(kp, chan);
 
 		value = readl(kp->base + PRESCALE_OFFSET);
@@ -173,6 +173,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    int duty_ns, int period_ns)
+{
+	return __pwmc_config(chip, pwm, duty_ns, period_ns, false);
+}
+
 static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				  enum pwm_polarity polarity)
 {
@@ -216,8 +222,8 @@ static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		return ret;
 	}
 
-	ret = kona_pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
-			       pwm_get_period(pwm));
+	ret = __pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
+			    pwm_get_period(pwm), true);
 	if (ret < 0) {
 		clk_disable_unprepare(kp->clk);
 		return ret;
-- 
2.19.1

