Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17D2213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="Ctx/jAlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfB0Tlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:41:52 -0500
Received: from 7of9.schinagl.nl ([62.251.20.244]:52572 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfB0Tlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:41:51 -0500
Received: from [10.2.10.179] (unknown [10.2.10.179])
        by 7of9.schinagl.nl (Postfix) with ESMTPA id B0242B75E16;
        Wed, 27 Feb 2019 20:41:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1551296506; bh=6mgppJLPViRDni6rhrh8/jIc+dW92ML1RH+vjjxbbt4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ctx/jAlEBuocdURv4ZkKk+94qwcfRqGrXTbmOV2r6JV/VOVE7JLeTZkomiyr3n/US
         IO76hp4EiG3cLLKfZ9b2sDCNFs7KgCZ5jH9TlT6is/m43pshT4dTUEEpoRXqBeqQU6
         pP9XQ5XOd96+FrgOWww0lJrkdBRsTsNj/9CWuDEY=
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS
 defines
To:     Mark Brown <broonie@kernel.org>
Cc:     Axel Lin <axel.lin@ingics.com>, Chen-Yu Tsai <wens@csie.org>,
        Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190220165013.12774-1-axel.lin@ingics.com>
 <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
 <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
 <20190221094237.GA5970@sirena.org.uk>
 <d52c2711-71f3-9e72-f01b-e761f4a92a07@schinagl.nl>
 <CAFRkauDdx00VmqhmzohdCyWbPkctCU2D03JqkpSw2x7n-bDzHA@mail.gmail.com>
 <15e97e28-0008-cda4-176d-a3feb9ad4e8a@schinagl.nl>
 <20190225172519.GD13898@sirena.org.uk>
From:   Olliver Schinagl <oliver@schinagl.nl>
Message-ID: <c277f7e1-09d9-b6e1-e5d6-8b2f88042e9c@schinagl.nl>
Date:   Wed, 27 Feb 2019 20:41:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190225172519.GD13898@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: nl-BE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-2019 18:25, Mark Brown wrote:
> On Sat, Feb 23, 2019 at 09:37:01PM +0100, Olliver Schinagl wrote:
>
>> In any case, you seem like a smart person that reads and writes hex and
>> bits often enough. This is not true for everyone. I can just as easily
>> reverse your arguments of course, for example, 'each field has a well
>> known meaning' ... to whom? People that use these things daily, sure.
>> People who just need to double check something or modify something, not
>> so much. They have to look up the MACRO, the struct its in, compare it
>> to others, so as you can see, what is natural for you, is not true for
>> everyone. :)
>> Also, the general consensus is still to avoid magic values, and to stay
>> consistent with the rest and not make expceptions, it makes sense to
>> have defines instead of magic values.
> If you find you need to describe what the fields are it would be much
> more constructive to add a comment at the top of the table saying what
> they are.  As things are this isn't helping anyone - as a big pile of
> defines it's hard to read the values without context for how they're
> used and if you're looking at the table you can't tell what the
> regulator actually supports without going and decoding the defines.
Then the name of the define should be more constructive, which imo they
are reasonably? But as everything with programming, naming things is the
he hardest part, right?


