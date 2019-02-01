Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E2EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532C920870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO3gTIgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfBAMlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:41:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43319 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfBAMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:41:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so5642109lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iODfpulofSvICmUrVD6LE9v57Ag6LMIWvsLhakZo+v4=;
        b=KO3gTIgy1VLS/nKUjaD6txQVMHuZjdAM92FM8tGlN4Og83T2J0f8vLaBpfI3uzM2KV
         iwKsxWBYz07V0PC+zODfTxA0pxxmrOLk30w6DkvSkmD1f2IKzZuk/SbG+N5QMsg41EaN
         2uejdYzKPA6gn9pSBGdCMKg4CSsN+qVcV6SoPWsjOPlLnMYEoEA4hhkX/V/sPIkaa346
         SQ2F2dPIaNhIKPt5l1oMyc/g8h+JqVW0KbpRAF6/ooM922qYrIKL2TQOIDJCy9gduytN
         9gKXq10HW8jpWJcy3Yg1vwn1kKF/aTrRj7DiYnjbzNs2qcfumrT2H0wsm7PNuoYFkVJt
         hLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iODfpulofSvICmUrVD6LE9v57Ag6LMIWvsLhakZo+v4=;
        b=IYgaFLWU1QPp9crEUQiX9mkz/Yti9utSCSSc5XfmvJcaPnqCj9B0PjkbdKctSBXqXl
         McYafbN1d38u2X8zeKJskk2M1BSggrlJ262GiQtG5Y2SZtBH3d0lc0G3d+IygY1cePkR
         MglZ2yCsx6n8i7lVeGIhgVz7dzdSIJ06bgl+b4Bw6IN5u5v0aqj0A6ciQTrxSf4jOXcS
         riyewzKMkc05Lxf36xKdenLJB1RkdIGG5B8/9EqG6sYdM+AHLpBa2ys8GbuKZdSBVZdB
         P9rFOlpk+KORkH2WmmpH3AqZDbC7M3b6KH3bXGxI4MzseKMZtNQtbIucs+nOhoY4dBSL
         KYBA==
X-Gm-Message-State: AJcUukf2qH1HGiA0tmz7YiTe7F4fD5eyEKoqfZnG3QolI/a448yl9eyx
        0wffFzneMgD9FnnV1Rt4dbt6foWxIrNg+jv17Jo=
X-Google-Smtp-Source: ALg8bN5knmz7SeCBsrXwu1a1gQWzHOdKxmYWL/9m3A67SexQtbd9pPoSNgF8BKtCyS1xodcsPSYJhCngOahTYTQEyDc=
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr30283823ljg.155.1549024894063;
 Fri, 01 Feb 2019 04:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
 <20190117112803.GC3710@rapoport-lnx> <CAFqt6zb-+hmF-zOrs-_J=m+YZO-R-VdwWKErYVHqtNcShk7sPA@mail.gmail.com>
 <10982a2f-8ff0-50f4-cdce-d028808d188f@arm.com> <CAFqt6zYE9Mv0Y+pfOtbOWeT5+AxPaJWB9_pkD5VO+pZVs-dF3w@mail.gmail.com>
 <001c1195-fe06-fc78-b8a9-ec96f44aef32@arm.com>
In-Reply-To: <001c1195-fe06-fc78-b8a9-ec96f44aef32@arm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 1 Feb 2019 18:11:21 +0530
Message-ID: <CAFqt6zae+8-TLaWEmgyLEVCbsy2cbeFg35SxH5r1kHYu6rrybw@mail.gmail.com>
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

On Fri, Feb 1, 2019 at 6:06 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> On 2/1/19 12:32 PM, Souptick Joarder wrote:
> > On Thu, Jan 31, 2019 at 6:28 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> >>
> >> Hi Souptick,
> >>
> >> On 1/31/19 5:54 AM, Souptick Joarder wrote:
> >>> On Thu, Jan 17, 2019 at 4:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>>>
> >>>> On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
> >>>>> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>>>>>
> >>>>>> Remove duplicate headers which are included twice.
> >>>>>>
> >>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>>>
> >>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> >>>>
> >>>>> Any comment on this patch ?
> >>>
> >>> If no further comment, can we get this patch in queue for 5.1 ?
> >>
> >> I'd be nice to use proper tags in subject
> >> line. I'd suggest
> >>
> >> [PATCH] ARM: mm: Remove duplicate header
> >>
> >> but you can get some inspiration form
> >>
> >> git log --oneline --no-merges arch/arm/mm/
> >>
> >> In case you want to route it via ARM tree you need to drop it into
> >> Russell's patch system [1].
> >
> > How to drop it to Russell's patch system other than posting it to
> > mailing list ? I don't know.
>
> https://www.armlinux.org.uk/developer/patches/info.php

This link is not reachable.

>
> Vladimir
>
> >>
> >> [1] https://www.armlinux.org.uk/developer/patches/
> >>
> >> Cheers
> >> Vladimir
> >
>
