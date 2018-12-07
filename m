Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D0DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3448520989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3448520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLGJiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:38:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40298 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeLGJiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:38:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 037B51596;
        Fri,  7 Dec 2018 01:38:01 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFBAE3F59C;
        Fri,  7 Dec 2018 01:37:59 -0800 (PST)
Date:   Fri, 7 Dec 2018 09:37:53 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Chen, Hu" <hu1.chen@intel.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC/RFT,v7] cpuidle: New timer events oriented governor for
 tickless systems
Message-ID: <20181207093751.io5hhmg53camwpzh@queper01-lin>
References: <2047881.s5VBHReNGT@aspire.rjw.lan>
 <20181207075840.5881-1-hu1.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207075840.5881-1-hu1.chen@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On Friday 07 Dec 2018 at 15:58:35 (+0800), Chen, Hu wrote:
> From: Chen Hu <hu1.chen@intel.com>
> 
> Hi Rafael,
> 
> I run several popular Android performance benchmarks on teov7, using kernel
> 4.19.0 as my baseline because I happen to work on it. To backport teov7 to
> kernel 4.19.0, I also backport patch 5f26bdc: "cpuidle: menu: Fix wakeup
> statistics updates for polling state". The teov7 doesn't show regressions on
> such perf KPIs.
> 
> Compare "4.19 + 5f26bdc" and "4.19 + 5f26bdc + teov7" on Android with Intel
> Apollo Lake SoC:
> 
> Test Case                               Diff after appling teov7
> Antutu_6                                0.51%
> GFX5_openGL_Car_Chase                   0.43%
> GFX5_openGL_Car_Chase_offscreen	        0.25%
> GFX5_openGL_Manhattan31	                0.75%
> GFX5_openGL_Manhattan31_1080_offscreen  -0.10%
> Geekbench3.3                            -0.13%
> H264_1080P_60FPS                        0.00%
> H264_2160P_60FPS                        0.00%
> H265_2K_10bit                           0.00%
> H265_2K_8bit                            0.00%
> Resume_time                             1.31%
> full_boot                               -0.39%

That's really nice that you guys are able to get good test results on
Android 4.19 that early after the release :-)

Do you happen to run interactive use-cases as well ? I think Jankbench
is one of the workload most folk care about for example. Also, did you
manage to measure energy numbers for the above tests ?

FWIW, I'd like to give a go to TEO on an Arm-based setup when I can.

Thanks,
Quentin
