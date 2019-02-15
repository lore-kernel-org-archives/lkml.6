Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC43FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D729222D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfBOTAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:00:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfBOTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:00:33 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0BF8C84;
        Fri, 15 Feb 2019 19:00:32 +0000 (UTC)
Date:   Fri, 15 Feb 2019 11:00:24 -0800
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
Message-Id: <20190215110024.011197d86e3ab8642a9bbecf@linux-foundation.org>
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

OK, thanks.

Well, we have a result.  Stephen, can we please drop
mm-shuffle-default-enable-all-shuffling.patch for now?
