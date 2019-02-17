Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76679C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EE12186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXiPb+jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfBQV4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:56:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42870 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQV4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:56:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so7694319plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0wmxiqqk7vAqmoD3PZT4D63Pg1Meu3+th20mrox0DOk=;
        b=bXiPb+jjfszHalIcoiGQpr79ma8nHUzFESYIQEBjgvau7dlK3K1YyqqgkSGMsyuTAN
         oi91PYriZRkfrrF/V8hoEH4ml69BOQMHy86EvXVDzpK9wlww8T5kstXI0AMa8MqsFZ8z
         3fG41To4sZ5ucp8bstPbknWBHxLatVJjmDIUOxEoyMVB0DeNxDf6UGbs1vZoXgD8zalt
         e3smdskO9nQgH11fmjyY+g0kVftd5WfwBF4+keK2y5lFUDra1xiQJRWIFzHKCkLDIkDh
         lSKxg/2+KIrGF33aPuTrHYpSBVlfKgeEfJ0cPEw/EYfT2hvYkkv1+NJtoq8qq+rwXG8Y
         Se8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0wmxiqqk7vAqmoD3PZT4D63Pg1Meu3+th20mrox0DOk=;
        b=GD1lJv1wJztFLqP5E9bRo+RV46180mRqiP/xv+Xe4vYS6oVrZO0J1VGiO/erQHOaJb
         9IXcPbbavF681gqDKwFNuSsv260JdKvJkh5D5hA807/gzTulydrkJlpmwnmozOpkuhVd
         Kun+HaMLslQ5PW3e6x0LygQjNH5m28TWTbb6ukzf2ffZ1VcAVn70Erfd/zVSR3qi7la4
         2SUUCfduZLQuwAkAmaHHu7SP4w+FIRyQGps6/rlHnWE8/S4MLUAK2NKzuhQebmO3NbYG
         h2rDITTGONxRHemY9H7LVI6iGxoXkOqCrQJZ5ZoB6A46djfsxBYfU/pMTJtZytkAIhxt
         KYkA==
X-Gm-Message-State: AHQUAubTkwO8A6ku3iVUrCIKBSApn2RlD/GCKVVQivsFTGdjYKNvq5s7
        u/gM3XVJTDJzuvW+l+7wLnE=
X-Google-Smtp-Source: AHgI3IbqXw5YEK0XINbUyF5eYSMqG3seFTkN2WP0zeb+/N+xaXLutf2s82q5LgbDabqLwxuFqUbxag==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr21903651plb.169.1550440559472;
        Sun, 17 Feb 2019 13:55:59 -0800 (PST)
Received: from localhost ([203.219.252.113])
        by smtp.gmail.com with ESMTPSA id k74sm5381900pfb.172.2019.02.17.13.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 13:55:58 -0800 (PST)
Date:   Mon, 18 Feb 2019 08:55:56 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        erhard_f@mailbox.org, jack@suse.cz, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due
 to pgd/pud_present()
Message-ID: <20190217215556.GH31125@350D>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
 <20190216105511.GA31125@350D>
 <20190216142206.GE14180@gate.crashing.org>
 <20190217062333.GC31125@350D>
 <87ef86dd9v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef86dd9v.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 07:34:20PM +1100, Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> > On Sat, Feb 16, 2019 at 08:22:12AM -0600, Segher Boessenkool wrote:
> >> Hi all,
> >> 
> >> On Sat, Feb 16, 2019 at 09:55:11PM +1100, Balbir Singh wrote:
> >> > On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
> >> > > In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
> >> > > rather than just checking that the value is non-zero, e.g.:
> >> > > 
> >> > >   static inline int pgd_present(pgd_t pgd)
> >> > >   {
> >> > >  -       return !pgd_none(pgd);
> >> > >  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> >> > >   }
> >> > > 
> >> > > Unfortunately this is broken on big endian, as the result of the
> >> > > bitwise && is truncated to int, which is always zero because
> >> 
> >> (Bitwise "&" of course).
> >> 
> >> > Not sure why that should happen, why is the result an int? What
> >> > causes the casting of pgd_t & be64 to be truncated to an int.
> >> 
> >> Yes, it's not obvious as written...  It's simply that the return type of
> >> pgd_present is int.  So it is truncated _after_ the bitwise and.
> >>
> >
> > Thanks, I am surprised the compiler does not complain about the truncation
> > of bits. I wonder if we are missing -Wconversion
> 
> Good luck with that :)
> 
> What I should start doing is building with it enabled and then comparing
> the output before and after commits to make sure we're not introducing
> new cases.
>

Fair enough, my point was that the compiler can help out. I'll see what
-Wconversion finds on my local build :)

Balbir Singh. 
