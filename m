Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ADDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1662E2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEVD/X+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1662E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeIYSYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:24:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43555 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:24:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so21445360lje.10;
        Tue, 25 Sep 2018 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jHfQGnZ93soRX8VpKjRe4BLMCVLRBA9eyyCIF+JnMC0=;
        b=TEVD/X+hYLn5kc7fnMZzFrEDPapAGdOpffoiTxOS6U6Iyy6f4qMm0CAdG1P+CTQs6T
         GfnWOQvRPBj1fcw+mT5VgxSJS1eq8j9mNDzPAX4q/Qb3mgeI1yB/9HwVWW3T/daDVGWo
         UXmk73fmCynNES9qWHXAsEmuZ25Gpv665ORoB6HW4jkKI6qoD0YLcpwSBkuG57AduxCN
         rW8MLpkBbbbEJ3e817THJjdVSh9bHeqyZMrosg9/PsjNuZkvyxRKRCkN3znuh4DzxtrI
         VXT9sYAfhQrrSSBqg4q4SYKGZsGqHIAH3fl3yPzURHWdTgurDwzV7AwgU1FgF055WQBf
         OR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHfQGnZ93soRX8VpKjRe4BLMCVLRBA9eyyCIF+JnMC0=;
        b=YLHh3/uebUQUZ5bR7UXDximj05FlXBcFGIipUkv4kQJnq9PljljtLaE52YPtcOtVEi
         nw1FxPFXBuDHkG06+xgt0/Xr4bpb8V2CmgVT1RNNR1QevZ1rjWCBugHkxL2q/FgkO0B+
         Y5dY9lBq1N+xFQk/AmijVXb2dq74bC/2pCe4pCs9zxJ1B2wW43AMSeNnYoqTsMtGdgze
         XV/XuP1GQbPZmZWip3OGvzYwe42d2hMsq5DjEW1c1uVE2k/JcQ94PkoeKS96srbLwJ0R
         Dzk+vDkCudEz1cEywY+KDLQXCgZJNhz/x8w6XYFE87RBYyu1N4lmoN1WCOJWDHM2i6T7
         lA9Q==
X-Gm-Message-State: ABuFfogVeRofaMcKGps3+hUKy2HdQhn6qrQoYn+c18eqlF2HNYlp0Xyy
        8coFdZfLyIpxWo0Ib33gYSISTPvI
X-Google-Smtp-Source: ACcGV63UDLySIBqXtHOktVk1LdPh3P/oaMz3OdGIM2JG5knLrl+vhSllXwgAC8B3zhB/79ufmFD9Hw==
X-Received: by 2002:a2e:2025:: with SMTP id g37-v6mr740492ljg.40.1537877808802;
        Tue, 25 Sep 2018 05:16:48 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm391362ljk.20.2018.09.25.05.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:16:48 -0700 (PDT)
Subject: Re: [PATCH v4 09/20] memory: tegra: Adapt to Tegra20 device-tree
 binding changes
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-10-digetx@gmail.com> <20180924100205.GB21032@ulmo>
 <bca7c87a-5f86-4a98-bb6b-411c641a0e80@gmail.com>
Message-ID: <3bf4cd84-3d67-e7eb-7786-bbe952ad4075@gmail.com>
Date:   Tue, 25 Sep 2018 15:16:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <bca7c87a-5f86-4a98-bb6b-411c641a0e80@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 4:22 PM, Dmitry Osipenko wrote:
> On 9/24/18 1:02 PM, Thierry Reding wrote:
>> On Mon, Sep 24, 2018 at 03:41:42AM +0300, Dmitry Osipenko wrote:
>>> The tegra20-mc device-tree binding has been changed, GART has been
>>> squashed into Memory Controller and now the clock property is mandatory
>>> for Tegra20, the DT compatible has been changed as well. Adapt driver to
>>> the DT changes.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>   drivers/memory/tegra/mc.c | 21 ++++++++-------------
>>>   drivers/memory/tegra/mc.h |  6 ------
>>>   include/soc/tegra/mc.h    |  2 +-
>>>   3 files changed, 9 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>>> index e56862495f36..1b4ceefd82f9 100644
>>> --- a/drivers/memory/tegra/mc.c
>>> +++ b/drivers/memory/tegra/mc.c
>>> @@ -51,7 +51,7 @@
>>>     static const struct of_device_id tegra_mc_of_match[] = {
>>>   #ifdef CONFIG_ARCH_TEGRA_2x_SOC
>>> -    { .compatible = "nvidia,tegra20-mc", .data = &tegra20_mc_soc },
>>> +    { .compatible = "nvidia,tegra20-mc-gart", .data =
>>> &tegra20_mc_soc },
>>
>> Technically we now regress because we no longer support the older device
>> tree bindings. I know that it doesn't really matter because this driver
>> doesn't really do much interesting yet other than reporting memory
>> access violations, but if that's enough to warrant a change of the
>> compatible string, then I think we also need to preserve compatibility
>> in the code.
>>
>> That said, I think compatibility would be easier to preserve if we stuck
>> with the old compatible string and used a "reg-names" property to
>> specify which version of the binding we're referring to.
>>
>> For example, we could have:
>>
>>     memory-controller@7000f000 {
>>         compatible = "nvidia,tegra20-mc";
>>         reg = <0x7000f000 0x024
>>                0x7000f03c 0x3c4>;
>>         ...
>>     };
>>
>> for the old binding and:
>>
>>     memory-controller@7000f000 {
>>         compatible = "nvidia,tegra20-mc";
>>         reg = <0x7000f000 0x00000400>,
>>               <0x58000000 0x02000000>;
>>         reg-names = "mc", "gart";
>>         ...
>>     };
>>
>> for the new binding. The driver can then easily check for the existence
>> of the reg-names property and take the legacy or new code paths.
> 
> There is no problem with keeping compatibility for newer kernels with
> the older binding, it just not worth the effort. The real problem is
> keeping compatibility of older kernels with the new binding, the older
> kernels won't care about the reg-names and will treat GART registers as
> the second registers bank of the Memory Controller. Unfortunately I
> don't see how your suggestion is supposed to help with the problem.

I've another variant. What about to drop the GART registers from the
binding? The range is always fixed and there is no good reason to
artificially change it. I recall that in the past you didn't like the
patch that made the GART's aperture size fixed, saying that some
imaginary person may want to change it via DT. It's still not a very
good argument to me, I can't see a good reason why anyone may want to
change the aperture size.

The new binding will look like this (just like T30+ binding, only
iommu-cells number differ):

     memory-controller@7000f000 {
         compatible = "nvidia,tegra20-mc";
         reg = <0x7000f000 0x00000400>;
         clocks = <&tegra_car TEGRA20_CLK_MC>;
         clock-names = "mc";

         interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;

         #reset-cells = <1>;
         #iommu-cells = <0>;
     };

That way older kernel will continue to work with the new binding because
of the miss of the second registers range and new kernels may keep
supporting the old binding. Though I don't think that keeping support of
the old binding really worth the churning. Thoughts?

Note that new kernels will require the "mc" clock and hence the old
binding will be rejected because it doesn't have that clock.
