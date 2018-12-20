Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC514C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB37B2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmS8HOvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbeLTM0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:26:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35999 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeLTM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:26:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so1582578edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4a5LGFdoY5XJf8K5/zF3Zn4wAJbZoJB4Ksv/i71lR8=;
        b=pmS8HOvQ99RyxXZv8Um0Dln2oVyXCzZzos0yDFrUuaAEJ2kXKJ9Ku3kIjGPqHo/LGU
         WetslvwId951YXveHiOIV8YVVN8BjF16781aCM21Rgk3wUUeoWCBmn1YRcKzu1HtJZ9l
         FLLO5mTeSJIYTv0kX2eLSof4sVTNItnoYfrXh69fl4sBmfudIjd9WV1XNpdt139rEmG7
         Lme39o7J6AXWplKSKr3tVL3CJbn6iDeBImXQ3iIMWXlMoWq0ZVNqA2tGxSpdtGqjxRdo
         na9s9cMzoexp0OzMB2JSHdI7ImTrf/0hfwJ/d9X57QL88JqDQcg3N3byEC/+6N+spZXr
         QMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4a5LGFdoY5XJf8K5/zF3Zn4wAJbZoJB4Ksv/i71lR8=;
        b=YeypgDfzudwRUsyan0rYiKdWpbT3EecujoPS8gyGpx/EFKLEThp99eYUqLNtK7UDJe
         p50qHJq7qhN5NoJFm12cHoLf3CPyTUPxaXVAtxT3kXJppkXUrh5HHLarjPSWQhddGzfe
         edjUbhLA6HQVkU9M1tfxzfiLZK+Qlqc36Frd2HcrTQQG0edwQcn9pssccYlmxUaQaMAt
         +16cKlLR/x6FsDULLWK/j14DmytKeBOuq6bIuZhIrcmxOf4tUPYpnnriirRSWImUQU3/
         MPuQ5K5zecRTbSKs1t4eQEzfjgvC6VTJsPBdhjxD7MWErwgmgyi/Yj85FJdu9LIi+IOT
         fRXQ==
X-Gm-Message-State: AA+aEWZrDjsrvhzwov/NHjwrONeRgV//MoMAmNA1QJBTL71Kl8ii39Z7
        +nFMz6hgpGMdb3yXEyGSg1EtmZPlVUDJ/Hpb4A==
X-Google-Smtp-Source: AFSGD/X0JdX1/FF5gw5aLqyJFharMVqH+3EGA/ie8E9ECtLlDqLGbrNPaoLf329YHkSosXaygBslGmRlZbcf556COmE=
X-Received: by 2002:a17:906:3488:: with SMTP id g8-v6mr19486881ejb.11.1545308800200;
 Thu, 20 Dec 2018 04:26:40 -0800 (PST)
MIME-Version: 1.0
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
 <1545299439-31370-3-git-send-email-kernelfans@gmail.com> <20181220113547.GC9104@dhcp22.suse.cz>
In-Reply-To: <20181220113547.GC9104@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 20 Dec 2018 20:26:28 +0800
Message-ID: <CAFgQCTvxNGTKD+DP_LxF86WoVnCHnPkWoSqdGeXQxXNVYD_orw@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] mm/numa: build zonelist when alloc for device on
 offline node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 7:35 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 20-12-18 17:50:38, Pingfan Liu wrote:
> [...]
> > @@ -453,7 +456,12 @@ static inline int gfp_zonelist(gfp_t flags)
> >   */
> >  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> >  {
> > -     return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> > +     if (unlikely(!possible_zonelists[nid])) {
> > +             WARN_ONCE(1, "alloc from offline node: %d\n", nid);
> > +             if (unlikely(build_fallback_zonelists(nid)))
> > +                     nid = first_online_node;
> > +     }
> > +     return possible_zonelists[nid] + gfp_zonelist(flags);
> >  }
>
> No, please don't do this. We do not want to make things work magically

For magically, if you mean directly replies on zonelist instead of on
pgdat struct, then it is easy to change
> and we definitely do not want to put something like that into the hot

But  the cose of "unlikely" can be ignored, why can it not be placed
in the path?
> path. We definitely need zonelists to be build transparently for all
> possible nodes during the init time.

That is the point, whether the all nodes should be instanced at boot
time, or not be instanced until there is requirement.

To replace the possible_zonelists, I bring out the following draft
(locking issue is not considered)
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0705164..24e8ae6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -453,6 +453,11 @@ static inline int gfp_zonelist(gfp_t flags)
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
+       if (unlikely(!node_data[nid])) {
+               WARN_ONCE(1, "alloc from offline node: %d\n", nid);
+               if (unlikely(build_offline_node(nid)))
+                       nid = first_online_node;
+       }
        return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
 }

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ec9cc4..4ef15fc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5261,6 +5261,21 @@ static void build_zonelists(pg_data_t *pgdat)
        build_thisnode_zonelists(pgdat);
 }

+int build_offline_node(int nid)
+{
+       unsigned long zones_size[MAX_NR_ZONES] = {0};
+       unsigned long zholes_size[MAX_NR_ZONES] = {0};
+       pg_data_t *pgdat;
+
+       pgdat = kzalloc(sizeof(pg_data_t), GFP_ATOMIC);
+       if (!pgdat)
+               return -ENOMEM
+       node_data[nid] = pgdat;
+       free_area_init_node(nid, zones_size, 0, zholes_size);
+       build_zonelists(pgdat);
+       return 0;
+}
+

Thanks and regards,
Pingfan
