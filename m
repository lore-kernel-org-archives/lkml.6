Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F9C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F1821709
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhnz2jek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F1821709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeHOBFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:05:16 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36534 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeHOBFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:05:16 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so8875191plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 15:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DVT95wMs8iciLnoB+xncJ3cewJC6M3HPWMID8AIAjzU=;
        b=nhnz2jek0KMWBU6Mi/Rup+jXme9IAO7/UKn8NXvV6TGNND/DaRoZMr/Dk13QfdYKbk
         kssm2kYfmXNJxDlrn553WTMoXWjHSpVB2s/8fM8lARgXKCi9IgnYz249eJlxdzKB6Eqi
         bYtRGy53sG6DS5uK8BI3OQttnpSPtxsaQT8J75l1mo7pXESeicJmsB1rWwfv7/t54bQx
         8XLKoobptFWlSilUMokbLDVOH/V0HXyjUj4g0DJnPjb9a7jAgv8P9107S1Diq6E5202j
         Q32/jMiSSE6N3EJalXoYnGbdvlhdITT/G0eo+qJWx4CjVCFYgyoM2EwO5xpFtwdmYeeZ
         gpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DVT95wMs8iciLnoB+xncJ3cewJC6M3HPWMID8AIAjzU=;
        b=KM7L/jc0HKzUAoTJ2ghRpEZqMJZpb33t16946STBc4DzziIiRuhbKvrEwY5+I/UHfm
         3YWItI1533clVvH7nrO24w6GiKQm0jNfRl+VX4PxduoUneVDARPWpbfBqHX4eYcYUdVA
         WtCZ0woCoY1MRLJaH564mHC1tVXCQBFBLDjXsNxoVbV8fRPkvjdeTh6AjkykqeUGJnXM
         Rc1tCSljrULk26Kx10AjCBB5SHsgP823qQtVYHyW5vJZMqgePCMWByPKmp8/XFKlQEZ/
         f/yqaS5hO/TWFU1qUkCAGBoBVP9lRfrbo+xEwzJd8t8OMtWiowTJctax8BGGoIfJXeSv
         kvqg==
X-Gm-Message-State: AOUpUlEGV4w/4ee7UDDNDvxTmtawy9HIxXoVB97DgK01Pp05KFX5rlym
        OpvTB/ZR1EnU3vFkm7b4N5Nr/s0Q
X-Google-Smtp-Source: AA+uWPxiTVomNEgGK202zNkwwr8zMA7GbdZ0hb6tz8mnA3OrKHvxugY2xLCUz4CGewjHJ2N4BQ8sZg==
X-Received: by 2002:a17:902:7486:: with SMTP id h6-v6mr22575116pll.165.1534284960847;
        Tue, 14 Aug 2018 15:16:00 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f90-v6sm36822442pfh.168.2018.08.14.15.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 15:16:00 -0700 (PDT)
Date:   Tue, 14 Aug 2018 15:15:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Build failures with gcc 4.5 and older
Message-ID: <20180814221559.GA15888@roeck-us.net>
References: <20180814170904.GA12768@roeck-us.net>
 <20180814143655.3acd4bb211d44747f77e74f2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814143655.3acd4bb211d44747f77e74f2@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 02:36:55PM -0700, Andrew Morton wrote:
> On Tue, 14 Aug 2018 10:09:04 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Since commit c1a2f7f0c0645 ("mm: Allocate the mm_cpumask
> > (mm->cpu_bitmap[]) dynamically based on nr_cpu_ids"), building
> > the Linux kernel with gcc version 4.5 and older fails as follows.
> > 
> > In file included from ./include/linux/mm.h:17:0,
> >                  from ./include/linux/pid_namespace.h:7,
> > 		 from ./include/linux/ptrace.h:10,
> > 		 from arch/openrisc/kernel/asm-offsets.c:32:
> > ./include/linux/mm_types.h:497:16: error: flexible array member in otherwise empty struct
 
> Confused.  Why does it think that the mm_struct is "otherwise empty"?
> 

The problem isn't really that the structure is otherwise empty.
Some digging reveals that the error message is wrong; gcc should
instead complain about having no _named_ structure element before
the flexible array member.

> This shuts it up:
> 
> --- a/include/linux/mm_types.h~a
> +++ a/include/linux/mm_types.h
> @@ -490,6 +490,7 @@ struct mm_struct {
>  #endif
>  	} __randomize_layout;
>  
> +	int wibble;
>  	/*
>  	 * The mm_cpumask needs to be at the end of mm_struct, because it
>  	 * is dynamically sized based on nr_cpu_ids.
> 

Unfortunately, that only triggers secondary errors.
Seen with both gcc 4.4 and 4.5.

mm/init-mm.c:29: error: unknown field ‘mm_rb’ specified in initializer
mm/init-mm.c:29: warning: missing braces around initializer
mm/init-mm.c:29: warning: (near initialization for ‘init_mm.<anonymous>’)
mm/init-mm.c:29: error: incompatible types when initializing type ‘struct
vm_area_struct *’ using type ‘struct rb_root’
mm/init-mm.c:30: error: unknown field ‘pgd’ specified in initializer

and many more similar errors.

Guenter
