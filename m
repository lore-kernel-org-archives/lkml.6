Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61782083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61782083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeHaQbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:31:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37330 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeHaQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:31:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so11028148wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 05:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NRy67uFMHQ07jmRD9fVBsxkOTnm1OvWO/sEiopWRIOE=;
        b=LP5EI18VgiC/u80KP45CjI+OZJIeIm17C+xBv5FjNjIrmXA7JqLOj5Rb5Xf+yWLV0Q
         Ork/M29lJEY6pBiRSLq03g3QV3sMy4M+h2x9kkJqCXsjlweCt62vk2LkHlSYZwie5dxK
         RGhiBbr6juGBlimsqyUEInWgtIX3SViG5996yZ7Y5cokIoWgnmnNOf+7a+EntTNQ5D63
         il9WfP9kkvQbAgvCMhSTQl5DbsqC9QR8dxLRJGTzZNnXzN2UAJ3lWXQ7OP+5TPzKGFId
         Sh9WGdP9qEcNPSi9UF/20yjvQbquCWz56oS1g7SeBwPC5r9G0vhWVZXMdrSsgwFeoduS
         g6YQ==
X-Gm-Message-State: APzg51AtfGovAOFyaC6Hxwd+geg5D2VyOCvo3nfz7bP7YI0SRXzRqrQ/
        08i96FIoFwTQ/am4qDjh0HY=
X-Google-Smtp-Source: ANB0VdZFW0/7HwLhj3tzAHwWr6QDAHAMkDzKOiVLA7ykYJmsFnEVPR6czcYRGZJZXZ4Vw25kagYRlw==
X-Received: by 2002:adf:d245:: with SMTP id o5-v6mr10523813wri.91.1535718242859;
        Fri, 31 Aug 2018 05:24:02 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v21-v6sm9682818wrd.4.2018.08.31.05.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 05:24:02 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 4854A124D2A; Fri, 31 Aug 2018 14:24:01 +0200 (CEST)
Date:   Fri, 31 Aug 2018 14:24:01 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/page_alloc: Clean up check_for_memory
Message-ID: <20180831122401.GA2123@techadventures.net>
References: <20180828210158.4617-1-osalvador@techadventures.net>
 <332d9ea1-cdd0-6bb6-8e83-28af25096637@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332d9ea1-cdd0-6bb6-8e83-28af25096637@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:55:29AM +0000, Pasha Tatashin wrote:
> I would re-write the above function like this:
> static void check_for_memory(pg_data_t *pgdat, int nid)
> {
>         enum zone_type zone_type;
> 
>         for (zone_type = 0; zone_type < ZONE_MOVABLE; zone_type++) {
>                 if (populated_zone(&pgdat->node_zones[zone_type])) { 
>                         node_set_state(nid, zone_type <= ZONE_NORMAL ?
>                                        N_NORMAL_MEMORY: N_HIGH_MEMORY);
>                         break;
>                 }
>         }
> }

Hi Pavel,

the above would not work fine.
You set either N_NORMAL_MEMORY or N_HIGH_MEMORY, but a node can have both
types of memory at the same time (on CONFIG_HIGHMEM systems).

N_HIGH_MEMORY stands for regular or high memory
while N_NORMAL_MEMORY stands only for regular memory,
that is why we set it only in case the zone is <= ZONE_NORMAL.

> zone_type <= ZONE_MOVABLE - 1
> is the same as:
> zone_type < ZONE_MOVABLE

This makes sense.

-- 
Oscar Salvador
SUSE L3
