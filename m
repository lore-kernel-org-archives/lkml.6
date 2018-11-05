Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D353CC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F662085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONkUsKip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F662085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbeKEUnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:43:53 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33732 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeKEUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:43:52 -0500
Received: by mail-oi1-f173.google.com with SMTP id c25-v6so7132705oiy.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 03:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itghpjIfmiE5/KM5eenSeE+/NVGanYuSF9iEq8vTcew=;
        b=ONkUsKipqH3BpHvDk1jDbYNOpbfBrwOSagDvLCoTgIMo+a80c+fxWgRKDyL2OQa0uV
         YxW6oUDQu7Xl1oACGgr6lRqYmMNsGJ/O73MdSdEok66eHnLeFE+0A798uulwS9DuUck9
         wtpsypr+EVBMV5Wg0VI8/sDVUHyS0Nz0EN1tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itghpjIfmiE5/KM5eenSeE+/NVGanYuSF9iEq8vTcew=;
        b=Dbx/AHSNB1uJuVmyCKiEvTiDyySpELmyUW/OtTTE4ApHYizOEwgg2ckwbnCLTFRjIV
         I4DOIibnLyS9N1QAF+CJ2pWD56i64N6OTxfRyF5q2JqD0fUi/E/JZipL2x4xknYG5wUD
         PyJWtF2x0xf8lyyMTWP5oyu4C5ICqy51BqdixEpSvtcP/2azt9D6l7Z1cRqvC+GHZk0a
         HU4M1+9xzsGg9aOws45lGBb14Sf1gGZC1wiliLct+9tVttMfMIt99PSDiZzr+BY3c/MN
         3fA29y042avQp60dlcwAei7cQwwzoX31pkGUlfX3+0Htg8Ut47qC7PFckJ5E6OWTLsDY
         Ybog==
X-Gm-Message-State: AGRZ1gLuO7nyimGuN2UYLByg4ZG0IzriEIuS66q2CEuocWdWHOqw/SQo
        XWhP8ZimT4ltfWrtl6h+5ys9pNoNA5udMe1HKX5k
X-Google-Smtp-Source: AJdET5df5WR6oikiyUn5iTHchVNmtdfxwXWuG8MHzNL4wgP/eiUl34UrGST/Qu/YcBuEyXTmVZHWmCJlv3SAMfXYaCI=
X-Received: by 2002:aca:5f45:: with SMTP id t66-v6mr59876oib.20.1541417077519;
 Mon, 05 Nov 2018 03:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20181031081945.207709-1-vovoy@chromium.org> <039b2768-39ff-6196-9615-1f0302ee3e0e@intel.com>
 <CAEHM+4q7V3d+EiHR6+TKoJC=6Ga0eCLWik0oJgDRQCpWps=wMA@mail.gmail.com>
 <80347465-38fd-54d3-facf-bcd6bf38228a@intel.com> <CAEHM+4rsV9G_cahOyyH8njOYyZc5C9b0a6CV4AH_Y7EubXBLAQ@mail.gmail.com>
 <b114017f-edeb-2055-1313-0d7821d633ae@intel.com>
In-Reply-To: <b114017f-edeb-2055-1313-0d7821d633ae@intel.com>
From:   Kuo-Hsin Yang <vovoy@chromium.org>
Date:   Mon, 5 Nov 2018 19:24:26 +0800
Message-ID: <CAEHM+4oR7tRv5qwKxKjRCQVHF75MnPmb3PdXtU7Ve0hj+G+tjg@mail.gmail.com>
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Michal Hocko <mhocko@suse.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 10:05 PM Dave Hansen <dave.hansen@intel.com> wrote:
> On 11/2/18 6:22 AM, Vovo Yang wrote:
> > Chris helped to answer this question:
> > Though it includes a few non-shmemfs objects, see
> > debugfs/dri/0/i915_gem_objects and the "bound objects".
> >
> > Example i915_gem_object output:
> >   591 objects, 95449088 bytes
> >   55 unbound objects, 1880064 bytes
> >   533 bound objects, 93040640 bytes
>
> Do those non-shmemfs objects show up on the unevictable list?  How far
> can the amount of memory on the unevictable list and the amount
> displayed in this "bound objects" value diverge?

Those non-shmemfs objects would not show up on the unevictable list.

On typical use case, The size of gtt bounded objects (in unevictable
list) is very close to the bound size in i915_gem_objects. E.g. on my
laptop: i915_gem_object shows 110075904 bytes bounded objects, and
there are 109760512 bytes gtt bounded objects, the difference is about
0.3%.
