Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D31C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AA52070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxgsITs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfAIHWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:22:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43622 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIHWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:22:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so6515229wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 23:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=7ZSVWsFyaxtCKYv0gtXtFkzYdHdbA/LiVbnEIgU+VwI=;
        b=LxgsITs3cTtLqGkmGtT/eRVcE3xyZlgD3STDv5B9Ukm7+WUxLrFR270FHqBtMnpYjF
         QPbdXFygSJuZgmVBwpGSqQpQzD+JRQjLa1sOZoMNcuNjpbDGlT0YKlasbodlkUEyeHQL
         d8RgTLy564SiO79VqeQv3A6Vm87kKF08OwBNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=7ZSVWsFyaxtCKYv0gtXtFkzYdHdbA/LiVbnEIgU+VwI=;
        b=sbVEeVNI7O9LnPq44Ej2S07Vref0n6x3MHsK1GwpAlISZmb2MteAn1ExgWaKjU6g0W
         XHAh7ozQC180H1h51WZAk0PfS0RguXVC13NpAkzmpiTeF2icj4U5HV0aX5S+HpbGO/C8
         JIo/jk7i3BJVcYZR5cI4xmWAUbvCoXsZeprmXBImQir3B3kE7VDVmcwa7PTNGWjRx+Ry
         7O78S54kW8PiVMXrT1tTKvT9++le9ux6pzuEbnwCcSySuPJoIjGMNaWHVvtMOsoW4kh1
         uQEsX9SImm9xXzzEtASPAMep14QuAJT6MlyHw+79sFGhw4iqp7JKPJWA4rzaZYv++jNp
         yjjg==
X-Gm-Message-State: AJcUukfJC/3ojEY0WWkg0+8Fg6RPm6xj5FO6c9fVUQRa2IKhqW8bQF2N
        3GpW7mNiMBHIx9u8jk14iTap8SN4E5g=
X-Google-Smtp-Source: ALg8bN6O5TFzYDK+UARmAeEXKC30VFp1lt6fhexOX8lBlRO8S8EAaDW+QQRSPVdyEBbNwXaA/UliAw==
X-Received: by 2002:adf:b102:: with SMTP id l2mr3756644wra.296.1547018574026;
        Tue, 08 Jan 2019 23:22:54 -0800 (PST)
Received: from dell ([2.27.35.240])
        by smtp.gmail.com with ESMTPSA id h10sm10682144wmf.44.2019.01.08.23.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 23:22:53 -0800 (PST)
Date:   Wed, 9 Jan 2019 07:22:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.1
Message-ID: <20190109072252.GC27286@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

Please accept my apologies for the lateness.

Christmas holidays, yada yada yada! :)

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-4.21

for you to fetch changes up to 3cee7a7d05b11038c8b5fa093e45c6f839ffc867:

  backlight: 88pm860x_bl: Use of_node_name_eq for node name comparisons (2018-12-14 12:30:24 +0000)

----------------------------------------------------------------
 - Fix-ups
   - Use new of_node_name_eq() API call;

 - Bug Fixes
   - Internally track 'enabled' state; pwm_bl
   - Fix auto-generated brightness tables parsed by DT; pwm_bl

----------------------------------------------------------------
Heiko Stuebner (2):
      backlight: pwm_bl: Re-add driver internal enabled tracking
      backlight: pwm_bl: Fix devicetree parsing with auto-generated brightness tables

Rob Herring (1):
      backlight: 88pm860x_bl: Use of_node_name_eq for node name comparisons

 drivers/video/backlight/88pm860x_bl.c |  2 +-
 drivers/video/backlight/pwm_bl.c      | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 12 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
