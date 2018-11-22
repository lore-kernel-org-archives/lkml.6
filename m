Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30928C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F0B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NZpfqCby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F0B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391146AbeKVL3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:29:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45454 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbeKVL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:29:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so7830018plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 16:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgzqfiRQBoL9QPyLrNO7xQ21AD736G0rhe/S0Lccysk=;
        b=NZpfqCbyrGduQBAcUcjZb376y1/oqbGwYLy0kJWTPgJ/eVmMEnaRaJvsBMgg0yRaSn
         oxIJvPrvLwuxNvEuuQ1C/baLQ4k5/u5JvSorCMIh5fdX7GqB2RWRdsueRBf/zzAjA5i2
         J7rNN3liQZJdwhqry0SI+3VDS5m09DM2k6rJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgzqfiRQBoL9QPyLrNO7xQ21AD736G0rhe/S0Lccysk=;
        b=ew2j7UM17J5PAv6vtTjQYP7CU69DEOD5T8GwJUZMubnG0/mkHn0ST/qg8xK90ehJWh
         NUxRen73UUGYyhQwo4xZ5TvM14wKKXBBaNhuaXPHmkbp4kmbfOPw37IyOOq6xc8P4Ffw
         Utyqjkr7OS+wVHTwUu3FAf1z/HjsJCXNFWjorf55oEvZBT3yNA9YZE36MMBrAsu/D4Au
         eXS+/8sPiT8RJRAQV8lVyM/+mEGIxWoO3Py5kNyz8IgBZ+5Yn+XKOFdA0MOJegpnFvs2
         tBSibpnm+9OxlWC3KyP2Bx493wMlKZdPtKH9PFTxt0CigRgOHyaHb9YbNv9y52MqzDng
         jYjQ==
X-Gm-Message-State: AA+aEWY02fnOKmutBpgq91ZGUDPlWzgEXU5vWvbS7/dAnHdTU+kmbbiL
        RLhvgRc/SfG/b3pxEks6V6SbMr8l+kxoXxhyDSWTkQ==
X-Google-Smtp-Source: AFSGD/VnD29MdzfnDhipbdlJJZQyKTjK6oUmnd6YWXXn+gEXw/VEgMnnDa8BjiRZHL8h4hPjxetUYnQupx5bwuyGKfc=
X-Received: by 2002:a63:6645:: with SMTP id a66mr7851490pgc.390.1542847977589;
 Wed, 21 Nov 2018 16:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <20181111090341.120786-3-drinkcat@chromium.org> <01000167378bf31a-a639b46c-4d1d-43de-9bed-9cdd9c07fa94-000000@email.amazonses.com>
In-Reply-To: <01000167378bf31a-a639b46c-4d1d-43de-9bed-9cdd9c07fa94-000000@email.amazonses.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 22 Nov 2018 08:52:46 +0800
Message-ID: <CANMq1KD4j=Zh1izN8Ujn3+ZsdMMzCLPurfkXTkM9TyQaTptjFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: Add support for SLAB_CACHE_DMA32
To:     Christoph Lameter <cl@linux.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 2:32 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Sun, 11 Nov 2018, Nicolas Boichat wrote:
>
> > SLAB_CACHE_DMA32 is only available after explicit kmem_cache_create calls,
> > no default cache is created for kmalloc. Add a test in check_slab_flags
> > for this.
>
> This does not define the dma32 kmalloc array. Is that intentional?

Yes that's intentional, AFAICT there is no user, so there is no point
creating the cache.

 (okay, I could find one, but it's probably broken:
git grep GFP_DMA32 | grep k[a-z]*alloc
drivers/media/platform/vivid/vivid-osd.c: dev->video_vbase =
kzalloc(dev->video_buffer_size, GFP_KERNEL | GFP_DMA32);
).

> In that
> case you need to fail any request for GFP_DMA32 coming in via kmalloc.

Well, we do check for these in check_slab_flags (aka GFP_SLAB_BUG_MASK
before patch 1/3 of this series), so, with or without this patch,
calls with GFP_DMA32 will end up failing in check_slab_flags.
