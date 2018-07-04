Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C3EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0D624051
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="10ITVFFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0D624051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeGDXCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 19:02:34 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36744 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbeGDXCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 19:02:32 -0400
Received: by mail-oi0-f68.google.com with SMTP id r16-v6so13303562oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+SkDKqTap5vvRJkm8D70VIZe70E/Jnr34w6ASg8ouc8=;
        b=10ITVFFyrc8UFGwwExxRpYZkvwmQArYWWNAtc5JBniPZIcFRLYGn8kZ7zfoSkemsTD
         W/1Kot5m9SrSb6fvS0jnpUSR2ZjQXPjg12Wcy/IM5QNoBe9dsUNy5ASczGI/Jx8oP8wQ
         LgGOHOJEyyBR0XHfEiOnM/2g2Gv/RYAxjnclMdgxeD8cuuWb4nrx8J6ijT48EuX4YZEC
         LJdREVUpWzEEmCaZyQfEFFpIRDw9SggjeOk8X97MD5cn43c5mXaG8U29V5lSyZowLpW1
         qMAn4Uepz7CJr/JU56ZQ0Lvz1jfnFlq93PC+FdHXlIm8hP+k/mvzOZYxjmfL5uf7FPgx
         JzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+SkDKqTap5vvRJkm8D70VIZe70E/Jnr34w6ASg8ouc8=;
        b=I7C3oHkuFnH5d3+9KqzoNdShaGMeKhicr0Cs0lI8J9scxgST6lshfZpWVqKw7Nodo2
         IM3dqar2BeNXFYFEWNCrHs2LcMt3/1Gevtp1ADQ2nmmtV5fciQ3gLUZ04rlo0V/EPpKb
         3ONOKJ/JIzSSqBfB/uJ5a38FSuv1wIjvWUiAlYiQxwtEEpmUglVy8eDGIGoDCNMxrmND
         JEDhobkHV7NW1QXbdM49x7YRLLWQ10nXYCB7oheuPnwrvYW51mCv19csFBMgcDnp+sU3
         FWemL1eP0RMEo/o3stZ4s9NcE0ecKGqD11+Eo8VSw8ZKE6o77ELsXV7dyr8yR1aZd63a
         JMFw==
X-Gm-Message-State: APt69E1ARmp1x2Evzy4PGftRAciOJFTFIqNdP63QImfnW79nMCKDHGZa
        E36811boy7Sh4VrdJ2UrcXVCpkkqG5R8LIZLF+ypMQ==
X-Google-Smtp-Source: AAOMgpfw9vkzLVlEk24u26jp/1VCvBS6E/xWlVoDJTkcSyQGSsOwJeg+l+R6yG8BmiOysNCoC5YcsBl0C98JXEcbtWs=
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr4454803oia.215.1530745352022;
 Wed, 04 Jul 2018 16:02:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 16:02:31 -0700 (PDT)
In-Reply-To: <20180704223825.GZ30522@ZenIV.linux.org.uk>
References: <20180702165803.GB19488@linux.intel.com> <153056565378.3420.295180898468362039.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180703083040.GB971@gmail.com> <20180704223825.GZ30522@ZenIV.linux.org.uk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Jul 2018 16:02:31 -0700
Message-ID: <CAPcyv4hFL4qE1n9jjJa_wuw6nOGQR5vtyqg-vvvbLw9X=9_RvA@mail.gmail.com>
Subject: Re: [PATCH] x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe()
 exception handling
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 3:38 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Jul 03, 2018 at 10:30:40AM +0200, Ingo Molnar wrote:
>>
>> * Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> > Hi Ingo,
>> >
>> > Here is an additional copy_to_iter_mcsafe() fix to address the crash
>> > reported by Ross. This now passes xfstests:generic/323 on my system.
>>
>> The lib/iov_iter fix would need an Acked-by from Al.
>
> I can live with that; I would really like to see some documentation on
> the copy_to_iter_mcsafe(), but that's a separate story.  Incidentally,
> are there any expectations of other callers appearing, or is that
> (and copy_from_iter_flushcache()) YASingleConsumerAPI?

The current cpu architectural detail preventing conversion of the
standard copy_to_iter() path to use the mcsafe flavor is that we can't
use REP MOV for fast copies and instead need to use a software loop so
that any exceptions are recoverable. When / if that is addressed, and
there is no performance difference between the two, it might make
sense to convert more users.

The _flushcache flavor, however, will likely stay limited to a single
consumer for the persistent memory use case.
