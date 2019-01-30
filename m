Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB70C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19C72087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fj+J85eH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbfA3TY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:24:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36056 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387509AbfA3TY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:24:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so636341oix.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i77S7MM2CpsPk8Esja5BnOxATbCo+ICNnWSU2cpIjQw=;
        b=fj+J85eHmmoDBgqOie71luR9HCN7N5yxqMUZTXmbCvylkuNUhNhR9aP2OBfmz4e57x
         ObuZ+bH8XJBallVWeFkvS27MtjgEtvXK7gzbMPnYJN1M3d54tClnvpRBbXmiXoTrJft5
         zZA6EtWwp4I5Te3oZAFukFzeyWqP8u132Cndei6rw9f3F0l2+BjFbn/SsTiw1J6QixON
         2ZpZX3CRVKW8fpYso+kKCEiKb4FSThUZLemrz3rnhobIqo4ZzF6Rck0Ja9Q2wcVR4zae
         RPVOqWcB/GRvQGfFI5LGTAFiY/GOjlyhVfxKWPkQ+wFf4vNsKQdFXzMEhUqgP4RD0bn8
         93+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i77S7MM2CpsPk8Esja5BnOxATbCo+ICNnWSU2cpIjQw=;
        b=FEflxdfrXPO3VtHvgXSCIK09qtcVyZCnt51+nWfA7AtPWeRXLwGe+h4tX7GZw2qNlH
         kYQYe38e4w7s0QhtKfUQLg3rc4nw8OJbsj5Ac7gem8jnTTZG6uAFvL8ePm6bFY85TuGO
         8vLCugSHgB1QNf3/GlDTZX83uYc2Gq5Db0gqU/va5676tar8+rDZ2g3CMpMgmigtbLid
         cVdje4ZRKsXFh5JruW9EzXUl4T1/z5VibK98++dCeBegrU3vaEbW0cUD7KEgA1aItNu3
         zKnDtBEGae87r5yLgdHEjtA6Sbij43PJy7zF28ceRziNdiPfM3VPhzvT1ELwpvgNNwuO
         QBhg==
X-Gm-Message-State: AHQUAuYj0/yDqzlHXZy7NQjm4jEeP1EKeOOPw69g6nUyEDHL9kl6bukD
        +2Y2AIpl50pRl7yWZfmXlZuKK5AoY+E0QtgLv22bMQ==
X-Google-Smtp-Source: AHgI3IZy2xBWKDGay61UfSFE8lBEuhM3cL4TF0tWmWTh4+NSpuIIIbDYmsWFLAlQDMDos1K4aM97n9Aqtj/nK8hqWfc=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr12545316oig.232.1548876296664;
 Wed, 30 Jan 2019 11:24:56 -0800 (PST)
MIME-Version: 1.0
References: <154882453052.1338686.16411162273671426494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154882454628.1338686.46582179767934746.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190130191117.GH18811@dhcp22.suse.cz>
In-Reply-To: <20190130191117.GH18811@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 30 Jan 2019 11:24:45 -0800
Message-ID: <CAPcyv4iEmPGtK5=7ah_0Fyeu17y26TwifDMRYruZtD07nCxD+A@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mm: Maintain randomization of page free lists
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:11 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 29-01-19 21:02:26, Dan Williams wrote:
> > When freeing a page with an order >= shuffle_page_order randomly select
> > the front or back of the list for insertion.
> >
> > While the mm tries to defragment physical pages into huge pages this can
> > tend to make the page allocator more predictable over time. Inject the
> > front-back randomness to preserve the initial randomness established by
> > shuffle_free_memory() when the kernel was booted.
> >
> > The overhead of this manipulation is constrained by only being applied
> > for MAX_ORDER sized pages by default.
>
> I have asked in v7 but didn't get any response. Do we really ned per
> free_area random pool? Why a global one is not sufficient?

Ah, yes, sorry, overlooked that feedback. A global one is sufficient.
Will rework.
