Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57186C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22EB2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbBoscG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22EB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeIYQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:55:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43283 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeIYQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:55:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so10964100pfi.10;
        Tue, 25 Sep 2018 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I7Xu0NETdXDnmPEi8HPS7wYX50yl8Lm/sr5H+H5U5O0=;
        b=VbBoscG1trIyUFLFuH8r1KsbFVi076Td5s5M8fH1QQGM7Rqqz+p4J0DCJ8Cr+h4wnC
         bA+pQyEj0U/DIQNPsxUiBmxcSUwRWYlqeSJDh5sz6UUGc7jMVXX+FVKuYkM885E8qgYl
         rCGaUGWnqfxn506bOdj+MtwD3JwGPuT/dmjSYsZ2X9oUTRiPAAo1az9ptB4jejXk9+FT
         IF+4Dqh1rJLkdThnCl6Qi4m6qX1XYGL1tvo+Mffl4AXCzco4vNSKui5oRMHcGhVB3IQV
         XInUIqOs/AB7uz36FQ6zMWffXr1C35QF7DfCcA4nNZsBPTox1++vIpH4Hzm01Y8Oi+F1
         oDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I7Xu0NETdXDnmPEi8HPS7wYX50yl8Lm/sr5H+H5U5O0=;
        b=UYhV5cCVrct2zNNpKp1NJVp3SR1NuG2ik31VYaVgOS63AdnX7V2Lo3OvEQHQupbW+5
         xbqevuUxK7OrOAc7ClECiyAjYwo/VFPskadyeppJSNG83UrV4reUksXYkP0QcPR67wWF
         3v+VjU8ETn8KVBqCY0JK6z8SrcA9M5wlbis8P+Nibp1Z01DFESWRiKO/fvN1Yr0hcbf3
         gZG62n4JIUksWny8J86DnehhJNx3KItE/H5SGRE6wHZ5iAdOU88dgTNut5R+57eEuBvq
         h8INCN8McJVrd8kLj4WnJ1mx5FfhAvUw6tIo6lPMoLpwys14rr5lPzK/cCPj/yalqKzh
         51/A==
X-Gm-Message-State: ABuFfojYD5dZfcuk5Ma8CzHhPKZHn6MmtUeOqrTzCt97dpSjvEzyeybb
        27LygeefVCn9XujbCZazWFs=
X-Google-Smtp-Source: ACcGV617WnUL2GRi1oK6GWL70md00UjF2lF1KbmxDbt1+ImGCqk2BdjbxYlBDrNJZcz3iq1RFMTUxg==
X-Received: by 2002:a63:c4f:: with SMTP id 15-v6mr463968pgm.155.1537872494753;
        Tue, 25 Sep 2018 03:48:14 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id a75-v6sm2831057pfa.124.2018.09.25.03.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 03:48:13 -0700 (PDT)
Subject: Re: [PATCH v2 00/22] Unify MediaTek pinctrl in preparation for MT8183
 and MT6765
To:     Sean Wang <sean.wang@mediatek.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Saber Rezvani <irsaber@gmail.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <CACRpkdZtVBjYGs5C7-HWEyX7f7pnCqvnRYBH=fFmLKhN4FGymA@mail.gmail.com>
 <1537325650.572.9.camel@mtkswgap22> <20180919043722.GA14181@Mani-XPS-13-9360>
 <1537503761.9654.17.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <9f0a8868-a06e-d378-1008-df758b898fbe@gmail.com>
Date:   Tue, 25 Sep 2018 12:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1537503761.9654.17.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/09/2018 06:22, Sean Wang wrote:
> On Tue, 2018-09-18 at 21:37 -0700, Manivannan Sadhasivam wrote:
>> On Wed, Sep 19, 2018 at 10:54:10AM +0800, Sean Wang wrote:
>>> On Tue, 2018-09-18 at 15:07 -0700, Linus Walleij wrote:
>>>> On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:
>>>>
>>>>> v2 and changes since v1:
>>>>
>>>> I had trouble applying the last patches in the series so I applied
>>>> all on an immutable branch (ib-mtk) then merged that into devel
>>>> and added a patch on top to fix up some GPIO includes (just sent).
>>>>
>>>> Please check the result!
>>>>
>>>
>>> Sure, I'll take a look and and test on the devel branch.
>>>
>>> On the top, I'll add a fix for the issue recently reported by kbuild
>>> test robot about implicit declaration and a new MT6765 driver based
>>> on the series.
>>>
>>
>> Hi Sean,
>>
>> Do you have any plans to add support for MT6797?
>>
> 
> I personally have no the plan to add support to MT6797 because I have no
> the device, but as I knew some of people in mediatek have interest to
> add them by volunteers and thus there is no clear schedule. Eventually,
> if they're really done, they would be still based on vendor binding not
> by generic binding.
> 

CCing Saber as he is working on the pinctrl for this device. Actually he as some
questions regarding the register layout.

Sean maybe you can bring him in contact with someone inside Mediatek who could
help him :)

Regards.
Matthias
