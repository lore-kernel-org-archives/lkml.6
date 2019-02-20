Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728F52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3thYfI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBTIIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:08:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44369 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfBTIIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:08:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id g2so16821730lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=C2WrDpsl5Tr1zlAUZqdQM9SsZWpB4tZoF1I1ecg6VEo=;
        b=j3thYfI4C+Fmyjo+gZll1u7x3mfa0YdG8GWexF88oiPS8i8GSpN1GgCG4OK3ug5Zmv
         saoX5+w13M2ZUMAtjTX/ImmTTEFqgNqrFRL5BoaDXuHuqQbn+fBWjonPwXVw/ZlCcJO8
         xY8qVN8wXd63jhbrtPOitQ8a92uCAWwmxyIAalc/7Pec+M3dJ+d4tLHWEhL4nsGxqajy
         fibj12bIUMddi7cCMmrGQz0nKFIK4kRkZSLhidAsbFHEjH0TsAz0/rTBHe/vghovbCpt
         irxRh3LJnAOlOAXiiTXCGZ6AACuA3WxX91svrz8vjDF1AqVt3sGwwgz/s+vOEaZLqdOL
         TTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=C2WrDpsl5Tr1zlAUZqdQM9SsZWpB4tZoF1I1ecg6VEo=;
        b=Jy0dJO6T0UAfALaprMDoCj2gLMkDxDctWDpeVFDtRT/130lgHUJLSPbvngnmHrqptB
         trirCMb7mXXrT8NhbTejxAj+GUmN1shWfMfy0z2a3UlryOsNKd59SXMCB8xk8gl6LMAa
         VejPfveYzx5O99KHveGqggv4pEUVIfa9qIO082Xj8g8K9HQbAd6+9bz3o5Y15CMFRS6S
         qM08aqDzKhyOocAmbDlRiZWe6kxmcJrXwfghyQ5KtcYFmAsWcNaaERXtgXlHpadzQOxw
         yMBNCFzIdKuLBjr+RZPhbDLPYWDEAmFNuohpkZEE8K/u6Age6/w9VLKGSE08ZOT1zF7M
         i3yQ==
X-Gm-Message-State: AHQUAuay7ca8Itm7LXvQdnRzFIsVyDjaHKDkn5AOjbECTrhCZIoyd/mf
        CthcJXC2nTJNSmOWPhS5kLVpsiXoF0rfh9wdnKlYDg==
X-Google-Smtp-Source: AHgI3IajqvB1NxVBGs292Hs07SSB5+ZNLH52KP7YCiBqgTg/rmJP0zsfTadGKGoT3htA6eLsS0xugT8EkzdxWNZI5tk=
X-Received: by 2002:a19:5611:: with SMTP id k17mr18716886lfb.168.1550650117245;
 Wed, 20 Feb 2019 00:08:37 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 09:08:25 +0100
Message-ID: <CACRpkdYMDh-VLBcKsfrCV5wV0vUqGPujztkqTjyZPznJ2APhEQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some final pin control fixes (I hope) to round off the v5.0 pin control
development cycle.

Only driver fixes, one for stable.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.0-3

for you to fetch changes up to c17abcfa93bf0be5e48bb011607d237ac2bfc839:

  pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins (2019-02-17
22:24:32 +0100)

----------------------------------------------------------------
Pin control fixes for the v5.0 series:
- Meson8B fixup for the sdc pins
- Fix SDC tile position for Qualcomm QCS404

----------------------------------------------------------------
Bjorn Andersson (1):
      pinctrl: qcom: qcs404: Correct SDC tile

Martin Blumenstingl (1):
      pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins

 drivers/pinctrl/meson/pinctrl-meson8b.c | 2 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
