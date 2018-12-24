Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12C0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C2A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FplkajAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbeLXNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:01:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbeLXNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZsIB6qumN3KKrUmRj7fYSd3f1ILuZORklr37aD5h6og=; b=FplkajAxOwKBT5LFsRggEvEsV
        Sa7T619x3Pof7uCe9Hlj/jJ/9EgYkRy+IXa0X+8ATLjE0u/Zcxs/f/w8GKJn+168aoPVrp0zLjek2
        VbdIfgUP8p5o5ZHVPE5urYnSLAqDEnwXtZUR2SPJd4avbB6gtghl0K3YrgBGCpJcNR7Rh0HE6IgMY
        OwoomWzmh1nVLY2g6tiGeg7MtJ2u9sIa+ngXrKxstVWv0KK3StYrgFwGIcjsPB9V7nF1K8NP6vpTa
        lw4EaxgGu5QibZYJtxsk2GZET1YkoW+Fg0odgSJV2QYrV59IacxeUfGhRNMC2Fvrrv9otWxxmrJzG
        mKVrLmuFw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gbPrO-00050o-MJ; Mon, 24 Dec 2018 13:01:30 +0000
Date:   Mon, 24 Dec 2018 05:01:30 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [xarray]  b803b42823: BUG:soft_lockup-CPU##stuck_for#s
Message-ID: <20181224130130.GM10600@bombadil.infradead.org>
References: <20181224125620.guph2apbk4snhirq@inn2.lkp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224125620.guph2apbk4snhirq@inn2.lkp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 08:56:20PM +0800, kernel test robot wrote:
> [   51.886077] Call Trace:
> [   51.886077]  ? xas_find+0x11b/0x240
> [   51.886077]  ? xa_find+0xc2/0xe0
> [   51.886077]  ? check_find+0x11a/0x420
> [   51.886077]  ? check_multi_store+0xa40/0xa40
> [   51.886077]  ? xarray_checks+0x30/0x70
> [   51.886077]  ? do_one_initcall+0x68/0x253

Since you're running the selftests at 51 seconds in, I'm putting this
in the same bucket as the others -- spurious report due to overloaded
test machine.


