Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834749-2-3392384329163731428
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834748; b=JXKzoMG/uQrh7B9kUnaB6vT6QHrV8IvoSwConR2b1+CScef
    +KZbSg+ZU2AiT/fSK6RIVR/Tc01UKDtejachcHhhvcebQLX0P4uNWh6ugpy4cO23
    rlUqSd1uS9uDHP9qtrvM31lLMKPZiwSXEHzU8u/AV2jNClVtnLyjgvlbsseNDS3T
    ZmQd9OiFagU9Q+nTZH9pVWZ0dqCgYBRLI3I3DA5oUjA7d5WoxltD7d/0dsmm1mkr
    FlR9nOApOCkXjZ3oEQHrd7gP8xJl5Rct06se//ezbJhl11QNLuu1zge4ACgSjojr
    yiJSilwpSGBR7YQh1ryia6M6132qkzHU+ui0abg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834748; bh=/TYXvv1t3uys3i3ppEB
    ogh91oWERLtfuidIWCYLGKuE=; b=mO55qjvupulL33cKZSenSZisX6zqse5Bl0a
    VlWjLrkm5Q3gavYzC2nbIL4MAADRkHoISV/pCGsRdoJm3k/XY9/Db3cBGdqPLYv9
    TuC7LVMC4hIC/wK0khQp0XJfgct6QlTKsnwx/+9zaBknK8zndNaZAvenGWDCgUrI
    wbL4/vdg7cbCGzCsMUjYv2EJRJgkr1tXxXrxxU9mlu03UaNCckfDqH9Jf6NCuaVV
    FhpG5pPfrw+f9lq6LKtrndsSQGkzrOZJUPayKXYUomP8I6rOhpmZGHU6ZPxUygFu
    28qFV/zKOhb0SWFOc3wBVgJ42/pJ6daCmXYq2cD5z6RVPrxmF8w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935047AbeB1QSC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:18:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35282 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932298AbeB1QSA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:18:00 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "Nicolin Chen" <nicoleotsuka@gmail.com>,
        "Mark Brown" <broonie@kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.586924437@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 015/254] ASoC: fsl_ssi: AC'97 ops need regmap, clock
 and cleaning up on failure
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

commit 695b78b548d8a26288f041e907ff17758df9e1d5 upstream.

AC'97 ops (register read / write) need SSI regmap and clock, so they have
to be set after them.

We also need to set these ops back to NULL if we fail the probe.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/soc/fsl/fsl_ssi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1273,12 +1273,6 @@ static int fsl_ssi_probe(struct platform
 				sizeof(fsl_ssi_ac97_dai));
 
 		fsl_ac97_data = ssi_private;
-
-		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
-		if (ret) {
-			dev_err(&pdev->dev, "could not set AC'97 ops\n");
-			return ret;
-		}
 	} else {
 		/* Initialize this copy of the CPU DAI driver structure */
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
@@ -1336,6 +1330,14 @@ static int fsl_ssi_probe(struct platform
 			goto error_irqmap;
 	}
 
+	if (fsl_ssi_is_ac97(ssi_private)) {
+		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+		if (ret) {
+			dev_err(&pdev->dev, "could not set AC'97 ops\n");
+			goto error_ac97_ops;
+		}
+	}
+
 	ret = snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
 					 &ssi_private->cpu_dai_drv, 1);
 	if (ret) {
@@ -1400,6 +1402,10 @@ error_irq:
 	snd_soc_unregister_component(&pdev->dev);
 
 error_asoc_register:
+	if (fsl_ssi_is_ac97(ssi_private))
+		snd_soc_set_ac97_ops(NULL);
+
+error_ac97_ops:
 	if (ssi_private->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
