Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A0C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AD520823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AD520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeJ3W3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:29:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:58366 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbeJ3W3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:29:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 06:35:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="275672971"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga005.fm.intel.com with ESMTP; 30 Oct 2018 06:35:53 -0700
From:   Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCHv4 0/2] iommu/arm-smmu: Add Stratix10 SMMU Support
Reply-To: thor.thayer@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        aisheng.dong@nxp.com, sboyd@kernel.org
Cc:     vivek.gautam@codeaurora.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
References: <1538773020-27784-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <65377977-8534-557a-b77b-f5f8f6962385@linux.intel.com>
Date:   Tue, 30 Oct 2018 08:38:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1538773020-27784-1-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping...

On 10/05/2018 03:56 PM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add SMMU support for the Stratix10 SOCFPGA. This patch requires
> clock enables for the master TBUs and therefore has a dependency
> on patches currently being reviewed.
> 
> This patchset is dependent on the patch series [1]
> 
> v4  Address Vivek's comment.
>      Abandon dependency on [2] (no recent activity/reviews)
>      Implement device tree parsing of clock on top of [1].
> v3  Address comment from Robin and change dependency on device
>      tree bulk clock patches [2].
> v2  Change to dependency on [1].
> 
> [1] [v16,0/5] iommu/arm-smmu: Add runtime pm/sleep support
> https://patchwork.kernel.org/cover/10581891/
> 
> [2] [PATCH V6 0/4] clk: new APIs to handle all available clocks
> https://lkml.org/lkml/2018/8/31/97
> 
> Thor Thayer (2):
>    arm64: dts: stratix10: Add Stratix10 SMMU support
>    iommu/arm-smmu: Get clock config from device tree
> 
>   arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 29 ++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c                          | 30 ++++++++++++++++++++---
>   2 files changed, 56 insertions(+), 3 deletions(-)
> 

Any comments on this patchset? I realize the dependency still needs to 
be accepted but the clock portion of the dependency which is what this 
patch builds on hasn't changed in the last iterations.
