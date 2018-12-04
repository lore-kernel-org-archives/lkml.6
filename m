Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D54C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B4D20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5PCq6XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B4D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLDDx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:53:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43558 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDDx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:53:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so6719752pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 19:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vTyC0Iyetumvi87Gb6Zwj3AYUL4Tsn5doEXtnMc5zs8=;
        b=b5PCq6XGU0JP9pYfMYj0OgBcIY4IGSzZdnUJ2LIG2VVsKb8CA+zmBTQOOYb/COzmrj
         gPK5aO+7/c23P/CQQwYXinpDUy4y6pW6UfrGYnlYTp1CDbC7uT+vM+35v0u7Owu1LgYs
         DrZCK5owszOy0i/KbQIgnZ8snAdOD1IhcbaDABEdQ0vvhetz5Q3gkgX6Exb1XwG/rkFh
         Agm8lp85N+sddX9Qtlhyswso9Lq2Bpf0qneVpxexOUI1uPb6io+npQ4RXQKG9E5dGrVZ
         Tk0xZc07hixAYB+UZI+Z1V09mFZjs7rDyyJQGNJVCFZFWBdKaNSmJGRuuHb8MldYcbQu
         mhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vTyC0Iyetumvi87Gb6Zwj3AYUL4Tsn5doEXtnMc5zs8=;
        b=Nrd2atXlABUBUQQyPiETyr+vhVt7KJcuTbo3ZqCyFl4mChZ4YKU7iqqiBPplu2Ssc1
         1+6mKvgs8XpnmNA6HEeGjQ3591dzkefSPNBiFt/EqqGdFWj5kTEDm6I0BDW/5CxaUWv5
         fqW6yxESu30J9irMtd5ZEqDNi1fDhCRxv28IE4xOFV8ZeuJWFnmrHuXmBtxyk0DGBKpB
         VepXMGA+4JmrLl3m4nVXNumHeKwxydy5n+yziS0m/C5q+mWDm5MzhndXKPc2WL+dAm28
         U/Wrio1O2gS2VLXIPoOI2kH3JJCiDjWFpXEG/kLXVh3sIKd+ddY1ZzE063Keryn9BEQX
         FwaQ==
X-Gm-Message-State: AA+aEWbz4b/bWY61bEVi0Pbe8bUapL497QG4zB3JkgpVZtdZQy3/ZZTc
        N5pt0CTUxDj6Afo97qcCIWsZz5gGZMo=
X-Google-Smtp-Source: AFSGD/X09SHkiZ7RS1UNImMxs4oDHiPsBK4i8IyTFoFujvS4oGYf/FqvMC/Uw4h+/s6E0iyVyybIGQ==
X-Received: by 2002:a63:c447:: with SMTP id m7mr15442288pgg.27.1543895634197;
        Mon, 03 Dec 2018 19:53:54 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x3sm23675360pgk.18.2018.12.03.19.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 19:53:53 -0800 (PST)
Date:   Mon, 3 Dec 2018 19:53:52 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pingfan Liu <kernelfans@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
In-Reply-To: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
Message-ID: <alpine.DEB.2.21.1812031946140.97328@chino.kir.corp.google.com>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Pingfan Liu wrote:

> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 76f8db0..8324953 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -453,6 +453,8 @@ static inline int gfp_zonelist(gfp_t flags)
>   */
>  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>  {
> +	if (unlikely(!node_online(nid)))
> +		nid = first_online_node;
>  	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
>  }
>  

So we're passing the node id from dev_to_node() to kmalloc which 
interprets that as the preferred node and then does node_zonelist() to 
find the zonelist at allocation time.

What happens if we fix this in alloc_dr()?  Does anything else cause 
problems?

And rather than using first_online_node, would next_online_node() work?

I'm thinking about this:

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -100,6 +100,8 @@ static __always_inline struct devres * alloc_dr(dr_release_t release,
 					&tot_size)))
 		return NULL;
 
+	if (unlikely(!node_online(nid)))
+		nid = next_online_node(nid);
 	dr = kmalloc_node_track_caller(tot_size, gfp, nid);
 	if (unlikely(!dr))
 		return NULL;
