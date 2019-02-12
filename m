Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B602CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BD0217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfBLOui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:50:38 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:60288 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727562AbfBLOuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:50:37 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 91D474244; Tue, 12 Feb 2019 15:50:36 +0100 (CET)
Date:   Tue, 12 Feb 2019 15:50:36 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Pavel.Tatashin@microsoft.com" <Pavel.Tatashin@microsoft.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v2 0/4] mm, memory_hotplug: allocate memmap from
 hotadded memory
Message-ID: <20190212145021.2bf2gmgprcvzkuq4@d104.suse.de>
References: <20190122103708.11043-1-osalvador@suse.de>
 <20190212124707.000028ea@huawei.com>
 <5FC3163CFD30C246ABAA99954A238FA8392B5DB6@lhreml524-mbs.china.huawei.com>
 <20190212135658.fd3rdil634ztpekj@d104.suse.de>
 <20190212144242.GZ15609@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212144242.GZ15609@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:42:42PM +0100, Michal Hocko wrote:
> Please make sure to test on a larger machine which has multi section
> memblocks. This is where I was hitting on bugs hard.

I tested the patchset with large memblocks (2GB) on x86_64, and worked
fine as well.
On powerpc I was only able to test it on normal memblocks, but I will check
if I can boost the memory there to get large memblocks.

And about arm64, I will talk to Jonathan off-list to see if we can do the same.

Btw, in the meantime, we could get some parts reviewed perhaps.
-- 
Oscar Salvador
SUSE L3
