Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C6BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D863208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D863208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbeHAOOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:14:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40598 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbeHAOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:14:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so19912105wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dg+g2nmubd43UqgHuAdlF22xp3hUUw9S6cXCbqKSDG8=;
        b=GuL3uG18sfu/T3x4e9ibQliohUTSLPY+DqdwoxepNNsoUOYKhJiJmyL095GUo0psnB
         3ZMmoZ99E5khifXZLPdgDv3gCNb6ja6pUXAwFQoRAvArAE7qrzMzo0LO9J5ia77eY2By
         05XG9Ga7MywS5fy2MswKCIIUphdBhoY1XbFR4UoqtoHvEhqNFYV7K+9NkyiJ4xmUeBYh
         Jc8MlC63fTaPYzAHC4ZYmtWu0OFFaWEZqNPnqedg/XN6cIp4Ids1BoB5jZUaEJ5g6cdI
         WsNp8Tri8RRjRf97SOGt/Q4VZhmqLOpZLQXvRxjAYUsapVSlz3esq/sK0OfhoJuS9flZ
         Cd0A==
X-Gm-Message-State: AOUpUlFzBjFDfTgxr0DuwUKfLVjqaOCQGzhou2XgI72zVxop2C+LcQV2
        KitRChgdywAcObsQfUwiOFY=
X-Google-Smtp-Source: AAOMgpf9CzEdX7ailpMspskkG10wGT51h0FaBkCU27grZJuuxw0aMmZXPzMaUiX2O7QwiQiuDrni4A==
X-Received: by 2002:adf:c08c:: with SMTP id d12-v6mr23101412wrf.268.1533126554064;
        Wed, 01 Aug 2018 05:29:14 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id u6-v6sm217521wmc.45.2018.08.01.05.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 05:29:13 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id B2E4D124546; Wed,  1 Aug 2018 14:29:12 +0200 (CEST)
Date:   Wed, 1 Aug 2018 14:29:12 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v5 4/4] mm/page_alloc: Introduce
 free_area_init_core_hotplug
Message-ID: <20180801122912.GC473@techadventures.net>
References: <20180730101757.28058-1-osalvador@techadventures.net>
 <20180730101757.28058-5-osalvador@techadventures.net>
 <20180731101752.GA473@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731101752.GA473@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:17:52PM +0200, Oscar Salvador wrote:
> On Mon, Jul 30, 2018 at 12:17:57PM +0200, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> ...
> > Also, since free_area_init_core/free_area_init_node will now only get called during early init, let us replace
> > __paginginit with __init, so their code gets freed up.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> 
> Andrew, could you please fold the following cleanup into this patch?
> thanks

Hi Andrew,

I sent v6, which already includes that cleanup-fixup plus another patch from Pavel and
an Acked-by from Michal Hocko.
So if it looks fine to you, feel free to replace it with the version that is sitting right now in -mm (v5)
 
Thanks
-- 
Oscar Salvador
SUSE L3
