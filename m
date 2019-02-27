Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96009218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="diU2UjEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfB0U0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:26:35 -0500
Received: from 7of9.schinagl.nl ([62.251.20.244]:54260 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbfB0U0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:26:34 -0500
Received: from [10.2.10.179] (unknown [10.2.10.179])
        by 7of9.schinagl.nl (Postfix) with ESMTPA id 481E4B7629E;
        Wed, 27 Feb 2019 21:26:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1551299192; bh=pkasG0/KUOMhICFRN9RLiUnbjqP0azni2jj+VRogvd8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=diU2UjEPjNtkEYwPMByjOOppavZpf7mu+9rQc1YREAm+5grFOCbHEWqeAP1wCGfYd
         ktx6RmcfTunflLgpaH1hjZxgd/oJjWz7I213k9J58eOlzr1r2xwjejiER4dF+Ll+YL
         YAutQi+YgVsCVh81zpWhk4lU6Mj8o6x+9EnyWxmE=
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
 <c277f7e1-09d9-b6e1-e5d6-8b2f88042e9c@schinagl.nl>
 <20190227200537.GB11065@sirena.org.uk>
From:   Olliver Schinagl <oliver@schinagl.nl>
Message-ID: <a724fa00-14a2-865b-ed8d-60fa6bda88ba@schinagl.nl>
Date:   Wed, 27 Feb 2019 21:26:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190227200537.GB11065@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-02-2019 21:05, Mark Brown wrote:
> On Wed, Feb 27, 2019 at 08:41:46PM +0100, Olliver Schinagl wrote:
>> On 25-02-2019 18:25, Mark Brown wrote:
>>> If you find you need to describe what the fields are it would be much
>>> more constructive to add a comment at the top of the table saying what
>>> they are.  As things are this isn't helping anyone - as a big pile of
>>> defines it's hard to read the values without context for how they're
>>> used and if you're looking at the table you can't tell what the
>>> regulator actually supports without going and decoding the defines.
>> Then the name of the define should be more constructive, which imo they
>> are reasonably? But as everything with programming, naming things is the
>> he hardest part, right?
> I really don't think that's it - I think that sometimes a data table is
> just a data table.  There are some coding styles that work to avoid
> having raw numbers anywhere in code outside of defines at all costs but
> I do think that goes too far in cases like this where the name of the
> define is at some level just going to summarize what should go in a
> given slot in a table which adds little.

I'm not sure if we're still talking about the same thing or same table;
In any case, this is something up to personal taste in the end, and I am
in the camp that favors (readable, which of course could always be
improved) defines over magic values; especially when it comes to these
bit-selectors. And even if a little less here, to keep things consistent
with all defines is why at least I prefer the one approach. You guys
prefer the raw values. Two flavors of two opinions I suppose :)


