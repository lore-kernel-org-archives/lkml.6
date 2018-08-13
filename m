Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78305C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C95B21870
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C95B21870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeHMLgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 07:36:54 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:54614 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeHMLgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 07:36:54 -0400
Received: by mail-wm0-f51.google.com with SMTP id c14-v6so8019635wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 01:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IOO1CTDN7g5wUzv+L4FRPPjvoQ5DGFz3a+/azEtswSI=;
        b=GSM594OTu9+0Aja9tWPuXyw0s1m+r2HQLsfmWZRR9gwtBkJ67P9v9Yngu80RM5ko72
         cQlnm+/y4ceuIxsBt8bysgFkAM+qv8Fi8lFs3TGnJMofogarM0kPZ3M3HJUeoPKgAXdq
         MJAHANw7cGirS/fPxWhtJvtni9Hbegrm4USbyk+9OmXTGpTSKcADQFhv5vc0SGFxaeT4
         wdVPr/6Qpyl07pWc2OlfP+r1E2n1NQe9edk4Gey6ag8M/EZ0incd9bs3KRwnQVpm7K5+
         EV57ej4aeyCTwpeKVui8rdvvhLHynGNPymNWVfFKGy/EriIzKj2C6g86rgums81IVNlA
         cAQg==
X-Gm-Message-State: AOUpUlEyzEn9yaIJrfBt2Wd++VrfOWA3KlQ/rlFDbiqf4Ai+6F4W8bIq
        tZffgWir1A91FcS8KcNEvno=
X-Google-Smtp-Source: AA+uWPyC15uLLtWgJYg16u89mS6tlzI6y6lw6o6apkTcwGSomq6QMmveDKWmDLRX6IDnnRJOCU7xTQ==
X-Received: by 2002:a1c:36aa:: with SMTP id y42-v6mr7183285wmh.159.1534150535707;
        Mon, 13 Aug 2018 01:55:35 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l16-v6sm5827678wme.36.2018.08.13.01.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 01:55:35 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 767C912484D; Mon, 13 Aug 2018 10:55:34 +0200 (CEST)
Date:   Mon, 13 Aug 2018 10:55:34 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 3/3] mm/memory_hotplug: Cleanup
 unregister_mem_sect_under_nodes
Message-ID: <20180813085534.GA1783@techadventures.net>
References: <20180810152931.23004-1-osalvador@techadventures.net>
 <20180810152931.23004-4-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810152931.23004-4-osalvador@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 05:29:31PM +0200, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> With the assumption that the relationship between
> memory_block <-> node is 1:1, we can refactor this function a bit.
> 
> This assumption is being taken from register_mem_sect_under_node()
> code.

Doh, this assumption is wrong for boot case when a mem_blk can have
multiple sections.

Nevertheless, I think that unregister_mem_sect_under_nodes can be polished a bit.
I am working on that

-- 
Oscar Salvador
SUSE L3
