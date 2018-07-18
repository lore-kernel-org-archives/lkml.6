Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7375EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391D520857
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391D520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbeGRQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:13:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731653AbeGRQNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:13:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2B1E649C602DD;
        Wed, 18 Jul 2018 23:34:32 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Wed, 18 Jul 2018
 23:34:31 +0800
Subject: Re: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, <robh@kernel.org>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B4F5E00.5050800@hisilicon.com>
Date:   Wed, 18 Jul 2018 16:34:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1530766981.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2018/7/5 6:09, Viresh Kumar wrote:
> Hi,
> 
> This is an attempt to fix the broken or partially defined DT bindings
> for cooling-maps. We should list every device that participates in
> cooling down at a certain trip point, instead of just the first in the
> list as that depends on certain ordering of events to work properly.
> 
> The first patch extends the binding to allow a list of phandles in
> "cooling-device" property and the second patch fixes one of the
> platform's DT.
> 
> This will be followed up by fixing all platform DT bindings that have
> these issues after this set is accepted.
> 
> The kernel also requires some changes to handle the phandle list, but
> wouldn't break with these changes as it reads the first phandle in the
> list for now. We can update that separately.
> 
> --
> viresh
> 
> Viresh Kumar (2):
>   dt-bindings: thermal: Allow multiple devices to share cooling map
>   arm64: dts: hi6220: Add all CPUs in cooling maps
> 
>  Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi             |  9 ++++++++-
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 

Thanks!
Applied both to the hisilicon dt tree.

Best Regards,
Wei

