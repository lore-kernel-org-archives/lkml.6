Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26722C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73C520833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZROd2EAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73C520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeKCEZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:25:46 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:35887 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKCEZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:25:45 -0400
Received: by mail-yw1-f49.google.com with SMTP id h21-v6so1194214ywa.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9n17ZvrmN4pooycrDUxOIX57fKmRrx3N2ZvgVpXxQM=;
        b=ZROd2EAtd44gRaTbiTSEpi7xns6bDnaG/2h1NCWu3hcBteaqZVhIirwl5PC0C9oab5
         jJ4NrblJlCFBrhLoLweloObOMe9+bMM1XGd5TlcF6X166ZMiAXKwHN5qSw4vdkXmzGNV
         QD6abFKtGbEq+OgoLJXCxP8LjyaucUlWqYW8YVVbXY8z+dhKZC0I/bNaTe3EBSkcGJ81
         m930fZYGL8IrecCjWzEikfAaeGPUfecDkJax+fHw0hRO1rh6frXuvSwuSMvfdOa0z2es
         Eucm1tgVqRJsa3lpO04VonEMkgZS1mCzUBllmDUHykvKB8oYOy3yPYH9emjrWJ9ZPivA
         hPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9n17ZvrmN4pooycrDUxOIX57fKmRrx3N2ZvgVpXxQM=;
        b=XrG6y9/a2r4RaLt7FyLutbr/uv8STUy/9OPM0K1MxMPXgEjGWBIHGX41N5BzEF40Fh
         iqTMNgwxraBpI6oEt/3PKjc1jWTTgPpNjjUPusIayAq+fQGLvvdVOf1gvTENZ150h90e
         gKrxzcYVkwWFiBNhrSW4a9c6QLPhSWNQH1nLRulAnsxjrViKnmHs01xsOzg9PKBsHFZI
         cZsmepQjqbj2RA2iuFULSkJcMCM7oh/C8ZjV4pRsjkYjKb2di/EAyNcE9F5LRVoDWXMI
         hborC9bYJQAAwXQsIev0XWRUN7P4ek4Gs19wSv3NI45Bc14cIUxLGpn0oTgP2JVl2Vmp
         yT+w==
X-Gm-Message-State: AGRZ1gK2DxVqrTZYJiuh2ml05wGB06Kx/V3uEoO/7pTrpf73alW2DM8l
        80XWCKjRioPxSdLGI0H6FUMhVg1JhGTBVH0M2S42Ag==
X-Google-Smtp-Source: AJdET5f6liU6Yb7yH2+BAMn803AQITXxcYcZQ8xBHBIxbSAxHqWBLwyt1ZWMLIri5m6K9UrLvt42c/MNwuiqADvQaO8=
X-Received: by 2002:a0d:ff46:: with SMTP id p67-v6mr12992400ywf.338.1541186242504;
 Fri, 02 Nov 2018 12:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <a170cf65-6884-3592-1de9-4c235888cc8a@intel.com>
 <4DECD467-AD45-419D-8F0F-1456863274FD@raithlin.com> <d127f28f-71fe-c175-c0e4-a368ff1d01a1@intel.com>
In-Reply-To: <d127f28f-71fe-c175-c0e4-a368ff1d01a1@intel.com>
From:   Daniel Mentz <danielmentz@google.com>
Date:   Fri, 2 Nov 2018 12:17:11 -0700
Message-ID: <CAE2F3rBifp4y=WQFC6CTcYtPUFyvLD4ZZMrZSzu4P+Fzot_f0A@mail.gmail.com>
Subject: Re: lib/genalloc
To:     alexey.skidanov@intel.com
Cc:     Stephen Bates <sbates@raithlin.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.co>,
        lkml <linux-kernel@vger.kernel.org>, labbott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:07 AM Alexey Skidanov
<alexey.skidanov@intel.com> wrote:
> On 11/1/18 18:48, Stephen  Bates wrote:
> >>    I use gen_pool_first_fit_align() as pool allocation algorithm allocating
> >>    buffers with requested alignment. But if a chunk base address is not
> >>    aligned to the requested alignment(from some reason), the returned
> >>    address is not aligned too.
> >
> > Alexey
> >
> > Can you try using gen_pool_first_fit_order_align()? Will that give you the alignment you need?
> >
> > Stephen
> >
> >
> I think it will not help me. Let's assume that the chunk base address is
> 0x2F400000 and I want to allocate 16MB aligned buffer. I get back the
> 0x2F400000. I think it happens because of this string in the
> gen_pool_alloc_algo():
>
> addr = chunk->start_addr + ((unsigned long)start_bit << order);
>
> and the gen_pool_first_fit_align() implementation that doesn't take into
> account the "incorrect" chunk base alignment.

gen_pool_first_fit_align() has no information about the chunk base
alignment. Hence, it can't take it into account.

How do you request the alignment in your code?

I agree with your analysis that gen_pool_first_fit_align() performs
alignment only with respect to the start of the chunk not the memory
address that gen_pool_alloc_algo() returns. I guess a solution would
be to only add chunks that satisfy all your alignment requirements. In
your case, you must only add chunks that are 16MB aligned.
I am unsure whether this is by design, but I believe it's the way that
the code currently works.
