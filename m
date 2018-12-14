Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01715C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AA620879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FShMxKRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AA620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeLNINM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:13:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42518 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeLNINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:13:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so4115833lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 00:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pM2KNpW2LPu6qvJbMDsb6eQ7aO9Xejvm0HYf9eHkEHQ=;
        b=FShMxKRwxgZ1j6JtWPprUUM7YYQDpez6fmYXZbKbQKR9tKcr+ayoj0j0wJ+vEnoPYz
         ihbWu6OHsecnkvW/95nc+fFnqjqCgJDGs1yoIkuu/wTCytd6ediCH4wTOToo9TQJgggT
         UmQqKP6+JJIa744GWXV/lK5k2ySaw1pa0sPoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pM2KNpW2LPu6qvJbMDsb6eQ7aO9Xejvm0HYf9eHkEHQ=;
        b=hg8wDqNFEOVftG/E/ook3WhcT4ivqc8g9rphcFVrE/MeBhzRh24WtO0UNwF8vAET4p
         Y2sYlcggsRMHFb4DM+HuAHIM1KYxpHbjpnaQIQEDgxQv8sObaYQJg57vF53VcENTV/Vy
         0gdGx8jt2LlroMTAjYgSqoWet5ZWAwEGLp8kZwhIscac8gplrHVyxL1qWgm8z3rurpZR
         UesgFBG7PspG3Ni5K4YA1DGGE6G6YIRqD3ZStRzVue81z3G7ILT7ZGCAQ9/mskHx09fO
         HxXBXNVEI4xWT7TDvwDEJQNGa4FYND4EEgzVjKAlbNwnPwbRO00QZRF+DA+GceX0jw0h
         eE6w==
X-Gm-Message-State: AA+aEWYdM4Qy9DpMoxmpdpA+2I8GlsN+/8VMWNhNibbocGKBHzV2g/o1
        EMYjgNQxjT7jKhCg2u+uz5uK1/ns5imBKgWRZU4dpg==
X-Google-Smtp-Source: AFSGD/U5Wfm8HPpPglAZulAhOjMDDIq/0RJ14bch6CwK3jbGxwyu+flC9+yP97YS156iw4w56k3pr5h5SkpX1LwxIOw=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr1209541ljg.23.1544775189225;
 Fri, 14 Dec 2018 00:13:09 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 09:12:57 +0100
Message-ID: <CACRpkdZqeKmrMr7SsAzZHCLM+z4=eyz2XhjYFdhJJLaFDH84zQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some three pin control fixes for the v4.20 series.
Just odd drivers, so nothing particularly interesting. Details
in the signed tag.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.20-3

for you to fetch changes up to 478b6767ad26ab86d9ecc341027dd09a87b1f997:

  pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11 (2018-12-07 13:32:19 +0100)

----------------------------------------------------------------
Pin control fixes for the v4.20 series:
- Set the tile property on Qualcomm SDM60.
- Fix up enable register calculation for the Meson
- Fix an IRQ offset on the Sunxi (Allwinner)

----------------------------------------------------------------
Chen-Yu Tsai (1):
      pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11

Craig Tatlor (1):
      pinctrl: sdm660: Set tile property for pingroups

Jerome Brunet (1):
      pinctrl: meson: fix pull enable register calculation

 drivers/pinctrl/meson/pinctrl-meson.c      |  3 ++-
 drivers/pinctrl/qcom/pinctrl-sdm660.c      | 28 +++++++++++++++-------------
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c |  2 +-
 3 files changed, 18 insertions(+), 15 deletions(-)
