Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA288C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE86D21A4A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4/rHPid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfBPVxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 16:53:10 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46404 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfBPVxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 16:53:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so10675815edy.13;
        Sat, 16 Feb 2019 13:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0Y07SSr71M/Pw1dkZpd+Pqcpn6B//XOq11C1nTZD20=;
        b=W4/rHPidNH2lZ0pKp3hetWrrtHJJTJGwtPSLshIuQYu6Tid5eTfUJvHoP0NSnLD0W3
         cQ10MsIyiRxBx81XoGSPeoynU4Uq8UjPeErb+CQtiO5McTpmpxny8nSBcMexjnTTl4c5
         4IU7bKk3Crv+RuIT4f7MI34ScqtY/9Pv4rrn32LO/zaRYqp0bIhR4j7xB1oQLl/BXbgO
         L3ifMhUEMMyxhawBJbSkFGL1X/rO1VoMUso9GWXbLFCQ4oLfVoRuUmzkN7OwdvZd5gGP
         6sgO4PBNmuwilUdQ8/bFUIl6JpUTKZhRqoGhDa+f1qk338pNd5JGSftPkRcB/tPL4j7M
         Jp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0Y07SSr71M/Pw1dkZpd+Pqcpn6B//XOq11C1nTZD20=;
        b=n6C74ugt/bx1X0VYwAhNpNXQA2/ZlJa24TTyYnDhnGfcS7A8aqYy98Ea9R+4emqUbu
         cTvUczzJC0OJVevn1vr0BNG5nEDtY80pAnpF/7NjeRyp8CuT6bG9tHgIN+l+sg+F+O5p
         givObWHrjnt+OOfj6rfWwy9nhC1tBt/8vTO7KaGe+2bQnifRFzkeEfZk5WzwuBPVYRlD
         9JSnB5YS7kVH4Ezxz7Jpacz87d04JTJ3pNV+S0/5tPpb+SRi+UVfCWlO6PGgAI0FSpSB
         YqBHYJ+LbgqIhSfiY9KhTL/y2SdvSm0eQBSUHzbzW7UxnUjsZ6AeR9r5enqKljUVdlBa
         qdYg==
X-Gm-Message-State: AHQUAubn9Rzovj3TyBAn9QZdLkKxBIEMXZ49z1TuH/B6JgEVaK2jJxnF
        1l+IJ2zQeiALDe1lAUTsNbw=
X-Google-Smtp-Source: AHgI3IapEEE4XQrZ6wliEPZutDuLKQ3R634VL7mkoK7ZSH8z71aCSCdf+FNTufTVQYGe77bwpVBTbg==
X-Received: by 2002:a17:906:b5b:: with SMTP id v27mr11397599ejg.127.1550353987663;
        Sat, 16 Feb 2019 13:53:07 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h24sm2217424edr.80.2019.02.16.13.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 13:53:06 -0800 (PST)
Date:   Sat, 16 Feb 2019 21:53:05 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xarray: Document erasing entries during iteration
Message-ID: <20190216215305.vdlshknfisgee7gy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190212072958.17373-1-tobin@kernel.org>
 <20190212135129.GL12668@bombadil.infradead.org>
 <20190213144744.ifejzbxrbaltivwc@master>
 <20190213161258.GS12668@bombadil.infradead.org>
 <20190214221652.rwctk7wrocpojtfy@master>
 <20190214223300.GH12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214223300.GH12668@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 02:33:00PM -0800, Matthew Wilcox wrote:
>On Thu, Feb 14, 2019 at 10:16:52PM +0000, Wei Yang wrote:
>> On Wed, Feb 13, 2019 at 08:12:58AM -0800, Matthew Wilcox wrote:
>> >The only remaining user of the radix tree in that tree is the IDR.  So
>> >now I'm converting the IDR users over to the XArray as well.
>> 
>> Wow, really a HUGE work.
>
>Yes ... but necessary.  Have to pay down the technical debt.
>
>> >But that isn't what I was talking about.  At the moment, the radix
>> >tree and the XArray use the same data structure.  It has good best-case
>> >performance, but shockingly bad worst-case performance.  So we're looking
>> >at replacing the data structure, which won't require changing any of the
>> >users (maybe the page cache ... that has some pretty intimate knowledge
>> >of exactly how the radix tree works).
>> 
>> Two questions from my curiosity:
>> 
>> 1. Why you come up the idea to replace radix tree with XArray even they
>>    use the same data structure?
>
>The radix tree API was just awful to use.  I tried to convert some users
>with their own resizing-array-of-pointers to use the radix tree, and I
>gave up in disgust.  I believe the XArray is much simpler to use.
>
>> 2. The worst-case performance is related to the data structure itself?
>
>Yes.  Consider the case where you store a pointer at its own address in
>the data structure.  It'll allocate 11 nodes occupying one-and-a-half pages
>of RAM in order to store a single pointer.
>

Thanks for your explanation :-)

>> >> BTW, have we compared the performance difference?
>> >
>> >It's in the noise.  Sometimes the XArray does a little better because
>> >the APIs encourage the user to do things in a more efficient way.
>> >Some of the users are improved just because the original author didn't
>> >know about a more efficient way of doing what they wanted to do.
>> 
>> So sometimes XArray does a little worse?
>> 
>> Why this happens whey XArray and radix tree has the same data structure?
>> 
>> Interesting.
>
>I'm not sure there are any cases where the XArray does worse.
>Feel free to run your own measurements ... the test cases in
>tools/testing/radix-tree can always do with being improved ;-) (that
>directory is a bit misnamed as it now features tests for the radix tree,
>IDR, IDA and XArray).

Sure, I will try to play with this.

-- 
Wei Yang
Help you, Help me
