Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD32C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 00:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA0F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 00:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2+I9NTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbeL0AKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 19:10:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35069 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbeL0AKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 19:10:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so10093633qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rlfM0qZk71l0Cr52tm9mKWXQxwKkCdJd3PpoMu+OKhI=;
        b=R2+I9NTsP3DKzOeSZoEwKctrHkfFGwCGYKMqYhhTzVa1SK8Vsxj3XLlpj/kEObyr0W
         T+szKOPo4LYXT84Oz/w0oVVpyLeEVvCF++Pn/IQbwFZ7fwmXn3qT0pJ86bkcs0N6wFUe
         dSuZPOABNaQd9D8XbJcJNnUNFGeGZP5JA0kXAWIN1s/cI9kxZtuBzLP9rv58ubbtTpkD
         5eQd5DHzqWfY7Q2t/pcrSQ7U5h5cg7CeAwDX4rn7JRq/jttDvGOWLd47/ffme44lbjWa
         pdLDRcVqmHMo/JhErwRY7CZQP097AmZ/UTkEvUTxnnz0YS+AaydwVN7N4S/6Qc/fOKLe
         KyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rlfM0qZk71l0Cr52tm9mKWXQxwKkCdJd3PpoMu+OKhI=;
        b=MROr42iG3imJ/lLg8Wh6s+jhvDIGQmseB4JJHSTqkd+iu7SEOtOm/uFMiBXmOq9Deg
         fJq4l6LYWbASK6n/qbDDqrw89czc9RrCkdteGhVYkKihleKiAv9xuUBQn8IPgB07GM/V
         zowerkS+8NRx98Q+s1xLro54TpQgFdBnNvhVdyG+NILPgpstyLyhaTx3kKuWUHpWysWH
         c9MS8CTSq3TRxGfDRQE0QiarGT0HsJfC0cB1qfJEljsvB1TRkSWPO3VUPMWUb4g6IbCN
         YzwkhU8hhGTlSyN6o/6dw1IR6cAICz0lojqSRDscizz/SmqEO5d3YeoD6hyza2NfP00z
         b0Qw==
X-Gm-Message-State: AJcUukfpjyF2DXy5Jq7sHkJUvd0ZVUK5vs2csNhFliVYmQMroJN1DQNN
        AbVdtZ9JmCzwbvhcdiY3ni+IvUiksxeUSlV89RIGeJ8D
X-Google-Smtp-Source: ALg8bN4Ov61SQa/44BfoyC2zWVtFxQJacDkvZUrRzvdtYw8/VxHNtoMz7ZgdMoGnohirVdbQlSAtzWqDqzUDSfJiiu8=
X-Received: by 2002:a37:1956:: with SMTP id k83mr18768536qkh.344.1545869401098;
 Wed, 26 Dec 2018 16:10:01 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 27 Dec 2018 10:09:49 +1000
Message-ID: <CAPM=9tyfyF0seDFRzycL0OBdquaj09BLU9Ft8datGhKaZfC2ow@mail.gmail.com>
Subject: [git pull] drm next leftovers for rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Daniel collected a couple of pulls after I want on holidays, back for
a couple of days, so may as well send them out.

This has exynos and etnaviv work for 4.21.

exynos:
- plane alpha and blending configurability

etnaviv:
- mostly cleanups in prep for new features.

Dave.

drm-next-2018-12-27:
drm etnaviv and exynos for rc1
The following changes since commit 2a3c83f5fe0770d13bbb71b23674886ff4111f44:

  Merge tag 'vmwgfx-next-2018-12-13' of
git://people.freedesktop.org/~thomash/linux into drm-next (2018-12-14
04:57:45 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-12-27

for you to fetch changes up to 221b35fedee1b38b9cee99320f0c60263d229e14:

  Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next (2018-12-18
14:24:52 +0100)

----------------------------------------------------------------
drm etnaviv and exynos for rc1

----------------------------------------------------------------
Christoph Manszewski (2):
      drm/exynos: fimd: Make plane alpha configurable
      drm/exynos: fimd: Make pixel blend mode configurable

Daniel Vetter (2):
      Merge tag 'exynos-drm-next-for-v4.21-v2' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next

Lucas Stach (5):
      drm/etnaviv: kill active fence tracking
      drm/etnaviv: consolidate hardware fence handling in etnaviv_gpu
      drm/etnaviv: remove unnecessary local irq disable
      drm/etnaviv: replace header include with forward declaration
      drm/etnaviv: remove lastctx member from gpu struct

Thomas Zimmermann (1):
      drm/etnaviv: Replace drm_dev_unref with drm_dev_put

 drivers/gpu/drm/etnaviv/etnaviv_buffer.c |   2 -
 drivers/gpu/drm/etnaviv/etnaviv_drv.c    |  12 +--
 drivers/gpu/drm/etnaviv/etnaviv_drv.h    |  11 ---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c    |  37 ++++------
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h    |  12 +--
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 123 +++++++++++++++++++++++++------
 include/video/samsung_fimd.h             |  10 +++
 7 files changed, 131 insertions(+), 76 deletions(-)
