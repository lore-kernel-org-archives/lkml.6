Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F9CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7FB20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7FB20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeGZIxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:53:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37514 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbeGZIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:53:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so658546wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PjxBw7W9SMaERIJZDXqC+zJFB5dFn0cHmVtuL/Rk3sY=;
        b=EvIOca+q5uAGsfvfyybn44OfulDsPBePEe3O/89LkNkhrBllLCUqZkXXUtye01+bJd
         7xLOkSHb8p33+Z3PY51L7IXcTRGCGYn3LJHXrBLgDLFJgOb5nseQypxJWaRf4yVVRgYs
         7Im/WG10ZgBIQjWdiiGQL7qv2LZ+iNrGXQ2P+qM6DT04N0tPGG4elhoOxBIh9us/Ji4h
         h7+BsRbOp4Rr4VIKn4JvJm+iLyPlHA/Dp4yQSscyQ04/2qBrupMplbFORQMvZ5YH1MX4
         ijkYv1RwrrkKbPDNyzAFLh5ldzu/iUVssRLxSMigRjhTm+gfieKtVDxQCs8ASqNEYqVg
         elrA==
X-Gm-Message-State: AOUpUlERNNeFpW0aSr/WpJVXam2MofENZQ01DdoxQGVOcPMyyAIWLsd2
        IhezVLZuyLhf3zVMl9UvizxAIQcRZa8=
X-Google-Smtp-Source: AAOMgpeaPgv6cduJqj2KiF1mgNDZniYKjnFYFYcJdXNvsktX5vlWEn7dQaOpmuzaBTkSXSAqLupoMA==
X-Received: by 2002:adf:82f0:: with SMTP id 103-v6mr624091wrc.131.1532590688342;
        Thu, 26 Jul 2018 00:38:08 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f6-v6sm1861908wrw.78.2018.07.26.00.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:38:07 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 30FC6124380; Thu, 26 Jul 2018 09:38:07 +0200 (CEST)
Date:   Thu, 26 Jul 2018 09:38:07 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 5/5] mm/page_alloc: Introduce memhotplug version of
 free_area_init_core
Message-ID: <20180726073807.GA22028@techadventures.net>
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
>  extern void free_initmem(void);
> +extern void free_area_init_core_hotplug(int nid);

The declaration should be wrapped with an #ifdef CONFIG_MEMORY_HOTPLUG.

> +void __paginginit free_area_init_core_hotplug(int nid)
> +{
> +	enum zone_type j;
> +	pg_data_t *pgdat = NODE_DATA(nid);
> +
> +	pgdat_init_internals(pgdat);
> +	for(j = 0; j < MAX_NR_ZONES; j++) {
> +		struct zone *zone = pgdat->node_zones + j;
> +		zone_init_internals(zone, j, nid, 0);
> +	}
> +}

The same applies here

-- 
Oscar Salvador
SUSE L3
