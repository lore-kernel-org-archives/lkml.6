Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E77C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31FF20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31FF20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438041AbeKWDUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:20:45 -0500
Received: from verein.lst.de ([213.95.11.211]:59530 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391469AbeKWDUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:20:45 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 78CEC68C35; Thu, 22 Nov 2018 17:40:36 +0100 (CET)
Date:   Thu, 22 Nov 2018 17:40:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 1/7] mm, devm_memremap_pages: Mark
 devm_memremap_pages() EXPORT_SYMBOL_GPL
Message-ID: <20181122164036.GA23899@lst.de>
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com> <154275557457.76910.16923571232582744134.stgit@dwillia2-desk3.amr.corp.intel.com> <20181122133013.GG18011@dhcp22.suse.cz> <20181122163858.GA23809@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122163858.GA23809@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 05:38:58PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 22, 2018 at 02:30:13PM +0100, Michal Hocko wrote:
> > Whoever needs a wrapper around arch_add_memory can do so because this
> > symbol has no restriction for the usage.
> 
> arch_add_memory is not exported, and it really should not be.

And in some older trees it oddly has an EXPORY_SYMBOL_GPL on x86
and sh, but no actual modular users..
