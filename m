Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB97C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CCF2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CCF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeH2Lvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:51:32 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52960 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2Lvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:51:32 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 420dGc6qyMz1qvpF;
        Wed, 29 Aug 2018 09:55:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 420dGb1Pzsz1tLNq;
        Wed, 29 Aug 2018 09:55:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id wne3ClngwfNm; Wed, 29 Aug 2018 09:55:49 +0200 (CEST)
X-Auth-Info: Nb7AJhgAOcG15FhwbMwv4JMQVvtQmZjFVmqWi284ayo=
Received: from antares.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 29 Aug 2018 09:55:49 +0200 (CEST)
Cc:     pn@denx.de, sravanhome@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mp-cs@actions-semi.com, Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        linux@cubietech.com
Subject: Re: [PATCH v4 0/5] Add Actions Semi S700 pinctrl support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <0180729200038.11795-1-sravanhome@gmail.com>
 <20180731194743.13678-1-sravanhome@gmail.com>
 <CACRpkda=q+LZMUN5xJ777ZGWxYRBdZTvG0naNqr5BoLnVQ1=aA@mail.gmail.com>
 <20180829074119.GA24958@Mani-XPS-13-9360>
From:   Parthiban Nallathambi <pn@denx.de>
Message-ID: <3c8a46a3-4884-ba0e-c72e-2e03357d6e40@denx.de>
Date:   Wed, 29 Aug 2018 09:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829074119.GA24958@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 08/29/2018 09:41 AM, Manivannan Sadhasivam wrote:
> On Wed, Aug 29, 2018 at 09:35:38AM +0200, Linus Walleij wrote:
>> On Tue, Jul 31, 2018 at 9:48 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>>
>>> This patchset adds pinctrl support for Actions Semi S700 SoC.
>>> Pinmux functions are only accessible for pin groups while pinconf
>>> parameters are available for both pin groups and individual pins.
>>>
>>> pinctrl driver is verified using the Cubieboard7.
>>>
>>> common functionalities from s900 is moved for all Actions Semi
>>> SoC's usage.
>>> Common pad control configurations are moved to SoC specific
>>>
>>> dts entry for pinctrl depends on clock driver which is still under review:
>>> https://patchwork.kernel.org/patch/10533959/
>>
>> So what is the status of this patch set?
>>
> 
> Oops. This one slipped through the cracks...
> 
>> I am happy to apply it once you have the right buildtime dependencies
>> and Manivannan's ACK on the patch set! (Looks good to me.)
>>
> 
> Sadly mutt played its part on this patchset and 1,3 patches got
> deleted accidentally.
> 
>> Maybe you want to rebase on v4.19-rc1 and resend as v5 before
>> I do that though?
>>
> 
> Parthiban,
> 
> Can you please rebase and send the next iteration as Linus said. I'll take a
> look.

Sure, will send it today after rebase.

> 
> Sorry for the late reply.
> 
> Regards,
> Mani
> 
>> Yours,
>> Linus Walleij

-- 
Thanks,
Parthiban N
