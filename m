Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC4AC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4F0205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546959180;
	bh=hv2fI+mwltR8/+uc3DtB8rK+o0WK2z6fjEEIPRKlpjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O6VKTjy2wwvMaiCwY9eMrwg62Oy/8qigvCGx+AO95gfiuoXnLj4e5a0s73VcB8eFI
	 Xsf0HseOgy6AnseuUVkKQ9qdECkr9pPVC2oaMJ79zsSmVlb27mGema+w2cBNCY6iNk
	 SkeV2PnASnM4Q8Avg9olpnyQ7NEoH41BeYdHxDb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfAHOw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:52:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:54542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728226AbfAHOw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:52:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C85CDB0B6;
        Tue,  8 Jan 2019 14:52:56 +0000 (UTC)
Date:   Tue, 8 Jan 2019 15:52:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>, Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20190108145256.GX31793@dhcp22.suse.cz>
References: <20181226131446.330864849@intel.com>
 <20181227203158.GO16738@dhcp22.suse.cz>
 <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
 <20181228084105.GQ16738@dhcp22.suse.cz>
 <20181228094208.7lgxhha34zpqu4db@wfg-t540p.sh.intel.com>
 <20181228121515.GS16738@dhcp22.suse.cz>
 <20181228133111.zromvopkfcg3m5oy@wfg-t540p.sh.intel.com>
 <20181228195224.GY16738@dhcp22.suse.cz>
 <20190102122110.00000206@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102122110.00000206@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-01-19 12:21:10, Jonathan Cameron wrote:
[...]
> So ideally I'd love this set to head in a direction that helps me tick off
> at least some of the above usecases and hopefully have some visibility on
> how to address the others moving forwards,

Is it sufficient to have such a memory marked as movable (aka only have
ZONE_MOVABLE)? That should rule out most of the kernel allocations and
it fits the "balance by migration" concept.
-- 
Michal Hocko
SUSE Labs
