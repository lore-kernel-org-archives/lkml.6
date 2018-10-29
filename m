Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7252C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D352084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="y/LYNvRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D352084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJ3ACx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:02:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36226 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeJ3ACx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:02:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so8313617wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8T1NHJCCCKb0YG0EaHRHFWM/RV2/7oEyibMgOYKbr9s=;
        b=y/LYNvREGslKtMZJgqY9RhNPJd9rSzKxCMyQw2ASb6vdu470yFlwd4S5VROVB881/V
         afu2sH7TO8uZ5IJEjCbERowFe4gISn9jpWeVTl/Ye66XDskVEgE59AKg96u/aMZp3uaR
         0siuKbUpM3McX/cNtld6JXx1K/5NRgVfDPn+7fp+o3yP9gry7Ge5d0S4ROVbEpVni12I
         yPaqXQc3xPkuVwirvvOdnQkyqDkNyB4LS0rk1HGHLTyTtJub6fIrrsyygcM9br2FDQ4p
         H253I26FIxLbMzn66X8hz2DjSQ9jsmraBFmH17i2QArJcrmiL3YADRbrN+6kT0t3lnal
         MDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8T1NHJCCCKb0YG0EaHRHFWM/RV2/7oEyibMgOYKbr9s=;
        b=nEmRLXOoiOmMP4gUktNu5Axoprzfijjdg62TpiyDVgv/NF89nGb2jb0KBql0w4Q4rK
         7ydHU1CxSzUxEnmIemsMgq7ndT2cHGWmE3UxUYYf3tq9YW2fAcMjItz9rvk540jNUuI5
         aIEqxK20a8Oaxw1AtYTuoc0ccTRiZhy/QdmVWekgJm/WENF9xafky6qrTmXv14/ifeG7
         M38LLkB4O/5UEvraHWMWTraJyrwePzbjONpwfo+tCY8AEBgmy0GmYvVKZu23DNe7eVIR
         +GYDK1VUuBXu/e+bSv0kWUPTbsH55gN0zf2rY0HFAG4KK44qaZG5hprPZEwbWPftHfzg
         22AA==
X-Gm-Message-State: AGRZ1gLAs81WAZVIrlpbDuMjFL38ea8Unuj46jxpmUG2UztGuQVwmh+f
        IsXfx5hcnxvrGVMpS2mMEKmX9g==
X-Google-Smtp-Source: AJdET5ecKCz34y4HLtZwHji4m7jmpGIT6LJgO3jElOJMuOJ2vgZFLAj3npzM2d+irFNm3Gl7mRiFtA==
X-Received: by 2002:a1c:84cd:: with SMTP id g196-v6mr14143876wmd.38.1540826028404;
        Mon, 29 Oct 2018 08:13:48 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm23045236wmd.41.2018.10.29.08.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 08:13:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] pinctrl: meson: fix pull bits
Date:   Mon, 29 Oct 2018 16:13:36 +0100
Message-Id: <20181029151340.9087-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the inversion between pull (up/down) and pull enable
bits on the GPIO AO bank of all amlogic when have, except the axg family.

The problem has been found while testing bias setting on the libretech
aml-s905x-cc on GPIO_AO 5. Unfortunately the bias register of this bank is
not described in the public datasheet of the s905x, but it is in the
one of the A113D, which gave a clue.

This was tested on gxl libretech aml-s905x-cc. Since all Amlogic we have
got so far derive from each other, there is no reason for things to be
any different on the meson8(b).

I would have preferred to make a single patch to fix this but the commit
introducing the mistake the is different for each SoC, so a single patch
could be more difficult/annoying to backport.

Jerome Brunet (4):
  pinctrl: meson: fix gxbb ao pull register bits
  pinctrl: meson: fix gxl ao pull register bits
  pinctrl: meson: fix meson8 ao pull register bits
  pinctrl: meson: fix meson8b ao pull register bits

 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 2 +-
 drivers/pinctrl/meson/pinctrl-meson8.c     | 2 +-
 drivers/pinctrl/meson/pinctrl-meson8b.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.2

