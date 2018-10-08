Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED494C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DD420882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KUrLVZrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DD420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJHPpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:45:43 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34812 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeJHPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:45:43 -0400
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 305621283;
        Mon,  8 Oct 2018 10:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538987706;
        bh=X8BqL3C7VX/PeKnFXLAawMeuKo+0PO3RzS/kpSs0nLI=;
        h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
        b=KUrLVZrB2PKz4ISVHYmO5Cp+oQBJUg7kUJnvmcY3zGgfeogPALDuWJk2ewoZqoiwi
         rYP0ct+YNYHtxPQQ/XfoATdk2R66cpB7WVtvWMtVfYP5ndXLUsiz0/VZpcf/n5PxgR
         H4ruPeFb1fZ4y9zaYhTm1MBhv4vJ+jzhtUN8TgdQ=
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
To:     Keiichi Watanabe <keiichiw@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Shik Chen <shik@chromium.org>
References: <20181003070656.193854-1-keiichiw@chromium.org>
 <CAD90VcbBUcpwLsY0sHim+mML6esSjZA2ocX0Ff-YiZxBsLTZ+w@mail.gmail.com>
 <5b236e95-b737-51b3-df4f-eea41a36735e@xs4all.nl>
 <CAD90VcaexKNsRE9s32UanzE32YM2EXFySCArkt_Zo2V3-eRnqQ@mail.gmail.com>
Reply-To: kieran.bingham@ideasonboard.com
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
Message-ID: <997483ea-4a41-a947-2cc8-45892ef91bc6@ideasonboard.com>
Date:   Mon, 8 Oct 2018 09:35:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD90VcaexKNsRE9s32UanzE32YM2EXFySCArkt_Zo2V3-eRnqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/18 11:29, Keiichi Watanabe wrote:
> Hi all,
> 
> On Fri, Oct 5, 2018 at 6:18 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>> On 10/03/18 09:08, Keiichi Watanabe wrote:
>>> I think 480p is a common frame size and it's worth supporting in vivid.
>>> But, my patch might be ad-hoc. Actually, I'm not sure which values are
>>> suitable for the intervals.
>>
>> I can apply this ad-hoc patch as-is.
>>
>> Or do you want to postpone this and work on a more generic solution?
>> Although I am not sure what that would look like.
> 
> I prefer providing a more flexible way rather than this ad-hoc patch.
> It would be helpful if there is a way of changing supported frame sizes easily.
> Perhaps, Kieran and me would use it, at least:)
> 

o/ <raising hand in agreement>

>>
>> Proposals are welcome!
>>
>> The main purpose of this code is to have something that kind of acts like
>> a real webcam that has various resolutions, and a slower framerate for
>> higher resolutions (as you would expect).
> 
> This sounds reasonable, so I guess we can keep this way as default and
> provide a way for specifying extra frame sizes as an option.
> 
> For example, how about a module option like this?
> "webcam_sizes=640x480@15,320x240@30"
> 
> If this parameter is passed to vivid, vivid works like a webcam that
> supports the following 7 pairs of frame size and fps:
> - 5 pairs of frame sizes and fps, as with the current implementation
> - 640x480 (15fps)
> - 320x240 (30fps)

I like the concept of being able to specify as a module parameter.

Perhaps we could have a magic marker on the string to define if the
existing frame sizes should be kept - or if this is just a complete
override ?

 vivid.webcam=640x480@15,320x240@30  # Specify sizes explicitly
 vivid.webcam=+640x480@15,320x240@30  # Append to existing frames
              ^ Magic Marker

We might of course want multiple rates per frame,

 vivid.webcam=640x480@15-25-30-90-120, # Separator to be defined...


> 
> If this parameter is not passed, vivid's behavior won't change from
> the current one.
> 
> How do you think?
> 
> We might want to stop using the default framesizes, i.e. vivid only
> supports framesize/fps that passed as the option.
> But, if we do so, the parameter will become mandatory and it would be annoying.

I think mandatory would be annoying yes.

Thus my suggestion for a magic marker above :)

--
Kieran


> So, I personally like to keep the default framesizes.
> 
> Best regards,
> Kei
> 
>>
>> Regards,
>>
>>         Hans
>>
>>>
>>> We might want to add a more flexible/extensible way to specify frame sizes.
>>> e.g. passing frame sizes and intervals as module parameters
>>>
>>> Kei
>>>
>>> On Wed, Oct 3, 2018 at 4:06 PM, Keiichi Watanabe <keiichiw@chromium.org> wrote:
>>>> Support 640x480 as a frame size for video input devices of vivid.
>>>>
>>>> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
>>>> ---
>>>>  drivers/media/platform/vivid/vivid-vid-cap.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/media/platform/vivid/vivid-vid-cap.c b/drivers/media/platform/vivid/vivid-vid-cap.c
>>>> index 58e14dd1dcd3..da80bf4bc365 100644
>>>> --- a/drivers/media/platform/vivid/vivid-vid-cap.c
>>>> +++ b/drivers/media/platform/vivid/vivid-vid-cap.c
>>>> @@ -51,7 +51,7 @@ static const struct vivid_fmt formats_ovl[] = {
>>>>  };
>>>>
>>>>  /* The number of discrete webcam framesizes */
>>>> -#define VIVID_WEBCAM_SIZES 5
>>>> +#define VIVID_WEBCAM_SIZES 6
>>>>  /* The number of discrete webcam frameintervals */
>>>>  #define VIVID_WEBCAM_IVALS (VIVID_WEBCAM_SIZES * 2)
>>>>
>>>> @@ -59,6 +59,7 @@ static const struct vivid_fmt formats_ovl[] = {
>>>>  static const struct v4l2_frmsize_discrete webcam_sizes[VIVID_WEBCAM_SIZES] = {
>>>>         {  320, 180 },
>>>>         {  640, 360 },
>>>> +       {  640, 480 },
>>>>         { 1280, 720 },
>>>>         { 1920, 1080 },
>>>>         { 3840, 2160 },
>>>> @@ -75,6 +76,8 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
>>>>         {  1, 5 },
>>>>         {  1, 10 },
>>>>         {  1, 15 },
>>>> +       {  1, 15 },
>>>> +       {  1, 25 },
>>>>         {  1, 25 },
>>>>         {  1, 30 },
>>>>         {  1, 50 },
>>>> --
>>>> 2.19.0.605.g01d371f741-goog
>>>>
>>


-- 
Regards
--
Kieran
