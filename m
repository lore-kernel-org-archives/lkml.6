Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE278C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690B120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690B120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389023AbeHANiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:38:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40767 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbeHANiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:38:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so19801466wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 04:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ySvPxFInicNmzK7nox6x4P/pPuZtGKzQ1+zqib1ovEc=;
        b=p6O+CWOC0V55Nz9QGVoRQJhzrDZTIT5W63ogUQDEojdvsmqW887rXxITefeVq1bnmJ
         D+gkfYVxjJqtQ3slekSfyIJVBj3mbzE7ydb3IOd/Nl+EzBrJt5pv92qN56aVL8PPpfAv
         R7rCi7shX+g+R4yboxcsXOnkWWjb+JCwMlFiIKw+8b4+P9FgO+3DpYah5Uxw0g/IHAWL
         /2t5K5tOkC+d2W+Glv+KWaJaet+j7uL3msLucXWphkVdkQXkoTVSnBKBCgh2BNBrpYah
         odACl0P7qPA+pMUlwNk/fXU26RYSq0EiyS7a2pbNti9PiR+mb7XcPKKoCHsSC1AN7+ig
         hCOg==
X-Gm-Message-State: AOUpUlH8BY5w56AqhXJ+9AnEXUQa1Ln3tqyROpxsh8p+s8UaxRQzWdmH
        p6KBLgmHXwSb0zUXE0hLIxA=
X-Google-Smtp-Source: AAOMgpeuaPl4f4IsssYrCD1Z6bA2dQ3pdzdxu06uHn20Y9xGz5f1WNw3hYmJ2+Dn4QUl1cmn3sI7Eg==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr24550262wre.12.1533124375773;
        Wed, 01 Aug 2018 04:52:55 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id t19-v6sm5881427wmi.42.2018.08.01.04.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 04:52:55 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 93C4212453E; Wed,  1 Aug 2018 13:52:54 +0200 (CEST)
Date:   Wed, 1 Aug 2018 13:52:54 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        pasha.tatashin@oracle.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v5 4/4] mm/page_alloc: Introduce
 free_area_init_core_hotplug
Message-ID: <20180801115254.GA7145@techadventures.net>
References: <20180730101757.28058-1-osalvador@techadventures.net>
 <20180730101757.28058-5-osalvador@techadventures.net>
 <20180801114726.GL16767@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801114726.GL16767@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 01:47:26PM +0200, Michal Hocko wrote:
> 
> The split up makes sense to me. Sections attributes can be handled on
> top. Btw. free_area_init_core_hotplug declaration could have gone into
> include/linux/memory_hotplug.h to save the ifdef

You are right, I will fix this up.

> 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks Michal!

Since Pavel and I agreed on putting a patch of his which removes __paginginit
into this patchset, I will send out a v6 in a few minutes.

-- 
Oscar Salvador
SUSE L3
