Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF59C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45172086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="mOfWqmr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45172086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLLIXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:23:11 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33621 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeLLIXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:23:11 -0500
Received: by mail-io1-f66.google.com with SMTP id t24so14192550ioi.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 00:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LI0Wl6BulX634HdsyTE9b5nHW86RHBJZvD2/gndbgVA=;
        b=mOfWqmr6h73vOycopbg1xDJoCT1ncnUKj3mKk8pbBrNMHw58kUhN0eCpe8nAi3XDXD
         5cP0iYjUyVWj4UzFYRctea0oKOvVdKYTcOqHV3K5yE2p9m1F36OlRxZPJKB4T9OXlQY1
         lmnLy0Lbd6B4ByVNoqkKd+/Ab2ERkzg4hjazTl17JoWEPla3ZFvEB5cI9nyxVfcv9IM0
         aYJNbohqVKyct5Kt/f94XgjLUEuV6a9Z/z7GYoOuqFPWrqyjfFVOYYRUyTBynWzoXDNe
         yUyNBJum4wo8Ap+E7IezPxxO2tEbNLfR7g+XjtVnsuhBg5L7fW6a7FcUn2JnKeifngaS
         szFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LI0Wl6BulX634HdsyTE9b5nHW86RHBJZvD2/gndbgVA=;
        b=X0bjAkSRWU85dtT9NxoticIFvCJ05ELE1zgsJyOIUV7iM5L9dhDTYDcPaWCSev/E6V
         1j6c5DFC4nUyA0pFWG4+EfPxFUvZTGsWhB0JeJ0+2/2P+Ad3afQS2l+k0kqMVuu9R9jm
         kz070210GXxCxJB6RP/b3rv9CEKu0xMXU0ILTe/1x7pJMz5rijOOh5w4Jnj3626TKdkY
         PSRa67ntOfZj/y5Xs+r73NlwZo9n29ZavEYY+q70oDUo9o0GbNvHt6g8Ap3+8a8fUVJb
         dMBcu9j3ly4/lbs0KQHrTWqIzBGebdvS7cMuhBjCt92jvNl9o1fLY08u/cGALnuJhl6u
         l5bQ==
X-Gm-Message-State: AA+aEWYEA4JIwA5RwXfHoEGeT5+hmkmRy23w9Shm/aK8tfCH0UFte7/o
        664E5QVvn7K5rprZt5qeT82XmVFVoFGuEhdLq0cbiA==
X-Google-Smtp-Source: AFSGD/V9wfJKlmKfzQtBMT01aGxF3Mwngb6JddBNct2ado2ztHeoMhQhjEizEB4x5nereQzCuJSJhmQDYN9CBst5c+o=
X-Received: by 2002:a5d:8049:: with SMTP id b9mr7591130ior.108.1544602990068;
 Wed, 12 Dec 2018 00:23:10 -0800 (PST)
MIME-Version: 1.0
References: <1544533009-12425-1-git-send-email-mw@semihalf.com> <20181212104304.49026ed2@xhacker.debian>
In-Reply-To: <20181212104304.49026ed2@xhacker.debian>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 12 Dec 2018 09:22:57 +0100
Message-ID: <CAPv3WKctDNJVq7SgHBZLO_TU50ponCLu7h5oMKLTndBiDadhaA@mail.gmail.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
To:     Jisheng.Zhang@synaptics.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        netdev <netdev@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        nadavh@marvell.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

=C5=9Br., 12 gru 2018 o 03:48 Jisheng Zhang <Jisheng.Zhang@synaptics.com> n=
apisa=C5=82(a):
>
> Hi,
>
> On Tue, 11 Dec 2018 13:56:49 +0100 Marcin Wojtas wrote:
>
> > Recent changes in the mvneta driver reworked allocation
> > and handling of the ingress buffers to use entire pages.
> > Apart from that in SW BM scenario the HW must be informed
> > via PRXDQS about the biggest possible incoming buffer
> > that can be propagated by RX descriptors.
> >
> > The BufferSize field was filled according to the MTU-dependent
> > pkt_size value. Later change to PAGE_SIZE broke RX operation
> > when usin 64K pages, as the field is simply too small.
> >
> > This patch conditionally limits the value passed to the BufferSize
> > of the PRXDQS register, depending on the PAGE_SIZE used.
> > On the occasion remove now unused frag_size field of the mvneta_port
> > structure.
> >
> > Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation
> > method for SWBM")
>
> IMHO, we'd better revert 562e2f467e71 and 7e47fd84b56bb
>
> The issue commit 562e2f467e71 wants to solve is due to commit 7e47fd84b56=
bb
> It looks a bit wired, to introduce regression then submit another commit(=
in
> the same patch set) solve it
>
> Per my test, after reverting 562e2f467e71 and 7e47fd84b56bb, I can't repr=
oduce
> what's claimed in commit 562e2f467e71 -- "With system having a small memo=
ry
> (around 256MB), the state "cannot allocate memory to refill with new buff=
er"
> is reach pretty quickly."

I am not the one to decide about patch reverting. From what I
understand, commit 7e47fd84b56bb was intorduced in order to increase
performance thanks to replacing mvneta_frag_alloc/free with using
entire pages for RX buffers. I have 2 questions:
- without reverting anything, do you observe memory allocation
problems during refill?
- are you able to check L2 forwarding numbers on top of the pure
mainline branch and after reverting the mentioned patches? I'm
wondering what would be the performance penalty (if any).

Best regards,
Marcin

>
>
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethern=
et/marvell/mvneta.c
> > index e5397c8..61b2349 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -408,7 +408,6 @@ struct mvneta_port {
> >       struct mvneta_pcpu_stats __percpu       *stats;
> >
> >       int pkt_size;
> > -     unsigned int frag_size;
> >       void __iomem *base;
> >       struct mvneta_rx_queue *rxqs;
> >       struct mvneta_tx_queue *txqs;
> > @@ -2905,7 +2904,9 @@ static void mvneta_rxq_hw_init(struct mvneta_port=
 *pp,
> >       if (!pp->bm_priv) {
> >               /* Set Offset */
> >               mvneta_rxq_offset_set(pp, rxq, 0);
> > -             mvneta_rxq_buf_size_set(pp, rxq, pp->frag_size);
> > +             mvneta_rxq_buf_size_set(pp, rxq, PAGE_SIZE < SZ_64K ?
> > +                                     PAGE_SIZE :
> > +                                     MVNETA_RX_BUF_SIZE(pp->pkt_size))=
;
> >               mvneta_rxq_bm_disable(pp, rxq);
> >               mvneta_rxq_fill(pp, rxq, rxq->size);
> >       } else {
> > @@ -3760,7 +3761,6 @@ static int mvneta_open(struct net_device *dev)
> >       int ret;
> >
> >       pp->pkt_size =3D MVNETA_RX_PKT_SIZE(pp->dev->mtu);
> > -     pp->frag_size =3D PAGE_SIZE;
> >
> >       ret =3D mvneta_setup_rxqs(pp);
> >       if (ret)
>
