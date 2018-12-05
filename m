Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DAAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EA820850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="BSdb992T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EA820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeLEHnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:43:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37585 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:43:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so9663397plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZC4/m7gibONJZQJdomibLyw3V43dGO6FJLcqsmgjvFQ=;
        b=BSdb992TUd6eLoDLUnqLudsJMwHnK0vjXXOrwMNSL9u61/6SfDbivyEjMfasB+0jhq
         d4xHSxROqOUf9CaDt5JUP5CM0EmZ2yEiEQeaNDkJSOYR6XqzwqsQ3vQ35xHC5WQctfE5
         30Rqfk1+KssaFrRfQDz3QnWbd7lWLPTIIPVINUAVisqm8TlnQhvZgmctPLWQo3AynXDa
         KuHk2ufy2Unlw4HpAdXCvMDNrXOxOXa1uoYEJAf2CYoxOPzVzW6/1/jyekKApZjgsK0W
         c5FdjMnmeC5HkQZlNywgye+96/U/e3Yqf038HI+J7n2bApFydQxEUmT8GT6MkBRnv0t5
         mOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZC4/m7gibONJZQJdomibLyw3V43dGO6FJLcqsmgjvFQ=;
        b=BObcGKIGVS7LhVmDHkFnpkW3scyVyflGWSZiY0GD1gj0npfUNHsmaz05CA5Qwurz/k
         Dfk4LgV+qerkM34poKp22qKpj+W4QbDTHRL6ccQ6oF9VtnapihlYc2raC2jFBJ7oYIOz
         8Taf+fPMpxsvTxPwkvriwGsrMBNvDMya4BLq5/mRXYo+CVEWFzoCAQZys6Wwn2yFjwvD
         rvkztysdrORoJB0IbAEPBG+ji/APzxQ80WyV+P/DM5+RFhBmK+GYFK6S+wmoTM1HKVAa
         d1gC/BZJCwf5gMDZ8uJ+q9E2VF7/uXwOzgYfErLPkSiZraUks6P9tFvhqN7DfMu0SePg
         0Nkw==
X-Gm-Message-State: AA+aEWbB62XA1ht1gy9XeIW0S3g2qEWMvqTUxScrwgZYJnnMhsJqgigR
        3P1LmQKZU0HF1ZJfZrZze1zzwQ==
X-Google-Smtp-Source: AFSGD/VJig05yuX+xTdWONwX3Qkd+jUAkIPqoeWuP6TCQJeI5QkzA08y3o/wFoJg6p4WyO9ov0vjOg==
X-Received: by 2002:a17:902:a98c:: with SMTP id bh12mr23334449plb.31.1543995817606;
        Tue, 04 Dec 2018 23:43:37 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id m76sm22473535pfi.102.2018.12.04.23.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 23:43:37 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 3/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN with ALC294
Date:   Wed,  5 Dec 2018 15:42:12 +0800
Message-Id: <20181205074212.31104-4-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181205074212.31104-1-jian-hong@endlessm.com>
References: <20181205074212.31104-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS UX433FN with ALC294 cannot detect the headset MIC and output
through the internal speaker and the headphone until
ALC294_FIXUP_ASUS_SPK_NOISE quirk applied.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5c25c8c3f703..56925140bfe6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7180,6 +7180,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK_NOISE,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},
-- 
2.11.0

