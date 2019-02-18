Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE955218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550483098;
	bh=0B++qp9lH2KBqaoraOZvZIYKbnigUaaUtHa1NrL6rqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ytZ8PPQYUWD+a/mwlGjCntyl8HZpM3mRn36eqyO+SIGJ8HKnsgI7ZszUVSvA4rHiB
	 Rfv+rDMwsKXrwNYdO/iznYjFHGFxpXxe6Oh7N4ZGYtT5Q6ZQibrBAbQ+r2S7pwaboW
	 CbSu1zNtspq6Wg/XiFZsDTLcCKfEyjotwJnlSShY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfBRJo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:44:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:60356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728586AbfBRJo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:44:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0FA9AD18;
        Mon, 18 Feb 2019 09:44:54 +0000 (UTC)
Date:   Mon, 18 Feb 2019 10:44:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        Dan Williams <dan.j.williams@intel.com>, broonie@kernel.org,
        matthew.hart@linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        khilman@baylibre.com, enric.balletbo@collabora.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
Message-ID: <20190218094453.GJ4525@dhcp22.suse.cz>
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-02-19 10:20:10, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master boot bisection: next-20190215 on beaglebone-black
> 
> Summary:
>   Start:      7a92eb7cc1dc Add linux-next specific files for 20190215
>   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
>   Plain log:  https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.html
>   Result:     8dd037cc97d9 mm/shuffle: default enable all shuffling

Does
http://lkml.kernel.org/r/155033679702.1773410.13041474192173212653.stgit@dwillia2-desk3.amr.corp.intel.com
make any difference?
-- 
Michal Hocko
SUSE Labs
