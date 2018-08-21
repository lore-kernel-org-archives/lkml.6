Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E896C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EE0214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EE0214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeHUPuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:50:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40052 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeHUPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:50:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so5230064wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 05:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RT1SNjDjJjENmAIpbmSZQgEfAJp/COrESxQvq7RVcWk=;
        b=V+ld3rCTcqrcKP/68xcwJy7FTI+AGxvdoC8npqso8RMn10aBrKKmRT3BNOGfCYnjsl
         JHeV4ODS0TODVurV95MtPgPRg5x7AoA3ja/7s/Eee98PfrWhgzipoAaWfj+CmKviB+9a
         oXx4Cu5qcUuXRK7f7Gsepcer0lgMb9TaQv6VGT7Xa1vrdZrhzNap/yjOVo38ccCVMIbA
         dlWXaem4+bdn/1ee1s4Lsm9A0MLWnsqR3BkFuizAfMxREbq+S1TvgzP8S8SXhLh0C4no
         iogFuis9gH67/maubm0Yk4w/TEMsr1An3drWly9NdEbsD45qhzQlPmgVl7Lf3hb1jNuA
         fW1g==
X-Gm-Message-State: AOUpUlFxU1OD/RTAJJ9QUMPmQuQHhMfBDYCLRteSAcUk4jflFkizgV00
        O0Zo10NdQWK68Yq1R6Qy0Yb2vAoc
X-Google-Smtp-Source: AA+uWPyA87MPa9EnJXbwiWvh03b7KHBjGItqdOR7/20Q11Ajry5YxwBYc3dhV85vRRlN9I8r8MUzgw==
X-Received: by 2002:adf:dd07:: with SMTP id a7-v6mr30730648wrm.2.1534854625400;
        Tue, 21 Aug 2018 05:30:25 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id w3-v6sm8270782wrn.16.2018.08.21.05.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 05:30:24 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 20FB41249C0; Tue, 21 Aug 2018 14:30:24 +0200 (CEST)
Date:   Tue, 21 Aug 2018 14:30:24 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Fix comment for NODEMASK_ALLOC
Message-ID: <20180821123024.GA9489@techadventures.net>
References: <20180820085516.9687-1-osalvador@techadventures.net>
 <20180820142440.1f9ccbebefc5d617c881b41e@linux-foundation.org>
 <20180821121734.GA29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821121734.GA29735@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 02:17:34PM +0200, Michal Hocko wrote:
> We do have CONFIG_NODES_SHIFT=10 in our SLES kernels for quite some
> time (around SLE11-SP3 AFAICS).
> 
> Anyway, isn't NODES_ALLOC over engineered a bit? Does actually even do
> larger than 1024 NUMA nodes? This would be 128B and from a quick glance
> it seems that none of those functions are called in deep stacks. I
> haven't gone through all of them but a patch which checks them all and
> removes NODES_ALLOC would be quite nice IMHO.

No, maximum we can get is 1024 NUMA nodes.
I checked this when writing another patch [1], and since having gone
through all archs Kconfigs, CONFIG_NODES_SHIFT=10 is the limit.

NODEMASK_ALLOC gets only called from:

- unregister_mem_sect_under_nodes() (not anymore after [1])
- __nr_hugepages_store_common (This does not seem to have a deep stack, we could use a normal nodemask_t)

But is also used for NODEMASK_SCRATCH (mainly used for mempolicy):

struct nodemask_scratch {
	nodemask_t	mask1;
	nodemask_t	mask2;
};

that would make 256 bytes in case CONFIG_NODES_SHIFT=10.
I am not familiar with mempolicy code, I am not sure if we can do without that and
figure out another way to achieve the same.

[1] https://patchwork.kernel.org/patch/10566673/#22179663 

-- 
Oscar Salvador
SUSE L3
