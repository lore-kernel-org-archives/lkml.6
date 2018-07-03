Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A545320BED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FWY182z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A545320BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbeGCPGI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:06:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55243 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbeGCPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:06:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so2708121wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7TSCTNqQpCTde+7FxvLMaUN2dEMiap7Gp9KYFohEo8c=;
        b=FWY182z4g2+/sOayX9g5kL32HAX09WDZfm+fkxTzQRqak9JnQ0rDCh6C23bvCnhSET
         VR8bd8g7utR9wrAW0lx0VGrwHLbgFLSuc3UZR6bNBhkKadmIb+zP83fwusVgdt+OTZPB
         6UjgCTlky0UMeD89Q8vOWUov3YEtPPjPmBGP4eTs+My4r56oi+hhJdVaAdw28A1eCrdf
         jz+ihLcjvlXY7hUEH5tgAtgDe1giXAnaFxXS1dLTAxt8VRVNMe7zs9g+ADhrDQ52ZmOD
         g6QRjg+rxKMR8uPJM2dTS/k5F/T2/A3nQkG5etZNx6CiPRcTxA4qi4XSNiDiX+lnKTFv
         cBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7TSCTNqQpCTde+7FxvLMaUN2dEMiap7Gp9KYFohEo8c=;
        b=LufleSOoiyJVdhyT2UKICspFBo774+BGe684bhptQk+SwcrY5tZSnphFh7qh4f6Mov
         qhikjJOum/KmnBR5rcTiG+fdvDeO/2lINbE04y/CewF1L9mOnnzIb8II3oQPxLiOOAKg
         QQEYguOYtkkpAbh4kVr8NoE72mpA+u3QGSyBiNOB7BLknaeg1h7QpSYw7hoyUU/ZNaK2
         yDHE1OQhl9TlVtZGHsQllkUdVIXqFV7392ypS6lRgOXnabryHW1dPQYFV6mguVwKhxGw
         o6uVo4o9mM48JIK96GNJEFXr2Nk+GSmzSVNA4hTFSsLwE3EZcXthPQs0UoRBZ8nu8FvF
         Ih3Q==
X-Gm-Message-State: APt69E3lafEO9arvWTqBGolcIeaoHGW4s8lJ+PFbiPAT/bGDgSItDfXA
        OBOSGOVMazzpDbNrGOQ0/yyurDkn
X-Google-Smtp-Source: AAOMgpdogKQ6scETqJPpp1/In8NeOQsTyqeR/AYOeUt7kFCMLxybKk+rmXisxBqiWi1mMqVZF02+Sw==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr4353787wmd.76.1530630365806;
        Tue, 03 Jul 2018 08:06:05 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x16-v6sm2905842wme.12.2018.07.03.08.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:06:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ASoC: es7134: driver updates
Date:   Tue,  3 Jul 2018 17:05:57 +0200
Message-Id: <20180703150600.17697-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes issues of v1 [0] around power supply requirement
and add es7154 support.

AVDD is renamed to PVDD to better match the component datasheet.
v1 assumed optional power supplies, which was a wrong thing do.
Now VDD, is required on all chip variant and PVDD is required on the
es7154.

[0]: https://lkml.kernel.org/r/20180629150924.18197-1-jbrunet@baylibre.com

Jerome Brunet (3):
  ASoC: es7134: update DT binding with new compatible and supplies
  ASoC: es7134: correct required power supplies
  ASoC: es7134: add support for the es7154

 .../devicetree/bindings/sound/everest,es7134.txt   |   7 +-
 sound/soc/codecs/es7134.c                          | 104 ++++++++++++++++++++-
 2 files changed, 106 insertions(+), 5 deletions(-)

-- 
2.14.4

