Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D3C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AAF20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfA2IoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:44:03 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:61573 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727176AbfA2IoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:44:00 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 4977F40AF; Tue, 29 Jan 2019 09:43:59 +0100 (CET)
Date:   Tue, 29 Jan 2019 09:43:59 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, mhocko@suse.com, dan.j.williams@intel.com,
        Pavel.Tatashin@microsoft.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com
Subject: Re: [RFC PATCH v2 0/4] mm, memory_hotplug: allocate memmap from
 hotadded memory
Message-ID: <20190129084359.65fzc4hqan265gii@d104.suse.de>
References: <20190122103708.11043-1-osalvador@suse.de>
 <d9dbefb8-052e-7cb5-3de4-245d05270ff9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9dbefb8-052e-7cb5-3de4-245d05270ff9@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 09:53:35AM +0100, David Hildenbrand wrote:
Hi David,

> I only had a quick glimpse. I would prefer if the caller of add_memory()
> can specify whether it would be ok to allocate vmmap from the range.
> This e.g. allows ACPI dimm code to allocate from the range, however
> other machanisms (XEN, hyper-v, virtio-mem) can allow it once they
> actually support it.

Well, I think this can be done, and it might make more sense, as we
would get rid of some other flags to prevent allocating vmemmap
besides mhp_restrictions.

> 
> Also, while s390x standby memory cannot support allocating from the
> range, virtio-mem could easily support it on s390x.
> 
> Not sure how such an interface could look like, but I would really like
> to have control over that on the add_memory() interface, not per arch.

Let me try it out and will report back.

Btw, since you are a virt-guy, would it be do feasible for you to test the patchset
on hyper-v, xen or your virtio-mem driver?

Thanks David!

-- 
Oscar Salvador
SUSE L3
