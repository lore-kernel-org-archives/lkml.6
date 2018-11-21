Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02699C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFA22147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UIx/ilNT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UIx/ilNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFA22147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbeKVCls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:41:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbeKVCls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:41:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 885E460A98; Wed, 21 Nov 2018 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542816405;
        bh=M86mWa9k/FV/LifoNXbjMM3YEnTRr0KvFQBVS1Bhk2Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UIx/ilNTzT7weIjpLQVylKyfmFOoY7l0zSmO2O6/XyGLvW46i5PgFiSTPaN2SP96p
         3ET4IccSWSGKbaZkbfr4FJAHW94TuQktSVkgYoSYMmOwPBnHgpTssXfp7f4l/U0d0N
         LVmi7kjTZ40iI1maMVZdUjbIVSZDKrYSBdesEkCs=
Received: from [192.168.43.100] (unknown [1.39.174.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F01E601D4;
        Wed, 21 Nov 2018 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542816405;
        bh=M86mWa9k/FV/LifoNXbjMM3YEnTRr0KvFQBVS1Bhk2Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UIx/ilNTzT7weIjpLQVylKyfmFOoY7l0zSmO2O6/XyGLvW46i5PgFiSTPaN2SP96p
         3ET4IccSWSGKbaZkbfr4FJAHW94TuQktSVkgYoSYMmOwPBnHgpTssXfp7f4l/U0d0N
         LVmi7kjTZ40iI1maMVZdUjbIVSZDKrYSBdesEkCs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F01E601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v4 0/2] Enable smmu support on sdm845
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        david.brown@linaro.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, dianders@chromium.org
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181121155249.GA24883@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <af01e45b-b35c-925c-e1b8-9847482adca5@codeaurora.org>
Date:   Wed, 21 Nov 2018 21:36:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121155249.GA24883@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,


On 11/21/2018 9:22 PM, Will Deacon wrote:
> Hi Vivek,
>
> On Thu, Oct 11, 2018 at 03:19:28PM +0530, Vivek Gautam wrote:
>> This series enables apps-smmu, the "arm,mmu-500" instance
>> on sdm845.
>> Series tested on SDM845 MTP device with related smmu patch series [1],
>> and necessary config change, besides one hack to keep LDO14 in LPM mode
>> to boot things up (see the commit in the test branch).
>> The tested branch is available at [2].
> [...]
>
>>   .../devicetree/bindings/iommu/arm,smmu.txt         |  4 ++
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi               | 72 ++++++++++++++++++++++
>>   2 files changed, 76 insertions(+)
> Given that this doesn't touch any of the driver code, please take this via
> the Andy and arm-soc.

Yea, once the driver changes are pulled in your tree, I can ask Andy to 
pick these.
Thanks

Best regards
Vivek
>
> Will

