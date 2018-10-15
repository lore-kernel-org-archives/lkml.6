Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAE72089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IcADIUFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAE72089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJPGTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:19:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42602 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJPGTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:19:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id c23so18764933otl.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iYpd4Mgq6LEOKqYaaT9tKpfZQY7xbz5nJPKIFyRf70=;
        b=IcADIUFoGeOHoDX5FLSWDROrKyNcC8Lmd4Q14IADedkbvqB84jHITrkLfqVLoW7azd
         qESyaNGW4qWvPvi//pbeUCl6gTYOqu7FNEgOMHIJJR7y/FMezBforeIvZLiBLYYWhR4L
         tTeM9IhBvVfWhONa9OE5gfmS/iLPc9Or/yzFgUNVscNW6lUQmooY6eWwohXg+6oeiMz7
         uGfvj+OyH6NyKa+a3RemHEKKw0DzaLNO2bq1IvCu/izLc6b8KVrVAdtpP0fMJCIPn9H0
         l9x/KcDfOBq2llQbS/kHxyClM1lmu7Y9DA7jjldLXqWAxiHEu9gLcaAU/A2lyk/yzimc
         kskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iYpd4Mgq6LEOKqYaaT9tKpfZQY7xbz5nJPKIFyRf70=;
        b=p8g0CGNuZ1Hp8+PLYVmGre1AOpPvV4aPUUP93mvALNV7LdwAX5mVcJBOjmS6+hZJ4V
         KbokZNc74nzusehgUfSTjq4xPnvFbazlGpahu6GeL9h1An1/SdDZS6Glgikeuln4/xtf
         ExnlegnkjTON0QNYK+riEttghysn6ui9fXJPS1FG9NC3yBStV3Izj02WeRc+EPT23iF7
         iHelEl136kyr1z7Nkrz+1kVwl41ITealGWT52Rivhg86xvssdmoSA+ld7XcN7IltLXx5
         yLQ/TMyHz6HR5JU+iHRP94pbbVd2lsLMMFn6RAPxkKXzQ2wVCJ3wdJSilSJeERWSrxsH
         2Yjw==
X-Gm-Message-State: ABuFfohL10BWAPCHJrCwsN9vHnVc/nH1v8L57qI4kIF1/BXMjv94XMIl
        lplTwgV14Ooj8KwzMWxe/BFpiwM7ZBjeZvMAy5QRejfQ
X-Google-Smtp-Source: ACcGV637GG/BEP0dqY66IqG0LVw3/ciM9Nitq4kY9Tnc9sqcvzUGjSs/BmGioF1iq6RgbI0DpzhpUYZaLqJ/DLmQFxs=
X-Received: by 2002:a9d:24c7:: with SMTP id z65mr11999927ota.229.1539642754823;
 Mon, 15 Oct 2018 15:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <153922180166.838512.8260339805733812034.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153922180696.838512.12621709717839260874.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGXu5j+PStxYhiJaWM-mt4+WWbS_WAfvyHoyZYD5ndDLN2SY6w@mail.gmail.com>
In-Reply-To: <CAGXu5j+PStxYhiJaWM-mt4+WWbS_WAfvyHoyZYD5ndDLN2SY6w@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Oct 2018 15:32:23 -0700
Message-ID: <CAPcyv4jQ2A7cDJ65+wzR=O3aabuh8p_yu9VNbpRF0A3QLUdGpA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm: Shuffle initial free memory
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 3:25 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 10, 2018 at 6:36 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > While SLAB_FREELIST_RANDOM reduces the predictability of some local slab
> > caches it leaves vast bulk of memory to be predictably in order
> > allocated. That ordering can be detected by a memory side-cache.
> >
> > The shuffling is done in terms of CONFIG_SHUFFLE_PAGE_ORDER sized free
> > pages where the default CONFIG_SHUFFLE_PAGE_ORDER is MAX_ORDER-1 i.e.
> > 10, 4MB this trades off randomization granularity for time spent
> > shuffling.  MAX_ORDER-1 was chosen to be minimally invasive to the page
> > allocator while still showing memory-side cache behavior improvements,
> > and the expectation that the security implications of finer granularity
> > randomization is mitigated by CONFIG_SLAB_FREELIST_RANDOM.
>
> Perhaps it would help some of the detractors of this feature to make
> this a runtime choice? Some benchmarks show improvements, some show
> regressions. It could just be up to the admin to turn this on/off
> given their paranoia levels? (i.e. the shuffling could become a no-op
> with a given specific boot param?)

Yes, I think it's a valid concern to not turn this on for everybody
given the potential for performance regression. For the next version
I'll add some runtime detection for a memory-side-cache to set the
default on/off, and include a command line override for the paranoid
that want in on regardless of the presence of such a cache.
