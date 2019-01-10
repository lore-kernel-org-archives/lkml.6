Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05117C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AFD214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfAJS0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:26:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730625AbfAJS0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:26:33 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8B6B6B2D781288A6371F;
        Fri, 11 Jan 2019 02:26:30 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 11 Jan 2019
 02:26:25 +0800
Date:   Thu, 10 Jan 2019 18:26:10 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>, Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <linux-accelerators@lists.ozlabs.org>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20190110182610.00004250@huawei.com>
In-Reply-To: <20190108145256.GX31793@dhcp22.suse.cz>
References: <20181226131446.330864849@intel.com>
        <20181227203158.GO16738@dhcp22.suse.cz>
        <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
        <20181228084105.GQ16738@dhcp22.suse.cz>
        <20181228094208.7lgxhha34zpqu4db@wfg-t540p.sh.intel.com>
        <20181228121515.GS16738@dhcp22.suse.cz>
        <20181228133111.zromvopkfcg3m5oy@wfg-t540p.sh.intel.com>
        <20181228195224.GY16738@dhcp22.suse.cz>
        <20190102122110.00000206@huawei.com>
        <20190108145256.GX31793@dhcp22.suse.cz>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 15:52:56 +0100
Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 02-01-19 12:21:10, Jonathan Cameron wrote:
> [...]
> > So ideally I'd love this set to head in a direction that helps me tick off
> > at least some of the above usecases and hopefully have some visibility on
> > how to address the others moving forwards,  
> 
> Is it sufficient to have such a memory marked as movable (aka only have
> ZONE_MOVABLE)? That should rule out most of the kernel allocations and
> it fits the "balance by migration" concept.

Yes, to some degree. That's exactly what we are doing, though a things currently
stand I think you have to turn it on via a kernel command line and mark it
hotpluggable in ACPI. Given it my or may not actually be hotpluggable
that's less than elegant.

Let's randomly decide not to explore that one further for a few more weeks.
la la la la

If we have general balancing by migration then things are definitely
heading in a useful direction as long as 'hot' takes into account the
main user not being a CPU.  You are right that migration dealing with
the movable kernel allocations is a nice side effect though which I
hadn't thought about.  Long run we might end up with everything where
it should be after some level of burn in period. A generic version of
this proposal is looking nicer and nicer!

Thanks,

Jonathan





