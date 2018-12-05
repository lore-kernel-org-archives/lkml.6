Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81025C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EE82082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="f8unKR4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EE82082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeLEHmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:42:42 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:32824 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:42:41 -0500
Received: by mail-pf1-f182.google.com with SMTP id c123so9604703pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=lfIwC6ncGlmtl/Fno9DDDKFg1OnyPdrU8NXn/tIFhnE=;
        b=f8unKR4TXNkpvpjpE8YHdibmVnOWDHrh4F9fFLGaejwsHuxa9hmrmVFZZLYpx9H6Kk
         uncCxgMEx3VQX1eVAZyhzhFTAIpdw5FoWMU7Jk6O6o3r+wTZS5gkIhgvLPczt7MlNzbQ
         OR3punuthaZsOWzq0mrapz1JOnJ40vgHQ86dfCG4zJg8tU6odzEK+WPCJrPQNd63KaNB
         /hgGptMz5xQavxVnXKEekrWu1rAnpBV4iiXe1Sb1aPVEj0KEOhefzrYyk/Mqf0HPttAh
         C5QZW1Ma97qpxlptIJevzW+r/m5JG4uVSyyDec+Snvi9XlLxarnPFIvVvEE4eGT3BJgn
         0qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lfIwC6ncGlmtl/Fno9DDDKFg1OnyPdrU8NXn/tIFhnE=;
        b=LqApqK99/SzQrtVkMdd38iYOXlnaR5XdC1QTMmSj7qu2J8FxRMO5xKKLvDyV2J/OWr
         UG+GTrVzXKMNFLx7LS103Neg2YN14/NjBAhuRT1u2JqYmqBeUMcFZkuYrbNIA5iAFVqa
         B3tEHCTYPn6Fg9cZH4pMMCq/+F+jGZgoP0KjyFlYciMVMaep5D8G6doa/qv31wQuYx/l
         5QvHABDs0XLSVmzhT01kBlgbI4ujeOuBnPe0aI4aXhJ2hCqOboTUEfHie4sKMK4zOm6t
         Z0yhsN6CoRUIjoH4v12fSXCFWbGEqvA69ffM7D0SmRNFf3G1L70sZhJuVZITeWjD8obd
         cd9Q==
X-Gm-Message-State: AA+aEWa5bOJZ3alNoad8Xm7BOaW+IfRW2/zejD577/rCiYd8fAb9+Z6C
        cy6RBJwLXzE1gifkhKMn/xfA2Q==
X-Google-Smtp-Source: AFSGD/UkdK6kIxwci6g4/VMAbF6Fzmq8eGu9XcFsZpf8GEL2wZTCDbtNVSx6ZGYAkBHrUnJJRoUgtg==
X-Received: by 2002:a63:c141:: with SMTP id p1mr19491237pgi.424.1543995760597;
        Tue, 04 Dec 2018 23:42:40 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id m76sm22473535pfi.102.2018.12.04.23.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 23:42:40 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 0/3] Add ALC294 quirks for ASUS laptops
Date:   Wed,  5 Dec 2018 15:42:09 +0800
Message-Id: <20181205074212.31104-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Realtek ALC294 quirks for ASUS X542UN, UX533FD and UX433FN laptops.

Chris Chiu (1):
  ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN

Jian-Hong Pan (2):
  ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
  ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN with ALC294

 sound/pci/hda/patch_realtek.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
2.11.0

