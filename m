Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C925DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E7220862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MEGQr8XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E7220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbeKHDMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:12:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45025 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbeKHDMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:12:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so7599055pgs.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ARzXNn6/nICGZMs9oHPbSoGfh7bmfrp8eFyC7A9bq9E=;
        b=MEGQr8XWCGnZg8U0cSEazxWWxye/6kO8iLBhw4u4pbWhxKtyE+Po81WD0LOmYWWDWS
         whIOsASxtov3Iz34yO5SkQFvNL7cMo6xyDQ98VfKgOG6lmwBqgfPEU+JW+IrawNjhd+T
         Q8sZJocEA6/yFR/dra0KhHn4u3BxMRLheiEEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ARzXNn6/nICGZMs9oHPbSoGfh7bmfrp8eFyC7A9bq9E=;
        b=cWqMsgNhVDqg7N3E3ZXbVC55UQxu5zrdOeUlFg3nPG/B0Z2doTLMmgUdqQ7XoFA4T0
         Em8vlwvdMYF9Edd0c7TIvdP9iYQJ1OLBpc/fmdzjqTfFK72Cz2RH2Cgq9oe9wWDsCFxi
         bo00nSSUMdjlEp4LUycdoiitFtM0bdxbwdOgCOJN9u6Jd+zyEyk1BBl2HLJSL7VrvlK7
         YYqbKEcJg4h/T98ospJlENSM6S+4O22lwu9IJOhRnpwjh0FCM6nZE/RWx942jFq5Fnuc
         kO1lq/Vak6EZJGNugC4D5QbT4u4VhPLcvT9WYQ1cvd9TZWhNqkeyLv8z2x5P+QsNKxvP
         S/Cw==
X-Gm-Message-State: AGRZ1gI/SP/dtG0Y3UFP3e9TYVyEmpjAU7eA/uzQcBTTFNsyiT92KNtW
        u4RwUmWjW0f++aftnmVMSvTN
X-Google-Smtp-Source: AJdET5enYm5ZW9nQeib976skvza6fYuZQpIR7/56hMBeGYE0qlj7JW/x4pWhBEQbIR8okgE33dbJsg==
X-Received: by 2002:a62:8c93:: with SMTP id m141-v6mr1071534pfd.239.1541612453573;
        Wed, 07 Nov 2018 09:40:53 -0800 (PST)
Received: from [10.28.17.185] ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm1430583pfr.55.2018.11.07.09.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 09:40:52 -0800 (PST)
Subject: Re: [PATCH V3 4/6] usb: ohci-platform: Add support for Broadcom STB
 SoC's
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
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
References: <Pine.LNX.4.44L0.1811071124260.1542-100000@iolanthe.rowland.org>
 <16a80878-58f7-1584-058e-0e0e49da61cb@gmail.com>
From:   Al Cooper <al.cooper@broadcom.com>
Message-ID: <45134862-4b72-be72-533c-942c2bf70400@broadcom.com>
Date:   Wed, 7 Nov 2018 12:40:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <16a80878-58f7-1584-058e-0e0e49da61cb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 12:29 PM, Florian Fainelli wrote:
> On 11/7/18 8:27 AM, Alan Stern wrote:
>> On Wed, 7 Nov 2018, Al Cooper wrote:
>>
>>> On 11/7/18 10:23 AM, Alan Stern wrote:
>>>> On Tue, 6 Nov 2018, Florian Fainelli wrote:
>>>>
>>>>> On 11/6/18 1:40 PM, Al Cooper wrote:
>>>>>> On 11/6/18 11:08 AM, Alan Stern wrote:
>>>>>>> On Mon, 5 Nov 2018, Al Cooper wrote:
>>>>>>>
>>>>>>>> Add support for Broadcom STB SoC's to the ohci platform driver.
>>>>>>>>
>>>>>>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>>>>>>>> ---
>>>>>>>
>>>>>>>> @@ -177,6 +189,8 @@ static int ohci_platform_probe(struct
>>>>>>>> platform_device *dev)
>>>>>>>>             ohci->flags |= OHCI_QUIRK_FRAME_NO;
>>>>>>>>         if (pdata->num_ports)
>>>>>>>>             ohci->num_ports = pdata->num_ports;
>>>>>>>> +    if (pdata->suspend_without_phy_exit)
>>>>>>>> +        hcd->suspend_without_phy_exit = 1;
>>>>>>>
>>>>>>> Sorry if I missed this in the earlier discussions...  Is there any
>>>>>>> possibility of adding a DT binding that could express this requirement,
>>>>>>> instead of putting it in the platform data?
>>>>>>>
>>>>>>> Alan Stern
>>>>>>>
>>>>>>
>>>>>> Alan,
>>>>>>
>>>>>> That was my original approach but internal review suggested that I use
>>>>>> pdata instead. Below is my original patch for:
>>>>>
>>>>> And the reason for that suggestion was really because it was percevied
>>>>> as encoding a driver behavior as a Device Tree property as opposed to
>>>>> describing something that was inherently and strictly a hardware
>>>>> behavior (therefore suitable for Device Tree).
>>>>
>>>> Right.  The best way to approach this problem is to identify and
>>>> characterize the hardware behavior which makes this override necessary.
>>>> Then _that_ can be added to DT, since it will be a property of the
>>>> hardware rather than of the driver.
>>>>
>>>>>> Add the ability to skip calling the PHY's exit routine on suspend
>>>>>> and the PHY's init routine on resume. This is to handle a USB PHY
>>>>>> that should have it's power_off function called on suspend but cannot
>>>>>> have it's exit function called because on exit it will disable the
>>>>>> PHY to the point where register accesses to the Host Controllers
>>>>>> using the PHY will be disabled and the host drivers will crash.
>>>>
>>>> What's special about this PHY?  Why does the exit function mess the PHY
>>>> up?  Or to put it another way, why doesn't the exit function mess up
>>>> other PHYs in the same way?
>>>>
>>>> For that matter, can we change the code so that suspend doesn't call
>>>> the exit function for _any_ PHY?  Will just calling the power_off
>>>> function be good enough?  If not, then why not?
>>>>
>>>> Alan Stern
>>>>
>>>
>>> In our USB hardware the USB PHY supplies a clock for the EHCI/OHCI and
>>> XHCI host controllers and if the PHY is totally shut down the EHCI, OHCI
>>> and XHCI registers will cause an exception if accessed and cause the
>>> EHCI, OHCI and XHCI drivers to crash. There is always talk of fixing
>>> this in the hardware by adding an aux clock that will takeover when the
>>> PHY clock is shut down, but this hasn't happened yet. It seems like
>>> "exit on suspend" still makes sense on systems that don't have this
>>> problem (additional power savings?) so removing the exit on suspend for
>>> all systems is not a good idea.
>>
>> Then in theory you should be able to add a Device Tree property which
>> says that the PHY provides a clock for the USB host controller.  That
>> is strictly a property of the hardware; it has nothing to do with the
>> driver.  Therefore it is appropriate for DT.
> 
> The very compatible string that is being allocated/defined for this
> controller carries that information already, that is, if you probe a
> "brcm,bcm7445-ohci" compatible then that means the controller has a
> dependency on the PHY to supply its clock.
> 
> Adding a property vs. keying on the compatible string makes sense if you
> know there is at least a second consumer of that property (unless we
> make it a broadcom specific property, in which case, it really is
> redundant with the compatible string).
> 
> Anyway, my grudge with that property was the name chosen initially,
> which included an action to be performed by an implementation as opposed
> to something purely descriptive. E.g: 'phy-supplies-clock' might be okay.
> 
>>
>> Wouldn't this solve your issue?
> 
> It would not change much except that there is no need to much with
> ohci-platform.c anymore, but ultimately that property needs to be read
> by ohci-hcd.c and acted on, which would likely lead to the same amount
> of changes as those present in patch #2 currently.
> 
We also need this functionality in the EHCI and XHCI drivers and it's 
not the ohci-hcd.c module that needs to know, it's the core/phy.c module 
called from core/hcd.c.

Al
