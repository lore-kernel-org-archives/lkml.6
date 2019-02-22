Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E972075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQdWK863"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfBVSFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:05:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41610 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBVSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:05:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id z25so2387456ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxYzLeroRCrwaC14L67flcP2TLWv1jy+Z+l6EBqVfJQ=;
        b=QQdWK863Td/zmZcA1OhJDuNXRkBGhVrL8ffmnz0CjYvWo9yQRXRKWcdpa9kT1RP33s
         UIeVxEC6GTHbPJJEwjsz9MolrtpYS6zXfHWg2UppIHka2FKEsZ6Do9E6NXlIdjCQidm0
         tMewp5sybk9kgwxzy3y7338oqqUBdDlexXwQc+5LczyUwom1m9nDRN7IaprFUEL4HMuU
         gp89tKEhz9Jg8vCl2D/eaf2OIpUiqOaxWg4vxImCnW9eRXn9J4fv8pZBFoy92A0JthLb
         9CbdFhnDkYBkk4wQ3MgW2wpYp/AvVItnnHPCbplnLMhxTpFE6LzMX5yOgl7D5HCZGu6X
         Y5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxYzLeroRCrwaC14L67flcP2TLWv1jy+Z+l6EBqVfJQ=;
        b=Q4aa+PVUfcEB0MvNIPVJ1kqtNqVum+D1F0w2Q+ZaNgvAelNwZcRWLXVz9zSGt7+GEH
         KX/4d3q90qFCq/OMreJTvTabu0X8Lg/k0vZpb57wV2u0mMbDt23UAJtgsXrZVofEp/2C
         MYgMtRElhvroDidyo2b0/1wqv5l746bwN8tm9rngBr5X3Y9SI4NQtxwLWk64ij0+2sA2
         nxdJnr7DCFRy4rN5nNFJn8fJaOUPe8UkS5QzFYhBcLEHKLDRuxdFPLKHbfZZ6xKjsqsK
         NtyhtpSkrLpeITq+pY/OtC0pk3BrjPKSjc7MQdBsjQ7jWy3KkZ5G4cLDf1kjuMNrAULa
         Shcg==
X-Gm-Message-State: AHQUAuaCtquC1oJFmbJnau44pOUB1OirGadJxgxGZBqEzGyUPpmAPhxi
        1inmbZ0XBgluds71w9UXqJT0Wao0Wg/VsrDikh+rW/nP
X-Google-Smtp-Source: AHgI3IaG64u7UcZBuRNWGh6J7upYUC4GkFXw8Ini/rnWQ2xZPZIFGpGSzw43iy8ghPCR/fOS+yqDqo8rloRNKfMPX9o=
X-Received: by 2002:a2e:711b:: with SMTP id m27mr2994129ljc.141.1550858731400;
 Fri, 22 Feb 2019 10:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20190221003231.31625-1-alistair.francis@wdc.com>
 <20190221115227.ipwjpn3xm4q7jfg2@sirius.home.kraxel.org> <CAKmqyKM_pb-riJ+jO65eT0SsVDxrstPOgurPuDf92Fd4C8k1Ug@mail.gmail.com>
 <20190222053747.rhed6j6nyi6tmg4l@sirius.home.kraxel.org>
In-Reply-To: <20190222053747.rhed6j6nyi6tmg4l@sirius.home.kraxel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 22 Feb 2019 10:05:04 -0800
Message-ID: <CAKmqyKNNwHin9XD1-9z13XZrRch_36Po_0R5X=GNUTGAAOek_A@mail.gmail.com>
Subject: Re: [PATCH] drm/bochs: Fix the ID mismatch error
To:     "kraxel@redhat.com" <kraxel@redhat.com>
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 9:37 PM kraxel@redhat.com <kraxel@redhat.com> wrote:
>
> On Thu, Feb 21, 2019 at 10:44:06AM -0800, Alistair Francis wrote:
> > On Thu, Feb 21, 2019 at 3:52 AM kraxel@redhat.com <kraxel@redhat.com> wrote:
> > >
> > > On Thu, Feb 21, 2019 at 12:33:03AM +0000, Alistair Francis wrote:
> > > > When running RISC-V QEMU with the Bochs device attached via PCIe the
> > > > probe of the Bochs device fails with:
> > > >     [drm:bochs_hw_init] *ERROR* ID mismatch
> > > >
> > > > This was introduced by this commit:
> > > >     7780eb9ce8 bochs: convert to drm_dev_register
> > > >
> > > > To fix the error we ensure that pci_enable_device() is called before
> > > > bochs_load().
> > > >
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> > >
> > > Pushed to drm-misc-fixes.
> >
> > Thanks. Any chance this will make it into 5.0?
>
> Hmm, we are damn close to the release, not sure there will be one more
> drm-fixes pull req.  But I've added a proper Fixes: tag, so even if the
> patch misses the boat it should land in the stable branches shortly
> thereafter.

Landing in the stable branches is probably enough. If you do end up
sending another pull request it would be great if this gets in. It
would be nice to have this fixed in the official 5.0 tag.

Alistair

>
> cheers,
>   Gerd
>
