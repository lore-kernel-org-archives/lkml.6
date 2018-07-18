Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350D6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED18520850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED18520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbeGRPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:54:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38842 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731251AbeGRPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:54:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so5073846wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qlYBls4QPCyb6ui+qsuEPi2v7Wk3AlrjAATQOhJwVz4=;
        b=Yfssq3BAONQkLoST+hNhGTwq2lmY14eFHB7OvV3FZVa6fOPY6G0sce3UUX2hY50fxE
         gSd9t+a0T9rl77cQewV6bciIiF3Afbt7WQOBeOvtrSGIjHZujjvQIi06KiOIaCDzbcq+
         YEAvsUKzX+p+HntgAeaXy1uTqfXcCUBinz2NTonDpPLyVeNYSgr1RAZIGGPt7yMqz7TE
         xbvLWyqHo0K3TdvMzaNh+6KUebkVnAxEvp5bgMtB2+qykw4c/xOORrlItfr6PZsgzYOD
         0qhyJnMU9kvd+3vzKxhRbTfgD7nBTUGmhp9uoPiTkpGQv5e8NPqIdzxRFtjY79OhwQw7
         ILmg==
X-Gm-Message-State: AOUpUlE7fytF2xNTlNKh9p1W1IC1r2TATkY0jovyjnegoi8EP2b41by7
        zosxhsNz6VsK1JJqMiq+JiM=
X-Google-Smtp-Source: AAOMgpfAt7ONuxWQAoRxDA2YZ9USdtW79+6hkMO4gdEeDyodei1rpDQxQjcNLAxFD0q1+Z2/poTiGA==
X-Received: by 2002:adf:ff49:: with SMTP id u9-v6mr5156517wrs.15.1531926952136;
        Wed, 18 Jul 2018 08:15:52 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id r1-v6sm4611499wrs.39.2018.07.18.08.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:51 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id EE66B1240EE; Wed, 18 Jul 2018 17:15:50 +0200 (CEST)
Date:   Wed, 18 Jul 2018 17:15:50 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/3] mm/page_alloc: Move ifdefery out of
 free_area_init_core
Message-ID: <20180718151550.GA2985@techadventures.net>
References: <20180718124722.9872-1-osalvador@techadventures.net>
 <20180718124722.9872-2-osalvador@techadventures.net>
 <20180718141150.imiyuust5txfmfvw@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718141150.imiyuust5txfmfvw@xakep.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:11:50AM -0400, Pavel Tatashin wrote:
> On 18-07-18 14:47:20, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > Moving the #ifdefs out of the function makes it easier to follow.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Hi Oscar,
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> 
> Please include the following patch in your series, to get rid of the last
> ifdef in this function.
> 
> From f841184e141b21e79c4d017d3b7678c697016d2a Mon Sep 17 00:00:00 2001
> From: Pavel Tatashin <pasha.tatashin@oracle.com>
> Date: Wed, 18 Jul 2018 09:56:52 -0400
> Subject: [PATCH] mm: access zone->node via zone_to_nid() and zone_set_nid()
> 
> zone->node is configured only when CONFIG_NUMA=y, so it is a good idea to
> have inline functions to access this field in order to avoid ifdef's in
> c files.

Hi Pavel

I will! Thanks for the patch ;-)
-- 
Oscar Salvador
SUSE L3
