Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA16C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3932150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sSbytMOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3932150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbeISXHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:07:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37329 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeISXHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:07:47 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so5826792oic.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohWyfVwBsxuhlbnJJn5sqc02ZNPahOm4FEe/cNnEu28=;
        b=sSbytMOEK9DNfjmn8rMVtuog0C41yfWMJhJukiRoFiTFFI0+a8T5SUzZasY4XMMTNe
         hH7bpi4eB6XVbXThYYnmI73A2OrMmplRlKK8gd6lqMmJ+qt/pZ8uV88gMJIW3NXEmSop
         wR2Hm7qOdWVQiz33sjGS8zLrPu4Vb59vp5frvqEiJ05frVSnm28rsSEZOXECn9ttCxbj
         6RorBlQbDbUm/iU5wjP/6H7x4EndmSUuEHJKOLw/TVFzhmmJJUDm+Uf5IDzfPyVDLvk8
         qVJbvOlFwgdVIYm/kBhib/aQKsTtau6IMt2bVXFY8m+WMXr5JgKYymaWmPaVBQpbTQWa
         L5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohWyfVwBsxuhlbnJJn5sqc02ZNPahOm4FEe/cNnEu28=;
        b=A7gMyJQAbXPzsUoA4IXykEZHag1JGreQl9Hn5haEQVO2woLoa2+tHQ39x5ycvfnGLF
         AIwo3jQPHkWJkCAfx06WND1AoP8Hnvyp/dwoKm4Cz+V2ju0gGVRupENIw5xBIb03kWiy
         fYFm+M/LjdB1BneSBhInqFDHqfTTc+P5OdJYi/rfOsiAN20UVd7xkg2vNqkyaVvnhluK
         QfDbWTyX7kwC04X7Heou0QzDmEs0DopWe6lJ0z8+BiEoqGKIav/iEu5gCwMX1dtDRtnQ
         0LsISqQ/8J8+2yidjdPyYuNM/u+sfZoomPTPuj/Vm2nvK7Kz89LPhdMaszGj/Tf5b1mm
         IO3A==
X-Gm-Message-State: APzg51BBefqjd7UPEjdpQtYQQsx9vIRtAFH6Gs+kf2Su2mfMdTfaIlRH
        gAQQnT+v++c1BbsJky3W9lZPoDWZ42EUtnLLjtb9Vw==
X-Google-Smtp-Source: ANB0VdZ64JbKqOd8HY7i6naHMvuA61nTUSu1T1v7WdFBz07r89hBlfwLoZCNpbj1cR0d7aJuIBZ6dqtS6SKxZkSz1Nk=
X-Received: by 2002:aca:a8c1:: with SMTP id r184-v6mr2397053oie.215.1537378130929;
 Wed, 19 Sep 2018 10:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <153737757130.23982.8187099986085191337.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153737757130.23982.8187099986085191337.stgit@djiang5-desk3.ch.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Sep 2018 10:28:39 -0700
Message-ID: <CAPcyv4gPDDHyev9cYHhrC4Z8rWRMZCS3xpXe+XWdgJ074renXw@mail.gmail.com>
Subject: Re: [PATCH] x86/numa_emulation: fix parsing of numa_meminfo for
 uniform numa emulation
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:20 AM Dave Jiang <dave.jiang@intel.com> wrote:
>
> During fakenuma processing in numa_emulation(), pi gets passed in and
> processed as new fake numa nodes are being split out. Once the original
> memory region is proccessed, it gets removed from the pi by
> numa_remove_memblk_from() in emu_setup_memblk(). So entry 0 gets deleted
> and the rest of the entries get moved up. Therefore we should always pass
> in entry 0 for the next entry to process.
>
> Fixes: 1f6a2c6d9f121 ("x86/numa_emulation: Introduce uniform split
> capability")
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Thanks Dave! I missed this behavior in my testing.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  arch/x86/mm/numa_emulation.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
> index b54d52a2d00a..a3ca8bf5afcb 100644
> --- a/arch/x86/mm/numa_emulation.c
> +++ b/arch/x86/mm/numa_emulation.c
> @@ -401,8 +401,8 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
>                 ret = -1;
>                 for_each_node_mask(i, physnode_mask) {

We might put a comment here because the use of 0 is non-obvious on first glance.

>                         ret = split_nodes_size_interleave_uniform(&ei, &pi,
> -                                       pi.blk[i].start, pi.blk[i].end, 0,
> -                                       n, &pi.blk[i], nid);
> +                                       pi.blk[0].start, pi.blk[0].end, 0,
> +                                       n, &pi.blk[0], nid);
>                         if (ret < 0)
>                                 break;
>                         if (ret < n) {
>
