Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4813FC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A9820827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bge7TpD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A9820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbeKHB3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:29:23 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33406 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeKHB3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:29:22 -0500
Received: by mail-yw1-f66.google.com with SMTP id z72-v6so6785567ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w916eGqKYP1jjLzCXTMmsTdj+BbJ3ZC3m8I+i5a0GtA=;
        b=Bge7TpD2RkYW7COsMF9BfNqF1i4CuDcltYR1hAwNEIqaXBt9t7oIC1nP4gLhB2wabz
         CRKSJ77GBFyvIYFAXEhsxGBTU2r1EwxJO5AzfPPmYMVlU1QeupgP1YhnmC/zIGr7AQ5K
         0b480nTOyGYSjHENm25CR7FU47jSMpu0/cGgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w916eGqKYP1jjLzCXTMmsTdj+BbJ3ZC3m8I+i5a0GtA=;
        b=llUgGsX5TYRS+DN1Vp/2jwq6FuAz3iHtpYrE8gw6RNimwmdSoYORuic0DDYszExkXS
         ctgBpJ4/IBPS0sR3tWPWglDUShd+JwcWXzFcmc3vDYZRe2dmaXvvOkU1EQfEuNNsGoQe
         1N1dmEN3U7gHOYgk8JYd3nn8yj8nOdqQHtn50fm3e9fE/OGW1wrX/RwXhCxGGyPtjgKg
         4dVpp7bdw6seeJYk41abJTOb5cZloP9WU4JY00tbcb5xQuU0d7HtfToYD/yXWE93MyHG
         N/FDh1kSF3VlOp05O7zqwWnCx8gWjHiCUKRHt7AVynAIrALZtgIjgMJ1Prn1IQMCedSs
         RGZQ==
X-Gm-Message-State: AGRZ1gJPNLSNm6il17zjow2sw4Jpb9eSRVZuTHzu4I0ns3qCCVzX8+a2
        ZyfdAupQtKUMd2gh2DS2ZYLO
X-Google-Smtp-Source: AJdET5cI88WORg0EJo0nX8xUcFopcUc1CdxVCfZyDisn32MJTpLWkzLmNBnq7i7VrRrUUQF7DVHiwQ==
X-Received: by 2002:a0d:db02:: with SMTP id d2-v6mr744499ywe.402.1541606304711;
        Wed, 07 Nov 2018 07:58:24 -0800 (PST)
Received: from [10.28.17.185] ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h186-v6sm245503ywe.103.2018.11.07.07.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 07:58:24 -0800 (PST)
Subject: Re: [PATCH V3 4/6] usb: ohci-platform: Add support for Broadcom STB
 SoC's
To:     Alan Stern <stern@rowland.harvard.edu>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
References: <Pine.LNX.4.44L0.1811071019090.1542-100000@iolanthe.rowland.org>
From:   Al Cooper <al.cooper@broadcom.com>
Message-ID: <e4f2a868-c265-58c8-7b7b-91de91f2cf0b@broadcom.com>
Date:   Wed, 7 Nov 2018 10:58:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1811071019090.1542-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 10:23 AM, Alan Stern wrote:
> On Tue, 6 Nov 2018, Florian Fainelli wrote:
> 
>> On 11/6/18 1:40 PM, Al Cooper wrote:
>>> On 11/6/18 11:08 AM, Alan Stern wrote:
>>>> On Mon, 5 Nov 2018, Al Cooper wrote:
>>>>
>>>>> Add support for Broadcom STB SoC's to the ohci platform driver.
>>>>>
>>>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>>>>> ---
>>>>
>>>>> @@ -177,6 +189,8 @@ static int ohci_platform_probe(struct
>>>>> platform_device *dev)
>>>>>            ohci->flags |= OHCI_QUIRK_FRAME_NO;
>>>>>        if (pdata->num_ports)
>>>>>            ohci->num_ports = pdata->num_ports;
>>>>> +    if (pdata->suspend_without_phy_exit)
>>>>> +        hcd->suspend_without_phy_exit = 1;
>>>>
>>>> Sorry if I missed this in the earlier discussions...  Is there any
>>>> possibility of adding a DT binding that could express this requirement,
>>>> instead of putting it in the platform data?
>>>>
>>>> Alan Stern
>>>>
>>>
>>> Alan,
>>>
>>> That was my original approach but internal review suggested that I use
>>> pdata instead. Below is my original patch for:
>>
>> And the reason for that suggestion was really because it was percevied
>> as encoding a driver behavior as a Device Tree property as opposed to
>> describing something that was inherently and strictly a hardware
>> behavior (therefore suitable for Device Tree).
> 
> Right.  The best way to approach this problem is to identify and
> characterize the hardware behavior which makes this override necessary.
> Then _that_ can be added to DT, since it will be a property of the
> hardware rather than of the driver.
> 
>>> Add the ability to skip calling the PHY's exit routine on suspend
>>> and the PHY's init routine on resume. This is to handle a USB PHY
>>> that should have it's power_off function called on suspend but cannot
>>> have it's exit function called because on exit it will disable the
>>> PHY to the point where register accesses to the Host Controllers
>>> using the PHY will be disabled and the host drivers will crash.
> 
> What's special about this PHY?  Why does the exit function mess the PHY
> up?  Or to put it another way, why doesn't the exit function mess up
> other PHYs in the same way?
> 
> For that matter, can we change the code so that suspend doesn't call
> the exit function for _any_ PHY?  Will just calling the power_off
> function be good enough?  If not, then why not?
> 
> Alan Stern
> 

In our USB hardware the USB PHY supplies a clock for the EHCI/OHCI and 
XHCI host controllers and if the PHY is totally shut down the EHCI, OHCI 
and XHCI registers will cause an exception if accessed and cause the 
EHCI, OHCI and XHCI drivers to crash. There is always talk of fixing 
this in the hardware by adding an aux clock that will takeover when the 
PHY clock is shut down, but this hasn't happened yet. It seems like 
"exit on suspend" still makes sense on systems that don't have this 
problem (additional power savings?) so removing the exit on suspend for 
all systems is not a good idea.

Al
