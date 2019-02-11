Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389F5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058E02082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLmA4Rhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfBKRKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:10:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51960 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBKRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:10:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so18584567wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mjoT+R6x7nhxzpe7uM0GaUFLAhkILZo0c3B68v2g49I=;
        b=kLmA4Rhfed362QiXI6/yK2qmTWAjvYnV+tebew38CppOqXDxUMkZCUVL122trTmt76
         Y/0/Tm2j6agtTHR3pegB27H65kJrY0GkP13lXM99wUv1YtbG0kzi1SlfLeO1eSdzW38K
         UTy9qX8NRffI3VbO39JYYtyL2dBXSCVov08vIticjEBeeUCkZZTBIu/N4fJxUe+fy5XM
         EvnnfLO+l/ACuqWFfhsY+LcO2vyJPT7uW91pOpk/HsLXCpweIJZ0kLZzMR0oJl8FVXz/
         z/NC4H6CIN7DGrrvurz0x76txPeLRBba063g8pFYgBMZYUP5K0woc0+Kqw/e7jU9JLpj
         +ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjoT+R6x7nhxzpe7uM0GaUFLAhkILZo0c3B68v2g49I=;
        b=HR26kQM1mh4Jc3A+f4dnrv0J4Ver3Y+KKFWdDCvGGnGmdQzn0levWO4Gh25T2qLbJw
         9HvXpvFIvws7//NvfjGNGXq1jnId7hmyDwbWkG6KQwr/9NIbDj3XVYkoJ6AoPU3GqC5o
         pPqKLLRlG28z9GRtSZRF5EguPgsPn4LmSKwAY9H3mpripz2is0s9Q08LrMtrkomqkoBR
         vFjrm0PVRr6W1B42fM2UenIgmCLpSEoB9pKnjeplxewvjpo6D/k2blISNJOC8dunRUCn
         MjDT6Ith2YF+sA6M4LDTt1tyiS6Cu4iwzFTT522iIDz3RejA0bChiVdQrt2u7pO8Xpx9
         Z84A==
X-Gm-Message-State: AHQUAuaAOuENo+ZiEM6ZZpgiNOW2VT3VbbJCtEJ1+1WG7A8U4BL6N/w2
        FT13CbDNOPtxVuarDc6LXUOB9t0=
X-Google-Smtp-Source: AHgI3Ibnl1TgPUD/3p/sgqNnmAhAFFKN5+AbCPTjboM1Ea3t7paiBCWA6CQc1xrmwUgdPwIeaHRWsw==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr409690wmi.7.1549905042366;
        Mon, 11 Feb 2019 09:10:42 -0800 (PST)
Received: from avx2 ([46.53.240.81])
        by smtp.gmail.com with ESMTPSA id l20sm20456344wrb.93.2019.02.11.09.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 09:10:41 -0800 (PST)
Date:   Mon, 11 Feb 2019 20:10:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v-1] x86_64: new and improved memset() + question
Message-ID: <20190211171039.GA3574@avx2>
References: <20190117222318.GA10338@avx2>
 <20190211124716.GA13062@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211124716.GA13062@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:47:16PM +0100, Ingo Molnar wrote:
> * Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > QUESTION: is it possible to tell gcc "this function is semantically
> > equivalent to memset(3) so make high level optimizations but call it
> > when it is necessary"? I suspect the answer is "no" :-\
> 
> No idea ...
> 
> > TODO:
> > 	CONFIG_FORTIFY_SOURCE is enabled by distros
> > 	benchmarks
> > 	testing
> > 	more comments
> > 	check with memset_io() so that no surprises pop up
> 
> I'd only like to make happy noises here to make sure you continue with 
> this work - it does look promising. :-)

Thanks, Ingo.

This is really the core of the problem: once memset() becomes something
other than

	static inline void *memset(void *p, int c, size_t len)
	{
		return __builtin_memset(p, c, len);
	}

GCC starts pretending that it doesn't know what memset() is and all those
advertised space savings go to hell.
