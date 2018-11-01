Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222FDC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9942081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9942081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeKAT34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:29:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeKAT34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:29:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6348AD94;
        Thu,  1 Nov 2018 10:27:34 +0000 (UTC)
Date:   Thu, 1 Nov 2018 11:27:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
Message-ID: <20181101102734.GF23921@dhcp22.suse.cz>
References: <20181029081706.GC32673@dhcp22.suse.cz>
 <1540862950.12374.40.camel@mtkswgap22>
 <20181030060601.GR32673@dhcp22.suse.cz>
 <1540882551.23278.12.camel@mtkswgap22>
 <20181030081537.GV32673@dhcp22.suse.cz>
 <1540975637.10275.10.camel@mtkswgap22>
 <20181031101501.GL32673@dhcp22.suse.cz>
 <1540981182.16084.1.camel@mtkswgap22>
 <20181031114107.GM32673@dhcp22.suse.cz>
 <1541066412.31492.10.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541066412.31492.10.camel@mtkswgap22>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-11-18 18:00:12, Miles Chen wrote:
[...]
> I did a test today, the only code changed is to clamp to read count to
> PAGE_SIZE and it worked well. Maybe we can solve this issue by just
> clamping the read count.
> 
> count = count > PAGE_SIZE ? PAGE_SIZE : count;

This i what Matthew was proposing AFAIR. At least as a stop gap
solution. Maybe we want to extend this to a more standard implementation
later on (e.g. seq_file).
-- 
Michal Hocko
SUSE Labs
