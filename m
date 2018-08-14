Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8580B21700
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOD8zKfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8580B21700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbeHNUYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:24:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42819 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeHNUYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:24:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so9402534pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MB4DeZcc1axnQV8hDkceH08m/Jqflt+rGhPGhn5Najo=;
        b=fOD8zKfgNjZwdchtnE8wjoJYA0UzSUEuZyuRv4jNWS3ULn7eu/JqdQ68aX8si6FsGC
         swJnJk9nVgvTuFiiL5mkUjzSVsqsX/UGFZw2EsSHIqvy8Wv4IXfrKdd51HARQRwYgnZe
         r/s6bN6nSw6EqZW+DUkrTg2CTuZxcDMu6QTaXmRjrMLR6Y4yRF3oaxRwPJ1cQd0GwH1L
         UV/L/iVv/WO5paGBP8n3B7PDvycpptaIEgWvCDSiJ+EeJFYrqbpAOJc2mdjSMgoiQQb5
         BiJJDMxEnOSBc46zwkW0G3AWIUOgVgWIgBLAV2ttOH/mM07DvU2/AmbN+teX3FJQ93FF
         h4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MB4DeZcc1axnQV8hDkceH08m/Jqflt+rGhPGhn5Najo=;
        b=f/a6imw6Virt+zh3GsXZs4hNl2i7/8HXmcNgi0/wxarcriAcpBHKVIOIkCW+9sZQMZ
         SoCVd+A5+b73wc0w5FvNZXMT3T68G735mc+CxJ4JhAVjEQDwRPtiExM54ruEh2dUEFeQ
         F0RPm0kEi2B0lHd33WNvVLJ6/61tNBMCG3+tUhFF7lzT4ibakYHl8Xd9fS8cJymkILAo
         32cHmqwP8biOcOUtCJDu4wssmM+hVewU/5QYwqztBXAqE0K98tHOxgEj8aqexKST0r3H
         J7qMdU3BjgFsaJnlwjaLe+eETZfzjbz7rv5oRlTb0PLYOxipeSyRxFrYZ20FY8C+OtCD
         GVeQ==
X-Gm-Message-State: AOUpUlHuxFzw9KcYpxxD4wrdzh5hCL0bDtZ1k0oPa7ErWx36jBKINZrK
        tMPCo7mbHxwHposoZUyo39Q=
X-Google-Smtp-Source: AA+uWPyvgC5GIErPuJ3YCeHLs3bEsV6wFNOTrP5yuuBz2BZG/KH7LafbVIaBp6B9GOoNQD8NlRpslQ==
X-Received: by 2002:a62:d842:: with SMTP id e63-v6mr24653745pfg.88.1534268184841;
        Tue, 14 Aug 2018 10:36:24 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e190-v6sm57839086pfc.81.2018.08.14.10.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:36:24 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:36:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Build failures with gcc 4.5 and older
Message-ID: <20180814173623.GA5117@roeck-us.net>
References: <20180814170904.GA12768@roeck-us.net>
 <CA+55aFy0SFGaNmzCcpwMCeY_f3ZTG54NmV3SosbK6=QdE20=5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy0SFGaNmzCcpwMCeY_f3ZTG54NmV3SosbK6=QdE20=5A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 10:20:32AM -0700, Linus Torvalds wrote:
> On Tue, Aug 14, 2018 at 10:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Does that mean that gcc 4.5 and older are now officially no longer
> > supported for compiling the kernel ?
> 
> I guess we might as well make this the excuse for making that official.
> 
> Maybe it's trivially fixable, but I don't even want to look at it,
> since we've talked about updating the minimum gcc version so long.
> 
> > If so, would it make sense to update include/linux/compiler-gcc.h
> > accordingly ?
> 
> Unless somebody cares, and comes with a trivial fix to make old
> compilers happy, let's just do that.
> 

Only implication is that it is the death warrant for unicore32,
since the only compiler available for it is gcc 4.4.2.

Another question is if there are still companies out there who only
permit gcc 4.4 and older due to its switch to GPL3.

Not that I care about any of those. Building the kernel with those old
compilers without hitting some compiler bug is getting more and more
difficult.

Guenter
