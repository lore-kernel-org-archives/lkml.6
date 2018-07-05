Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2E6C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA91F20878
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA91F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeGERPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:15:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753657AbeGERPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:15:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 686AB7A9;
        Thu,  5 Jul 2018 10:15:33 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 392DC3F2EA;
        Thu,  5 Jul 2018 10:15:33 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7F9A91AE3638; Thu,  5 Jul 2018 18:16:13 +0100 (BST)
Date:   Thu, 5 Jul 2018 18:16:13 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
Message-ID: <20180705171612.GB25425@arm.com>
References: <20180627141348.21777-1-toshi.kani@hpe.com>
 <20180627141348.21777-3-toshi.kani@hpe.com>
 <20180627155632.GH30631@arm.com>
 <1530115885.14039.295.camel@hpe.com>
 <20180629122358.GC17859@arm.com>
 <1530287995.14039.361.camel@hpe.com>
 <alpine.DEB.2.21.1807032301140.1816@nanos.tec.linutronix.de>
 <20180704173605.GB9668@arm.com>
 <alpine.DEB.2.21.1807042137330.28271@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807042137330.28271@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 09:39:50PM +0200, Thomas Gleixner wrote:
> On Wed, 4 Jul 2018, Will Deacon wrote:
> > On Tue, Jul 03, 2018 at 11:02:15PM +0200, Thomas Gleixner wrote:
> > 
> > > I just pick it up and provide Will a branch to pull that lot from.
> > 
> > Thanks, Thomas. Please let me know once you've pushed something out.
> 
> Just pushed it out into tip x86/mm branch. It's based on -rc3 and you can
> consume it up to
> 
>   5e0fb5df2ee8 ("x86/mm: Add TLB purge to free pmd/pte page interfaces")
> 
> Please wait until tomorrow morning so the 0day robot can chew on it. If
> nothing breaks, then it should be good to pull from.

Great, thanks Thomas. It looks like the bot's happy with that, so I've
pulled it locally and I'll push it out as part of the arm64 for-next/core
branch tomorrow, after some basic tests.

Will
