Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31B320855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7BQ5nlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfARFpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:45:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41927 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfARFpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:45:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so14015031qtf.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 21:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=K7jidEG6XCSxGT14yIoxuvZR8WMNBOFPpBPWSPowOpg=;
        b=h7BQ5nlc7kIT7UTjGCFHpNAxxwWMq6RVWgBO+UiZClyv2s1t9LCiyCVtq+dAGn/4Mi
         5NX1KJju54EGVSsL83Ugp2JHwirFJyikpgYrTWnh92PW6nYt9zPvcnSt8/HCQv7aUAya
         VnInMSRApdVGVs7e+oVle49+q9Ps30C9pRVj0xZwMtqwp74QfR+jd0By44EWCFRBAW0R
         Xmm+a45RcIvBhENBn6AWhF/Arai4oQIevT4kBPd6J1jLVr+u0YhilwVX4q2+dJXZxtDs
         sAt+F+Z6rMVBXUFyDf9+w/6K0Ks5A+Z+ssZ0exSqNYlCNn25a/6TLCwXoMlt0cBim0h6
         0iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=K7jidEG6XCSxGT14yIoxuvZR8WMNBOFPpBPWSPowOpg=;
        b=fa/aDL5CXUIk4hFRlxImfcJ0ILRkj5rlYnig+7+nAcHOn9YYS6yswUVXiRd/kz0kz+
         d8qj4qbIwMLfufpzFVcNrkOJvEXgD6+H9jnPpKbwtJwzmTp3GTZjE1dWKrF530ll873F
         8EAdqsKw/LKaWrWpXYpk7SF+hEJ35QqF/SsUkxr/l8/5A7LUjYd7L0U9aU6WkJD63p3E
         af1fJw3L8oEN4/cgueb8O3dnzZjapAON0zy/wigmyn9chvVMvt8SOXrF0s2lKAQoJqG6
         pHu/yQi6O5JuBH3661GiIzKwSsgEh99EKuIPkJQf/yYcDGHF2YFoZ8ERnbRPoceJP75x
         ckxQ==
X-Gm-Message-State: AJcUuken1P4Hzb0ZDC14A1rY5IT5GeDW+Oy4h15+zogbP9mK/B+FtyxM
        F3Rs+ZwDjIJaIJQ3R+LvcvQIuY1rvPDJJKsnzIQ=
X-Google-Smtp-Source: ALg8bN5AQOHRRMjhB56PhxAZMZI6SqS31gDu3wjoFysQ4AIssGkH7XU9FiQl2MttdpfbCc1d/iySGk8rXyyuLzRBZ2w=
X-Received: by 2002:ac8:13c5:: with SMTP id i5mr3596966qtj.365.1547790299600;
 Thu, 17 Jan 2019 21:44:59 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 18 Jan 2019 15:44:48 +1000
Message-ID: <CAPM=9ty7U8D_stQeAtxgEzS_eeR0VKnZKBzGDNJwaotcr_7KCg@mail.gmail.com>
Subject: [git pull] drm nouveau TU102 hw support
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a separate pull req for -fixes that just contains the patch to
enable TU102 GPUs with nouveau (RTX 2080 Ti).

It seems small enough to go in now rather than wait for merge.

Dave.

drm-fixes-2019-01-18-1:
drm/nouveau: add TU102 support
The following changes since commit df0219b4f9576c72b618db5edf7bb75c14829dbd:

  Merge tag 'drm-misc-fixes-2019-01-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2019-01-18
09:14:45 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-18-1

for you to fetch changes up to 9420151d88ca35cd7f857774d90bfdca505a2cc1:

  Merge branch 'linux-4.21' of git://github.com/skeggsb/linux into
drm-fixes (2019-01-18 15:38:18 +1000)

----------------------------------------------------------------
drm/nouveau: add TU102 support

----------------------------------------------------------------
Ben Skeggs (1):
      drm/nouveau/core: recognise TU102

Dave Airlie (1):
      Merge branch 'linux-4.21' of git://github.com/skeggsb/linux into drm-fixes

 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)
