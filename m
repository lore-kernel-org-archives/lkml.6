Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3254CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E742D20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtzFVyp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E742D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeLLXjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:39:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34350 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeLLXjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:39:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so104044plz.1;
        Wed, 12 Dec 2018 15:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t7RzwJg9SU1a0tSRK4L4gkChQHLSNCVw/K1MAC+FDYM=;
        b=gtzFVyp0tiN/Fl8CY/pk9qcTSumK4alYCnB4ffSu8J13Z4rIF2gSc1lSZhARAT+RM2
         mCcMLG8WJkdeJ5Db7ygp+v3IvrMAi7FysMDITcGNS6TBOsNV8liHeAtz8DRcFi7fZaGQ
         V0VBe/kEptzr6E+MnCL8xzcoU4zGDmmMS0d5dzQ+zhbON/gI+dq3qLsM77tU0NKUSkWv
         so4zahp92Nv6eynYZoW242uyNs+tqQ90mdQrL8/llNg1K2ou53/KJlATs/uHitl3Y/Dz
         X61BbNdeHLp8m9yzHA9r6S5vVUEJbpGGNPPckDb7vSl0zBb7SxREGKYxFKxvbQPyvKBU
         Zy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t7RzwJg9SU1a0tSRK4L4gkChQHLSNCVw/K1MAC+FDYM=;
        b=sfEFniNWoB842+m5NMACyfFCbhb5GPPAw9imRjRiLIvmtF5BDA7H8YgGMQj2GAl3EY
         BISWNkLfEGf4pZWBsuQTXpxKHg96B4xkS3m2KKoRYdeRoPA11dB49Cwv9mmQ8JEZ/nxY
         +pgGit6eJi1yoVJQ9UeyPIGkLBxody45sguh1AAvsJMEIi/j6gbYAWnyn6jhCB8NjuLt
         8IquihNsK7oclgfJEycA7CCAX1+B9ZPqxIfxtNRkUwdZrA/z2OAjbZ1X3fQEbIv497W2
         PocfnKx5vHVu72X9u8zTR7EZeO5k1bIZ+TfxMV+6ufVF/I4FfSXAWVnLXytUAyWXZHzI
         1Y7A==
X-Gm-Message-State: AA+aEWb6Bmt3gu+kE8BI1gfWvKMQQU3Gmc3VinPtVV1Nbd/j1L/+3sjV
        jQldHX4za67romaBW0FFOWwIpBsB
X-Google-Smtp-Source: AFSGD/UdhCfVpVJmy0TkCTooI/Yj7bEx4LvZDuR2uWqfe178t63m2FC20v/nQ9WiK94ciwXwYc/htw==
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13mr22367968plm.49.1544657953831;
        Wed, 12 Dec 2018 15:39:13 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:2c20])
        by smtp.gmail.com with ESMTPSA id u123sm144682pfb.1.2018.12.12.15.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 15:39:12 -0800 (PST)
Date:   Wed, 12 Dec 2018 15:39:10 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the bpf-next
 tree
Message-ID: <20181212233909.hhf5q4vpi3mmi37u@ast-mbp.dhcp.thefacebook.com>
References: <20181213073245.5b2d2536@canb.auug.org.au>
 <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
 <20181213094820.62d26354@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213094820.62d26354@canb.auug.org.au>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 09:48:20AM +1100, Stephen Rothwell wrote:
> Hi Alexei,
> 
> On Wed, 12 Dec 2018 12:53:11 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Dec 13, 2018 at 07:32:45AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Commits
> > > 
> > >   3bdc28aa2340 ("selftests/bpf: add btf annotations for cgroup_local_storage maps")
> > >   1dfd1959fed4 ("bpf: add bpffs pretty print for cgroup local storage maps")
> > >   3adc62d9a5be ("bpf: pass struct btf pointer to the map_check_btf() callback")
> > >   9cf3a785dc4c ("selftests/bpf: use __bpf_constant_htons in test_prog.c")
> > > 
> > > are missing a Signed-off-by from their committers.  
> > 
> > the must be a script mistake?
> > 
> > I clearly see SOBs for all of them.
> 
> For example:
> 
> commit 3bdc28aa2340bf1e5af753287b373522bd1c02a9 (bpf-next/master)
> Author: Roman Gushchin <guroan@gmail.com>
> Date:   Mon Dec 10 15:43:02 2018 -0800
> 
>     selftests/bpf: add btf annotations for cgroup_local_storage maps
>     
>     Add btf annotations to cgroup local storage maps (per-cpu and shared)
>     in the network packet counting example.
>     
>     Signed-off-by: Roman Gushchin <guro@fb.com>
>     Cc: Alexei Starovoitov <ast@kernel.org>
>     Cc: Daniel Borkmann <daniel@iogearbox.net>
>     Acked-by: Martin KaFai Lau <kafai@fb.com>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> But it was committed by you, not Daniel.

since there were only 4 commits I fixed them up manually.
But this approach doesn't scale.
We do rebase our trees when we need to fixup or drop patches and
at any given point a number of commits will be committed by me
and another set by Daniel. When we rebase we cannot keep adding
our SOBs to the other person SOBs.
Then comes the next rebase and we get to the point of
double and triple SOBs ?

I think you need to adjust the script to something like:
SOBs by Daniel | Alexei == commit by Daniel | Alexei
in bpf and bpf-next trees.

