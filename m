Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519832088-2-15509430811093179306
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832088; b=BuJv9PdXT7mfzmRpPdUAPmGYApv3NtM53dyzrOw5VnLcjcE
    dyTa4SIfQf9IulwpPRnz7D9AIoY8S4Ep77wQ/Nt4113TlwqM9k+ISD//+AcZAysS
    cJgYt1XtAgGkNYYDeMo9L3PIKr6RgLwng5h3af90oXVTii0Z1gdSiHLY2dHtUBaP
    yGMxxF+Q/mtT6EY6l9NiW+jyOmYh+PaOFNhMF2dcdRF+wVKsnmLMqyCMVFXsLyIz
    SoH/IddWaFqwTYU9x0b0oJQif93+Mk0Y/CZVU9OwhHaJnmWDeZnqQA5ZOgi8YVmp
    +yTfNyK5O1BUZMrBGE6gMBsftJdMP88E+INYA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832088; bh=mzHMqXJ+a75z/meapzE
    mh0/KO+4/Qpn3XwsRS02Dcv0=; b=KpNmG13kCM/lCEXK4HVclYynF8bZRNla1yW
    QaZafhQC3P9oEZ7P1np/j3iz+iABwFyN0F53HZmM/AtdGPeKCVa7+JlZeRNuxKsg
    /V1cDfUDZoMYFofeokHknhfsLpq/6k+B9UMtRI7Z7Lq+PH+bWGz0jiUR1a+Ljfdk
    +zXiAh+6IYx5VuP+jBgDGGOjmj/qf5XsQxtQj13oNcfvc57Ww28IGwzDwqrgi3TP
    SN6OnhOgnXqaJ0JzsaWUrNOi/VS3vZIHSWLNlEzSdzeiL0P0OtMStL0Wodkm4+vH
    4Q4U39vW5sYLOwRFmqicshV49Nj61Hp8PY/aTP/isDqz6ysNVIQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933126AbeB1Peo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:34:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33296 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752814AbeB1PWg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:36 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "Mark Brown" <broonie@kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.902311745@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 014/254] ASoC: fsl_ssi: add AC'97 ops setting check
 and cleanup
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

commit 04143d614f3af84a3f39e79a24a7ca740bd39efd upstream.

Check whether setting AC'97 ops succeeded and clean them
on removal so the fsl_ssi driver can be reloaded.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/soc/fsl/fsl_ssi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1274,7 +1274,11 @@ static int fsl_ssi_probe(struct platform
 
 		fsl_ac97_data = ssi_private;
 
-		snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+		if (ret) {
+			dev_err(&pdev->dev, "could not set AC'97 ops\n");
+			return ret;
+		}
 	} else {
 		/* Initialize this copy of the CPU DAI driver structure */
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
@@ -1422,6 +1426,9 @@ static int fsl_ssi_remove(struct platfor
 	if (ssi_private->use_dma)
 		irq_dispose_mapping(ssi_private->irq);
 
+	if (fsl_ssi_is_ac97(ssi_private))
+		snd_soc_set_ac97_ops(NULL);
+
 	return 0;
 }
 
