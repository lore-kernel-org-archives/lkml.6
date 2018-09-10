Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B999C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDB42087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDB42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeIJTOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:14:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:57432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727674AbeIJTOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:14:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90083B000;
        Mon, 10 Sep 2018 14:19:47 +0000 (UTC)
Date:   Mon, 10 Sep 2018 16:19:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Message-ID: <20180910141946.GJ10951@dhcp22.suse.cz>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
 <e8d75768-9122-332b-3b16-cad032aeb27f@microsoft.com>
 <20180910135959.GI10951@dhcp22.suse.cz>
 <CAGM2reZuGAPmfO8x0TnHnqHci_Hsga3-CfM9+udJs=gUQCw-1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reZuGAPmfO8x0TnHnqHci_Hsga3-CfM9+udJs=gUQCw-1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-09-18 14:11:45, Pavel Tatashin wrote:
> Hi Michal,
> 
> It is tricky, but probably can be done. Either change
> memmap_init_zone() or its caller to also cover the ends and starts of
> unaligned sections to initialize and reserve pages.
> 
> The same thing would also need to be done in deferred_init_memmap() to
> cover the deferred init case.

Well, I am not sure TBH. I have to think about that much more. Maybe it
would be much more simple to make sure that we will never add incomplete
memblocks and simply refuse them during the discovery. At least for now.
-- 
Michal Hocko
SUSE Labs
