Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5445C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B82F214FE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+nHKN+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B82F214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbeIXTY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:24:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34481 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbeIXTY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:24:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id y10-v6so2409522lfj.1;
        Mon, 24 Sep 2018 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+WGynMLJg5EI2b4ngEyDjT/rTN6ZaFlkD8ALVJUG3Tk=;
        b=R+nHKN+ZEvrH3pJ55/t6S/4/kZ6L9DJllqNy4dHdphEHfMhppmGOsi0WT/KvTfAhVc
         kXEKZUm3enk8q0wupo7Ba9qO86mfMamxew1CqLtuHLm/ye/Z2oGkRu7EZb34U4wHSbtW
         mwgD0TazH55JX0YhJHZdqf28360LCpEvQC+09iOTbplMKAtQ+mfYAZ8sJBlKuvOxk7Ic
         suLr1axl+2vxBBfcGe6TEEKn5MHTgIXVAW9yqBO6nYc3T5BXbGRfhxlI3X5fGJjQe/gv
         demGSC8/A/mnITZmYrwETz2e5oJ6gHU0MmqVBnXz27w4XvKN+g6ZI0TjTdmXgAOXPW8+
         IGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+WGynMLJg5EI2b4ngEyDjT/rTN6ZaFlkD8ALVJUG3Tk=;
        b=Ht7HJi/pIRQs5yfJ+tJ5ClfLOmWgTE3rpADXVpkAVqJwPFDo/9qOV/t6A7y0eXtSqV
         aDojR2wLBdGk7xzxDP+pTip36veIvzNLTb9nY1UVKrs/An+M+Pxby7+92OySNG32E1H1
         F/eGfHGAQDTNbj1NeiO90GLq9mceQ2X6/PH0OQ/BwWaHEZgaKWmzXlv4CGoD8pttJJ0f
         cl8oPwcwERyeuuo/rx6ztFb71z6OHiPxYIxrhRoz7X+zCfgX0w0Ai/hbPyxZ8YEruU0w
         jntztB3WNn2xvUeSU0frHfn9zb0ORNl0X97OMGqssTEIBHV5dRK0tTai7d5A1uAzTfd4
         EGJg==
X-Gm-Message-State: APzg51Bz4FPOyQYq1s3Ogtpity9+oaXngKfNI46XIx7QXteug/Gxtvd4
        2AsElwzmEuW2Lbjkgyp+UVqFRQD3
X-Google-Smtp-Source: ANB0VdaBOVSuQfnq/LAdjW5kYVmybt7+22Aci+QS7mWH6twmiw68lssadw76ojW0o1AXego3HNZ7uw==
X-Received: by 2002:a19:13dc:: with SMTP id 89-v6mr6582346lft.111.1537795364517;
        Mon, 24 Sep 2018 06:22:44 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id y16-v6sm6613026lje.30.2018.09.24.06.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 06:22:43 -0700 (PDT)
Subject: Re: [PATCH v4 09/20] memory: tegra: Adapt to Tegra20 device-tree
 binding changes
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-10-digetx@gmail.com> <20180924100205.GB21032@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bca7c87a-5f86-4a98-bb6b-411c641a0e80@gmail.com>
Date:   Mon, 24 Sep 2018 16:22:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180924100205.GB21032@ulmo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 1:02 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:42AM +0300, Dmitry Osipenko wrote:
>> The tegra20-mc device-tree binding has been changed, GART has been
>> squashed into Memory Controller and now the clock property is mandatory
>> for Tegra20, the DT compatible has been changed as well. Adapt driver to
>> the DT changes.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>   drivers/memory/tegra/mc.c | 21 ++++++++-------------
>>   drivers/memory/tegra/mc.h |  6 ------
>>   include/soc/tegra/mc.h    |  2 +-
>>   3 files changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index e56862495f36..1b4ceefd82f9 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -51,7 +51,7 @@
>>   
>>   static const struct of_device_id tegra_mc_of_match[] = {
>>   #ifdef CONFIG_ARCH_TEGRA_2x_SOC
>> -	{ .compatible = "nvidia,tegra20-mc", .data = &tegra20_mc_soc },
>> +	{ .compatible = "nvidia,tegra20-mc-gart", .data = &tegra20_mc_soc },
> 
> Technically we now regress because we no longer support the older device
> tree bindings. I know that it doesn't really matter because this driver
> doesn't really do much interesting yet other than reporting memory
> access violations, but if that's enough to warrant a change of the
> compatible string, then I think we also need to preserve compatibility
> in the code.
> 
> That said, I think compatibility would be easier to preserve if we stuck
> with the old compatible string and used a "reg-names" property to
> specify which version of the binding we're referring to.
> 
> For example, we could have:
> 
> 	memory-controller@7000f000 {
> 		compatible = "nvidia,tegra20-mc";
> 		reg = <0x7000f000 0x024
> 		       0x7000f03c 0x3c4>;
> 		...
> 	};
> 
> for the old binding and:
> 
> 	memory-controller@7000f000 {
> 		compatible = "nvidia,tegra20-mc";
> 		reg = <0x7000f000 0x00000400>,
> 		      <0x58000000 0x02000000>;
> 		reg-names = "mc", "gart";
> 		...
> 	};
> 
> for the new binding. The driver can then easily check for the existence
> of the reg-names property and take the legacy or new code paths.

There is no problem with keeping compatibility for newer kernels with the older binding, 
it just not worth the effort. The real problem is keeping compatibility of older kernels 
with the new binding, the older kernels won't care about the reg-names and will treat GART 
registers as the second registers bank of the Memory Controller. Unfortunately I don't see 
how your suggestion is supposed to help with the problem.
