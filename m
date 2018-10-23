Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2740C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A714F2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2UMzSG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A714F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJWPdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:33:39 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46948 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeJWPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:33:39 -0400
Received: by mail-yb1-f194.google.com with SMTP id o8-v6so123613ybk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAUoW4GPMceex9vKPnxYK5d2K6OG73bxqiDXkLVgDpI=;
        b=c2UMzSG/4b6FgoZJ5pABqK/m8ll3XNqCNGSupB0N1Z90jdOJwlXjzcxb4AhLywVVhL
         eGrfdnMD9FnnN3vr3CioHZnUsQ7rCmUA1IBvOHUHhMbwPWu22zj/VQ7hLpnl8SJ/nHKT
         y/EE4YzZEALyQjNfj4FlfmnOxCDQNrWAmdr0z5rkTkfC68RmWBORYE8jFI9aTur/ZsDd
         p6cI7iG9H24awBgLxSFpdyb9KvrJnlAU1jx9D1CGXoiYzYQPpQJj3RtLQuRiN7H5VVsC
         RFzJfDVswKZs7VQ9E9qsi444vhuC4wucOZttBI1u8/m/FDc1epV2cmi0Sh//MoAF8rJ5
         98uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAUoW4GPMceex9vKPnxYK5d2K6OG73bxqiDXkLVgDpI=;
        b=fJF0Toi/ocnITHe0dR4j9abHiFfT11AlLc04HqVZOfuU1CZqnFVVg8ZZzQZ40rE8bt
         GPthJHZINdOWT9TH21isdUDMdPMcEyhNejFDSXevR9VNWEDzSfpTOol7S1SHcMzaGpI0
         7Cf8bK8jhfx/kv1EjwVr43aWwJuIwd6Yd7vhLpdYgNAvaD6/oZWp5ue63zXLbf6pu9Zi
         FBhYYzid6knUdu+mfijgVoMB59xr0/F0gv9iKF8mYi/TRvGheQ7WRIvBzjCZug7CiJHq
         y/q53rQ6gZ/WaYvrMvNunmklufinoUQj9h0GDybPRhQ0Le/UJHhnIjrYCGsY9Wht0yJa
         Ka/g==
X-Gm-Message-State: ABuFfohpBjvxVCLW/y7zW+7sxMOjlbAN17vAQiqIcIL8uRC9hyj4z7sy
        MP99IlcZrujQSczMB3K7suDVeBGlxHOqaclFUFE=
X-Google-Smtp-Source: ACcGV61vFOr6fdZ6LyedC7mAu/vunW/cF4UiYIwNOByqnQDGrNzVmqLHZRkBIMp8jSbrLM6noSfzN+NafDIfl9LNufQ=
X-Received: by 2002:a25:3c7:: with SMTP id 190-v6mr34754584ybd.457.1540278691334;
 Tue, 23 Oct 2018 00:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <20181022181122.GK18839@dhcp22.suse.cz> <CABOM9Zpq41Ox8wQvsNjgfCtwuqh6CnyeW1B09DWa1TQN+JKf0w@mail.gmail.com>
 <20181023053359.GL18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810230711220.2343@hadrien>
In-Reply-To: <alpine.DEB.2.21.1810230711220.2343@hadrien>
From:   Arun Sudhilal <getarunks@gmail.com>
Date:   Tue, 23 Oct 2018 12:41:19 +0530
Message-ID: <CABOM9Zr48HTphfbmk9v7a3A+cqzrAFZT71pEyvvseV8PpbWOhg@mail.gmail.com>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
To:     julia.lawall@lip6.fr
Cc:     mhocko@kernel.org, arunks@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        minchan@kernel.org, mhocko@suse.com, gregkh@linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 12:11 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Tue, 23 Oct 2018, Michal Hocko wrote:
>
> > [Trimmed CC list + Julia - there is indeed no need to CC everybody maintain a
> > file you are updating for the change like this]
> >
> > On Tue 23-10-18 10:16:51, Arun Sudhilal wrote:
> > > On Mon, Oct 22, 2018 at 11:41 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Mon 22-10-18 22:53:22, Arun KS wrote:
> > > > > Remove managed_page_count_lock spinlock and instead use atomic
> > > > > variables.
> > > >
> > >
> > > Hello Michal,
> > > > I assume this has been auto-generated. If yes, it would be better to
> > > > mention the script so that people can review it and regenerate for
> > > > comparision. Such a large change is hard to review manually.
> > >
> > > Changes were made partially with script.  For totalram_pages and
> > > totalhigh_pages,
> > >
> > > find dir -type f -exec sed -i
> > > 's/totalram_pages/atomic_long_read(\&totalram_pages)/g' {} \;
> > > find dir -type f -exec sed -i
> > > 's/totalhigh_pages/atomic_long_read(\&totalhigh_pages)/g' {} \;
> > >
> > > For managed_pages it was mostly manual edits after using,
> > > find mm/ -type f -exec sed -i
> > > 's/zone->managed_pages/atomic_long_read(\&zone->managed_pages)/g' {}
> > > \;
> >
> > I guess we should be able to use coccinelle for this kind of change and
> > reduce the amount of manual intervention to absolute minimum.
>
> Coccinelle looks like it would be desirable, especially in case the word
> zone is not always used.
>
> Arun, please feel free to contact me if you want to try it and need help.

Thanks Julia. I m starting with,
http://coccinelle.lip6.fr/papers/backport_edcc15.pdf

Regards,
Arun
>
> julia
