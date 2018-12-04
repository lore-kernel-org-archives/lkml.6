Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE44C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA40320834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/BoPqSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA40320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeLDHU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:20:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42487 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLDHU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:20:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id j6so12981994edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 23:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkwZTCjxjMRS0mgg5lpZWC1vgbD+70J+PanvKnwZCp4=;
        b=H/BoPqSnfaOUCZexBPeRTZj3f4Q1ctVK/LfeYp0wbiYkInEjEJQHnJ/UTcf9VIBYyJ
         fZGcFWfB+AXJZomsVo4cdy+IANibHi6zo1h9bSPhA+X8R2HHhGAGkuj6SQB3QL/5kJDh
         O4iF5aptPo1OIq72oqlfM+X5juSgFlwCZHR8lvXDSzSDzkYTVcS8q7TtbncLpgQq1ciQ
         C3IS7Qwq2jkr1T98HqQQ2UPFzoT7kHFNchLpHzfQL2dFIUusSnX+w2Ti5yXt21AwI1yd
         YjMBtzL/jPVsopzWAhZM1g4BmIj43Ol5VB+O7uHHGPvBBml8B4XT4zD5K9K9qMC8OUlc
         PINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkwZTCjxjMRS0mgg5lpZWC1vgbD+70J+PanvKnwZCp4=;
        b=BeWNfBcuUomI97UPKEzk0KF3ATBumSGAn9kbg9sESclJVOA0YRTsYdbk+qE7d8f5ot
         MUYZ3IC9YCNa03lFx+J2h3VBdsmhBE3X4RS53SGaO8CuTQLmycWb/0HlB4VvZ4Ej5SKw
         f8muONmV4X14mGa6YdfLP+SzOJN/B3FYlw2GWzAFlhPiwl32ZgOC3K4ntrLvaCBNllLa
         BY1PzDsqbV2g5f5JaYyX2Z38B17H9e4J+9GmPrHetGSMpt39KH/MB+j+VG1DjBTvM/bn
         aU7cRf3Miu8q45RGICU9jV6cek49LtDAm3m+ZraUAluBfo0cxV3G/2Q4/bb0l7gZkbb8
         tm2w==
X-Gm-Message-State: AA+aEWaQPOqXZ0Ml5g1l6wY9bx0z7IjqSNWX2UKsIebp/P8CvDH746+y
        E1fXWRrsgVob/SR8y/n7V3wUiJspp6aSQWY4wg==
X-Google-Smtp-Source: AFSGD/WL0PXtcLY59+PZkBcwylINwO40jrIsd6tPE/ViLWjj9zDAPUZe3aVsHoynx9a0kqagV7Gf26gqZT/Rxp4JH9E=
X-Received: by 2002:a17:906:3488:: with SMTP id g8-v6mr15107013ejb.11.1543908025330;
 Mon, 03 Dec 2018 23:20:25 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com> <20181204065453.4rsyhtsk2aej4vim@master>
In-Reply-To: <20181204065453.4rsyhtsk2aej4vim@master>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 4 Dec 2018 15:20:13 +0800
Message-ID: <CAFgQCTvQBC11=4eGQ6T9vyB+KOznFCr4hjdg1wwD8GotSRWpDg@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     richard.weiyang@gmail.com
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

On Tue, Dec 4, 2018 at 2:54 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> On Tue, Dec 04, 2018 at 11:05:57AM +0800, Pingfan Liu wrote:
> >During my test on some AMD machine, with kexec -l nr_cpus=x option, the
> >kernel failed to bootup, because some node's data struct can not be allocated,
> >e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
> >device->numa_node info is used as preferred_nid param for
>
> could we fix the preferred_nid before passed to
> __alloc_pages_nodemask()?
>
Yes, we can doit too, but what is the gain?

> BTW, I don't catch the function call flow to this point. Would you mind
> giving me some hint?
>
You can track the code along slab_alloc() ->...->__alloc_pages_nodemask()

Thanks,
Pingfan
