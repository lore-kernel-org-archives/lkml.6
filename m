Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1F10AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9822208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6IbUw42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9822208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755356AbeFNNvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:51:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35414 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754912AbeFNNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:51:53 -0400
Received: by mail-pf0-f196.google.com with SMTP id c22-v6so3289978pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2ZzX8dTvjPdCp7FNvAwTTTiJERDlJcWWXgpZ/dPXD58=;
        b=O6IbUw427ELPmDFk8MqBFBCdGGlPVUvZe1EzUJbqQD+nHyEMMlS8NM1h+4HSnDAlGF
         x82fVpXDimR7b53gDr1HoxvTWdkDsKMYRxQDqaXUm41HkGJyvTY3IfRnxXHmPCpmVIhQ
         04f36T9yV7LOP2iMl89K83D4JrrqlJBVbYt2N/1z0ELGtwbFdVdtd12zNcuuIIp4ijb/
         rUexpULvlQLP5FREMx6J5VRosk43FAIhtiEIMEieIa3Y0rnrdQMr2SdxzCPKFVZyw6/8
         4BKw03Xd6dyI/PCplzstqecpc7JIBfsvVwoZpsUUHk2+qoaVIhSZBzhYQpSD9acmDPdy
         lrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ZzX8dTvjPdCp7FNvAwTTTiJERDlJcWWXgpZ/dPXD58=;
        b=BRNQCEpzbT/3rGS9MNi3tMr0qcgYPpx128Jta4fy3LHJ67HJfx0OedoItkWKVpfpkY
         zzl72tqByCNAOhEWT/Zxh5s4s0PcPSIlhVDDndXa+bhsNtnOOxv+sl7W2uwU6vKB6sWH
         Jm9RLLghUOiia4wo5yighsKuQb59DnoXk1CKookqqSLM/C8JTzM3uvrqGGwyYXlq5H4R
         3oxFqqB/3tyCcAYi7hqOfzvQnQtoW58EPF9HxZsbyRJqWbhMlluEhkQNVDSYsNTDnY+i
         5DjJSsKE9F4sxSn6WPr7qTzvplSWXLE+iYUwuzQIq05zZgWUl0smVBUxQSVKeqMLUCeJ
         tcHg==
X-Gm-Message-State: APt69E3gOSqKqGfwj5NOyfZiTqSIWB9D9gDOH0CIaHr6FovC7TzvIWzM
        Z8mSjRZTLtb1pgQ2dBLpOMqTihVu5yE=
X-Google-Smtp-Source: ADUXVKKgLgzyVz547mQUoq3ZewixEB3CyYzQFJeyW0RqK1c8u+63HcHZoEFP0Q5Wkx4csNybKiStkQ==
X-Received: by 2002:a65:5348:: with SMTP id w8-v6mr2449300pgr.247.1528984313128;
        Thu, 14 Jun 2018 06:51:53 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id n76-v6sm12746749pfg.98.2018.06.14.06.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 06:51:52 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: lx6464es: add error handling for pci_ioremap_bar
Date:   Thu, 14 Jun 2018 21:51:46 +0800
Message-Id: <1528984308-53122-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528773796-37922-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528773796-37922-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pci_ioremap_bar fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pci_ioremap_bar.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Add new goto label.
---
 sound/pci/lx6464es/lx6464es.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 9655b08..6c85f13 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1016,6 +1016,10 @@ static int snd_lx6464es_create(struct snd_card *card,
 
 	/* dsp port */
 	chip->port_dsp_bar = pci_ioremap_bar(pci, 2);
+	if (!chip->port_dsp_bar) {
+		dev_err(card->dev, "cannot remap PCI memory region\n");
+		goto remap_pci_failed;
+	}
 
 	err = request_threaded_irq(pci->irq, lx_interrupt, lx_threaded_irq,
 				   IRQF_SHARED, KBUILD_MODNAME, chip);
@@ -1055,6 +1059,9 @@ static int snd_lx6464es_create(struct snd_card *card,
 	free_irq(pci->irq, chip);
 
 request_irq_failed:
+	iounmap(chip->port_dsp_bar);
+
+remap_pci_failed:
 	pci_release_regions(pci);
 
 request_regions_failed:
-- 
2.7.4

