Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71421C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9BD2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVx+A641"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9BD2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeICNF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:05:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50603 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeICNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:05:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so305305wmc.0;
        Mon, 03 Sep 2018 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=CUdhx+ffl1usLrRC0oJn2G13e2wYwQwLxlV6oLEgFpk=;
        b=VVx+A6415V9kr5SYSbGYn1LEabDk2r7eKE1cYXUXAsDqWq5pY0lBb/cbuWR+cSBpt/
         CqH5kZ5Esnfum2QuFBxEnKfxhr2yLBCXK8Dq+79IGquq4UGQUg4J4Lix6PPMo8owIP7G
         8FpBFLRO+KuzOSEfrX3/nqZNiChzEzYGSwwOH4IuV+6XkAUwiEe/nYw8ZqdE0pQdRjrf
         tImlx4zTSTEudubPRgBqOHJpJBHRrgoWSIPQN/sL3AipTYxRrd7JpGIsA/SPsQOOGtt7
         tMym6XMLXtZMzo2xXSrhUXgPbDpqQo2R3RqRZSTtbC+Q82YwYmsMafmS3cLWqSqRXSrr
         xLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=CUdhx+ffl1usLrRC0oJn2G13e2wYwQwLxlV6oLEgFpk=;
        b=GjHx5AgAbcFSrdigXEOyXLjRGvAZO3UFGj1P9NCIBVX3VTCdBL1P0LWbWb0I7uHN98
         bdG6bDkMu6mOkV7ky8qKF1kx9GckmWkfpTxjfuz+/D1jDx/8wMxWmLeiaVpSQvQa4jV3
         0rSkXle8ELRyLQUwNoAA+0yNvJXpnR/e3+yNtq6eYQ5UGVnPw3e/VPix2MyIyV0L+Q5n
         cC9gKIknKlbzkzhcNtR6vh/O3m5M0xxk6Z1PRp3gkp9LFndYv0YVY1lEkt4l/8xUXXHX
         WFtw1jxBWXOoZCqR73dJk37Lpx5VvzLRuIPD2cItJ7TAyQ0J4nX1kOTOKNrkNYpL6ggs
         BdCg==
X-Gm-Message-State: APzg51AbJ97/ohXJsWtbqzvCWl9fFaV2dYFujqFBCs8LdY3xU5cUHvnd
        Fa2EiXyX114DRLh7d46KBskKZWTTNfvhZxQ2tSQ=
X-Google-Smtp-Source: ANB0VdZriZhFCZDumRy9ANM/TyLTYsl7lSWp1QjQDsPROSwi03N8gRZh4RCdheUpWPZtJbQDaIWgc5POK32J9IC6qpk=
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr4715254wmf.89.1535964407638;
 Mon, 03 Sep 2018 01:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-2-andrea.merello@gmail.com> <20180827053002.GT2388@vkoul-mobl>
 <CAN8YU5MOdz_sW06B8yc_kewjsxP0DP5pgB2bSu=vkNG-ezvMpQ@mail.gmail.com>
 <CAN8YU5M0tJmsU4Xp+0xDwQYtqeB8tPP_4FyBC_ctUOSV=HZNmA@mail.gmail.com> <20180830132745.GC2322@vkoul-mobl>
In-Reply-To: <20180830132745.GC2322@vkoul-mobl>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 3 Sep 2018 10:46:34 +0200
Message-ID: <CAN8YU5NpOsY-J9yNA6vAmmLTVrtknwxNP7pjhLJDm=-WQ0+Fuw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 3:27 PM Vinod <vkoul@kernel.org> wrote:
>
> On 30-08-18, 10:11, Andrea Merello wrote:
> > On Wed, Aug 29, 2018 at 10:12 AM Andrea Merello
> > <andrea.merello@gmail.com> wrote:
> > >
> > > On Mon, Aug 27, 2018 at 7:30 AM Vinod <vkoul@kernel.org> wrote:
> > > >
> > > > On 02-08-18, 16:10, Andrea Merello wrote:
> > > >
> > > > s/cylic/cyclic in patch title
> > >
> > > OK
> > >
> > > > > Whenever a single or cyclic transaction is prepared, the driver
> > > > > could eventually split it over several SG descriptors in order
> > > > > to deal with the HW maximum transfer length.
> > > > >
> > > > > This could end up in DMA operations starting from a misaligned
> > > > > address. This seems fatal for the HW if DRE is not enabled.
> > > >
> > > > DRE?
> > >
> > > Stands for "Data Realignment Engine". I will add this string nearby
> > > the acronym..
> > >
> > > > >
> > > > > This patch eventually adjusts the transfer size in order to make sure
> > > > > all operations start from an aligned address.
> > > > >
> > > > > Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > > > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > > > > Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > > > > ---
> > > > > Changes in v2:
> > > > >         - don't introduce copy_mask field, rather rely on already-esistent
> > > > >           copy_align field. Suggested by Radhey Shyam Pandey
> > > > >         - reword title
> > > > > Changes in v3:
> > > > >       - fix bug introduced in v2: wrong copy size when DRE is enabled
> > > > >       - use implementation suggested by Radhey Shyam Pandey
> > > > > Changes in v4:
> > > > >       - rework on the top of 1/6
> > > > > ---
> > > > >  drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++++----
> > > > >  1 file changed, 18 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> > > > > index a3aaa0e34cc7..aaa6de8a70e4 100644
> > > > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > > > @@ -954,15 +954,28 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
> > > > >
> > > > >  /**
> > > > >   * xilinx_dma_calc_copysize - Calculate the amount of data to copy
> > > > > + * @chan: Driver specific DMA channel
> > > > >   * @size: Total data that needs to be copied
> > > > >   * @done: Amount of data that has been already copied
> > > > >   *
> > > > >   * Return: Amount of data that has to be copied
> > > > >   */
> > > > > -static int xilinx_dma_calc_copysize(int size, int done)
> > > > > +static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
> > > > > +                                 int size, int done)
> > > >
> > > > please align with opening brace
> > >
> > > OK
> >
> > Sorry for getting back on this.
> > I've checked it, but it seems already aligned with opening brace in
> > the original e-mail text I've sent. (4 tabs + 4 spaces).
>
> Okay, please see that code looks fine, I will check after I apply

Yes, I confirm that here the code does look fine: the 2nd line is
aligned with opening brace indeed.

Do you want I produce now a v5 with all the other fixes you asked for
(basically commit message fixes), or you are going to apply/check this
one and should I wait for that?

> --
> ~Vinod
