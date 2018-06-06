Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iSIMA0w4GFsjZAAAmS7hNA
	; Wed, 06 Jun 2018 19:38:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 23304608B8; Wed,  6 Jun 2018 19:38:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/SQzCsG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F9C76074D;
	Wed,  6 Jun 2018 19:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F9C76074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeFFTi4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:38:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36982 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbeFFTiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:38:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id d8-v6so7517419wro.4;
        Wed, 06 Jun 2018 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W8zl4Wx3N0wx2PwRCFxcbADdVeCY6GFY62lJyH1HFmQ=;
        b=o/SQzCsGc2LsZsWTxf14hTh+1BRvQ5zE7yDbxXnYHLbev6rdbH+pulLLQXjqudx6gJ
         Ht68HEs8oPLvdg7clQclk0FdQEWXYamrpz9+157rgrq6dREt9FVvCw40yolj3y+69/CU
         sJUdPMLThzX7Xp8Bav5S/IA8snTO51GOLOXd5vqHHqKDhD73MHAyG9+RoDNoXNRB1Cyn
         oC4w0mx4HhP+x3sCGBMXn3zwPcoOaZpIO/R2ma94xBe6Q6lGumT4oFolwLrk08G6c2s4
         lccS1AhU86KSwyt1/HgkZDe+8VKqfpJKJRI3EsvXYACHG0K5FuI4va147zmorbxC6iY4
         fwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=W8zl4Wx3N0wx2PwRCFxcbADdVeCY6GFY62lJyH1HFmQ=;
        b=Mx2BdBFDHeLNaf3AhjNtJdEUf2cJUtxV2hfDYLqS9oTc6RGSMU5x8AaUcCt5uza8id
         QT589rXzNH32M8UkB7m0ZjVp2ndwTyBVGc4VqK1uAL5uwXdJmAgzNMZ+fmiIOcMQZqKx
         f/JsiBm72AwC+CJxYveFc18Vnuwt7ef+vDXvThnOvVvg6QN1U0aWkYY3lJrr/mZCAAOw
         KmRQrrQxXF603cayLqC+viA6HXNvvAeG+A3Az2xwo9jeeJiYhkjVEFuwpXKjfeTijcLm
         0cJm+ei8vI/ee+2EQdBMp5v9zkx4iyR8RI8CHKjbMUSvH08dUOaqKbwcqFRdsFwoKkvg
         Q2eQ==
X-Gm-Message-State: APt69E2cc1kktWijubNylcx6hH61JmwS4YPyp5/Wkg27Zl71clrcs2+T
        493FssJqasuIdaMN3I4oJ9U=
X-Google-Smtp-Source: ADUXVKKAEVz4/yN2Qa/o7Hs76/9Ter7c4hegB0if2tXjfQENkBThCE7XB/+3Qg5f2f903a7rSOOe+A==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr3567029wrd.61.1528313899213;
        Wed, 06 Jun 2018 12:38:19 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id f24-v6sm3609046wmc.0.2018.06.06.12.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:38:18 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id A039910C2B80; Wed,  6 Jun 2018 21:38:17 +0200 (CEST)
From: Mathieu Malaterre <malat@debian.org>
To: James Hogan <jhogan@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 2/3] MIPS: Ci20: Enable SND_JZ4740_SOC driver
Date: Wed,  6 Jun 2018 21:38:09 +0200
Message-Id: <20180606193811.16007-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180606193811.16007-1-malat@debian.org>
References: <20180606193811.16007-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Ci20's defconfig to enable the JZ4780's SND driver.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/configs/ci20_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index e1c14f6af824..0c08c7675b42 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -104,6 +104,10 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DEBUG=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_JZ4740_SOC=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-- 
2.11.0
