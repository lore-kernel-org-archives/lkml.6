Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E4EC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E22084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMDiUHrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0E22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeLKUr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:47:57 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:35139 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKUrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:47:55 -0500
Received: by mail-it1-f175.google.com with SMTP id p197so6258320itp.0;
        Tue, 11 Dec 2018 12:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFfcjpB1lELVQyW5+K68sMdDDx4aWAo66XaeR9Q0OzE=;
        b=fMDiUHrVHXWDnInT48lONdwAKkBzopuGGUl4N2HtxQu+umcXxXDB78fpBcYF/JCPM9
         HCQAH5P3MW4mM2T4eMBmZTvFK6a3DFpckmpsz119mbXjJ5K+nDWTmAr/CeBWwpkT/SdW
         CPn1C3HWixdjAUDMQuDnW5lR9l0EpBLBf/e9rGgykdZM/RXK+FMVWgm7IhRAr7sv9izF
         tIWG9Er2FpOo5zydQ998qHyWrTynlnlE324UlFg7U1F5OlXgs/21C9WcUYq5EXX/Zstq
         5y2YxgrgruKsEQZcPHeFuVdrpBUliMzyYfa2M0AEcWeM7qIA2S8Fyh0lhRPBISsyUmdQ
         6pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFfcjpB1lELVQyW5+K68sMdDDx4aWAo66XaeR9Q0OzE=;
        b=AYk7OZ4HhzdSthc0oHnpqnIYHYyy3tv9lZFiGM4wQLB9WVMvlF5sD3QM6EVpJVwUte
         WklsgM+SAAJt9RhpsvseltfsUTxVmvLTK7yYyrx+3/lJnwvFc4WC7TG7R68j/L3XGHDo
         F5rNWB8sounanx1dpg9lcpYbxwzryD8FruBHLeOZFGkA+GUNhUoNr2mzk++TWdKD684d
         5BH/sLg/EwDqLAjhEO79xe9EpoPiKmj+E75niEikaFLTgGw9Ni6ae48PFqO6Blt0PhE+
         Fbc5i3+71WEwyYi5PYZumpF6umSmbGST2LPqH71Ap/R1FhdW41B0mN3jgEvDvdTr5Mhc
         5cIA==
X-Gm-Message-State: AA+aEWZ8/FD7pl85bzoGK5ZNQx82OCKOznEF5GLoDpo8xorW0mzTlKpD
        5mrMjZvFN4NTRAe72VndAMZXFAt6NaZOVQOAsEE=
X-Google-Smtp-Source: AFSGD/Vd9/DBT66njqUM2R88beejHJBU5RAPs5gd2KUPqgWDV5pzPhBctvV3vjWp9uZQXahsdmvQA/+LKZczLcJFjvo=
X-Received: by 2002:a24:2912:: with SMTP id p18mr3567405itp.16.1544561275032;
 Tue, 11 Dec 2018 12:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20181212072402.7b967df7@canb.auug.org.au> <20181212073802.2fc8dc53@canb.auug.org.au>
In-Reply-To: <20181212073802.2fc8dc53@canb.auug.org.au>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 11 Dec 2018 21:47:43 +0100
Message-ID: <CAHpGcM+wCSrj0pk89ZoMENp+L_zSXbSFhEJcsdDEOh1F-GmGvg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the gfs2 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Di., 11. Dez. 2018 um 21:40 Uhr schrieb Stephen Rothwell
<sfr@canb.auug.org.au>:
> Hi all,
>
> On Wed, 12 Dec 2018 07:24:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Commit
> >
> >   ec702fa79702 ("gfs2: Dump nrpages for inodes and their glocks")
> >
> > is missing a Signed-off-by from its committer.
>
> Now, after the rebase:
>
> Commits
>
>   187e4dad3f55 ("gfs2: Remove vestigial bd_ops")
>
> is missing a Signed-off-by from its committer.

Yep, I've not asked for a way to get the server to reject or warn
about such pushes without a reason.

Thanks,
Andreas
