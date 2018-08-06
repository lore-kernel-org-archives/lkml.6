Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEDEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF8C21918
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs+7LRo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF8C21918
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbeHGBQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:16:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32794 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbeHGBQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:16:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so6012902edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTT5Qi08h4lbzwoBJQEFpX+sdQJpBP1ZlomShrgMuyI=;
        b=Qs+7LRo9AgwaBqixL7u+IzeNwtzj67xdc0pB4rZwm7HMYVBwv5vZbQQND4s1xyaYN7
         4cnaAObub4BXFxY7eeH0rhf0lh/eNPIpOND+Wt6cFdXHiDUddR0xvKo3vPV6t1tnSiYm
         pf4xsFPHO94JMZ/+l8Mlm7GpucAgPbE6pjOcTAYb/7z2BlLZoa5Jau1WGiYEOrflbbp8
         Db46hlcil4e1+KTULBVOrkf7L10BHO24gK2SmahXvtMrjQjupcabhJNUTv0L9hyPIciC
         dL64rs6AdjS8IlOo1y1ILLUbkDTfgkyyfJINNyi3PRzM+RdKIim1ThWVdX5GH3fsMmaH
         sZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTT5Qi08h4lbzwoBJQEFpX+sdQJpBP1ZlomShrgMuyI=;
        b=kMEqtLnV2/5lTV8VYf38bYhzUXIoZLF8xzA5sX1a+pxyIaYdAKLkOhsH9PX/yEnUL4
         8TRWaK+Ltx5yXkdQcxK4TGpJZL9OjY5U6Hb29ZtRZRrQG6NYSCJwZS6Jr31SBi0VvMy2
         iE0M3/I37Kv1MeSTB0EonNZQCoxF+QbbzWmnb4G9XU1VqFMwMgrmw3RqlzKOLij5GTQq
         9VDzHJcrNOG3EIDVOC4eZ6TuZT0o+teajz5c2p+NicPiKWyoWmBLhfepMfp1jDbE9dhx
         htwjBGzPq0fnt/sLlLQ3EJ0CoySPsjGGUzdJK6qZTsbdYebAEaBe0BaQKTU9RsYhMYDi
         WLeg==
X-Gm-Message-State: AOUpUlGBPl6+c03v30p1Zt1ndwGrYmGclTR48SBwJDiqpyAgCCLsndjI
        BCmbnj8xhbUQkj799ZypPEb+6mtIGumRaX8NAoJ29g==
X-Google-Smtp-Source: AAOMgpfgaxLT0+fa7C81PCMUCDaWpzrJgrdT0KEUmZOEp6PYmxufLLTYKC8C9avpFzfJpQjUH4OIGPPdJm14GyWNtpg=
X-Received: by 2002:a50:e0c9:: with SMTP id j9-v6mr20189043edl.198.1533596691783;
 Mon, 06 Aug 2018 16:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble> <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net> <CAJAFBLDtRUwYhMaOrgHer4eTvjWL2jC-fy0GGv+Pjd8q3wgywA@mail.gmail.com>
 <20180806154235.GO2494@hirez.programming.kicks-ass.net> <CAJAFBLCt574QmeP5N9D-d+Sc67BWQ5E2C=LhqFVvUpchC4O3PQ@mail.gmail.com>
 <20180806180423.GC2476@hirez.programming.kicks-ass.net> <CAJAFBLA2WigOMxuWXxZvHVwuGtvYr3_b4gpNbdGzry-=AVxjqA@mail.gmail.com>
 <20180806223008.GW2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180806223008.GW2494@hirez.programming.kicks-ass.net>
From:   Fubo Chen <fubo.chen@gmail.com>
Date:   Mon, 6 Aug 2018 16:04:40 -0700
Message-ID: <CAJAFBLDzX78w=uaTdBQ_obb9hBMLGXG1Ec0hb199HEXxXQBPjQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)
To:     peterz@infradead.org
Cc:     jpoimboe@redhat.com, Ingo Molnar <mingo@kernel.org>,
        bhole_prashant_q7@lab.ntt.co.jp,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 3:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 06, 2018 at 02:28:18PM -0700, Fubo Chen wrote:
> > Do you think the patch below is sufficient to suppress the sparse warning?
>
> Why would I want to make the code ugly to supress it?

There are many kernel developers who use sparse to verify the
correctness of endianness annotations (__be32, __le32, ...). When
compiling kernel code with sparse every warning that is reported by
sparse should be analyzed. Most kernel developers consider it annoying
having to deal with false positive warnings. So I think that is useful
to suppress false positive sparse warnings if it is possible to
suppress false positives with a reasonable effort.

Thanks,

Fubo.



-- 
Fubo.
