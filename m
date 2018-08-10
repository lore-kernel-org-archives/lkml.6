Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE760C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8084A22402
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8084A22402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeHJPar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:30:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727563AbeHJPar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:30:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 728D8AFEF;
        Fri, 10 Aug 2018 13:00:56 +0000 (UTC)
Date:   Fri, 10 Aug 2018 15:00:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, toshi.kani@hpe.com,
        tglx@linutronix.de, bp@suse.de, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        dan.j.williams@intel.com, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>, malat@debian.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] resource: Merge resources on a node when hot-adding
 memory
Message-ID: <20180810130052.GC1644@dhcp22.suse.cz>
References: <20180809025409.31552-1-rashmica.g@gmail.com>
 <20180809181224.0b7417e51215565dbda9f665@linux-foundation.org>
 <CAC6rBs=yYYZw-c02yp6rx-+TN2oUGgrp=uuLhZ=Kc_nnjmTRqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC6rBs=yYYZw-c02yp6rx-+TN2oUGgrp=uuLhZ=Kc_nnjmTRqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-08-18 16:55:40, Rashmica Gupta wrote:
[...]
> Most memory hotplug/hotremove seems to be block or section based, and
> always adds and removes memory at the same place.

Yes and that is hard wired to the memory hotplug code. It is not easy to
make it work outside of section units restriction. So whatever your
memtrace is doing and if it relies on subsection hotplug it cannot
possibly work with the current code.

I didn't get to review your patch but if it is only needed for an
unmerged code I would rather incline to not merge it unless it is a
clear win to the resource subsystem. A report from Oscar shows that this
is not the case though.

-- 
Michal Hocko
SUSE Labs
