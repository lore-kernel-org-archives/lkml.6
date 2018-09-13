Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FE2FC6171
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E2B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E2B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIMVgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:36:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44350 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeIMVgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:36:16 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g0URM-0001O7-NI; Thu, 13 Sep 2018 10:26:02 -0600
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, alexander.h.duyck@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153680532635.453305.11297363695024516117.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f011859e-eab3-acea-9498-246f791922ff@deltatee.com>
Date:   Thu, 13 Sep 2018 10:25:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153680532635.453305.11297363695024516117.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, alexander.h.duyck@intel.com, hch@lst.de, jglisse@redhat.com, mhocko@suse.com, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 1/7] mm, devm_memremap_pages: Mark
 devm_memremap_pages() EXPORT_SYMBOL_GPL
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/18 08:22 PM, Dan Williams wrote:
> devm_memremap_pages() is a facility that can create struct page entries
> for any arbitrary range and give drivers the ability to subvert core
> aspects of page management.
> 
> Specifically the facility is tightly integrated with the kernel's memory
> hotplug functionality. It injects an altmap argument deep into the
> architecture specific vmemmap implementation to allow allocating from
> specific reserved pages, and it has Linux specific assumptions about
> page structure reference counting relative to get_user_pages() and
> get_user_pages_fast(). It was an oversight and a mistake that this was
> not marked EXPORT_SYMBOL_GPL from the outset.
> 
> Again, devm_memremap_pagex() exposes and relies upon core kernel
> internal assumptions and will continue to evolve along with 'struct
> page', memory hotplug, and support for new memory types / topologies.
> Only an in-kernel GPL-only driver is expected to keep up with this
> ongoing evolution. This interface, and functionality derived from this
> interface, is not suitable for kernel-external drivers.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Mostly to say that I agree with you and Christoph on this debate and
that the change to GPL does not affect my P2PDMA work.

Logan
