Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E34ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48B42146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocYQzWyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48B42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeIREDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:03:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39264 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeIREDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:03:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so272073edi.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljM8VDjifPXTYQpHOjUd7Si1xgCriPj9wcI3wqoAR8c=;
        b=ocYQzWyzZd8A9nU8Iywxxsl87iZ3oHSR85pxYSiPa+rxPyrNF0ZmAKfnzOD4IuuwfW
         XPbVHYzG3ODUsWUSUny+TgzIL32dHWKUwMmfbKjN4k3o6uNOcpn34AAhMY0aXQIojFXQ
         NwVYPryYLyI7mqd5LhlbF+sTvcWTJtHZq6jP0QCWZgmehwr732BP79UHjoy8youP7o2E
         RAKmRpaSHTnADEJhdUaNM93ObfVcjoQ/70aFLONw+ITbjLXW/UGN6p+r1x8zcBkp3qhu
         jftZ5QiFpRdVmqIKSKeeV3cbIshLZniC2nOk2orA8ACKyacAHoAF3lI922wukMCpCDDV
         7+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljM8VDjifPXTYQpHOjUd7Si1xgCriPj9wcI3wqoAR8c=;
        b=LiHOqRIWHFq1+RzFIOOmvfaeuRG3efI2kUAqLylLABZk39sbK2DF1Ynk/7aiid3O8T
         8qFgcNir+PbNiBCjTwXqrX2waTJ/n65ubZNOQxKegHM2mDCFLyDAgjYLxFh3l2V3gL4A
         +eha0Xb7EIWAFxBszwP2uv8UH75z7VbrbLqz+Mi6Et01jRIGMrTnh98cQesMz/85DkK6
         CClmbKRgvGns/0UYbW5qONw75+ox3fxKM6U8BEoTglYFlskK527n3Uq8UGbfj3/GgKfQ
         b8O/cySBPOx5vsABct+i0lS/F5ZlLBMSSrGXbjCtYigoyAphCbd0/nz3uFuKq7ipVcrG
         nZgw==
X-Gm-Message-State: APzg51AhNQBmJLc0mqk+a0Jqq1HMdDj0YNYq/FNK70smCAeUV7/l8qPf
        YNy9kSnyGJEA85328wce5JyOtGKTsznkf62Nwrc=
X-Google-Smtp-Source: ANB0Vdb659TkXfUvzyx1M1xQSI9uhshUTM1GAic66SR3T5IC8m2Q7a0yJKToNZWYJk4TJ1DliI0PPc7VZELKDW5cDsA=
X-Received: by 2002:a50:ad5a:: with SMTP id z26-v6mr48144246edc.142.1537223666853;
 Mon, 17 Sep 2018 15:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536517047.git.lukas@wunner.de> <76fccab34a66023c08b71a864a9fea77daac9742.1536517047.git.lukas@wunner.de>
 <20180910093333.GI14465@lahna.fi.intel.com> <20180913085826.GC14465@lahna.fi.intel.com>
In-Reply-To: <20180913085826.GC14465@lahna.fi.intel.com>
From:   Andreas Noever <andreas.noever@gmail.com>
Date:   Tue, 18 Sep 2018 00:34:16 +0200
Message-ID: <CAMxnaaXbkWysZ2JbPTL7gmhq_MS5Ba1PJrzsXndjodH4X9WJOw@mail.gmail.com>
Subject: Re: [PATCH 5/5] MAINTAINERS: Add Lukas Wunner as co-maintainer of thunderbolt
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Jamet <michael.jamet@intel.com>, YehezkelShB@gmail.com,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:00 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Sep 10, 2018 at 12:33:33PM +0300, Mika Westerberg wrote:
> > Hi Lukas,
> >
> > I'm including Greg here in case I've done something wrong as a maintainer.
> > Since I've only maintained Thunderbolt quite short time, it may be that
> > I've done mistakes but certainly I did not deliberately try to make life of
> > people developing this for older Apple systems harder.
>
> Greg did not yell at me (yet) so I guess I'm doing OK :)
>
> > On Sun, Sep 09, 2018 at 11:42:01PM +0200, Lukas Wunner wrote:
> > > Andreas Noever has let it be known off-list already a while ago that he
> > > currently cannot spare as much time for Thunderbolt development as he'd
> > > like.  As a result the driver's development has become dominated by
> > > Intel.
> >
> > I was not aware of this. Althought Andreas has not commented much
> > lately, I thought he is still looking after our changes. I hope he still
> > is :)
> >
> > > I would like to step up as co-maintainer to provide additional checks
> > > and balances and prevent the driver from degenerating into an Intel-only
> > > show.  A number of things really irk me:
> >
> > I don't have anything against this but at the same time I'm afraid it
> > might lead to a situation where the Thunderbolt driver evolution gets
> > stopped into its tracks because of unnecessary fighting over each patch
> > and change which does not benefit Linux kernel in general.
>
> I think we have enough maintainers in this subsystem:
As mentioned by Lukas I'm currently quite preoccupied with other commitments
and have not done much more than skimming the incoming patches (especially
those touching the Intel part - as I trust you know what you are doing there :))
If there is concern over too many maintainers then please give my spot to Lukas.
Since I no longer use my MacBook regularly my ability to effectively
test stuff is
quite limited anyways.

Thanks,
Andreas


>   Andreas - Apple hardware
>   Michael and me - Intel
>   Yehezkel - Microsoft
>
> But I think we can make you a dedicated reviewer. This should make sure
> you get to review all the patches touching this subsystem.
>
> However, first I would like to get confirmation from Andreas that he
> approves this.
Signed-off-by: Andreas Noever <andreas.noever@gmail.com>

>
> I also would like that anyone submitting patches to this subsystem do
> not get bad feelings during the review but instead possible issues and
> improvement suggestions are written in such way that the submitter feels
> his work is valued (even if not always correct).
>
> This is especially important when a random Intel (well, or Apple)
> engineer submits a patch, say fixing a typo in a comment of some data
> structure. There is no point starting to demand that the specific
> register meaning needs to be disclosed. I've said this before but I or
> any other Intel engineer do not have any power over when the spec is
> released or any other related matter (like disclosing registers) and I
> really don't want that every single patch review starts with demanding
> people to disclose something extra. After all they are just trying to
> improve the driver which is good for Linux.
>
> If Andreas approves this, please send a patch adding you as a reviewer
> and I'll apply it. Just please write the changelog in good will without
> any personal frustration as those will be recorded forever in the kernel
> history and you never know in future who you are working for.
>
> From my point of view, I welcome you on board as good reviewer :)
