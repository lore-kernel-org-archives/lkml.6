Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFEBC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A6A218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551225593;
	bh=MHD+FcdQSqYumIeEP0I1uVqrCPFk3vBQSaXOD9KZBQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xtyxhbDZ5aZswhDp2o+chdoq+8kGyNiFSSZhu4aMb4nz89rPujN4b3h9TNJKhGZpi
	 3i4fpG4N63gGgmvPeFCkpINGcZKFLR9sxWoJC6xII/X+NYSIsXee4L97QuaK3MOrgd
	 vVHc8zoeettkTXzFnvCwdTd7dIgzPzBY6oOkHjvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfBZX7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:59:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZX7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:59:51 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CD112833B;
        Tue, 26 Feb 2019 23:59:49 +0000 (UTC)
Date:   Tue, 26 Feb 2019 15:59:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com,
        Dan Williams <dan.j.williams@intel.com>,
        matthew.hart@linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        khilman@baylibre.com, enric.balletbo@collabora.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
Message-Id: <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
In-Reply-To: <20190215185151.GG7897@sirena.org.uk>
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
        <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
        <20190215185151.GG7897@sirena.org.uk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 18:51:51 +0000 Mark Brown <broonie@kernel.org> wrote:

> On Fri, Feb 15, 2019 at 10:43:25AM -0800, Andrew Morton wrote:
> > On Fri, 15 Feb 2019 10:20:10 -0800 (PST) "kernelci.org bot" <bot@kernelci.org> wrote:
> 
> > >   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
> > >   Plain log:  https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.txt
> > >   HTML log:   https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.html
> 
> > Thanks.
> 
> > But what actually went wrong?  Kernel doesn't boot?
> 
> The linked logs show the kernel dying early in boot before the console
> comes up so yeah.  There should be kernel output at the bottom of the
> logs.

I assume Dan is distracted - I'll keep this patchset on hold until we
can get to the bottom of this.

