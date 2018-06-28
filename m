Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1986C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EC125721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EC125721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965417AbeF1LYN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:24:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36015 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeF1LYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:24:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id u18-v6so8660133wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 04:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKr5OAlCNAgYLwF64gnkCFKXbEsRAMa6Yjmwx+2UmcY=;
        b=jlvCdKuXSBOjQFNTT7I3fSffqgSoObPoQltn8L1ZEsocyiuODh27/uXkJadgBOtyYf
         Nj10pvVi3XEzNl6Ke0x4nFfDSZmQYdF2IG4yMPVWHfEohMBl+kkCyCSAQ6Abqfh/yA1b
         gQwuWH2W62xKj5J26PZff/LI4HtZAwW7fy50pQ9AJ4vl/RcAgGbYtvAjk1vgrzuC66zK
         /TzJwA+ANQcdqPeZ8GJNev0700h5oYpSxm9L5xQ7TL26reqnaVWUctWy61SJsUKrfX9n
         1U8mcMQq0L85VKbRUp1umqww2+lgxg/hm4v6hfEU18dff+oNHFtP6ifb7wwiwwJ22v/z
         Dt7w==
X-Gm-Message-State: APt69E0Tu1t4YTt4swF4oR0oGDp5wz0EZ1FpTSaOZAzIj+RyY3uy2cr0
        +2Y4gYxDP4Iul4dirljV0M0=
X-Google-Smtp-Source: AAOMgpeXASgy5/FogpaCbqRChabM8JyYH6ObgtwqT54r2i/ElBSISSWh+uq1I7tsGLgRai63r1EM3Q==
X-Received: by 2002:a1c:7a19:: with SMTP id v25-v6mr1235088wmc.81.1530185051224;
        Thu, 28 Jun 2018 04:24:11 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id m3-v6sm6560904wro.27.2018.06.28.04.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 04:24:10 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id B725212390E; Thu, 28 Jun 2018 13:24:09 +0200 (CEST)
Date:   Thu, 28 Jun 2018 13:24:09 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v6 1/5] mm/sparse: Add a static variable
 nr_present_sections
Message-ID: <20180628112409.GB12956@techadventures.net>
References: <20180628062857.29658-1-bhe@redhat.com>
 <20180628062857.29658-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628062857.29658-2-bhe@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 02:28:53PM +0800, Baoquan He wrote:
> It's used to record how many memory sections are marked as present
> during system boot up, and will be used in the later patch.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/sparse.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f13f2723950a..6314303130b0 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -200,6 +200,12 @@ static inline int next_present_section_nr(int section_nr)
>  	      (section_nr <= __highest_present_section_nr));	\
>  	     section_nr = next_present_section_nr(section_nr))
>  
> +/*
> + * Record how many memory sections are marked as present
> + * during system bootup.
> + */
> +static int __initdata nr_present_sections;
> +
>  /* Record a memory area against a node. */
>  void __init memory_present(int nid, unsigned long start, unsigned long end)
>  {
> @@ -229,6 +235,7 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
>  			ms->section_mem_map = sparse_encode_early_nid(nid) |
>  							SECTION_IS_ONLINE;
>  			section_mark_present(ms);
> +			nr_present_sections++;
>  		}
>  	}
>  }
> -- 
> 2.13.6
> 

-- 
Oscar Salvador
SUSE L3
