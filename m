Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eejJu8+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D7A560763
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbeFFRbb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:31:31 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39113 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeFFRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:31:29 -0400
X-Google-Smtp-Source: ADUXVKJyyILOqt86imNK3EPVGWzPxpdrYsafFiGisotCnM1wdSvyg1JzybdNPuH/lMZUJBxayME63g==
Subject: Re: [PATCH] ARM: dts: cygnus: Add HWRNG node
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
References: <20180606093441.16483-1-peron.clem@gmail.com>
 <c8836130-1d96-b813-4e87-5011db679ba8@broadcom.com>
 <c7990001-00e6-d828-bafd-3d472fcfee20@gmail.com>
 <CAJiuCcdfmrdHf10JkVOGQXD77JN=_FUv2ysEGTzyvwON31HX_A@mail.gmail.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <c3c49a49-f2c9-f4bb-bd97-f2010f1d4a0c@broadcom.com>
Date: Wed, 6 Jun 2018 10:31:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcdfmrdHf10JkVOGQXD77JN=_FUv2ysEGTzyvwON31HX_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-06-06 10:06 AM, Clément Péron wrote:
> Hi Scott, Florian,
>
> On Wed, 6 Jun 2018 at 18:47, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 06/06/201 8 09:03 AM, Scott Branden wrote:
>>> Hi Clement,
>>>
>>>
>>> On 18-06-06 02:34 AM, Clément Péron wrote:
>>>> From: Clément Peron <clement.peron@devialet.com>
>>>>
>>>> There is a HWRNG in Broadcom Cygnus SoC, so enable it.
>>>>
>>>> Signed-off-by: Clément Peron <clement.peron@devialet.com>
>>> Thanks for upstreaming some missing Cygnus components.
>>>
>>> But, the problem is the tarball release from Broadcom you are extracting
>>> these changes from does not contain git history; so, you are missing the
>>> original authors and signed-off's.
>>> I checked our internal git repository and for this commit the author is:
>>> Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
>>>
>>> Please adjust author and signed-off appropriately.  If there are other
>>> changes you are extracting from the source tarballs you have please
>>> contact me so we can construct patch appropriately.
>> If you want the original author's Signed-off-by to be preserved, why
>> don't you extract it from your internal git tree and submit the patch on
>> Mohamed's behalf?
>>
>> AFAICT what Clement is doing here is permissible given the Linux
>> developer certificate of origin though I am not a lawyer of course.
>> --
>> Florian
> Totally not my goal to steal the author and agree to keep track of the
> original author
> as soon as it's possible. I didn't though it was important for this
> patch as the same
> code is available in the dt-bindings documentation.
>
> Actually there are still some buggy components like DSA (Arun proposed
> a patch this morning)
> the PWM (config and delay aren't correct) and I2C. These are mainlined
> but can't be used
> and need a minimal effort to correctly work on Cygnus.
We have internal versions of most everything.  It's a matter of getting 
people to push the appropriate patches out for upstream version to work.
Please contact the bcm-kernel-feedback list with issues and we can work 
through common solution (or, likely already have a solution just not 
upstreamed).
>
> Also there are some important components like USB Phy or Mailbox that
> were proposed and
> almost made it, but just need a small modification to be accepted.
Again - we may have internal solution already.  Yes, mailbox was 
submitted upstream a long time ago and I think got stalled being 
accepted upstream.  We can work through upstream solution by starting 
with sending to bcm-kernel-feedback-list to discuss details.
>
> My idea was just to submit small patches that are trivial to review.
> In order to avoid keeping
> lots of patches in our kernel and also have something functional when
> building a mainline kernel.
I understand the difficulty you would have if you're trying to work with 
a different kernel version in our release.  If you send me a list 
directly of the drivers you use in Cygnus that will help me get those 
changes prioritized to be pushed upstream.  And/or we can work together 
on that.
>
> Regards,
> Clement
Thanks,
  Scott
