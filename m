Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1804620827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jh8jzQ4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1804620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbeKFSnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:43:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43179 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:43:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id j202-v6so10091514oih.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFXU6KuBfcve29crjXH2P8kwZ0XtTWD3YQGvFnfJ1fg=;
        b=Jh8jzQ4mWv05gOzhjxAKlgIc/E+Py9lrlljjUq966J6ZgrQGOaYD7z3na2kmUmtIbl
         FICMQ+eYhdXYuo1vEDglKU4iOIUHhqPgPMTqlDAlov0/wr+urI2r/WEMjWfHykZQWXzm
         39Lsmeb5yHfMdotHRxD3uYnbbofHOqm2l1WpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFXU6KuBfcve29crjXH2P8kwZ0XtTWD3YQGvFnfJ1fg=;
        b=ldEFkSkXSWmxxXaEQsB3UEWIzGACAeEk2CmYxaQ7RyYBBNsyVVr9Ahd+ghs+/WdcTR
         fw6rI0AkB8xFXGM6quUwh8QpHjteTiSncM6rMC9cHvvDCIUcnuKpLXXdhyJQ/IkzRtCE
         APBKOEIEzvaXS+guLSZ3fP43VTCDOMAh/FQxbmelvp6ISFFsZYmca11DIPDG7y4aWwTu
         1PZ7jjImxIZb/ycegbrHXE9v7rmrJGR0YZnMMBh7ReOyqT+ltiUgJ5cA+XCQ7tH1TQox
         i55iS20WNFSZ0+dl/xNlufXkP+wXhrX8j8lPOSLzFB8oxS8Hin6xdsaXRtGxF2pLxr1O
         IS8g==
X-Gm-Message-State: AGRZ1gKmng/dr20d7YwcF1m5h0eyhj0Iq1oCl+2B00TSwdt+70cQ0zEa
        PrEnBN/Zls73eZEbBLiEBhJK/1xHhmFdk+lWvLpNjiw=
X-Google-Smtp-Source: AJdET5faInj2lKjaZSPc3pqyxnTGJTZJEE/hayQCut0I2oGSFrGmgpCvbn1A0xyATOu7gTv76FCU5qHRf96Dpjjy+E4=
X-Received: by 2002:aca:5f45:: with SMTP id t66-v6mr2293352oib.20.1541495966330;
 Tue, 06 Nov 2018 01:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20181106090352.64114-1-vovoy@chromium.org> <20181106090839.GE27423@dhcp22.suse.cz>
In-Reply-To: <20181106090839.GE27423@dhcp22.suse.cz>
From:   Kuo-Hsin Yang <vovoy@chromium.org>
Date:   Tue, 6 Nov 2018 17:19:15 +0800
Message-ID: <CAEHM+4rdeGqryvJqTkV_ocEA8y7dOXS_Nx+O3ouFZ44j9wzm=g@mail.gmail.com>
Subject: Re: [PATCH v5] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     mhocko@kernel.org
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 5:08 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 06-11-18 17:03:51, Kuo-Hsin Yang wrote:
> > The i915 driver uses shmemfs to allocate backing storage for gem
> > objects. These shmemfs pages can be pinned (increased ref count) by
> > shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> > wastes a lot of time scanning these pinned pages. In some extreme case,
> > all pages in the inactive anon lru are pinned, and only the inactive
> > anon lru is scanned due to inactive_ratio, the system cannot swap and
> > invokes the oom-killer. Mark these pinned pages as unevictable to speed
> > up vmscan.
> >
> > Export pagevec API check_move_unevictable_pages().
> >
> > This patch was inspired by Chris Wilson's change [1].
> >
> > [1]: https://patchwork.kernel.org/patch/9768741/
> >
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> please make it explicit that the ack applies to mm part as i've
> mentioned when giving my ack to the previous version.
>
> E.g.
> Acked-by: Michal Hocko <mhocko@use.com> # mm part
>
> because i am not familiar with the drm code to ack any changes there.

Got it. Thanks.
