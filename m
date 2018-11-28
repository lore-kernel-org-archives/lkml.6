Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FBF2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FBF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeK2CV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:21:56 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45024 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeK2CV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:21:56 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gS1cs-0005mC-12; Wed, 28 Nov 2018 16:19:42 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, hjc@rock-chips.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
Date:   Wed, 28 Nov 2018 16:19:41 +0100
Message-ID: <5480157.mmjlM7ZeET@diego>
In-Reply-To: <CAFqt6zZy0-dy=a+KDrx7V1-j37pAVmt2r6bOkjgHwiopG-L+xA@mail.gmail.com>
References: <20181115154826.GA27948@jordon-HP-15-Notebook-PC> <CAFqt6zZy0-dy=a+KDrx7V1-j37pAVmt2r6bOkjgHwiopG-L+xA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

Am Montag, 26. November 2018, 06:36:42 CET schrieb Souptick Joarder:
> On Thu, Nov 15, 2018 at 9:14 PM Souptick Joarder <jrdr.linux@gmail.com> 
wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> > 
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> 
> Any feedback for this patch ?

sorry, took a bit longer to find time for a test-run.

Except the missing EXPORT_SYMBOL already pointed out in patch1,
my displays are still working on modern (with iommu) and the older
(without iommu) Rockchip socs, so

On rk3188, rk3288, rk3328 and rk3399
Tested-by: Heiko Stuebner <heiko@sntech.de>
and in general
Acked-by: Heiko Stuebner <heiko@sntech.de>


Heiko


