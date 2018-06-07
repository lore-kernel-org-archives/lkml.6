Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OkIKHPAzGVsgTwAAmS7hNA
	; Thu, 07 Jun 2018 13:32:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 626C2608BA; Thu,  7 Jun 2018 13:32:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CDCF5601D2;
	Thu,  7 Jun 2018 13:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDCF5601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932683AbeFGNc3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:32:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44478 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeFGNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:32:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id x4-v6so1728783wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nEV2lR5IRazNk+a4GYuU3Xuv6Q9gB/FA2FIKXeCARIc=;
        b=kn5TRXPNHjUsGjhFg01RKUcy/2wwC6xzZgvaT+BykObTchLad0urJZUyDcZomba7QO
         6jAB5sxBmAjNJE4XhKCei46XfwSnXPqAcMu8njnzg2no9LdnDemIT2Q7ehpaq4ZGsQVn
         ZzzlUkOO7Onqh2vnyWDOwdiIxoOZx1//ib1Cw6iyWyZVATJa07Gu/QKdiCV01WZ0vgyy
         XMpFAKPfPpWPcvFmeKtCDibXXhwgtosrKm3k2Xm7GtyVx1trqYb1p5fs13pEfpcpzKE1
         J86BNuGr9GkHpuV0AAu54Dfdriyw88arb82sFHCJl8XzDIGjB9WqGeZVmSLaQPW2+VGt
         fk7Q==
X-Gm-Message-State: APt69E2nXA4Zk0PR0CZb83d0vG7tER70OaXcubPCHENKJQ0Ci6Kd2u6j
        +qj6qJRtHXERp2eBJoxcC4A=
X-Google-Smtp-Source: ADUXVKLvayXKmNtvbEA0vnhoLlFADrY51mURVdOhH6xFQRCqKEY4Rvf8yjfOlnpg+WvI310M+JTNCw==
X-Received: by 2002:adf:fa07:: with SMTP id m7-v6mr1888018wrr.228.1528378347685;
        Thu, 07 Jun 2018 06:32:27 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j4-v6sm1958474wrr.47.2018.06.07.06.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 06:32:26 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id B769C123270; Thu,  7 Jun 2018 15:32:25 +0200 (CEST)
Date: Thu, 7 Jun 2018 15:32:25 +0200
From: Oscar Salvador <osalvador@techadventures.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 0/4] Small cleanup for memoryhotplug
Message-ID: <20180607133225.GA11024@techadventures.net>
References: <20180601125321.30652-1-osalvador@techadventures.net>
 <20180607114245.00001068@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607114245.00001068@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 11:42:45AM +0100, Jonathan Cameron wrote:
> On Fri, 1 Jun 2018 14:53:17 +0200
> <osalvador@techadventures.net> wrote:
> 
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > 
> > Hi,
> > 
> > I wanted to give it a try and do a small cleanup in the memhotplug's code.
> > A lot more could be done, but I wanted to start somewhere.
> > I tried to unify/remove duplicated code.
> > 
> > The following is what this patchset does:
> > 
> > 1) add_memory_resource() has code to allocate a node in case it was offline.
> >    Since try_online_node has some code for that as well, I just made add_memory_resource() to
> >    use that so we can remove duplicated code..
> >    This is better explained in patch 1/4.
> > 
> > 2) register_mem_sect_under_node() will be called only from link_mem_sections()
> > 
> > 3) Get rid of link_mem_sections() in favour of walk_memory_range() with a callback to
> >    register_mem_sect_under_node()
> > 
> > 4) Drop unnecessary checks from register_mem_sect_under_node()
> > 
> > 
> > I have done some tests and I could not see anything broken because of 
> > this patchset.
> Works fine with the patch set for arm64 I'm intermittently working on.
> Or at least I don't need to make any additional changes on top of what I currently
> have!
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for having tested it Jonathan ;-)!

> 
> Thanks,
> 
> Jonathan
> > 
> > Oscar Salvador (4):
> >   mm/memory_hotplug: Make add_memory_resource use __try_online_node
> >   mm/memory_hotplug: Call register_mem_sect_under_node
> >   mm/memory_hotplug: Get rid of link_mem_sections
> >   mm/memory_hotplug: Drop unnecessary checks from
> >     register_mem_sect_under_node
> > 
> >  drivers/base/memory.c |   2 -
> >  drivers/base/node.c   |  52 +++++---------------------
> >  include/linux/node.h  |  21 +++++------
> >  mm/memory_hotplug.c   | 101 ++++++++++++++++++++++++++------------------------
> >  4 files changed, 71 insertions(+), 105 deletions(-)
> > 
> 
> 
