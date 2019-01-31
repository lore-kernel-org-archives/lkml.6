Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A323C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DDD218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ClgrYYsj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WxMmqbTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbfAaLXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:23:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfAaLXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:23:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2C75360987; Thu, 31 Jan 2019 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548933802;
        bh=27sPpMVytBxo/dSpOXz7XscvzaW7yqjIC6rPP2BIWAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ClgrYYsj1wHYyBougStrCcxmhpkeyHmnEqf7KyQbnDgvM5faBUx+Ev8jUJPsW2z3P
         itvIAdPkDfSm+Eq/kV2Rk4xqwkIowSdprcrbYP1H1FbcLSZkZh8/GI1LFsLPTFmhWg
         nZdoLDBdaq3FJB+XSPy8z9Hv7qshnCMbDh95RDUY=
Received: from [192.168.43.47] (unknown [27.59.108.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1450C6030D;
        Thu, 31 Jan 2019 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548933798;
        bh=27sPpMVytBxo/dSpOXz7XscvzaW7yqjIC6rPP2BIWAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WxMmqbTqwwZ2bVm9hamfxDFoTuJEOODyqSupT1JMxqtC4JEmp1LXDO31Yme75yNax
         cF+9Ey0vJYVilUKqOSee+3A4zvWfxogmIZFzYpKDyaNQqWEqmcYm1PFcUobyzbPWvx
         8GFcGmMi9hc9kCzU7+QXexrjrh+FbKNIsgfmhkGw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1450C6030D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v4 1/3] drivers: amba: Updates to component identification
 for driver matching.
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, arm@kernel.org
References: <20190130234051.2294-1-mike.leach@linaro.org>
 <20190130234051.2294-2-mike.leach@linaro.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <dc23a09c-7814-8fa1-ed07-7afe9eb3e7ed@codeaurora.org>
Date:   Thu, 31 Jan 2019 16:53:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130234051.2294-2-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2019 5:10 AM, Mike Leach wrote:
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
> Bits 15:12 of the CID are defined to be the device class.
> Class 0xF remains for PrimeCell and legacy components.
> Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
> Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
> at present.
> Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
> 
> The specification futher defines which classes of device use the standard
> CID/PID pair, and when additional ID registers are required.
> 
> This patch introduces the amba_cs_uci_id structure which will be used in
> all coresight drivers for indentification via the private data pointer in
> the amba_id structure.
> 
> Existing drivers that currently use the amba_id->data pointer for private
> data are updated to use the amba_cs_uci_id->data pointer. Macros and
> inline functions are added to simplify this code.
> 

Thanks Mike, this fixes STM probe with UCI change.

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
