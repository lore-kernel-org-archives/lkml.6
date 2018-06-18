Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AA7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FCD20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FCD20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbeFRHOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:14:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40380 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754876AbeFRHN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:13:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so13392395wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/bAn4Lj/Hwn5YgMtm/6HDOcCCJtc9Lc2F+nR0OvbJQk=;
        b=fnwmTFhFwUGvuTzAXyjIq/2/DQ2RVWqAl447VnnBffCnelT/L8Wr3GsYI7XPtwpjCP
         Uek5m3BefBhRkZV2UsaX2ZeDJ8PjA5OGb+BmTP/Nn27AvTWL8IRowE//ZbCMg03uI3wG
         xBlmm16koqFxL00559kf+eKpyUvOL8RCcCVx1FBGxFF5zGKEd09KjYJZjHMQw2DEwb6Q
         io15V/QXU2Ymh8lwRUB+T0btSrh8jODqOkikD5a5+YqGj0YNq+w7T04z5T1DU/Ok2A1I
         umbigDBH1verEw0s116BCzTWcpTF/khWRkZ2o5cpo5cwTEmSXCNEg4DoCA+bS7lIFMY5
         ztkw==
X-Gm-Message-State: APt69E3xKOMsvXIY9LjpxbUQFR3IOxfTDow4okPH1mySXPJ+l9tkcCAd
        W6Pesx4ldRtZE2YoNffLLx8=
X-Google-Smtp-Source: ADUXVKK1JIRYEJioSmqC7KxToIADwJuInkiJB83AbM4BnUURE1WJ3VlQBOW46tPQhNi5oU7F9rlJhw==
X-Received: by 2002:a1c:d2cb:: with SMTP id j194-v6mr7123318wmg.129.1529306037383;
        Mon, 18 Jun 2018 00:13:57 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e2-v6sm17125909wro.97.2018.06.18.00.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 00:13:56 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 0BF811235A4; Mon, 18 Jun 2018 09:13:56 +0200 (CEST)
Date:   Mon, 18 Jun 2018 09:13:56 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 0/4] Small cleanup for memoryhotplug
Message-ID: <20180618071355.GA18238@techadventures.net>
References: <20180601125321.30652-1-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601125321.30652-1-osalvador@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:53:17PM +0200, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> 
> Hi,
> 
> I wanted to give it a try and do a small cleanup in the memhotplug's code.
> A lot more could be done, but I wanted to start somewhere.
> I tried to unify/remove duplicated code.
> 
> The following is what this patchset does:
> 
> 1) add_memory_resource() has code to allocate a node in case it was offline.
>    Since try_online_node has some code for that as well, I just made add_memory_resource() to
>    use that so we can remove duplicated code..
>    This is better explained in patch 1/4.
> 
> 2) register_mem_sect_under_node() will be called only from link_mem_sections()
> 
> 3) Get rid of link_mem_sections() in favour of walk_memory_range() with a callback to
>    register_mem_sect_under_node()
> 
> 4) Drop unnecessary checks from register_mem_sect_under_node()
> 
> 
> I have done some tests and I could not see anything broken because of 
> this patchset.
> 
> Oscar Salvador (4):
>   mm/memory_hotplug: Make add_memory_resource use __try_online_node
>   mm/memory_hotplug: Call register_mem_sect_under_node
>   mm/memory_hotplug: Get rid of link_mem_sections
>   mm/memory_hotplug: Drop unnecessary checks from
>     register_mem_sect_under_node
> 
>  drivers/base/memory.c |   2 -
>  drivers/base/node.c   |  52 +++++---------------------
>  include/linux/node.h  |  21 +++++------
>  mm/memory_hotplug.c   | 101 ++++++++++++++++++++++++++------------------------
>  4 files changed, 71 insertions(+), 105 deletions(-)
> 
> -- 
> 2.13.6
> 

Hi,

maybe this can get reviewed now that the merge window is closed.

Thanks

Best Regards
Oscar Salvador


