Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93917C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F312218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nLhckvrE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gVjTnLoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfAYHU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:20:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49084 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAYHU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:20:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5A93960312; Fri, 25 Jan 2019 07:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548400855;
        bh=8JLDzK7/igH177ZVH3VATrYgg/5oll7iVUf3eezsxdw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nLhckvrEemRDHJ+5F17fbz8s9uGBssdsv+oNf6LdFT+mUjGk87dqAjCiGITp4JtK2
         /jGzxwRj5ZpUT/e6xppJppsXVet7H9T47m+BxMODyTX0OLf1nS9BXm4ttOLEOKNlJb
         nk2AfnvqFyyA+jegz1kFzQ8NeoHkh1dDN/9S9QFM=
Received: from [10.79.129.250] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86EDD60312;
        Fri, 25 Jan 2019 07:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548400854;
        bh=8JLDzK7/igH177ZVH3VATrYgg/5oll7iVUf3eezsxdw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gVjTnLoLQa4Maa5qkF3rBBJeqg/BIRlKy+I1s3vyu/T9/0H0WXQ90hu3FkJqdiNFR
         mRnkvWBzH4SoGSFNXO6r21RYOQA2tzrA9NGGkiZuO480Gj3F39TNz9KcfmPvWQ2q8a
         iBoXx04/AM+ThK/ZH4feS56z/qziy6kPLse+Vte8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86EDD60312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [RESEND PATCH v3 1/2] drivers: amba: Updates to component
 identification for driver matching.
To:     Mike Leach <mike.leach@linaro.org>, linux@armlinux.org.uk
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
References: <20181218215944.2444-1-mike.leach@linaro.org>
 <20181218215944.2444-2-mike.leach@linaro.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <353c8f4b-f48f-863c-7149-342b764a02c0@codeaurora.org>
Date:   Fri, 25 Jan 2019 12:50:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181218215944.2444-2-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thanks for the patch.

BTW somehow I can't find the latest series in my inbox, so commenting
on this here.

Mathieu pointed me to this patch series.This solves CPU debug module
sharing same PID as ETM on MSM8996. I will be posting patch for CPU
debug UCI table soon.

But please find my one comment inline.

On 12/19/2018 3:29 AM, Mike Leach wrote:
> The CoreSight specification (ARM IHI 0029E), updates the ID register
> requirements for components on an AMBA bus, to cover both traditional
> ARM Primecell type devices, and newer CoreSight and other components.
> 
> The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
> cases to uniquely identify components. CoreSight components related to
> a single function can share Peripheral ID values, and must be further
> identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
> PMU and Debug hardware of the A35 all share the same PID.
> 

[..]

> +static const struct amba_id *
> +amba_lookup(const struct amba_id *table, struct amba_device *dev)
> +{
>   	while (table->mask) {
> -		ret = (dev->periphid & table->mask) == table->id;
> -		if (ret)
> -			break;
> +		if (((dev->periphid & table->mask) == table->id) &&
> +			((dev->cid != CORESIGHT_CID) ||
> +			 (amba_cs_uci_id_match(table, dev))))

Shouldn't the check be (dev->cid == CORESIGHT_CID) ?
Without this STM fails to probe on both SDM845 and MSM8996.

With this,

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
