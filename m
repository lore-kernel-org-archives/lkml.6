Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF19C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6A820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6A820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeIGC1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:27:39 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:15841 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbeIGC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:27:39 -0400
X-IronPort-AV: E=Sophos;i="5.53,339,1531778400"; 
   d="scan'208";a="345310021"
Received: from lneuilly-657-1-24-134.w92-154.abo.wanadoo.fr (HELO hadrien) ([92.154.38.134])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 23:50:07 +0200
Date:   Thu, 6 Sep 2018 23:50:07 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Mikita Lipski <mikita.lipski@amd.com>
cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, kbuild-all@01.org
Subject: drivers/gpu/drm/amd/display/dc/core/dc_resource.c:352:1-14: code
 aligned with following code on line 354 (fwd)
Message-ID: <alpine.DEB.2.20.1809062349170.25742@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like line 352 needs to be indented more.

julia

---------- Forwarded message ----------
Date: Fri, 7 Sep 2018 05:47:25 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/gpu/drm/amd/display/dc/core/dc_resource.c:352:1-14: code
    aligned with following code on line 354

CC: kbuild-all@01.org
CC: linux-kernel@vger.kernel.org
TO: Mikita Lipski <mikita.lipski@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
CC: Hersen Wu <hersenxs.wu@amd.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   db44bf4b4768a0664d3c9d9000ecb747de31ded8
commit: 3e27e10e2ecee0d3a0083f8ae76354ac9c6ad15c drm/amd/display: Don't share clk source between DP and HDMI
date:   4 weeks ago
:::::: branch date: 5 hours ago
:::::: commit date: 4 weeks ago

>> drivers/gpu/drm/amd/display/dc/core/dc_resource.c:352:1-14: code aligned with following code on line 354

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e27e10e2ecee0d3a0083f8ae76354ac9c6ad15c
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 3e27e10e2ecee0d3a0083f8ae76354ac9c6ad15c
vim +352 drivers/gpu/drm/amd/display/dc/core/dc_resource.c

4562236b Harry Wentland   2017-09-12  310
4562236b Harry Wentland   2017-09-12  311  bool resource_are_streams_timing_synchronizable(
0971c40e Harry Wentland   2017-07-27  312  	struct dc_stream_state *stream1,
0971c40e Harry Wentland   2017-07-27  313  	struct dc_stream_state *stream2)
4562236b Harry Wentland   2017-09-12  314  {
4fa086b9 Leo (Sunpeng  Li 2017-07-25  315) 	if (stream1->timing.h_total != stream2->timing.h_total)
4562236b Harry Wentland   2017-09-12  316  		return false;
4562236b Harry Wentland   2017-09-12  317
4fa086b9 Leo (Sunpeng  Li 2017-07-25  318) 	if (stream1->timing.v_total != stream2->timing.v_total)
4562236b Harry Wentland   2017-09-12  319  		return false;
4562236b Harry Wentland   2017-09-12  320
4fa086b9 Leo (Sunpeng  Li 2017-07-25  321) 	if (stream1->timing.h_addressable
4fa086b9 Leo (Sunpeng  Li 2017-07-25  322) 				!= stream2->timing.h_addressable)
4562236b Harry Wentland   2017-09-12  323  		return false;
4562236b Harry Wentland   2017-09-12  324
4fa086b9 Leo (Sunpeng  Li 2017-07-25  325) 	if (stream1->timing.v_addressable
4fa086b9 Leo (Sunpeng  Li 2017-07-25  326) 				!= stream2->timing.v_addressable)
4562236b Harry Wentland   2017-09-12  327  		return false;
4562236b Harry Wentland   2017-09-12  328
4fa086b9 Leo (Sunpeng  Li 2017-07-25  329) 	if (stream1->timing.pix_clk_khz
4fa086b9 Leo (Sunpeng  Li 2017-07-25  330) 				!= stream2->timing.pix_clk_khz)
4562236b Harry Wentland   2017-09-12  331  		return false;
4562236b Harry Wentland   2017-09-12  332
3e27e10e Mikita Lipski    2018-07-12  333  	if (stream1->clamping.c_depth != stream2->clamping.c_depth)
3e27e10e Mikita Lipski    2018-07-12  334  		return false;
3e27e10e Mikita Lipski    2018-07-12  335
4562236b Harry Wentland   2017-09-12  336  	if (stream1->phy_pix_clk != stream2->phy_pix_clk
7e2fe319 Charlene Liu     2017-03-17  337  			&& (!dc_is_dp_signal(stream1->signal)
7e2fe319 Charlene Liu     2017-03-17  338  			|| !dc_is_dp_signal(stream2->signal)))
4562236b Harry Wentland   2017-09-12  339  		return false;
4562236b Harry Wentland   2017-09-12  340
4562236b Harry Wentland   2017-09-12  341  	return true;
4562236b Harry Wentland   2017-09-12  342  }
3e27e10e Mikita Lipski    2018-07-12  343  static bool is_dp_and_hdmi_sharable(
3e27e10e Mikita Lipski    2018-07-12  344  		struct dc_stream_state *stream1,
3e27e10e Mikita Lipski    2018-07-12  345  		struct dc_stream_state *stream2)
3e27e10e Mikita Lipski    2018-07-12  346  {
3e27e10e Mikita Lipski    2018-07-12  347  	if (stream1->ctx->dc->caps.disable_dp_clk_share)
3e27e10e Mikita Lipski    2018-07-12  348  		return false;
3e27e10e Mikita Lipski    2018-07-12  349
3e27e10e Mikita Lipski    2018-07-12  350  	if (stream1->clamping.c_depth != COLOR_DEPTH_888 ||
3e27e10e Mikita Lipski    2018-07-12  351  	    stream2->clamping.c_depth != COLOR_DEPTH_888)
3e27e10e Mikita Lipski    2018-07-12 @352  	return false;
3e27e10e Mikita Lipski    2018-07-12  353
3e27e10e Mikita Lipski    2018-07-12 @354  	return true;
3e27e10e Mikita Lipski    2018-07-12  355

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
