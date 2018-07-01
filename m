Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C34C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F9321545
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HapR8h5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F9321545
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030561AbeGARyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:54:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53170 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965078AbeGARyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:54:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id w16-v6so6074584wmc.2;
        Sun, 01 Jul 2018 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Lj8n2ojFUnc3yYApZULrlC+qSnU1dL6EMNwgDX8FzVQ=;
        b=HapR8h5+JhIP6m4IbV6gWrKLyHMWEHiYzl2PhDTlXt8gdE2BKyL7Jhoq03fW7rtOpY
         aLWmZ51dfk2ClwhEcBzbxDH0ujdVHPlQ3rDYjsiXKxcNM+AVH40UWdH9NwS2rBFjkngc
         VpxANP02fO/2cgmGpsiRV/klWkFAKpeHJDRXdrF1Kc/Cr6k05hz18tuhhZUzwMbFg3fC
         UqaAO+qUuwdS6aMZlNS0XBH1PfaZ4sbdqJtJtqL4AtOgf32EBiaZTZBqONb0KTnfOUzQ
         adFGvIVjVTUzovToJ+VM4v/t7Apd7L95CKprn+oJkllgDDH0m/q5/rostek/VrZRXR7W
         6JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Lj8n2ojFUnc3yYApZULrlC+qSnU1dL6EMNwgDX8FzVQ=;
        b=Y+62jAK47vhYmynklaZvpF8w4fwCvallwcIVBwAmqYm5BhxksKe/eWyVsUclETMXb2
         ydpIUF8BjO1T4z8G3pKQ7/pD7+lJSCPVJmu3kTimT+Q/LZc8j7o3SvKd/qfX+BIXLiDX
         R1qGf7bGEw7UCw4g8tDlk132YITE2AUV7HAUJLVht7G+x0JOZi8lWzymdhMxYgovkSjR
         pOUL7txZJisogY8jlyFjuTwdr5xQE3WA9gfdfiECCjt4P06SGE4QrjHrfUUUi2bZPDjw
         ZmP/bYud8iME80zgqxcUSd0yl0RFDzwgTq7tB42RRhHwO4DKeDduE8hfr4u7oM87u9hk
         +q8Q==
X-Gm-Message-State: APt69E2EMazg613MyKTeIhLwaHk2FxhprrZ3T1l6XpG9j+iNebGv5zsH
        DJdMAyY9K/ab7n0YjydDuH2XK6T8res=
X-Google-Smtp-Source: AAOMgpeEkE+v4x+4grQm/wN1Xz5HOQtnby/hhadgcUaaqhskoWrqEnKsh+d72HM5biwTirxV4sbZsA==
X-Received: by 2002:a1c:99c5:: with SMTP id b188-v6mr5915770wme.15.1530467651923;
        Sun, 01 Jul 2018 10:54:11 -0700 (PDT)
Received: from [192.168.0.103] (p5B3F6705.dip0.t-ipconnect.de. [91.63.103.5])
        by smtp.gmail.com with ESMTPSA id t11-v6sm3524725wro.53.2018.07.01.10.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 10:54:11 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dt-bindings: clock: Modify Actions Soc clock
 bindings
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     afaerber@suse.de, sboyd@kernel.org, pn@denx.de,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-4-sravanhome@gmail.com>
 <20180630093202.GB7320@Mani-XPS-13-9360>
 <15070ea0-aebf-2b7d-89f0-b21e729c927e@gmail.com>
 <20180701173706.GA15895@Mani-XPS-13-9360>
From:   Saravanan Sekar <sravanhome@gmail.com>
Message-ID: <c9c737ff-c94f-a508-2cf7-a12456ec9e8a@gmail.com>
Date:   Sun, 1 Jul 2018 19:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180701173706.GA15895@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,


On 07/01/18 19:37, Manivannan Sadhasivam wrote:
> On Sun, Jul 01, 2018 at 07:26:20PM +0200, Saravanan Sekar wrote:
>> Hi Mani
>>
>>
>> On 06/30/18 11:32, Manivannan Sadhasivam wrote:
>>> Hi Saravanan,
>>>
>>> I agree with modifying the existing binding to accomodate other
>>> SoC's of the same family. But the binding should be
>>> "actions,owl-cmu.txt" since it reflects the family name.
>> Agree, will modify the name
>>
>>> Andreas, what do you think?
>>>
>>> On Thu, Jun 28, 2018 at 09:18:05PM +0200, Saravanan Sekar wrote:
>>>> Modify clock bindings common Actions Semi Soc family S700/S900.
>>>>
>>>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>>>> ---
>>>>    ...tions,s900-cmu.txt => actions,sx00-cmu.txt} | 18 ++++++++++--------
>>>>    1 file changed, 10 insertions(+), 8 deletions(-)
>>>>    rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
>>>> similarity index 71%
>>>> rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
>>>> rename to Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
>>>> index 93e4fb827cd6..8dc7edb4d198 100644
>>>> --- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
>>>> +++ b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
>>>> @@ -1,12 +1,14 @@
>>>> -* Actions S900 Clock Management Unit (CMU)
>>>> +* Actions S900/S700 Clock Management Unit (CMU)
>>> Same as above. Should be Actions OWL SoC's Clock Management Unit (CMU).
>> sure
>>
> During the review of I2C controller driver, Andreas pointed out that
> we should use Owl instead of OWL in all places and also Actions should
> be replaced by Actions Semiconductor. So, please change it in relevant
> places. For this binding, title should be:
>
> Actions Semiconductor Owl SoC's Clock Management Unit (CMU).


Ok will change as mentioned above.

> Thanks,
> Mani
>
>>>> -The Actions S900 clock management unit generates and supplies clock to various
>>>> -controllers within the SoC. The clock binding described here is applicable to
>>>> -S900 SoC.
>>>> +The Actions S900/S700 clock management unit generates and supplies clock to
>>>> +various controllers within the SoC. The clock binding described here is
>>>> +applicable to S900/S700 SoC.
>>>>    Required Properties:
>>>> -- compatible: should be "actions,s900-cmu"
>>>> +- compatible: should be one of this
>>> Change to: compatible: should be one of the following:
>> sure
>>
>>> Thanks,
>>> Mani
>>>
>>>> +	"actions,s900-cmu"
>>>> +	"actions,s700-cmu"
>>>>    - reg: physical base address of the controller and length of memory mapped
>>>>      region.
>>>>    - clocks: Reference to the parent clocks ("hosc", "losc")
>>>> @@ -15,9 +17,9 @@ Required Properties:
>>>>    Each clock is assigned an identifier, and client nodes can use this identifier
>>>>    to specify the clock which they consume.
>>>> -All available clocks are defined as preprocessor macros in
>>>> -dt-bindings/clock/actions,s900-cmu.h header and can be used in device
>>>> -tree sources.
>>>> +All available clocks are defined as preprocessor macros in corresponding
>>>> +dt-bindings/clock/actions,s900-cmu.h or s700-cmu.h header and can be used in
>>>> +device tree sources.
>>>>    External clocks:
>>>> -- 
>>>> 2.18.0
>>>>
>> Thanks,
>> Saravanan

