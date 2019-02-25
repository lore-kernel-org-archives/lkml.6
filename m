Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83771C10F18
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544F5213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V7pozMlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfBYAXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 19:23:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39633 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfBYAXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 19:23:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id x6so4339173qki.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 16:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUPTL3PLqLo52so3LAReL1b7OoKBQnl+BlN/LgFRYCg=;
        b=V7pozMlwApDKiEuQ9KL99F2KVnCWK4yyb52Eec+39LdbtmZGHL4qD9tBIbF/OwIW+y
         cM1aCYv/z1jPXZ7bMZ6GvPia/8hff80OYppp2fw6cFExuhUxML2MU9prpa0SluDPE0dw
         5R6hzapbb+GT0B0Q6uA7M4QHKCJm20igRHoL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUPTL3PLqLo52so3LAReL1b7OoKBQnl+BlN/LgFRYCg=;
        b=M0l5E9RgwIFnjCtmvEGQcgRgJ9Xs0JeT5qwY+FS8JeVmMueIyeABb8+wAop3reWW92
         IAZ1rDrDlbKxJKQ4CVvBS99JmHu87L2VSxZNx1r5lnYcG2w91ryzEFWrlQWt/zSDXXQ/
         V7QsxfaGm5P+9/fiKcFL126fFxDwMwa7QVdazjs/3c8BUsbph8gaJoVTYMM18gXu6nMx
         SVB4KfM4KrYvQpygaJjQeVNr+zCUHMRiet7y+ZrFpEINbXDjLJSNMkGSzj1829f7ZkPI
         xhm9P/NbHlxVgIRdaIvLUGddI/XVQFlgVDvVxiHslIs667DfBV4eUmUapg8loKbHA+YN
         RrhA==
X-Gm-Message-State: AHQUAuZahP7p2SKHYYffqHXgu85X3jAgRBIq/biFcckJF090JwCBz5BM
        XnRpkuH4Or0VhFyOnno7ON+zYgBo71qcOfO8kLnKsA==
X-Google-Smtp-Source: AHgI3IYirf19cEx+D7YVBM5KBkdm2qM0SS7imatY1p89YM8NkGpwT67vhO3HIEUXH8EZmfreZX4pl0NiDFDcK8eBgF0=
X-Received: by 2002:ae9:e901:: with SMTP id x1mr11369376qkf.124.1551054230094;
 Sun, 24 Feb 2019 16:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
 <20190111102155.in5rctq5krs4ewfi@8bytes.org> <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
 <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz>
In-Reply-To: <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 25 Feb 2019 08:23:39 +0800
Message-ID: <CANMq1KCfhWdWtXP_PRd_LEEcWV8SQg=hOy4V7_grqtL873uUCg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
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
        Tomasz Figa <tfiga@google.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>, hch@infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, stable@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 1:12 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/22/19 11:51 PM, Nicolas Boichat wrote:
> > Hi Andrew,
> >
> > On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
> >>
> >> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> >> > Does anyone have any further comment on this series? If not, which
> >> > maintainer is going to pick this up? I assume Andrew Morton?
> >>
> >> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
> >> this should go through mm.
> >
> > Gentle ping on this series, it seems like it's better if it goes
> > through your tree.
> >
> > Series still applies cleanly on linux-next, but I'm happy to resend if
> > that helps.
>
> Ping, Andrew?

Another gentle ping, I still don't see these patches in mmot[ms]. Thanks.

> > Thanks!
> >
> >> Regards,
> >>
> >>         Joerg
> >
>
