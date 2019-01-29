Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DF9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3882087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBjc++dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfA2WLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:11:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45584 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2WLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:11:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so24064003qtr.12;
        Tue, 29 Jan 2019 14:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5K8WJ497OEbzhCMQuUAs1/V6j9aK7iw5NuKf4Sftrds=;
        b=pBjc++dhCTOkOtktu2T1X3krQ7HfE68QIO096b8soqiw/Gm2qcLI6ZdxFeRv5oFciC
         sycwG5Iuv2PJEsnm4fZzDVBSC6R3rK7S0CPfbSHzMEGwYj2EhhePuw7lmzyftX5zO3xd
         /c4/fBHYTGKKckfxu5sLtJu7awxNsPGn+4vD/8PgCZh6ekreMrjyMTcgZ6e38bb3ByDL
         UPs67YL5nOmRa1YYjSBJtV+s9lYMkB1IE1tiuWYR4v7jX7wRCbzpT+1bTJMIBqpoXTY/
         oCCPJEV+lAFnqpTEK9GkYhsirZ88rCGSFGtJ6MwZM8znc4JOrXLVRejSVy+KB7H8YiLE
         p2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5K8WJ497OEbzhCMQuUAs1/V6j9aK7iw5NuKf4Sftrds=;
        b=q2pK0qEBzbrbJnXUgd9xiEuiH4nNlYS+VFKImKNfJhuxzwrGLF055GYotM3yWtWlgN
         z8bTT15c8PH0YHUuLAil1iZEyHS1jSIKOZNu3vvx3G8ykbRwAbq3SEJbERrHMm7AWBmA
         MnXsmOKnEv2SeVxv2Hp+1RyHTbjBUeQC3LOESNU6k3Ww+RhESYyu2EBMJWtLV/q20sm4
         Ai/5xGdPU6Cmc21XZKbJWVs2iqEv7LG0U7hQAvrqVyur6kcK/WmCkiTFzRfWCdAKWFtn
         RVz62we6Bh02o4UnSzwEgd3wzP1sHE937rFJK72+UWY06LItkJQkWAbEcEkrsNJOmyk9
         Uy5g==
X-Gm-Message-State: AJcUukckAHpumpSzU7DW5lUDLbAloa0DrX9uKO3K3VAm/80+UwzL5lzL
        OPiSfW2r8KZUesBJcDqXj0nUgc77ZlXFVG1Tk0U=
X-Google-Smtp-Source: ALg8bN4ssvrZiKcDk/+Ym5ydL+N+V7gYMeNumxnluhGIZqELD3StwS9a37LPzXgRih72Tc4ZMCG+hm4ndxrS3ereFC8=
X-Received: by 2002:ac8:4611:: with SMTP id p17mr28395390qtn.263.1548799865207;
 Tue, 29 Jan 2019 14:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20190107174538.GA7255@embeddedor> <CAPhsuW7a_F_K1cJdrGHLhnuCdpeN365n1BG-QawmxKWaZajGeA@mail.gmail.com>
 <caff2263-fb7d-257c-f7f2-cca6c537f597@embeddedor.com>
In-Reply-To: <caff2263-fb7d-257c-f7f2-cca6c537f597@embeddedor.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 29 Jan 2019 14:10:53 -0800
Message-ID: <CAPhsuW4dZYmiBvnrs=SNkAM4EByxiaB2hE3X6n9HFr6e+Ze=zA@mail.gmail.com>
Subject: Re: [PATCH] md-linear: use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Shaohua Li <shli@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will take it, and send pull request.

Thanks,
Song

On Tue, Jan 29, 2019 at 9:22 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Friendly ping:
>
> Who can take this?
>
> Thanks
> --
> Gustavo
>
> On 1/7/19 5:01 PM, Song Liu wrote:
> > On Mon, Jan 7, 2019 at 10:35 AM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> >>
> >> One of the more common cases of allocation size calculations is finding the
> >> size of a structure that has a zero-sized array at the end, along with memory
> >> for some number of elements for that array. For example:
> >>
> >> struct foo {
> >>     int stuff;
> >>     void *entry[];
> >> };
> >>
> >> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> >>
> >> Instead of leaving these open-coded and prone to type mistakes, we can now
> >> use the new struct_size() helper:
> >>
> >> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> >>
> >> This code was detected with the help of Coccinelle.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >
> > Acked-by: Song Liu <songliubraving@fb.com>
> >
> >> ---
> >>  drivers/md/md-linear.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
> >> index d45c697c0ebe..5998d78aa189 100644
> >> --- a/drivers/md/md-linear.c
> >> +++ b/drivers/md/md-linear.c
> >> @@ -96,8 +96,7 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
> >>         int i, cnt;
> >>         bool discard_supported = false;
> >>
> >> -       conf = kzalloc (sizeof (*conf) + raid_disks*sizeof(struct dev_info),
> >> -                       GFP_KERNEL);
> >> +       conf = kzalloc(struct_size(conf, disks, raid_disks), GFP_KERNEL);
> >>         if (!conf)
> >>                 return NULL;
> >>
> >> --
> >> 2.20.1
> >>
