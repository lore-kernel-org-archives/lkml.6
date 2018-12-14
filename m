Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B33FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA1620879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544775878;
	bh=ZpjfIzUAWbfaOYNft92sUPKdjhXDWm+8alaNlD3TrUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uaIQmUH7LLj3uhdJge5J3nshpq2R9L26fDu326pyvIM3MQeVgsC5mMtYMK62BeG7M
	 KK2CsS+yR0JtpN+WelCvzC/tH0Dgddy8Lv1X+/UjwyJhH3MIjbmOkgfQ2PnSPsUtee
	 Ds8dcK64QCJFt1gQ14x6Sq/IkJ8oratBrmAHUGEk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA1620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeLNIYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:24:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:37474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbeLNIYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:24:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3000BAE72;
        Fri, 14 Dec 2018 08:24:35 +0000 (UTC)
Date:   Fri, 14 Dec 2018 09:24:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm: remove unused page state adjustment macro
Message-ID: <20181214082433.GJ1286@dhcp22.suse.cz>
References: <20181214063211.2290-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214063211.2290-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-12-18 14:32:11, Wei Yang wrote:
> These four macro are not used anymore.
> 
> Just remove them.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/vmstat.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index f25cef84b41d..2db8d60981fe 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -239,11 +239,6 @@ extern unsigned long node_page_state(struct pglist_data *pgdat,
>  #define node_page_state(node, item) global_node_page_state(item)
>  #endif /* CONFIG_NUMA */
>  
> -#define add_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, __d)
> -#define sub_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, -(__d))
> -#define add_node_page_state(__p, __i, __d) mod_node_page_state(__p, __i, __d)
> -#define sub_node_page_state(__p, __i, __d) mod_node_page_state(__p, __i, -(__d))
> -
>  #ifdef CONFIG_SMP
>  void __mod_zone_page_state(struct zone *, enum zone_stat_item item, long);
>  void __inc_zone_page_state(struct page *, enum zone_stat_item);
> -- 
> 2.15.1
> 

-- 
Michal Hocko
SUSE Labs
