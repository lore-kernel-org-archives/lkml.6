Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82C6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD4F20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547805554;
	bh=bi79GgZoAuKaprmqKXHTzgLH9/5j+h1IjVoIMgE+fvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HtFtRKtVtAt811ZMHfOPPYvUelAr2NLHXfM31BONB9eC1byjQEkUwncgBBURvuOoX
	 23m3Tmo78cVhVRSAV3wmxF+lQb0wG7a1vxahDWr922735QfKRFcdYQc3xC+GXTH/y4
	 /8Zqyz5B7cn1i6CmcZFoTl84QHTMsRM74T+DY9a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfARJ7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:59:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfARJ7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:59:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F09120855;
        Fri, 18 Jan 2019 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547805552;
        bh=bi79GgZoAuKaprmqKXHTzgLH9/5j+h1IjVoIMgE+fvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yf1jjm/VFkQ5nG+rjeQM3LZqHdV2MjPVlMO5L1C8RLkJ1Ub6DAkbaKCug3O1oe5jl
         CF1r4vuVYR0tR0FBAtfAV/utPjX7k3BITbE5DR2T0IELiyh2xzHnsg8BHlUyJLlxnK
         53klqVavymDn+Lj5/vlLk7lkEyR2beeG8GHGkm/I=
Date:   Fri, 18 Jan 2019 10:59:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] staging: android: ion: Declare helpers for
 carveout and chunk heaps
Message-ID: <20190118095909.GB28982@kroah.com>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-13-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111180523.27862-13-afd@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:05:21PM -0600, Andrew F. Davis wrote:
> When enabled the helpers functions for creating carveout and chunk heaps
> should have declarations in the ION header.

Why?  No one calls these from what I can tell.

Which makes me believe we should just delete the
drivers/staging/android/ion/ion_carveout_heap.c and
drivers/staging/android/ion/ion_chunk_heap.c files as there are no
in-tree users?

Any objection to me doing that?

thanks,

greg k-h
