Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E9DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E74020839
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E74020839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391421AbeHPPcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:32:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41807 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeHPPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:32:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so4014608wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 05:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8AhVT0lZxlSJXddYcz8ILsnXrHfl0DH3qmhnwDP60Ys=;
        b=oJh7bJjTUfMAv1P6tZoolUAI0rbj6Reydw+vxlrpMNIla6k1cB4U7g3R8ySQTIm+6G
         mW6BXtNL5Wu1oJbMfMAAt2sNUGTEsTaUZUgJKd/rBYzVGUeeX2H4Q3LhOfpX+Ar+g2RY
         yt/vAn0zo5iTEF98bXUpkp4vxoGVEAsMh6NsEZOStTpW8QFMICDHORv8eCJDjxNnutCO
         Mld5riJlo3BJv3OvCEtekux2m4rsIm+c9/TrSoNE0NjbAHhIhM+9A1RDFgHe+s9xeGkN
         UZbJ5bj3imP4+z2WZj2qelnsJCKA/F+yKnJGKn9uvoGxJ8CanY75T0SDYhRR4POFasQh
         mjvw==
X-Gm-Message-State: AOUpUlHkT+en2/usJFymFXumfewJ/7SK8EGkhQqcro1VuXFBDk85HtyK
        fr/Em5HDUFIoiHck6gI6214=
X-Google-Smtp-Source: AA+uWPwTMcIewbgqBVthCEeo/9n+XY9ooRDZTC/pb+CEh3S8KCPcKe7Vj6g5W63/1z+IiKYRyuwOfA==
X-Received: by 2002:a5d:694e:: with SMTP id r14-v6mr18771632wrw.278.1534422874530;
        Thu, 16 Aug 2018 05:34:34 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 9-v6sm64224235wrb.48.2018.08.16.05.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 05:34:33 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 0FA071248E7; Thu, 16 Aug 2018 14:34:33 +0200 (CEST)
Date:   Thu, 16 Aug 2018 14:34:33 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Oscar Salvador <osalvador@suse.de>,
        Petr Tesarik <ptesarik@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mathieu Malaterre <malat@debian.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 2/5] mm/memory_hotplug: enforce section alignment when
 onlining/offlining
Message-ID: <20180816123433.GB16861@techadventures.net>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816100628.26428-3-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:06:25PM +0200, David Hildenbrand wrote:
> onlining/offlining code works on whole sections, so let's enforce that.
> Existing code only allows to add memory in memory block size. And only
> whole memory blocks can be onlined/offlined. Memory blocks are always
> aligned to sections, so this should not break anything.
> 
> online_pages/offline_pages will implicitly mark whole sections
> online/offline, so the code really can only handle such granularities.
> 
> (especially offlining code cannot deal with pageblock_nr_pages but
>  theoretically only MAX_ORDER-1)
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Hi David,

If you are really willing to move the checks from this patch[1] to
online/offline_pages, you might consider to put that in as well.
So we have a function that checks for everything, and not multiple checks.

Another thing is that I would have prefered to take the checks up to
memory_block_action, but offline_pages gets also called from ppc-memtrace code.

Other than that, 

Reviewed-by: Oscar Salvador <osalvador@suse.de>


[1] https://patchwork.kernel.org/patch/10567277/

Thanks
-- 
Oscar Salvador
SUSE L3
