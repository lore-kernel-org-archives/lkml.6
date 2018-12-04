Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B58DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2227E214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScH82CyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2227E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeLDHQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:16:52 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40641 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDHQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:16:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so12975724edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 23:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l60/TJR3YhfpFyt1x2HOf7fUKk4/P6UR/hSTbtnruvo=;
        b=ScH82CyU/xoG9RlIlXFOdetUayFdING8Mh6fwggPFYvaRoPNs3bhDf6HfpuvjIBBDJ
         4XcysOs//n9M9ro9Lw8qTSTmy9IezIGK0AQTsjZBErPK49zKmmQfNUPUYy9ecyaRLLSz
         SCFdGgsvUmvSOiH1yY/6EcIlyYvPa1HCQ/poPEJ3CrFBN3vUwqtrmtp3zdZxCBeCNkm6
         VYedFjsrOQL+Cqeasu+DS7Kmm97iyyem0X7QdQ8oS5+fz4GAncmdwPoQtLAqOamWETZh
         WKktqVEX43yuuokkmcbu0Brus5Rn2U0VkwAkG3/jywqDQAbdUsirjgScPLf37kZ+42RO
         98oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l60/TJR3YhfpFyt1x2HOf7fUKk4/P6UR/hSTbtnruvo=;
        b=fzhp14f1ge4JYFt3sLm36SYipaTO3dBCLLbrcrVWum7pvlKMNNNJF+/3f497wSUonb
         AXNzx9vmx46/zYZqHZJSG5QF43AHs4zDSrSgugE1pCPK10h0yl4ZNfXwvdbY5e2a2d2Z
         PU3WNDmkurdFYvQCsHQAqj4ldDrdDu2ay+T5cqGgjuMY6/ehnFUgpeaU62xDi35xojxR
         QYjc04WNSOKfUDY5UO3ct5LsZf67bTcjUofSl3d8nvpKOnMIH1iOoywhhhCg2EVyqFrn
         fMqNFJluzjg8XRUmLraodehtVw0LYAWuRZP1bx0rkWA8QEE1G84t/ALkzIwlV+OHX+sn
         u4sg==
X-Gm-Message-State: AA+aEWbLUh8h4VkJ5dE+C1kupNmcre9CiH0isLdh4jTUo2v4nO34SuJw
        xP55n3bAMfoSmY4A5ufJf96a6jHukEinxl237g==
X-Google-Smtp-Source: AFSGD/Vy914YoUEJ8DLJwvSgf3Z63W+5Mz/FCRfJ95NoCHj6M7ODRJmr/eRD9P5jkOUA1y6lOqzQ3FznFPOLJW1+SLU=
X-Received: by 2002:a17:906:2acf:: with SMTP id m15-v6mr14795041eje.180.1543907810709;
 Mon, 03 Dec 2018 23:16:50 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com> <alpine.DEB.2.21.1812031946140.97328@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1812031946140.97328@chino.kir.corp.google.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 4 Dec 2018 15:16:39 +0800
Message-ID: <CAFgQCTsikqQERh2MgsrupdVzp0TyF4dDQPjJkN9g3DTq4DB9hw@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 11:53 AM David Rientjes <rientjes@google.com> wrote:
>
> On Tue, 4 Dec 2018, Pingfan Liu wrote:
>
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 76f8db0..8324953 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -453,6 +453,8 @@ static inline int gfp_zonelist(gfp_t flags)
> >   */
> >  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> >  {
> > +     if (unlikely(!node_online(nid)))
> > +             nid = first_online_node;
> >       return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> >  }
> >
>
> So we're passing the node id from dev_to_node() to kmalloc which
> interprets that as the preferred node and then does node_zonelist() to
> find the zonelist at allocation time.
>
> What happens if we fix this in alloc_dr()?  Does anything else cause
> problems?
>
I think it is better to fix it mm, since it can protect any new
similar bug in future. While fixing in alloc_dr() just work at present

> And rather than using first_online_node, would next_online_node() work?
>
What is the gain? Is it for memory pressure on node0?

Thanks,
Pingfan

> I'm thinking about this:
>
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -100,6 +100,8 @@ static __always_inline struct devres * alloc_dr(dr_release_t release,
>                                         &tot_size)))
>                 return NULL;
>
> +       if (unlikely(!node_online(nid)))
> +               nid = next_online_node(nid);
>         dr = kmalloc_node_track_caller(tot_size, gfp, nid);
>         if (unlikely(!dr))
>                 return NULL;
