Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BBCECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369A020831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY7gWz3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369A020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJ1RhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 13:37:18 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42878 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeJ1RhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 13:37:17 -0400
Received: by mail-vk1-f195.google.com with SMTP id m199-v6so1307102vke.9;
        Sun, 28 Oct 2018 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=edOEPFu2hUuTHLe8EzWt1WURON1HOvXRbGkSjRgd1zU=;
        b=lY7gWz3REH0AbS5NoaawM25yTD65+1DCkpHUPRojAy5HZ4Je58EXEGFta1mbd+EfnW
         /TKbxQa61tkAp12Zd8SzZkApzPKGaobit7cskXNgH1xGHUtA0MgCtrZdBUkQq9jkJ1eL
         kd82TO7YwkRyrcao9/uavb1n6JEj6zjyq2oJY24Y8Fv+buO3EuqbMwU35hTXjf+4U6+H
         4LeYTWsBrGhay7MvdjpTrOE5lqIJXxChlfj1HHpHNqjiuul+vxopxNnCfDIQqidOwJuz
         /osI+nJ/kr2bU1abqORHozWmkIco1RxdvEiRWSuHdRD4bUqGpaRRNy6AKDLJ9t0vgibR
         aAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=edOEPFu2hUuTHLe8EzWt1WURON1HOvXRbGkSjRgd1zU=;
        b=mgCmrf0oyWdA40/W+xQZmih49CPhCDioV/khKMvuq2kP2h8YdjyTKhV7ylHCPPYnIg
         kB9+3P3qPEU49Q/Gve02UnkCru6eRSHjZDd5evQopV1mi6f2qcczGK2yU7zNzfi0yCPj
         T69GAZ2mrjhdmYG9ustXBkVnF5zDT2r8QIlBUfDJM+TYQLsq4sJmPJSJ/ukP+yetoZu/
         bK3gNTs6BpBgZ5PEoFRHHi6830PVEKEEe19mciG956mexRiehg7bLAwbiqGKcWQhJxHc
         m8AvbH/2Cy0qL6UAurgksUlzUj5Z6phF1oAGA+OfOEdqbzxUlnH1fag4Ei9KPLBv53c8
         +06Q==
X-Gm-Message-State: AGRZ1gLDdDlbh0d6cxpnG9jlnL6/FrejQuGleA4dAZUe+XG/W/BM1ReG
        5NjJNupfDK2WPj2xovvABZtJd8cnmrxCA6BGhw==
X-Google-Smtp-Source: AJdET5cuhvzcTKc7xgXIfq+IBKof44KRBaRT0wbg2/UpdFwlHHOBHUX0zlOY+TFpwAaW/wvQG72pkf2R0vmv/aspiFA=
X-Received: by 2002:a1f:850a:: with SMTP id h10-v6mr4343101vkd.4.1540716795443;
 Sun, 28 Oct 2018 01:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
 <20181026062743.GA21483@ming.t460p> <CALjTZvaAc1HBXWHuhaCMsWwJLZEvPy_gvX2U2Lzcj6iVVktWNQ@mail.gmail.com>
 <20181028010156.GB26731@ming.t460p>
In-Reply-To: <20181028010156.GB26731@ming.t460p>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Sun, 28 Oct 2018 08:53:03 +0000
Message-ID: <CALjTZvZtmTCvLQph95rNQk73L23h=1QaODny_ZOf9F1MjcsMFQ@mail.gmail.com>
Subject: Re: Bug: swap discard issue with zram caused by "block: don't deal
 with discard limit in blkdev_issue_discard()"
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018 at 01:02, Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Oct 26, 2018 at 08:50:20AM +0100, Rui Salvaterra wrote:
> > On Fri, 26 Oct 2018 at 07:27, Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > The patch titled with 'block: make sure discard bio is aligned with l=
ogical block size'
> > > in the list may fix this issue, please test and see if it works.
> > >
> > > Thanks,
> > > Ming
> >
> > Hi, Ming,
> >
> > Thanks for the quick reply. Unfortunately, it doesn't seem to apply
> > cleanly to 4.19. To which tree/tag/commit should I apply the series?
>
> The whole patchset is against linus tree (44786880df196a4200).
>
> I am sure that the 1st patch can be applied cleanly against v4.19, and
> it is enough for fixing this issue, please double check.
>
> [ming@ming linux]$ git log --oneline -1
> 84df9525b0c2 Linux 4.19
> [ming@ming linux]$ git am ~/emails/blk/181026\ \[PATCH\ 1=E2=88=953\]\ bl=
ock\:\ make\ sure\ discard\ bio\ is\ aligned\ with\ logical\ block\ size.em=
l
> Applying: block: make sure discard bio is aligned with logical block size
> [ming@ming linux]$
>
>
> Thanks,
> Ming

Hi, Ming,

You're, right, of course. I had reverted the aforementioned commit, so
the patch set obviously wouldn't apply anymore. After checking out
v4.19 again, everything went smoothly. I confirm the patch set fixes
the issue for me, which means this series is

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks again,

Rui
