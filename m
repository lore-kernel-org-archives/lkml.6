Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0753520647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0753520647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeH3AtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:49:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43715 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbeH3AtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:49:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so6041613wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j14McSVxijwlskdbKvE1PJqMF7ULEtXPJDjDBaysAGQ=;
        b=FZpiMS7imt6AA2ByD6NiWZ9ak2QFv6EHzpPXRY0/ES699bpnvrGKxPl2paJIRS1BKQ
         MGubI1GVH61dBS62NM6jkY9J9ApZP6/L4a68fsvzzf7zpLR1HLx1TxHqwVxbmWs3nBRV
         Y3FuGI8+IugqdBTPdT5BPAT/QuErKVTiVEscUJcCjY40JdvNdHiho3zsIFkahjFnLLU1
         vWH5CF2rouaIbvJSRWrALFmOqEFXU42KbsYGRiVZ8oD51GLozIwdmQAMCNf8MkdHnHx1
         FVGOpLzrUA4pybFzTr52W7SS0rUhhryebGRv7kaT3Sft3mSiraMfslQKaQMZ4KK7gT9S
         ADUQ==
X-Gm-Message-State: APzg51DctcWawmN2tT+0at5spxmNzWgOyvsys7/dPbfjKvOAmIx5Mqvs
        z0wf8fQi6kfsTfz3LOYq4Xo=
X-Google-Smtp-Source: ANB0VdaUXY5XWRiR/bRBniTDbiuD+t3/vy7dO5oxgVKFPaku9VjBVX0nPB7cJuvW+FLKd0nM9hh0kw==
X-Received: by 2002:a5d:4cc8:: with SMTP id c8-v6mr5553952wrt.210.1535575829620;
        Wed, 29 Aug 2018 13:50:29 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id g129-v6sm8313893wmf.42.2018.08.29.13.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:50:28 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 344AD124C54; Wed, 29 Aug 2018 22:50:28 +0200 (CEST)
Date:   Wed, 29 Aug 2018 22:50:28 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v4 0/4] Refactoring for
 remove_memory_section/unregister_mem_sect_under_nodes
Message-ID: <20180829205028.GA25072@techadventures.net>
References: <20180817090017.17610-1-osalvador@techadventures.net>
 <20180821162122.GA10300@techadventures.net>
 <20180821134318.f743b6c58f2b5a91e17e596e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821134318.f743b6c58f2b5a91e17e596e@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 01:43:18PM -0700, Andrew Morton wrote:
> On Tue, 21 Aug 2018 18:21:22 +0200 Oscar Salvador <osalvador@techadventures.net> wrote:
> 
> > On Fri, Aug 17, 2018 at 11:00:13AM +0200, Oscar Salvador wrote:
> > > From: Oscar Salvador <osalvador@suse.de>
> > > 
> > > v3 -> v4:
> > >         - Make nodemask_t a stack variable
> > >         - Added Reviewed-by from David and Pavel
> > > 
> > > v2 -> v3:
> > >         - NODEMASK_FREE can deal with NULL pointers, so do not
> > >           make it conditional (by David).
> > >         - Split up node_online's check patch (David's suggestion)
> > >         - Added Reviewed-by from Andrew and David
> > >         - Fix checkpath.pl warnings
> > 
> > Andrew, will you pick up this patchset?
> > I saw that v3 was removed from the -mm tree because it was about
> > to be updated with a new version (this one), but I am not sure if
> > anything wrong happened.
> 
> Yes, things are still changing and we're late in the merge window.  I
> decided to park it and shall take it up again after 4.19-rc1.

Hi Andrew,

I just got the Reviewed-by from Pavel for patch3.
So you may consider it for -mm when you got some time.

Thanks
-- 
Oscar Salvador
SUSE L3
