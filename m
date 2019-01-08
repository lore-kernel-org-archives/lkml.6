Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44045C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B37F20665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACC7emwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfAHXY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:24:27 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34546 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfAHXY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:24:26 -0500
Received: by mail-vs1-f65.google.com with SMTP id y27so3644687vsi.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zeA7wPbvu4atpqM4sPM6IAShi6Cxo/Ri1A2df3T19k=;
        b=ACC7emwD/V6b0oJqwIt2mcqlaZ1wsVmLYiqliHX5EQSKAlJMJ7VKN0C2cbqScS+fxq
         z1KBrNKpm0NlIO0dTlWg9OQj3Q8tbMs9Lv940Ng/nxXJfuKCuu/5xqdoSO5Rs94B+MQa
         nU94b4lM3XNDqPAkvbzaTTIjWkgiEfSLwGI64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zeA7wPbvu4atpqM4sPM6IAShi6Cxo/Ri1A2df3T19k=;
        b=VNLQogztiiibWEV2vFBaWKeGkkihYa3LrIYKwYCar8NOB8jdaIDlseHgvKO8hggI35
         qUDlb51N6dmHHvudcPifAAHvh1bZd8iVXwcn5a7dWQL6MEm3J1wRy+9dfZSIKiPw8PnR
         kqZZf+vZT7p464FafdYc1mk0nLEJrJ25+iv85NrDWljsOX9939KAZNyK9khFt/nzAAdl
         zxfYqe/p3jGCtYwdJ4sRLQm5six1rG7cX5mKxhPht8uU0obHwpx+Jgw1lrFk61rTonfH
         ikaaLz7mqq/m89C9C8A/LXRsdGoGxOq7YD4bVTf2RqyjvMQnjd4cHpG0qSrk4gEFaz1O
         oJKQ==
X-Gm-Message-State: AJcUukfTp1Dl86kXQhXqGVa1uawhZ1o9pfLlE1hRte/E/xb93lAccDWI
        rIL2zCOpmVt5mRnlHRBbPC70RG83cD0=
X-Google-Smtp-Source: ALg8bN7kPtFUbdgWEFCeNmY9VON6UM/W8sl0Lt6L2QohpEbaZy3YtrbPs+ynam1bxFAlleTO9F+cqg==
X-Received: by 2002:a67:41c2:: with SMTP id x63mr1640798vsf.185.1546989864743;
        Tue, 08 Jan 2019 15:24:24 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id y195sm23542761vkd.0.2019.01.08.15.24.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:24:23 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 185so1276828vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:24:23 -0800 (PST)
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr1289532vkh.92.1546989862868;
 Tue, 08 Jan 2019 15:24:22 -0800 (PST)
MIME-Version: 1.0
References: <154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154690327057.676627.18166704439241470885.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGXu5jLGkfHax86C-M9ya05ojPwwKrpDL90k3gfAqxKc_emKpA@mail.gmail.com> <CAPcyv4h-Qce3-+Ragh5+0hzDvhCbV5YhNhzsnT0+dqnxR0bSzQ@mail.gmail.com>
In-Reply-To: <CAPcyv4h-Qce3-+Ragh5+0hzDvhCbV5YhNhzsnT0+dqnxR0bSzQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 15:24:11 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLVB6EKETqnKAwjtDYYXj9kjccb6HbFcghmxt8E1Qxq=g@mail.gmail.com>
Message-ID: <CAGXu5jLVB6EKETqnKAwjtDYYXj9kjccb6HbFcghmxt8E1Qxq=g@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 5:48 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Jan 7, 2019 at 4:19 PM Kees Cook <keescook@chromium.org> wrote:
> > Why does this need ACPI_NUMA? (e.g. why can't I use this on a non-ACPI
> > arm64 system?)
>
> I was thinking this would be expanded for each platform-type that will
> implement the auto-detect capability. However, there really is no
> direct dependency and if you wanted to just use the command line
> switch that should be allowed on any platform.
>
> I'll delete this dependency for v8, but I'll hold off on that posting
> awaiting feedback from mm folks.

Okay, cool. I'm glad there wasn't a real dep. :)

> > > +static bool shuffle_param;
> > > +extern int shuffle_show(char *buffer, const struct kernel_param *kp)
> > > +{
> > > +       return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
> > > +                       ? 'Y' : 'N');
> > > +}
> > > +static int shuffle_store(const char *val, const struct kernel_param *kp)
> > > +{
> > > +       int rc = param_set_bool(val, kp);
> > > +
> > > +       if (rc < 0)
> > > +               return rc;
> > > +       if (shuffle_param)
> > > +               page_alloc_shuffle(SHUFFLE_ENABLE);
> > > +       else
> > > +               page_alloc_shuffle(SHUFFLE_FORCE_DISABLE);
> > > +       return 0;
> > > +}
> > > +module_param_call(shuffle, shuffle_store, shuffle_show, &shuffle_param, 0400);
> >
> > If this is 0400, you don't intend it to be changed after boot. If it's
> > supposed to be immutable, why not make these __init calls?
>
> It's not changeable after boot, but it's still readable after boot.
> This is there to allow interrogation of whether shuffling is in-effect
> at runtime.

In that case, can you make all the runtime-immutable things __ro_after_init?

> > > +                               ALIGN_DOWN(get_random_long() % z->spanned_pages,
> > > +                                               order_pages);
> >
> > How late in the boot process does this happen, btw?
>
> This happens early at mem_init() before the software rng is initialized.
>
> > Do we get warnings
> > from the RNG about early usage?
>
> Yes, it would trigger on some platforms. It does not on my test system
> because I'm running on an arch_get_random_long() enabled system.

Okay, cool. :)

-- 
Kees Cook
