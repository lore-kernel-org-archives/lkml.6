Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E25C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1552075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1552075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeIGNOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:14:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:43390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeIGNOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:14:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52BBCAC1F;
        Fri,  7 Sep 2018 08:34:53 +0000 (UTC)
Date:   Fri, 7 Sep 2018 10:34:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        sudeep.holla@arm.com, ganapatrao.kulkarni@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add NUMA emulation support
Message-ID: <20180907083452.GC19621@dhcp22.suse.cz>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
 <20180829110802.GD10349@dhcp22.suse.cz>
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
 <20180905064252.GW14951@dhcp22.suse.cz>
 <c1b58f13-6190-20e9-7e4f-b8bc2b9d5f80@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b58f13-6190-20e9-7e4f-b8bc2b9d5f80@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 15:53:34, Shuah Khan wrote:
[...]
> A few critical allocations could be satisfied and root cgroup prevails. It is not the
> intent to have exclusivity at the expense of the kernel.

Well, it is not "few critical allocations". It can be a lot of
memory. Basically any GFP_KERNEL allocation. So how exactly you expect
this to work when you cannot estimate how much
memory will kernel eat?

> 
> This feature will allow a way to configure cpusets on non-NUMA for workloads that can
> benefit from the reservation and isolation that is available within the constraints of
> exclusive cpuset policies.

AFAIR this was the first approach Google took for the memory isolation
and they moved over to memory cgroups. I would recommend to talk to
those guys bebfore you introduce potentially a lot of code that will not
really work for the workload you indend it for.
-- 
Michal Hocko
SUSE Labs
