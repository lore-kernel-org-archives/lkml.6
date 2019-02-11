Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAA0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719D4218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549889242;
	bh=0imaeGbWBOJfVodMAIpCCr44kw0QHoPTzdcy0AoAdzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wM6m6c/FuP8rPrs7F8r54QGNWfWKrLVN5YBjiprSMX9AnfgXlTEvXRoRozRe0ns69
	 1chFlQTphANo1cLHtJXp/fo90xeR6i/VE3U5lWe/GTxpmUnauSmX7EcvSrpHxd0gJd
	 TayOiyp5ICgG1Hcu23VJhDMEujc2nq54uiHXA70U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbfBKMrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:47:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55655 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfBKMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:47:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id r17so17430364wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p0SsjOnZ7YvXnZciAVQIblpSdwgRLGmpnJCcS6cQ51I=;
        b=PasV01QHJZVaE5jOIl0f/dQ7nVnXNxmN40iWZnTU+GYFOmrKGsAnhi7iPs25s0WYeh
         iQI0HJ5psr0GfMhwcK8PDMvF5PjIOOt0ZCeXeX4d69Ah8Z+MxBSEpnqeMN9Vw89G/8v0
         XluczRecKUaR+aPxNU0ft8MbMbk0nTQ50miQSpzxMdn0sgV3EYH15hjX8PcEB7XCTecb
         dhA9Ogv3myI37pN4PWuttGeM6oazQtS6nuy5BPHOPK5KlBdY/qFl/6R8yaL1uPUssylF
         CesKx6EFptiOuKm0n1ju0L/n7VMRqttFDwBIh3nccxyuUwzZWwks54x1VCxvl5JssJcW
         TozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p0SsjOnZ7YvXnZciAVQIblpSdwgRLGmpnJCcS6cQ51I=;
        b=RrgPkdrBSiusx9LyY5waLEtaoCaSk1Lf3ZDXcBpi3w0ChxFX36e58A33HvN5h1sRcd
         Zc7eEN0zXrN6TroZcLyj7RQImK9E9wsnbskvhrjm9xib2sAUPGgJYdKqpDB4Z6rYdqaq
         dYlMaW8C96lJfiHeE4Mdqe6jQwPmDjxyZU1DK0oZaIHC0nxNgPy0NlTNGwPbvcfXaQ7D
         oAVfv6Uk3hvO/6wjN2tF9N/ZadZ9y6rwTh/0fiLnjhvm2i7RKDnDJpZVJheGTe6TPKiw
         1ZDoO4BB/isqCrIK5ClOdggbIRwsjsRaa6MLpzdfL/jfZ98cZXzT1u5UaY9impItc5qC
         JKrQ==
X-Gm-Message-State: AHQUAuah9ZYTOgWFeXQ6oU50lJ7t8Eb8hw9QhnFfX2Koj5GovYGOLp+C
        ElsumdULyQ+cHivcYkN0dGA=
X-Google-Smtp-Source: AHgI3IbNqvFmYrIpVtnIoQWxtEI1FdQqmxNNWLvuj5bRmug93OmN1XL68MlvOKeqtuUlvCDKs69LLg==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr9432451wmu.52.1549889238909;
        Mon, 11 Feb 2019 04:47:18 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c129sm10726357wma.48.2019.02.11.04.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:47:18 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:47:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v-1] x86_64: new and improved memset() + question
Message-ID: <20190211124716.GA13062@gmail.com>
References: <20190117222318.GA10338@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117222318.GA10338@avx2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Current memset() implementation does silly things:
> * multiplication to get wide constant:
> 	waste of cycles if filler is known at compile time,
> 
> * REP STOSQ followed by REP STOSB:
> 	this code is used when REP STOSB is slow but still it is used
> 	for small length (< 8) when setup overhead is relatively big,
> 
> * suboptimal calling convention:
> 	REP STOSB/STOSQ favours (rdi, rcx)
> 
> * memset_orig():
> 	it is hard to even look at it :^)
> 
> New implementation is based on the following observations:
> * c == 0 is the most common form,
> 	filler can be done with "xor eax, eax" and pushed into memset()
> 	saving 2 bytes per call and multiplication
> 
> * len divisible by 8 is the most common form:
> 	all it takes is one pointer or unsigned long inside structure,
> 	dispatch at compile time to code without those ugly "lets fill
> 	at most 7 bytes" tails,
> 
> * multiplication to get wider filler value can be done at compile time
>   for "c != 0" with 1 insn/10 bytes at most saving multiplication.
> 
> * those leaner forms of memset can be done withing 3/4 registers (RDI,
>   RCX, RAX, [RSI]) saving the rest from clobbering.

Ok, sorry about the belated reply - all that sounds like very nice 
improvements!

> Note: "memset0" name is chosen because "bzero" is officially deprecated.
> Note: memset(,0,) form is interleaved into memset(,c,) form to save
> space.
> 
> QUESTION: is it possible to tell gcc "this function is semantically
> equivalent to memset(3) so make high level optimizations but call it
> when it is necessary"? I suspect the answer is "no" :-\

No idea ...

> TODO:
> 	CONFIG_FORTIFY_SOURCE is enabled by distros
> 	benchmarks
> 	testing
> 	more comments
> 	check with memset_io() so that no surprises pop up

I'd only like to make happy noises here to make sure you continue with 
this work - it does look promising. :-)
 
Thanks,

	Ingo
