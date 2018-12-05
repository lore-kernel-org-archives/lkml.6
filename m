Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7142C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B06120878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBi8dKY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B06120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeLEFtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:49:47 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36302 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeLEFtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:49:47 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so15973330edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 21:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrqlGatGK9YWYP95JatWcvRkypUfQHeO7cDiS5LHNcA=;
        b=BBi8dKY1MWqPViUyXV5LIuj9009UFj/amW5TyTPI2g8olZFi6gw5Jp2sxS8pJOCtUy
         dCptci7fWhyaFvDW0lRQeIzgpTvYen2HIyTlyYlPwXUSzg5CW1SMvXe4kGhy4tvGrFoi
         t40FTXiplCSytp8qRDxSWOFSJ4l9gwNSZ6gcwl+qyo7Et3Di+IUdkvsgkNf718HKP6Wc
         NB+Nyag9cSxXfutfRqol4N7o62vOyEedrv8gdX6YHsPWsxhZAakbQBz26dD3K0eh7nra
         jSVDh+i+25ytu3hdGN2xiWucGxz9qEUv3ZE4Bllwq7E/KWHTzLO7nqj7y7PfRBtaT1ii
         oC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrqlGatGK9YWYP95JatWcvRkypUfQHeO7cDiS5LHNcA=;
        b=k3I0zi+fUcdY/JnVHdxdUg0W/j5aaxyfoH332LxpHNyVhiiJAc3Nk0PprQ7/uVXbM3
         Ke8iSwgQQTV0CU5GeDKvMM/uEowm81JBilyQl2MWkD8rYdgNuRS1sXLOVSCR/EAEJtg9
         CrnfjbGfeFGELOnb1Us0Mx5peyZ3Tl0TndYdYYzGG9JbtI0UF8G/+qoTygbURGcgm5nf
         AgmZKVh1t1wK/rKUnXGMlsCd5lJGRcYNVaj8r3w+BnO6D33s70/B1csmHB/EahquvxIk
         VF5gBJjPr2RBatM20CVtvt1qw5BuIlSJITUZfxIyyZQHABEZp1JekujVCmG568VphkSW
         nYhw==
X-Gm-Message-State: AA+aEWYdH9Mwujb53EUW+58lhmXoy6MtlgdnoWTmT0pjXxgB5VoTdJzy
        9x6ywxkupN0by49aw5s2j/+KQo/Ysetj8RqCcg==
X-Google-Smtp-Source: AFSGD/VE+eKadByrcOyM7unoyTWL5i+huPCABfbk/hGBpG9EA7OjMgrcEQxHZ/g7LJVn4k8guKtc3IIhJOFiYyw1AgY=
X-Received: by 2002:aa7:cf88:: with SMTP id z8mr20563201edx.208.1543988985509;
 Tue, 04 Dec 2018 21:49:45 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <alpine.DEB.2.21.1812031946140.97328@chino.kir.corp.google.com> <CAFgQCTsikqQERh2MgsrupdVzp0TyF4dDQPjJkN9g3DTq4DB9hw@mail.gmail.com>
In-Reply-To: <CAFgQCTsikqQERh2MgsrupdVzp0TyF4dDQPjJkN9g3DTq4DB9hw@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 5 Dec 2018 13:49:34 +0800
Message-ID: <CAFgQCTttgfuPJZHqGDSF5hLpLWDm2+_+UiyK+ScKgxs6qD-KCQ@mail.gmail.com>
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

On Tue, Dec 4, 2018 at 3:16 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Tue, Dec 4, 2018 at 11:53 AM David Rientjes <rientjes@google.com> wrote:
> >
> > On Tue, 4 Dec 2018, Pingfan Liu wrote:
> >
> > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > index 76f8db0..8324953 100644
> > > --- a/include/linux/gfp.h
> > > +++ b/include/linux/gfp.h
> > > @@ -453,6 +453,8 @@ static inline int gfp_zonelist(gfp_t flags)
> > >   */
> > >  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> > >  {
> > > +     if (unlikely(!node_online(nid)))
> > > +             nid = first_online_node;
> > >       return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> > >  }
> > >
> >
> > So we're passing the node id from dev_to_node() to kmalloc which
> > interprets that as the preferred node and then does node_zonelist() to
> > find the zonelist at allocation time.
> >
> > What happens if we fix this in alloc_dr()?  Does anything else cause
> > problems?
> >
> I think it is better to fix it mm, since it can protect any new
> similar bug in future. While fixing in alloc_dr() just work at present
>
> > And rather than using first_online_node, would next_online_node() work?
> >
> What is the gain? Is it for memory pressure on node0?
>
Maybe I got your point now.  Do you try to give a cheap assumption on
nearest neigh of this node?

Thanks,
Pingfan
