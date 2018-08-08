Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2DFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731E0219EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aTSOOqRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731E0219EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHHPLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:11:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58950 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeHHPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:11:24 -0400
Received: from [192.168.0.67] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98AFC57;
        Wed,  8 Aug 2018 14:51:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533732708;
        bh=y//qQYoIbU08EZuBytCqAM616fsUErEcG7lbzoui5uM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aTSOOqRqQ9XhUVCOGBjJJkZUlWNUFeCayLymJvJi5hB2yL5ilfXR0idJ+cUgtkZSx
         41ugbqFSSRumFCrGexcFemkPCIygWzNvsp8cxvC0DhU85VeZXEIJuofT6UiDb89nnx
         YHQPKw7iZZDpZK1jUZiWonLQEegd0KIv/LSb0tbo=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH] media: dt: adv7604: Fix slave map documentation
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180807155452.797-1-kieran.bingham@ideasonboard.com>
 <505904fb-7bfc-c455-740e-b72a14731eb9@ysoft.com>
 <b5b25641-f898-577b-7762-d72dd64272cf@ideasonboard.com>
 <5273911.bCJl0SVgzf@avalon> <bc69dca9-89c7-2df7-3dea-d6ee6651677e@ysoft.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 xsFNBFYE/WYBEACs1PwjMD9rgCu1hlIiUA1AXR4rv2v+BCLUq//vrX5S5bjzxKAryRf0uHat
 V/zwz6hiDrZuHUACDB7X8OaQcwhLaVlq6byfoBr25+hbZG7G3+5EUl9cQ7dQEdvNj6V6y/SC
 rRanWfelwQThCHckbobWiQJfK9n7rYNcPMq9B8e9F020LFH7Kj6YmO95ewJGgLm+idg1Kb3C
 potzWkXc1xmPzcQ1fvQMOfMwdS+4SNw4rY9f07Xb2K99rjMwZVDgESKIzhsDB5GY465sCsiQ
 cSAZRxqE49RTBq2+EQsbrQpIc8XiffAB8qexh5/QPzCmR4kJgCGeHIXBtgRj+nIkCJPZvZtf
 Kr2EAbc6tgg6DkAEHJb+1okosV09+0+TXywYvtEop/WUOWQ+zo+Y/OBd+8Ptgt1pDRyOBzL8
 RXa8ZqRf0Mwg75D+dKntZeJHzPRJyrlfQokngAAs4PaFt6UfS+ypMAF37T6CeDArQC41V3ko
 lPn1yMsVD0p+6i3DPvA/GPIksDC4owjnzVX9kM8Zc5Cx+XoAN0w5Eqo4t6qEVbuettxx55gq
 8K8FieAjgjMSxngo/HST8TpFeqI5nVeq0/lqtBRQKumuIqDg+Bkr4L1V/PSB6XgQcOdhtd36
 Oe9X9dXB8YSNt7VjOcO7BTmFn/Z8r92mSAfHXpb07YJWJosQOQARAQABzTBLaWVyYW4gQmlu
 Z2hhbSA8a2llcmFuLmJpbmdoYW1AaWRlYXNvbmJvYXJkLmNvbT7CwYAEEwEKACoCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4ACGQEFAlnDk/gFCQeA/YsACgkQoR5GchCkYf3X5w/9EaZ7
 cnUcT6dxjxrcmmMnfFPoQA1iQXr/MXQJBjFWfxRUWYzjvUJb2D/FpA8FY7y+vksoJP7pWDL7
 QTbksdwzagUEk7CU45iLWL/CZ/knYhj1I/+5LSLFmvZ/5Gf5xn2ZCsmg7C0MdW/GbJ8IjWA8
 /LKJSEYH8tefoiG6+9xSNp1p0Gesu3vhje/GdGX4wDsfAxx1rIYDYVoX4bDM+uBUQh7sQox/
 R1bS0AaVJzPNcjeC14MS226mQRUaUPc9250aj44WmDfcg44/kMsoLFEmQo2II9aOlxUDJ+x1
 xohGbh9mgBoVawMO3RMBihcEjo/8ytW6v7xSF+xP4Oc+HOn7qebAkxhSWcRxQVaQYw3S9iZz
 2iA09AXAkbvPKuMSXi4uau5daXStfBnmOfalG0j+9Y6hOFjz5j0XzaoF6Pln0jisDtWltYhP
 X9LjFVhhLkTzPZB/xOeWGmsG4gv2V2ExbU3uAmb7t1VSD9+IO3Km4FtnYOKBWlxwEd8qOFpS
 jEqMXURKOiJvnw3OXe9MqG19XdeENA1KyhK5rqjpwdvPGfSn2V+SlsdJA0DFsobUScD9qXQw
 OvhapHe3XboK2+Rd7L+g/9Ud7ZKLQHAsMBXOVJbufA1AT+IaOt0ugMcFkAR5UbBg5+dZUYJj
 1QbPQcGmM3wfvuaWV5+SlJ+WeKIb8tbOwU0EVgT9ZgEQAM4o5G/kmruIQJ3K9SYzmPishRHV
 DcUcvoakyXSX2mIoccmo9BHtD9MxIt+QmxOpYFNFM7YofX4lG0ld8H7FqoNVLd/+a0yru5Cx
 adeZBe3qr1eLns10Q90LuMo7/6zJhCW2w+HE7xgmCHejAwuNe3+7yt4QmwlSGUqdxl8cgtS1
 PlEK93xXDsgsJj/bw1EfSVdAUqhx8UQ3aVFxNug5OpoX9FdWJLKROUrfNeBE16RLrNrq2ROc
 iSFETpVjyC/oZtzRFnwD9Or7EFMi76/xrWzk+/b15RJ9WrpXGMrttHUUcYZEOoiC2lEXMSAF
 SSSj4vHbKDJ0vKQdEFtdgB1roqzxdIOg4rlHz5qwOTynueiBpaZI3PHDudZSMR5Fk6QjFooE
 XTw3sSl/km/lvUFiv9CYyHOLdygWohvDuMkV/Jpdkfq8XwFSjOle+vT/4VqERnYFDIGBxaRx
 koBLfNDiiuR3lD8tnJ4A1F88K6ojOUs+jndKsOaQpDZV6iNFv8IaNIklTPvPkZsmNDhJMRHH
 Iu60S7BpzNeQeT4yyY4dX9lC2JL/LOEpw8DGf5BNOP1KgjCvyp1/KcFxDAo89IeqljaRsCdP
 7WCIECWYem6pLwaw6IAL7oX+tEqIMPph/G/jwZcdS6Hkyt/esHPuHNwX4guqTbVEuRqbDzDI
 2DJO5FbxABEBAAHCwWUEGAEKAA8CGwwFAlnDlGsFCQeA/gIACgkQoR5GchCkYf1yYRAAq+Yo
 nbf9DGdK1kTAm2RTFg+w9oOp2Xjqfhds2PAhFFvrHQg1XfQR/UF/SjeUmaOmLSczM0s6XMeO
 VcE77UFtJ/+hLo4PRFKm5X1Pcar6g5m4xGqa+Xfzi9tRkwC29KMCoQOag1BhHChgqYaUH3yo
 UzaPwT/fY75iVI+yD0ih/e6j8qYvP8pvGwMQfrmN9YB0zB39YzCSdaUaNrWGD3iCBxg6lwSO
 LKeRhxxfiXCIYEf3vwOsP3YMx2JkD5doseXmWBGW1U0T/oJF+DVfKB6mv5UfsTzpVhJRgee7
 4jkjqFq4qsUGxcvF2xtRkfHFpZDbRgRlVmiWkqDkT4qMA+4q1y/dWwshSKi/uwVZNycuLsz+
 +OD8xPNCsMTqeUkAKfbD8xW4LCay3r/dD2ckoxRxtMD9eOAyu5wYzo/ydIPTh1QEj9SYyvp8
 O0g6CpxEwyHUQtF5oh15O018z3ZLztFJKR3RD42VKVsrnNDKnoY0f4U0z7eJv2NeF8xHMuiU
 RCIzqxX1GVYaNkKTnb/Qja8hnYnkUzY1Lc+OtwiGmXTwYsPZjjAaDX35J/RSKAoy5wGo/YFA
 JxB1gWThL4kOTbsqqXj9GLcyOImkW0lJGGR3o/fV91Zh63S5TKnf2YGGGzxki+ADdxVQAm+Q
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <4e8e3546-21f0-33c2-42b2-db0bbe9ed11d@ideasonboard.com>
Date:   Wed, 8 Aug 2018 13:51:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bc69dca9-89c7-2df7-3dea-d6ee6651677e@ysoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 08/08/18 13:33, Michal Vokáč wrote:
> On 8.8.2018 12:25, Laurent Pinchart wrote:
>> Hi Kieran,
>>
>> On Wednesday, 8 August 2018 13:23:32 EEST Kieran Bingham wrote:
>>> Hi Michal,
>>>
>>> Thank you for your review.
>>>
>>> +Rob, +Mark, +Laurent asking for opinions if anyone has any on prefixes
>>> through media tree.
>>>
>>> On 08/08/18 08:48, Michal Vokáč wrote:
>>>> On 7.8.2018 17:54, Kieran Bingham wrote:
>>>> Hi Kieran,
>>>>
>>>>> The reg-names property in the documentation is missing an '='. Add it.
>>>>>
>>>>> Fixes: 9feb786876c7 ("media: dt-bindings: media: adv7604: Extend
>>>>> bindings to allow specifying slave map addresses")
>>>>
>>>> "dt-bindings: media: " is preferred for the subject.
>>>
>>> This patch will go through the media-tree as far as I am aware, and
>>> Mauro prefixes all commits through the media tree with "media:" if they
>>> are not already prefixed.
> 
> OK, I did not know about that practice with the prefix.

It's media specific. It used to be [media], but now changed to "media:"


> Anyway, why should this patch go through media-tree when it is a single
> patch affecting device tree binding only? I would expect it to be picked
> by Rob or Mark.


My change 9feb786876c7 went through the media tree, because it directly
affected a media driver. This change affects the same thing, so I
assumed it's a media-tree patch, but I could be wrong. I'll await to be
told :)



>>> Thus this would then become "media: dt-bindings: media: adv7604: ...."
>>> as per my commit: 9feb786876c7 which seems a bit redundant.
> 
> Agree that this seems redundant. Absolutely no offense, just a curious
> newbee question - why is the "media:" prefix added later on to *all* the
> patches at all?

Mauro's tree style choice as far as I know.


> I understand that each subsystem has it own convenience what subject
> prefix to use. Given that all patches are propperly formated after
> the review process is finished I do not see a reason why the subject
> should be changed.
> 
> So patches to "drivers/media/xxx" should land as "media: xxx: ..." and
> patches to "Documentation/devicetree/bindings/xxx" should land as
> "dt-bindings: media: xxx".
> 
> This allows easier git log browsing.
>>>
>>> Is it still desired ? If so I'll send a V2. (perhaps needed anyway, as I
>>> seem to have erroneously shortened dt-bindings: to just dt: which wasn't
>>> intentional.
> 
> I do not know. Some time ago I tripped over a patch from Rob explaining
> how to properly format dt-binding related patches. I also read a bunch
> of his replies to emails that were kind of "out of bounds" in this regard.
> So I got an impression that he is starting to be upset that people still
> make the same mistakes and do not read
> devicetree/bindings/submitting-patches.txt

Well - I didn't know that existed :) So I've learnt something new.

Seems we now have three "submitting-patches" files to read:

find | grep submitting-patches
./Documentation/process/submitting-patches.rst
./Documentation/hwmon/submitting-patches
./Documentation/devicetree/bindings/submitting-patches.txt


Perhaps adding some rules into checkpatch.pl is the way forward to
enforce prefixes where necessary ?

> I deeply memorized that "rules" and once a while I go through the DT list
> and reply to some emails that does not fit. Just because I am sure
> that all maintainers are overloaded and surely have something more useful
> to do than commenting on trivial mistakes.
Absolutely! I believe that is a worthwhile thing to do :) and certainly
eases the strain on maintainers.


> Next time I will choose more wisely what emails I reply to :)
>>>
>>>> I think you should also add device tree maintainers to the recipients.
>>>
>>> Added to this mail to ask opinions on patch prefixes above.
>>>
>>> Originally, I believed the list was sufficient as this is a trivial
>>> patch, and it goes through the media tree.
>>>
>>> But, it turned out to be more controversial :)
>>>
>>> Rob, Mark, should I add you to all patches affecting DT? Or is the list
>>> sufficient?
>>
>> Given the insane amount of patches received by DT maintainers, I
>> personally
>> try to use common sense and only disturb them when needed. Such a typo
>> fix
>> doesn't qualify for a full CC list in my opinion.
> 
> OK, sorry you spent your time discussing such a trivial thing folks.
> I am still learning how to efficiently contribute and I still very much
> depend on get_maintainers.pl output and other great tools others created ;)

Yes, the difficulty is having so many lists, and subsystems with
different preferences. I've been told off for blindly including all
recipients from get_maintainers. Otherwise I'd just always use
 "git send-email --cc-cmd ./scripts/get_maintainers.pl ..."


> Thank you for your time,

And yours :)

> Michal

Kieran


> 
>>>>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/media/i2c/adv7604.txt | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>>>>> b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>>>>> index dcf57e7c60eb..b3e688b77a38 100644
>>>>> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>>>>> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
>>>>> @@ -66,7 +66,7 @@ Example:
>>>>>             * other maps will retain their default addresses.
>>>>>             */
>>>>>            reg = <0x4c>, <0x66>;
>>>>> -        reg-names "main", "edid";
>>>>> +        reg-names = "main", "edid";
>>>>>              reset-gpios = <&ioexp 0 GPIO_ACTIVE_LOW>;
>>>>>            hpd-gpios = <&ioexp 2 GPIO_ACTIVE_HIGH>;
>>
> 

-- 
Regards
--
Kieran
