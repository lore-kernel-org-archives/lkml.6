Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4600EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61422082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCyaDDCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61422082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeIDTBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:01:48 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45397 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeIDTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:01:48 -0400
Received: by mail-ua1-f67.google.com with SMTP id q7-v6so3017121uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3R2iG+GOambTEXBDTya2Rwi0UEeTJD5Hpk1vs+OVSU=;
        b=UCyaDDCD0col5RsSFwd17K5SwCiXXUFcW/3Dziu+9NyJRUTIEfKmQFC7k0W62iyWJA
         ctC3fkhNY15cUlHV7I152cOW11iC4e1Puzj8S1yCOKowm2XtxEmBWbRuQ+gVG3amcatw
         lBWahvAyddU5VPb0r6wEGVuqo+W1ZzCLhU7dZEPnHG8F0Ceo4scCZHWxFu8yJ5A/uNE8
         OKYNzBFDvwsFqlTPCmZEQGHLDVeNYUradeZDFvCbcuWEiYTgMeDSYGsrgdcVf+bF+3Pi
         tqO6RtYF19LkvOqcZ3X4sqs6BgZ30Eidkw4Ceva7n5pE6q4SQD7LUkzUZTdCmcxaU/jT
         q1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3R2iG+GOambTEXBDTya2Rwi0UEeTJD5Hpk1vs+OVSU=;
        b=bXQZheTCnjMOLKntbRRek89Xb2s8L/WGcDPG/bIMdq1o5Y1uTgf8U8upM4v5Pw1xx0
         xGtDXY14zo6Om+8RvbnoY4GDhlc/o0IeP64P+2MUW24xYrQ3Ap2H+jvwQUqwh0KHxy3q
         LiAdYsLSgNpKWH5XaCIgt0XdcOI1P84A1n8SwCwcSnL5o7qGZxBFdrp06pULootIvpID
         KDq8BdFp4p8Zt2dCtClAPZ22eZykKOsUr2JfYq+HBdRPgxKhhD3qKu6IxElp8bCZxDnI
         KAPD/YLw3eqVm9/4cuPoPJO3Kx3jqXzPlpDlvytvf43OPtJUHHhj/Ao7CdA4G8yPHiSZ
         tZCQ==
X-Gm-Message-State: APzg51BVbpBDWNjTDoAmHAJsljQcJQaVRGu6mooulk8e/YQViGRW50zn
        VIrBr9nA6bKL5G4i/o0rEDzl/51zcFzpnOOKyrE=
X-Google-Smtp-Source: ANB0Vdbs0dulbSt7X4AEwgSaKqLDdUqTUydl49NgvAzJJuvdWXnsUXQbTCPGNo7V0PTQ+n1LyFUkeM8nqbPUyGvm9Z4=
X-Received: by 2002:a9f:318a:: with SMTP id v10-v6mr18341675uad.36.1536071785528;
 Tue, 04 Sep 2018 07:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180810100806.9298-1-yuchao0@huawei.com> <20180814041329.GB52730@jaegeuk-macbookpro.roam.corp.google.com>
 <8dd153c2-5611-728b-e4a9-0c59486f53a4@huawei.com>
In-Reply-To: <8dd153c2-5611-728b-e4a9-0c59486f53a4@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Tue, 4 Sep 2018 23:36:14 +0900
Message-ID: <CAD14+f15yadDMY-fwSW5TVHRF1JAz-8kKocN0t258H7c1CTDAw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: set 4KB discard granularity by default
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering what would be the negatives on reducing the discard granularity
other than making discard more aggressive(hence higher overhead and latency?).

Thanks.

On Tue, Aug 14, 2018 at 4:08 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> On 2018/8/14 12:13, Jaegeuk Kim wrote:
> > On 08/10, Chao Yu wrote:
> >> Small granularity (size < 64K) fragmentation will cause f2fs suspending
> >> all pending discards, result in performance regression, so let's set
> >> 4KB discard granularity by default.
> >>
> >> So that without fstrim, we also have the ability to avoid any performance
> >> regression caused by non-alignment mapping between fs and flash device.
> >
> > This is why we added a sysfs entry. Why do we need to change the default
> > value every time?
>
> Of course, I didn't forget it. But, mostly, our user didn't know very well about
> our filesystem including each configuration's meaning, mechanism, or usage
> scenario, most of the time, they will choose to test f2fs with all default
> option, and then make the conclusion.
>
> Currently, with default 64k granularity, if we simulate fragmentation scenario
> of filesystem, like by a)writing 4k file and b)deleting even indexing file, then
> all 4k discards won't be issued, result in exhaustion of free space of flash
> storage, and performance degradation.
>
> So I think we'd better to consider and set default value of configuration more
> elaborately to avoid obvious weakness.
>
> Thoughts?
>
> Thanks,
>
> >
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/f2fs.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 58431b9bfd8f..273ffdaf4891 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -248,7 +248,7 @@ struct discard_entry {
> >>  };
> >>
> >>  /* default discard granularity of inner discard thread, unit: block count */
> >> -#define DEFAULT_DISCARD_GRANULARITY         16
> >> +#define DEFAULT_DISCARD_GRANULARITY         1
> >>
> >>  /* max discard pend list number */
> >>  #define MAX_PLIST_NUM               512
> >> --
> >> 2.18.0.rc1
> >
> > .
> >
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
