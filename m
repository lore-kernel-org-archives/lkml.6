Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E117C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E757020861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6csySU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E757020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeIGGpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:45:24 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:36142 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIGGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:45:24 -0400
Received: by mail-qk1-f177.google.com with SMTP id 93-v6so8770179qks.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 19:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kdQdsCXqdzZUMm0wjgHOMhmXpBSlt2QVqWv+rUwL2TQ=;
        b=B6csySU3fMN2uYUIwY2o3tKfEHh8x9g/Rr89w7lZoevtk3lWTzvMWrsraJdfcfRJBV
         p8tkp7qlmb37kL6dyDtXn1zz5d6nNHyWJjUn1vfc5sDuXIFx4LbCmQ4hvvyclfPGaA9V
         ceKfIVmFbMudHUIUTeudhFhpU240tEUM90zd0pElnTbydYRjdmP94Zctwv1uEGpuDIJK
         NmXSINObTzfEvN3AIrvlJYcFR/7W8mxxFUWvIsctqVKItZIgz5JMKKiEu4Qm7oijGVOe
         KFrLoIVeM9oec393bjlacw3ui9w+8BBmiXz8n2TBZUcTvW5RbF+VVPX8YlS5RAdkCoaf
         FaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kdQdsCXqdzZUMm0wjgHOMhmXpBSlt2QVqWv+rUwL2TQ=;
        b=BZA1kZkKYQ+JYLUvOlYdI7ndXlmAXDV6svtr+Kwjl7OCPACbL+JLH6UZ3c/5mTWYrZ
         NbhD/WJM2QJkmQfzGWleyaDbwsna+d99u0Csl4KqdTtE6HLUlMa5B3jqiI9h0BzVUNd0
         vbsY9+YXdUTT3QnvrZUtpfMV4zWKGqGkGsvFMtszCnlLIXQkixJi8xGHv7cQFkJDVICL
         TLAq1kPnEaAsYqQq+cUpFiSOI4cEU0nlH5p5Lf8DX2hX2IEmLm3v3fiRhAQwDte9yCUR
         EROxp2lZS175bdzxUbo0CeQbQBzOvrXtKBktxkWSxJXNUU16t/mBmB4suDQAp+yDSk2W
         8PMw==
X-Gm-Message-State: APzg51B2ztq4Ug6XejloFqnEfq6h6vtZ/NHQIfrwwVCxrufOpi62sVkr
        T/fumWlvQHOT0QXSVfuQizSdWdRWRLJezzeEUc4=
X-Google-Smtp-Source: ANB0VdYecv/kQLp/bpKV1+3UOpqPy386JxfN59YDNNMpdM/kYFtQMHT4zoNlUb/BU5+3C4+oTPiFeN6NyolfKh+eWz4=
X-Received: by 2002:a37:c881:: with SMTP id t1-v6mr4324239qkl.285.1536286017463;
 Thu, 06 Sep 2018 19:06:57 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Sep 2018 12:06:45 +1000
Message-ID: <CAPM=9tyJzRMh5+wOq+6TwfJqGF=G1Xntn+tj4a6EK5ONzCuQOw@mail.gmail.com>
Subject: [git pull] drm fixes for 4.19-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Seems to have been overly quiet this week so I expect next week will
be more stuff, just one pull request with i915 fixes in it.

i915: (from Rodrigo's pull)
"The critical fix here on display side is the DP MST regression one.
  But this pull also include fixes for DP SST, small VDSC register fix
  and GVT's bucked with "BXT fixes, two guest warning fixes, dmabuf
  format mod fix and one for recent multiple VM timeout failure."

Dave.

drm-fixes-2018-09-07:
i915 fixes
The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-09-07

for you to fetch changes up to 67c6ed7cf9ebe53815f15bfdeb49ad91801c2235:

  Merge tag 'drm-intel-fixes-2018-09-05' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2018-09-07
11:07:03 +1000)

----------------------------------------------------------------
i915 fixes

----------------------------------------------------------------
Colin Xu (2):
      drm/i915/gvt: Make correct handling to vreg BXT_PHY_CTL_FAMILY
      drm/i915/gvt: Handle GEN9_WM_CHICKEN3 with F_CMD_ACCESS.

Dave Airlie (1):
      Merge tag 'drm-intel-fixes-2018-09-05' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Hang Yuan (1):
      drm/i915/gvt: move intel_runtime_pm_get out of spin_lock in stop_schedule

Imre Deak (1):
      drm/i915/dp_mst: Fix enabling pipe clock for all streams

Jan-Marek Glogowski (1):
      drm/i915: Re-apply "Perform link quality check, unconditionally
during long pulse"

Manasi Navare (1):
      drm/i915/dsc: Fix PPS register definition macros for 2nd VDSC engine

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2018-09-04' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Xiaolin Zhang (1):
      drm/i915/gvt: emulate gen9 dbuf ctl register access

Zhenyu Wang (2):
      drm/i915/gvt: Fix drm_format_mod value for vGPU plane
      drm/i915/gvt: Give new born vGPU higher scheduling chance

 drivers/gpu/drm/i915/gvt/dmabuf.c       | 33 ++++++++++++++++++++++-------
 drivers/gpu/drm/i915/gvt/fb_decoder.c   |  5 ++---
 drivers/gpu/drm/i915/gvt/fb_decoder.h   |  2 +-
 drivers/gpu/drm/i915/gvt/handlers.c     | 33 +++++++++++++++++++++++------
 drivers/gpu/drm/i915/gvt/mmio_context.c |  2 --
 drivers/gpu/drm/i915/gvt/sched_policy.c | 37 ++++++++++++++++++++++++++-------
 drivers/gpu/drm/i915/i915_reg.h         |  4 ++--
 drivers/gpu/drm/i915/intel_ddi.c        | 17 ++++++++-------
 drivers/gpu/drm/i915/intel_dp.c         | 33 ++++++++++++++++-------------
 drivers/gpu/drm/i915/intel_dp_mst.c     |  4 ++++
 10 files changed, 120 insertions(+), 50 deletions(-)
