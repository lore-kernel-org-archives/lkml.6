Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CAC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B449120989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B449120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLGIAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:00:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:5605 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLGIAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:00:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 00:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="125868883"
Received: from hu.sh.intel.com ([10.239.160.33])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2018 00:00:09 -0800
From:   "Chen, Hu" <hu1.chen@intel.com>
To:     rjw@rjwysocki.net
Cc:     Chen Hu <hu1.chen@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC/RFT,v7] cpuidle: New timer events oriented governor for tickless systems 
Date:   Fri,  7 Dec 2018 15:58:35 +0800
Message-Id: <20181207075840.5881-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <2047881.s5VBHReNGT@aspire.rjw.lan>
References: <2047881.s5VBHReNGT@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Hu <hu1.chen@intel.com>

Hi Rafael,

I run several popular Android performance benchmarks on teov7, using kernel
4.19.0 as my baseline because I happen to work on it. To backport teov7 to
kernel 4.19.0, I also backport patch 5f26bdc: "cpuidle: menu: Fix wakeup
statistics updates for polling state". The teov7 doesn't show regressions on
such perf KPIs.

Compare "4.19 + 5f26bdc" and "4.19 + 5f26bdc + teov7" on Android with Intel
Apollo Lake SoC:

Test Case                               Diff after appling teov7
Antutu_6                                0.51%
GFX5_openGL_Car_Chase                   0.43%
GFX5_openGL_Car_Chase_offscreen	        0.25%
GFX5_openGL_Manhattan31	                0.75%
GFX5_openGL_Manhattan31_1080_offscreen  -0.10%
Geekbench3.3                            -0.13%
H264_1080P_60FPS                        0.00%
H264_2160P_60FPS                        0.00%
H265_2K_10bit                           0.00%
H265_2K_8bit                            0.00%
Resume_time                             1.31%
full_boot                               -0.39%

Thanks
Chen Hu
