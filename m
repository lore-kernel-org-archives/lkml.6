Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A434320844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A434320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeGZNS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:18:57 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39704 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbeGZNS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:18:57 -0400
Received: by mail-wr1-f44.google.com with SMTP id h10-v6so1450516wre.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 05:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KW+cuey2Uyhx4e4RgmCN1icwoYJbhN5KxxZiIO6NWy0=;
        b=mff6xHF86NfHkKn9fsm8esMaWXSQN4A0RyWZ91YZqLDELyOJ+rIruE05mNBZTo1U6C
         u8S6UVAHI1P2cKtd3GZTPkv5VgAK81SqwVpl4XBCsuNmNQJq4BVroX8PiYp7SvudAdbN
         Wl2hFJVrbxjI8f1B4Eh3oqoDdE8V8xrxydWYQuIhQFUd41uP1xJtLPlEKO3dxauWrTV6
         QiVEOIkbFcCxMjKRpHrW5yK0pfoqJr4orI1puqbEIJP54GLrRYyINHsjerh5DqsMpmWs
         eh2dttwbIIuckmn4T6atJvmr1mmvZ0HV3ini6XyqeZtD+SyLEzIwT0jo4kIaR6nAC3+o
         WQMQ==
X-Gm-Message-State: AOUpUlFoAHANGaNr7DxKF5Usp+N3Q8AicjWq7F4ztZB3AftSzMgcQKqi
        cWm3RqexnuzgDPawfm+B83k=
X-Google-Smtp-Source: AAOMgpdnuH9SFDX66C8v0Gz7S+1elcpOSAjdsmEndL4Dg+Nsq02sleArcNkoytejNHKsi9o9TbWRlQ==
X-Received: by 2002:adf:f485:: with SMTP id l5-v6mr1397127wro.259.1532606545418;
        Thu, 26 Jul 2018 05:02:25 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id z62-v6sm1049583wmc.10.2018.07.26.05.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 05:02:24 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 237F012439A; Thu, 26 Jul 2018 14:02:24 +0200 (CEST)
Date:   Thu, 26 Jul 2018 14:02:24 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 5/5] mm/page_alloc: Introduce memhotplug version of
 free_area_init_core
Message-ID: <20180726120224.GA8302@techadventures.net>
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-6-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725220144.11531-6-osalvador@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:01:44AM +0200, osalvador@techadventures.net wrote:
> -	 */
> +         * When memory is hot-added, all the memory is in offline state. So
> +         * clear all zones' present_pages because they will be updated in
> +         * online_pages() and offline_pages().
> +         */

Sigh..., I should have run checkpatch. Tabs are missing there


> +void __paginginit free_area_init_core_hotplug(int nid)
> +{
> +	enum zone_type j;
> +	pg_data_t *pgdat = NODE_DATA(nid);
> +
> +	pgdat_init_internals(pgdat);
> +	for(j = 0; j < MAX_NR_ZONES; j++) {

And missing a space here.

Sorry, I will fix all this up in the next re-submission once I got feedback. 

Thanks
-- 
Oscar Salvador
SUSE L3
