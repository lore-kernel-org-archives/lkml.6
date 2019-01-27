Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DDCC282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14B7217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfA0ImS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 03:42:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37664 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfA0ImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 03:42:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so9739488lfj.4;
        Sun, 27 Jan 2019 00:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9FTIfDASsMNAYoIZcyHR5mRcG34dUMfrhjEUxRl4eU4=;
        b=iTqN5HQsJJ5reWIOXzEvYvUjv/+x/tkAF38jl9+5peNCG0Djs14/RJqWNsHlO3n+4I
         bCq34RKK2x5uZyJt34gs2kWncq3d00o/0mgvXdfd9jhGrcwVKw6UgJYQ2AWuOfXlLFIP
         +RZRcLqRhsT0pwM+JFC/WahTRZV2Av6Y0kPKozzsXwSbSb3iRd1z9/cuTMXTS82q3+CI
         KHE+d7P15qqZfHBe7PMNKczMGf4YCIWmD1k0pCcXOJsHEScovf1meeyoUR5F586NMaTi
         V1CYTqUokPkSEG6xpfKa5mJG71qtyxqx0ZRxHEyBRWAJ06QGlGuhDfUNibmrZMa4YU36
         lGQg==
X-Gm-Message-State: AJcUukcsVo9RWwBHIJOy6kyPgIOiCOdCeOC/fLvx0RzbDphEySYUewsE
        rYgGBH46GLy3GOEoUrT+XHA0LpzYsQ3NVLjs4H8=
X-Google-Smtp-Source: ALg8bN6IRanYeWVdhlr5VIpgUzY0XYiYg7rf1MNr1y38ICzr3BpctjunBH53m85XTk+Rm5vi0D4SUFRNlsnB91TGf0c=
X-Received: by 2002:a19:f705:: with SMTP id z5mr14253624lfe.158.1548578532918;
 Sun, 27 Jan 2019 00:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20181210235156.6237-1-natechancellor@gmail.com> <20190126191143.GB25003@archlinux-ryzen>
In-Reply-To: <20190126191143.GB25003@archlinux-ryzen>
From:   Masanori Goto <gotom@debian.or.jp>
Date:   Sun, 27 Jan 2019 17:42:01 +0900
Message-ID: <CALZLnaEkikS6Yv-PR-kBpnrCRrn9A8yHg+ZYGXkq+d_JQvR23g@mail.gmail.com>
Subject: Re: [PATCH] scsi: nsp32: Remove unnecessary self assignment in nsp32_set_sync_entry
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix!

2019年1月27日(日) 4:11 Nathan Chancellor <natechancellor@gmail.com>:
>
> On Mon, Dec 10, 2018 at 04:51:56PM -0700, Nathan Chancellor wrote:
> > Clang warns:
> >
> > drivers/scsi/nsp32.c:2444:14: warning: explicitly assigning value of
> > variable of type 'unsigned char' to itself [-Wself-assign]
> >         offset      = offset;
> >         ~~~~~~      ^
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: GOTO Masanori <gotom@debian.or.jp>

> > ---
> >  drivers/scsi/nsp32.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
> > index 5aac3e801903..7ce6e7acf2f3 100644
> > --- a/drivers/scsi/nsp32.c
> > +++ b/drivers/scsi/nsp32.c
> > @@ -2441,7 +2441,6 @@ static void nsp32_set_sync_entry(nsp32_hw_data *data,
> >
> >       period      = data->synct[entry].period_num;
> >       ackwidth    = data->synct[entry].ackwidth;
> > -     offset      = offset;
> >       sample_rate = data->synct[entry].sample_rate;
> >
> >       target->syncreg    = TO_SYNCREG(period, offset);
> > --
> > 2.20.0
> >
>
> Ping?
