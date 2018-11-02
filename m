Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3414EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2FE20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncGA3AbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2FE20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeKCGZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:25:31 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:38481 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeKCGZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:25:31 -0400
Received: by mail-yw1-f47.google.com with SMTP id d126-v6so1315558ywa.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mno8dAIKnaDMIRmkPO62K+I1gtEuyi3eGPcIn207xQ=;
        b=ncGA3AbYd+cH9/LMyKyKA6/blhZg6dJyCNNww/+5eNPm9Z4jZCabwMjM5cyYJMRev3
         BAn4byrhi2+/6NkRDgkLjCRInW6nHcKuwJgHyJclfQ4IKVErKOujXdPmNvItv9I6vTbz
         KFpHOfmNlQC4k9fF8fxn1PD5uK09hQ2FGqARiMrxUSXZwzjuMZL5k2YnvQ5vPIx09Oep
         5YIsJ1ztmSLGFKlaxZ5XISsg3SieoA9tcuE9BAjz9R0VhlQC00izH1ReBbI78kYzZSRu
         yZs88pnO6ZFskkpWWVsv6BKvYqK5v5IPBrB3H1Y/PfHZ7CzSQ47AlyOltNZrePwvJjI/
         lFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mno8dAIKnaDMIRmkPO62K+I1gtEuyi3eGPcIn207xQ=;
        b=iy3vm9YK70PYFhP6Jf6IQjubogPu0eKwKJ1XXQYZdmWp5jwa6MJfq7OrN2zLYyyYg2
         9rzXdlW74eWp83UVNStpsMyhG0VwZ+Op6aGm70qxzKZ8nVR8s0Im7gUS6plQx6oc/tGi
         tfsBBl3OxvSTc05zNoZxsafJhsWKJhFb2dD1XKNyt+yxrmNVqJ2nm3MfKZoCY1yndPPZ
         U0LUMT0MOqPpXVNgiBrvcDQs8Gn8jGJtv19cUvlJY+DXEzfOfF8enlX1nCxRRZyIzya2
         TQnhWAw+pqIh225t7V48pCQEHTtGThbOVlD0hzQti13px2uR+uz++tGjCKHmO7GZKrBx
         PxRw==
X-Gm-Message-State: AGRZ1gL29JG0K3EqHV6Hhb9kZxo1xlCCYP6g8zjVWSMhJYGOdtW/yNRT
        8iogNglXWvcMVr3QY3YcZfPe/+CYCN5OeO2DnP8pBw==
X-Google-Smtp-Source: AJdET5esU0JGopC9pZFXQVigztWY+Vwnd0KRM063HDlAQe3ZMyY+RIl+LN3mEGlyon5Kyfjy9QPNSOkC5JuXL+m7Vf4=
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr13414300ywf.237.1541193406862;
 Fri, 02 Nov 2018 14:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <a170cf65-6884-3592-1de9-4c235888cc8a@intel.com>
 <4DECD467-AD45-419D-8F0F-1456863274FD@raithlin.com> <d127f28f-71fe-c175-c0e4-a368ff1d01a1@intel.com>
 <CAE2F3rBifp4y=WQFC6CTcYtPUFyvLD4ZZMrZSzu4P+Fzot_f0A@mail.gmail.com> <de2e1756-329b-7df2-559e-a603a7edc2ff@intel.com>
In-Reply-To: <de2e1756-329b-7df2-559e-a603a7edc2ff@intel.com>
From:   Daniel Mentz <danielmentz@google.com>
Date:   Fri, 2 Nov 2018 14:16:35 -0700
Message-ID: <CAE2F3rDm1X-UuWHoJf9wAz3HJkC_LQP+UMq81Opu6te7KH704Q@mail.gmail.com>
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

On Fri, Nov 2, 2018 at 1:55 PM Alexey Skidanov
<alexey.skidanov@intel.com> wrote:
>
>
>
> On 11/2/18 9:17 PM, Daniel Mentz wrote:
> > On Thu, Nov 1, 2018 at 10:07 AM Alexey Skidanov
> > <alexey.skidanov@intel.com> wrote:
> >> On 11/1/18 18:48, Stephen  Bates wrote:
> >>>>    I use gen_pool_first_fit_align() as pool allocation algorithm allocating
> >>>>    buffers with requested alignment. But if a chunk base address is not
> >>>>    aligned to the requested alignment(from some reason), the returned
> >>>>    address is not aligned too.
> >>>
> >>> Alexey
> >>>
> >>> Can you try using gen_pool_first_fit_order_align()? Will that give you the alignment you need?
> >>>
> >>> Stephen
> >>>
> >>>
> >> I think it will not help me. Let's assume that the chunk base address is
> >> 0x2F400000 and I want to allocate 16MB aligned buffer. I get back the
> >> 0x2F400000. I think it happens because of this string in the
> >> gen_pool_alloc_algo():
> >>
> >> addr = chunk->start_addr + ((unsigned long)start_bit << order);
> >>
> >> and the gen_pool_first_fit_align() implementation that doesn't take into
> >> account the "incorrect" chunk base alignment.
> >
> > gen_pool_first_fit_align() has no information about the chunk base
> > alignment. Hence, it can't take it into account.
> >
> > How do you request the alignment in your code?
> >
> > I agree with your analysis that gen_pool_first_fit_align() performs
> > alignment only with respect to the start of the chunk not the memory
> > address that gen_pool_alloc_algo() returns. I guess a solution would
> > be to only add chunks that satisfy all your alignment requirements. In
> > your case, you must only add chunks that are 16MB aligned.
> > I am unsure whether this is by design, but I believe it's the way that
> > the code currently works.
> >
>
> Daniel,
>
> I think the better solution is to use bitmap_find_next_zero_area_off()
> that receives the bit offset (CMA allocator uses it to solve the same
> issue). Of course, we need to pass the chunk base address to the
> gen_pool_first_fit_align().
>
> What do you think?

Yeah, I guess you could extend genpool_algo_t to include the
information you need i.e. the offset and then provide a modified
version of gen_pool_first_fit_align() that does take your offset into
account. I wouldn't change gen_pool_first_fit_align(), though, because
existing users might depend on the current behavior.
