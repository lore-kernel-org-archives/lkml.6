Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5093ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A18A20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A18A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeGMJXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:23:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54604 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeGMJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:23:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so8075744wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 02:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xKvZkHOlUeQIYo9gwW94vyuckDuJUjSok2n/F05uD1Q=;
        b=CaX8gdD5+X4OEyXn56oSBTKeDfwut61slaMl2MNrQHTkYlGTHrhApT16+4Iat0k3fp
         moTRZMGjsA/fjw6PrYV/AeBV+I1fJzrOgnWdYYnqWpDlvyOl5/S/9q0E1EWLQq/ruqdm
         hVuABUtepJHn8YdnGeWHvl6vtQ7YUFxcqd9X0N0gX0WebBjAcWCGb3CVfIpCiHGTJyN5
         jg2yR1CTdGgL3Ur12nN2ByXoIb5JjekxZeRJjq9s8KrLP0T8CgxsY0/wRNqwhvXSex4L
         Nk5uvgngbWLU6P8TY3/3F+M9Fj+C/a6FBh5rCbrsf3Y94MH1DdxYuudT+bZoaMjrTHR4
         NbvQ==
X-Gm-Message-State: AOUpUlHLdpD43aGUEWR8b9jJKdnn7A2prlxgoo7fR6LkIm3CUysKW2fe
        W8TxpycjDHjJCVi94n2B70o=
X-Google-Smtp-Source: AAOMgpfTrljEfiQBomYum4nLnOkRNoQNIoiX2taH5ZuyO4VG7sYHbdhbdfuuzdlN/I32+a2RNpWURw==
X-Received: by 2002:a1c:3e92:: with SMTP id l140-v6mr3302336wma.134.1531472990691;
        Fri, 13 Jul 2018 02:09:50 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id m17-v6sm38528633wrg.65.2018.07.13.02.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 02:09:50 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 37046123EB7; Fri, 13 Jul 2018 11:09:49 +0200 (CEST)
Date:   Fri, 13 Jul 2018 11:09:49 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v5 5/5] mm/sparse: delete old sprase_init and enable new
 one
Message-ID: <20180713090949.GA15039@techadventures.net>
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
 <20180712203730.8703-6-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712203730.8703-6-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  
> -#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> -static void __init sparse_early_mem_maps_alloc_node(void *data,
> -				 unsigned long pnum_begin,
> -				 unsigned long pnum_end,
> -				 unsigned long map_count, int nodeid)
> -{
> -	struct page **map_map = (struct page **)data;
> -
> -	sparse_buffer_init(section_map_size() * map_count, nodeid);
> -	sparse_mem_maps_populate_node(map_map, pnum_begin, pnum_end,
> -					 map_count, nodeid);
> -	sparse_buffer_fini();
> -}

From now on, sparse_mem_maps_populate_node() is not being used anymore, so I guess we can just
remove it from sparse.c, right? (as it is done in sparse-vmemmap.c).
-- 
Oscar Salvador
SUSE L3
