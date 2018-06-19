Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8610EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4845520652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4845520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966406AbeFSPPD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:15:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937576AbeFSPPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:15:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 41A2AAE0C;
        Tue, 19 Jun 2018 15:15:00 +0000 (UTC)
Date:   Tue, 19 Jun 2018 17:14:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        tnowicki@caviumnetworks.com, linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, wanghuiqiang@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhongjiang <zhongjiang@huawei.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
Message-ID: <20180619151425.GH13685@dhcp22.suse.cz>
References: <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
 <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
 <20180611145330.GO13364@dhcp22.suse.cz>
 <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
 <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
 <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
 <20180619120714.GE13685@dhcp22.suse.cz>
 <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
 <20180619140818.GA16927@e107981-ln.cambridge.arm.com>
 <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-06-18 15:54:26, Punit Agrawal wrote:
[...]
> In terms of $SUBJECT, I wonder if it's worth taking the original patch
> as a temporary fix (it'll also be easier to backport) while we work on
> fixing these other issues and enabling memoryless nodes.

Well, x86 already does that but copying this antipatern is not really
nice. So it is good as a quick fix but it would be definitely much
better to have a robust fix. Who knows how many other places might hit
this. You certainly do not want to add a hack like this all over...
-- 
Michal Hocko
SUSE Labs
