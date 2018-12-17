Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75501C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E80520675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545037539;
	bh=HTXZCtMcxs/gYfkoy/3LsaDOOz6vNKD/BtyVneGJnBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UgW5pxo6FMcVkmI+mYLUOd55YKM0I47DYdYHrUhIhaTp/b+kZrHUw9XgGsJLtTZV0
	 wwfk0CnKA8PurE9HOus++U3JcYNm0c3/t/whSdwjZH2DdB/vaYWzGkJujZyfXyNZNe
	 hxhENPlnyS2X7Xgkh3cLx8YV58ErJEu3rtbNHmiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbeLQJFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLQJFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:05:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EB2120672;
        Mon, 17 Dec 2018 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545037536;
        bh=HTXZCtMcxs/gYfkoy/3LsaDOOz6vNKD/BtyVneGJnBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uD3x4Hy6iB47DDnq3x5PIfu+jvFGmgziU4DSfT1tublK+1gP+GEPZmdZmgUeM/4Ox
         UegbJS0DQ42JtId3VsPMhsGNdOfmWgBad1Sqb5pp8V/ucVWTLFcxJzzyy99rRL3eZp
         vLu7GeU5EGcC5ekjqhZMLv+3bIn5G7qC80gCi4qY=
Date:   Mon, 17 Dec 2018 10:05:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
Message-ID: <20181217090533.GA12938@kroah.com>
References: <20181214115702.151309521@linuxfoundation.org>
 <dfd49bfd-359a-7f5e-8332-5e6ad6da21cd@roeck-us.net>
 <20181215080729.GG10074@kroah.com>
 <c5862b36-beae-4810-fb33-4b646e96378b@roeck-us.net>
 <1545004693.19315.66.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545004693.19315.66.camel@codethink.co.uk>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 11:58:13PM +0000, Ben Hutchings wrote:
> On Sat, 2018-12-15 at 07:45 -0800, Guenter Roeck wrote:
> > On 12/15/18 12:07 AM, Greg Kroah-Hartman wrote:
> > > On Fri, Dec 14, 2018 at 06:10:29PM -0800, Guenter Roeck wrote:
> > > > On 12/14/18 3:59 AM, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.4.168 release.
> > > > > There are 88 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > 
> > > > Build results:
> > > > 	total: 170 pass: 145 fail: 25
> > > > Failed builds:
> > > > 	arm:allnoconfig
> > > > 	arm:tinyconfig
> > > > 	arm:efm32_defconfig
> > > > 	blackfin:defconfig
> > > > 	blackfin:BF561-EZKIT-SMP_defconfig
> > > > 	c6x:dsk6455_defconfig
> > > > 	c6x:evmc6457_defconfig
> > > > 	c6x:evmc6678_defconfig
> > > > 	h8300:allnoconfig
> > > > 	h8300:tinyconfig
> > > > 	h8300:edosk2674_defconfig
> > > > 	h8300:h8300h-sim_defconfig
> > > > 	h8300:h8s-sim_defconfig
> > > > 	m68k:allnoconfig
> > > > 	m68k:tinyconfig
> > > > 	m68k:m5272c3_defconfig
> > > > 	m68k:m5307c3_defconfig
> > > > 	m68k:m5249evb_defconfig
> > > > 	m68k:m5407c3_defconfig
> > > > 	microblaze:nommu_defconfig
> > > > 	microblaze:allnoconfig
> > > > 	microblaze:tinyconfig
> > > > 	sh:defconfig
> > > > 	sh:allnoconfig
> > > > 	sh:tinyconfig
> > > > Qemu test results:
> > > > 	total: 288 pass: 288 fail: 0
> > > > 
> > > > mm/nommu.c: In function '__get_user_pages_unlocked':
> > > > mm/nommu.c:211:49: error: 'write' undeclared (first use in this function)
> > > > mm/nommu.c:211:56: error: 'force' undeclared (first use in this function)
> > > > mm/nommu.c:212:9: warning: passing argument 7 of 'get_user_pages' from incompatible pointer type [enabled by default]
> > > > mm/nommu.c:185:6: note: expected 'struct vm_area_struct **' but argument is of type 'struct page **'
> > > > mm/nommu.c:212:9: error: too many arguments to function 'get_user_pages'
> > > > mm/nommu.c:185:6: note: declared here
> > > > 
> > > > Details are available at https://kerneltests.org/builders/.
> > > 
> > > Ugh, I'll dig through this later on today, we must be missing something
> > > with those backports that Ben did...
> > > 
> > 
> > 69ce144e5c3a ("mm: replace get_user_pages() write/force parameters
> > with gup_flags") seems to have missed converting a call of
> > get_user_pages().
> 
> Right.  This was changed earlier upstream in commit cde70140fed8
> "mm/gup: Overload get_user_pages() functions", but I don't think it
> makes sense to apply all of that.  I'm attaching a minimal patch
> (tested with an arm allnoconfig build) which should ideally be inserted
> before mm-replace-get_user_pages-write-force-parameters-with-
> gup_flags.patch.
> 
> Ben.
> 
> -- 
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom

> From 0d0afe933f60f5736c984e9171214aa34b18764c Mon Sep 17 00:00:00 2001
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Date: Sun, 16 Dec 2018 23:50:08 +0000
> Subject: [PATCH] mm/nommu.c: Switch __get_user_pages_unlocked() to use
>  __get_user_pages()
> 
> Extracted from commit cde70140fed8 "mm/gup: Overload get_user_pages()
> functions".  This is needed before picking commit 768ae309a961
> "mm: replace get_user_pages() write/force parameters with gup_flags".
> 
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  mm/nommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index fa1560c218d5..2360546db065 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -208,8 +208,8 @@ long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
>  {
>  	long ret;
>  	down_read(&mm->mmap_sem);
> -	ret = get_user_pages(tsk, mm, start, nr_pages, write, force,
> -			     pages, NULL);
> +	ret = __get_user_pages(tsk, mm, start, nr_pages, gup_flags, pages,
> +			       NULL, NULL);
>  	up_read(&mm->mmap_sem);
>  	return ret;
>  }

Thanks for the patch.  I've added it to the queue and pushed out a -rc2
with this in it.

Let's see what the builders say :)

greg k-h
