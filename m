Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A614BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FF02082C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og7ObeOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfBAMc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:32:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32926 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBAMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:32:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so5690690ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rNxm2fv00ManwVnsYnyLFJNBjAatMdZ/RRWb7HrcS0=;
        b=og7ObeOmE/rEjMmdDhJyK7r2CVRFrtebvUKXSvR9be/BPVzwmaWFqEcBrUZlH9tWb3
         tfzBNYLwgKuPHKRhHLBMb6Fs9YFY//W+56B4V5KMxkLxNiK9rFR0C4Waw8DlwcL9HubT
         ZO/fwRiSCr4Mlfz9FNrgnP3kxe3F68tiG1VO4XzvefWNU8IlLzIbV6g7rGenAciEL9U+
         Tf+FN1edZ+Hehg5jrmtgBswKC9QVbmMvVM+U6lV7nDDtAV+SLaCflUQg/IchoywCNfMj
         UaOBw02VyV3JobLYV5hnD3AiZWoVNRcOUJ1wNR+Uje609GWu2fKbQaow/nGicEZDqrD6
         +fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rNxm2fv00ManwVnsYnyLFJNBjAatMdZ/RRWb7HrcS0=;
        b=PQ+QSrhHFJ0BmzpZyAw7ULExCccal1VO5ObrJ4HJJ3TyIDFI4KEiXxQiJwZ0OGHvVh
         3pmJVeapVV8BNZjWp1u4JtBSXzUh3jNQEI99VVIlh+NExcbCBXcYb4mZw8NtlqFFLpGi
         bFJQPRkfe+MHy+u+uoCLPbt+jG8PkQoYdPsP5mNFnC+KZzg4iCCk3lmgDP7xMQ1/3oGv
         ZzyKAtMNP48A3vhRwcJ+vvFbpBZ9EW585+RNHbAbXfq4PFqR2QJy8mueCBgUCWf9fMWw
         KS+UYL/hRGZQerkKLjo493oM5g7LgJ95JhqNlMfqydW/BBoKkOFqSSl5BrtCPz6p86cv
         ygYw==
X-Gm-Message-State: AJcUukfkcVMTJ+/VQjMBK5LKXgZcPXTE2Ck+DNDqg4wzMulGJ0rs3N1Y
        pf72EoQ/FqSWJvbCEns/9KXxON8gRUv8n/S6RRI=
X-Google-Smtp-Source: ALg8bN7uCET9Pxh7PdClRvWI1wL7udB1yOPIgy9+apCkHsgcW+pd7YxPrG5MgM7cuIz7h9xLe6unO8yJDmuH8LUL5Zg=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr31169671ljj.9.1549024344032;
 Fri, 01 Feb 2019 04:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
 <20190117112803.GC3710@rapoport-lnx> <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
 <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
In-Reply-To: <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 1 Feb 2019 18:02:12 +0530
Message-ID: <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
Subject: Re:
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@suse.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, rppt@linux.vnet.ibm.com,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 6:28 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> Hi Souptick,
>
> On 1/31/19 5:54 AM, Souptick Joarder wrote:
> > On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>
> >> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
> >>> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>>>
> >>>> Remove duplicate headers which are included twice.
> >>>>
> >>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>
> >> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> >>
> >>> Any comment on this patch ?
> >
> > If no further comment, can we get this patch in queue for 5.1 ?
>
> I'd be nice to use proper tags in subject
> line. I'd suggest
>
> [PATCH] ARM: mm: Remove duplicate header
>
> but you can get some inspiration form
>
> git log --oneline --no-merges arch/arm/mm/
>
> In case you want to route it via ARM tree you need to drop it into
> Russell's patch system [1].

How to drop it to Russell's patch system other than posting it to
mailing list ? I don't know.
>
> [1] https://www.armlinux.org.uk/developer/patches/
>
> Cheers
> Vladimir
