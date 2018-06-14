Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0CC69C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1899208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1899208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755403AbeFNSxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:53:11 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46659 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754862AbeFNSxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:53:09 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so6784937qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nIFPUhWTNl3emafDJ/OF6TzQqRoV6bfgVi90mPrUGbs=;
        b=PNVBfYNMsEn5dCobQGWKfLd6Q/4puRgKVE+HRwsq1s6B5ENY+eJSFzqjT4fCSX+Xvs
         buWkCyUjqqY8r5gP6h81R9pknsnROwqa52B0zJ6TuLmkCJLEFOw9a8LMCsMgXe/0zrPy
         bpk+31ijGg1tIGlrt4fe9mJ2V7uJ4U+bioZpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nIFPUhWTNl3emafDJ/OF6TzQqRoV6bfgVi90mPrUGbs=;
        b=qyujOpIUHFUabVb9UpQKTBWcctwIrioGHXlQDrjEdyf2QbFN2jpbgDuRMDc7sr6Xiv
         RxhoRz92Q6JSaX3QK7PTRpj9sIrVP86JqUKGRxjP6jkPPdqUKrwyeCt7yo+aOGzfi88D
         FPSxYY/8/K2X+ZOK2KnLjo+49DPG2TRhknQN9HGLoAXW6YvA21ieZIR+280VujKjyZaS
         Y91r0mRlsdP1f7I0Evwkbn5yunKNxlW4f8efvLFPBMvpZHD4oyA7v3r9jyyT5BRcNa88
         V8ve9JogXEpeZIeIjVpC7AkQvj0nbSNIKocghYQbe5HgLrKIaI/G57ClNoxGEvKeBksD
         Euqw==
X-Gm-Message-State: APt69E2/0mbYpyrEkbPWX16orpKhN9JuzPSgXpgJ5vxVyE8jGL+p80RY
        qJPcMJf6iFJJ5MhiLOk8pOU1dOuD
X-Google-Smtp-Source: ADUXVKKBAU7W5TQNund71bz48z91hg+52nz2vMyJURuFwbMmQixXFES+e1McTRV2dryX9toUllmb8Q==
X-Received: by 2002:aed:2311:: with SMTP id h17-v6mr3563128qtc.144.1529002388486;
        Thu, 14 Jun 2018 11:53:08 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b15-v6sm4179385qkc.90.2018.06.14.11.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 11:53:07 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: stingray: use NUM_SATA to configure number of
 sata ports
To:     Rob Herring <rob.herring@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
 <d35afa1f-e0fd-84f1-7d42-60595e22cc77@gmail.com>
 <395f1fe8-76f1-8310-d09e-63e25bca23d2@broadcom.com>
 <CAL_JsqJEFLXFf-Vq9c9XC41vBpisQwxkd06_v8Fmt6X=gp=2_g@mail.gmail.com>
 <f20222ea-47ac-ca05-a8d3-69f28932de94@gmail.com>
 <0bf3c57c-dac8-8ece-6b8a-3b4d024140fc@broadcom.com>
 <CABGGiszcTNw23e_qA7EiGb_2hc6kHfVQJq02pQjbpTnv1CNksg@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <ad3e7225-35f6-f926-d925-42627154659b@broadcom.com>
Date:   Thu, 14 Jun 2018 11:53:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABGGiszcTNw23e_qA7EiGb_2hc6kHfVQJq02pQjbpTnv1CNksg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-06-13 03:06 PM, Rob Herring wrote:
> On Wed, Jun 13, 2018 at 2:18 PM, Scott Branden
> <scott.branden@broadcom.com> wrote:
>> Hi Rob,
>>
>> Thanks for comment - reply inline.
>>
>>
>>
>> On 18-06-13 12:31 PM, Florian Fainelli wrote:
>>> On 06/12/2018 03:54 PM, Rob Herring wrote:
>>>> On Thu, Jun 7, 2018 at 12:53 PM, Scott Branden
>>>> <scott.branden@broadcom.com> wrote:
>>>>> Hi Rob,
>>>>>
>>>>> Could you please kindly comment on change below.
>>>>>
>>>>> It allows board variants to be added easily via a simple define for
>>>>> different number of SATA ports.
>>>>>
>>>>>
>>>>>
>>>>> On 18-06-04 09:22 AM, Florian Fainelli wrote:
>>>>>> On 05/18/2018 11:34 AM, Scott Branden wrote:
>>>>>>> Move remaining sata configuration to stingray-sata.dtsi and enable
>>>>>>> ports based on NUM_SATA defined.
>>>>>>> Now, all that needs to be done is define NUM_SATA per board.
>>>>>> Rob could you review this and let us know if this approach is okay or
>>>>>> not? Thank you!
>>>>>>
>>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>>>> ---
>>>>>>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>>> b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>>> index 8c68e0c..7f6d176 100644
>>>>>>> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>>> @@ -43,7 +43,11 @@
>>>>>>>                           interrupts = <GIC_SPI 321
>>>>>>> IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>                           #address-cells = <1>;
>>>>>>>                           #size-cells = <0>;
>>>>>>> +#if (NUM_SATA > 0)
>>>>>>> +                       status = "okay";
>>>>>>> +#else
>>>>>>>                           status = "disabled";
>>>>>>> +#endif
>>>> This only works if ports are contiguously enabled (0-N). You might not
>>>> care, but it is not a pattern that works in general.
>> Correct - all board designs that include this dtsi file follow such
>> commonality (ie. design with SATA0 first, etc).  By having common board
>> designs it allows for commonality in dts files rather than duplicating
>> information everywhere.  If somebody designs a bizarro board they are free
>> to create their own dts file of course.
>>>>    And I'm not a fan
>>>> of C preprocessing in DT files in general beyond just defines for
>>>> single numbers.
>> The use of a define to specify the number of SATA ports in the board design
>> meets our requirements of being able to maintain many boards.  We need a
>> method to specify the number of ports in the board design rather than
>> copying and pasting the information in many dts files.  If you have an
>> alternative upstreamable mechanism to manage the configuration of many
>> boards without copy and paste that would be ideal?
> Is this really the only problem with maintaining lots of boards? What
> about all the other nodes that are conditionally enabled? Really, I
> don't see the problem with 3 lines per node.
Yes - the problem with maintaining lots of boards is having to copy and 
paste duplicated lines per nodes in many files which can be maintained 
with a single define.
>
> Does having an unused port enabled cause problems? If not, you could
> handle it all at run-time and just shutdown ports which have no link.
> You'd want to do that anyway for boards with a port, but is not
> connected to a drive (except for hotplug capable ports).
SATA is not the only place we use defines.  This is one change for 
review to see if there are any "real" problems with doing it upstream 
and get comment.  All the board variations simply add a few defines and 
don't need to do anything else using my approach.  No out-of-tree 
special tools or scripts required to generate dts files, no run-time 
bootloader or kernel changes necessary.
>
> Maybe we could add a property in /chosen that is a list of nodes to
> enable and either the bootloader or kernel could update their
> 'status'. Or It could even be done in dtc perhaps with some
> /directive/.
Sure, if it is a single line change needed through a "chosen" or 
"directive" instead of a "define" that sounds fine.  How would I do that 
in the SATA example?
I am looking for an in-tree solution to managing the boards in a simpler 
manner than what is available by cutting and pasting nodes in many files.
The use of the defines allows such without any special script or tool or 
repo needing to be maintained out of tree.
>
> Rob

