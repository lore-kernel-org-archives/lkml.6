Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7DEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E361B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnV4TR6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E361B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJ2WJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeJ2WJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:09:00 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B5A2080A;
        Mon, 29 Oct 2018 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540819220;
        bh=b5/tuago8D5WvfnWBCpaKZxBL4k4rNqpm7I1T8K9G00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnV4TR6x5uxdRRXyW3OV6Uf/kf23iwxq9HaMuLrF/qRXFvfDdQIgyBXL38OHCDDm0
         Ytigqy8NgZ7pSnWQZahbHMe0DX5+yB2awC8HHKrhaIu3Z/li5GaBDyeBK0cjrQvt/p
         AMr7/K9Rge6oulUgwwBS95mIvM3Aq6Pjw7nOtEBo=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id BCDFC142C5F; Mon, 29 Oct 2018 10:20:01 -0300 (-03)
Date:   Mon, 29 Oct 2018 10:20:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: fix spelling mistake, EACCESS -> EACCES
Message-ID: <20181029132001.GD21857@kernel.org>
References: <20181026175839.4565-1-colin.king@canonical.com>
 <20181029122854.GB20813@kernel.org>
 <20181029123357.GA21857@kernel.org>
 <20181029123656.GB57235@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029123656.GB57235@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 29, 2018 at 01:36:56PM +0100, Ingo Molnar escreveu:
> 
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Mon, Oct 29, 2018 at 09:28:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Oct 26, 2018 at 06:58:39PM +0100, Colin King escreveu:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > > 
> > > > Trivial fix to a spelling mistake of the error access name EACCESS,
> > > > rename to EACCES
> > > 
> > > Thanks, applied.
> > > 
> > > And I also took the chance to fix another spelling mistake, on this same
> > > line:
> > > 
> > > -        *  -EACCESS    -- @event is for this PMU, @event is valid, but no privilidges
> > > +        *  -EACCES     -- @event is for this PMU, @event is valid, but no privilidges
> > >                                                                                  ^
> > >                                                                                  ^
> > >                                                                                  ^
> > >                                                                                  ^
> > 
> > But I see Ingo has already merged your patch, lets fix that one later
> > then :-)
> 
> I zapped my commit, please let's merge your upgraded version.
> 
> BTW., while at it, could we also try a header refresh now that a lot of 
> the merge window changes to headers are behind us, this is from the 
> perf/urgent build (f0718d792b8a)"
> 
> Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
> diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
> diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
> diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
> Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/kvm.h' differs from latest version at 'arch/powerpc/include/uapi/asm/kvm.h'
> diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
> Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/kvm.h' differs from latest version at 'arch/s390/include/uapi/asm/kvm.h'
> diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm/kvm.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/unistd.h' differs from latest version at 'arch/arm64/include/uapi/asm/unistd.h'
> diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
> Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
> diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
> Warning: Kernel ABI header at 'tools/include/uapi/linux/mman.h' differs from latest version at 'include/uapi/linux/mman.h'
> diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h
> 
> ?
> 
> Thanks!

Ok, I'll put together a perf/urgent with those things resolved, may take
a day or two as I'm working on addressing DaveM's reported issues and in
fixing the regressions that that "remove fallback to kallsyms for
userspace addresses" patch caused.

- Arnaldo
