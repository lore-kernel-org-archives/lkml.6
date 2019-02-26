Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A670C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DB72173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVfexhYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfBZFkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:40:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45352 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZFkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:40:35 -0500
Received: by mail-io1-f67.google.com with SMTP id x9so9533336iog.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 21:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwd5WKENydJd1AJ9VjYkBwcxB6cS9K+hKRcVy4TnBYU=;
        b=UVfexhYQYVM7OO/Y6mGYyay7LIdXpdQbFycFO/6vxeoEAvZvB0PdwjgdS5/GLM9nHT
         gHnpTnpCwMFjcDLFTmwm8JnV9XQgnO705Tic6cseoI9X7n/j3RivlqovvUMlevu4Z6DV
         r5zJ6ye632K24DjX46vpMQvwZBJHojz++ieGoD1Vhy1dRSx/QTwWkdVaHWWjseSgw2Ak
         PfN9YNntFEKxQl2S2TYEvyZrAo74ab/ZzGZqrJJDvzqV8kxsHqsAX/FQAOttIP2p6kZA
         eF0sva3xL3qckbDUqfsn574Fc5gHl7kqYPJ7c+wwEp7gpSO1Fmah26n8P4yl7oEhDsaf
         gAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwd5WKENydJd1AJ9VjYkBwcxB6cS9K+hKRcVy4TnBYU=;
        b=rW0kDtPdM+IJOQhmFGfDZEuurRmvApnBGK6awV7LiI3q9I/3IA6y5XDYTEM2Z0yjEy
         o3tvZIVePQKr4BSQFG89I33xCHSLXIA66zO0vWEazaGMj1263hhAn8jgf6qWMOVA14v7
         TGySS+iRmXCNwFyP1Tsqe6XvS9rZxFW3bkOyYmpO6q0LwZEJxKFQPYTThdbXqX/lOFb/
         ds5bY7C695b1jpcroyb+80N/iXT2NEHIgeDPRJu2NFXpmeRSy5gtdmda6Qba2+Xoxel4
         CaarIdHKjnEfrbvR13mAWlE/rGwkdLuLE2JjgMMbQv595yR4yCM47hmtZR5wSAYe/6n1
         ljFw==
X-Gm-Message-State: AHQUAuY9UupLX82lQDCNikA6OM9TQwrbFcoUCTru2TN0RI8AnqYu5xgT
        s80Hspg9AkpA5FZAChiddMEM9oDtU0Fp2PgdJA==
X-Google-Smtp-Source: AHgI3IY6QEwonoS6fzWDIUOgbIdEtgVosiEWIT3kvbZYdAztyEi/OEqMDw9i+umwpCh+ioT6Wru6jzIismwumcYfN7Y=
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr10644882iog.281.1551159634696;
 Mon, 25 Feb 2019 21:40:34 -0800 (PST)
MIME-Version: 1.0
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
 <1551011649-30103-6-git-send-email-kernelfans@gmail.com> <0c76e937-7cca-12a5-0655-ea8c4a427c54@intel.com>
In-Reply-To: <0c76e937-7cca-12a5-0655-ea8c4a427c54@intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 26 Feb 2019 13:40:23 +0800
Message-ID: <CAFgQCTuzhF+iGaH3rbw1C0Fb0dGdwrR5oXh+_jjuuPYhOankQw@mail.gmail.com>
Subject: Re: [PATCH 5/6] x86/numa: push forward the setup of node to cpumask map
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:30 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/24/19 4:34 AM, Pingfan Liu wrote:
> > At present the node to cpumask map is set up until the secondary
> > cpu boot up. But it is too late for the purpose of building node fall back
> > list at early boot stage. Considering that init_cpu_to_node() already owns
> > cpu to node map, it is a good place to set up node to cpumask map too. So
> > do it by calling numa_add_cpu(cpu) in init_cpu_to_node().
>
> It sounds like you have carefully considered the ordering and
> dependencies here.  However, none of that consideration has made it into
> the code.
>
> Could you please add some comments to the new call-sites to explain why
> the *must* be where they are?

OK. How about: "building up node fallback list needs cpumask info, so
filling cpumask info here"
Thanks for your kindly review.

Regards,
Pingfan
