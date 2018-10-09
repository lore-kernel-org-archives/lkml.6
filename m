Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0FAC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F12721479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F12721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJITH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:07:26 -0400
Received: from foss.arm.com ([217.140.101.70]:36616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeJITHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:07:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 701307A9;
        Tue,  9 Oct 2018 04:50:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 412E33F5D3;
        Tue,  9 Oct 2018 04:50:50 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 846071AE03D0; Tue,  9 Oct 2018 12:50:49 +0100 (BST)
Date:   Tue, 9 Oct 2018 12:50:49 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steve.capper@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation/arm64: HugeTLB page implementation
Message-ID: <20181009115049.GA6248@arm.com>
References: <97e4e5fb-24ed-0545-414a-6a0c0116e6b8@infradead.org>
 <20181008100355.31820-1-punit.agrawal@arm.com>
 <67f4ceb7-d41c-ab7a-4d5e-c147dadf6860@infradead.org>
 <87ftxf7812.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftxf7812.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:02:01AM +0100, Punit Agrawal wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
> > On 10/8/18 3:03 AM, Punit Agrawal wrote:
> >> Arm v8 architecture supports multiple page sizes - 4k, 16k and
> >> 64k. Based on the active page size, the Linux port supports
> >> corresponding hugepage sizes at PMD and PUD(4k only) levels.
> >> 
> >> In addition, the architecture also supports caching larger sized
> >> ranges (composed of multiple entries) at the PTE and PMD level in the
> >> TLBs using the contiguous bit. The Linux port makes use of this
> >> architectural support to enable additional hugepage sizes.
> >> 
> >> Describe the two different types of hugepages supported by the arm64
> >> kernel and the hugepage sizes enabled by each.
> >> 
> >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks!
> 
> Catalin, Will - I assume you'll pick this up at some point? Or do arm64
> documentation patches get routed by another tree?

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin can pick this up for 4.20.

Will
