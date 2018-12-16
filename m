Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB357C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E99C21836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmfLzAnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbeLPSg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 13:36:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35261 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbeLPSgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 13:36:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so10106690wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 10:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qlCi1o59RtrnMq0dOxwqY3nCkhq9IXpKKbQNPLrpY4=;
        b=SmfLzAnOVSxeqQBmKVTdWxo4BmpWklSmPFQBRCs9eVjVDYCHqfL1WG5FxuI77LfgCY
         cM2jbV3d15nBH0+U5cNvwZ3TKH+N3fehQUr/iOMeOY5+eEG1v0zzsCcpv/65yR0fBoEP
         ag69JeYdvfnMLA7G1wCMCsY/LeZnAziiGW5E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qlCi1o59RtrnMq0dOxwqY3nCkhq9IXpKKbQNPLrpY4=;
        b=GDxbZ7mrVeeDUQt73R5gnJeR0JvFwV3REy1bsYGVGZZmHR+44H2EZCTQV7bqWfb0lX
         MmrKJVbRNRYjoxgfzKwm60xv8g3zcDKW2FXVTzRyvfebIN3vkMTQFAo8mpREMs+OhI8V
         i+ek7axC4b4azDCWVHu+38vOHYOS6OOjVWmGVvylIMYmw2z7mcW7UBdiHfymc0/RFOEX
         +BrMCDBMA5r+xMoAV3wRz8+PSIJhCQV7oZf+4vzQUshBN5K676hS84tVoid6mr1AOz26
         sspAR4ICbhPu7WSOCJe4f7bvv2DI4FLS4qbdwY2/gbJSXIBK1njBUcMdMxaD1tAEr2SS
         KVvQ==
X-Gm-Message-State: AA+aEWbzrAREE3jNF446GXf6DamcAdPVD19Bzl7yJ7Y6YNRVYMzEy4c5
        gushL2Bq1DQF/95jKpJiGDIlz0Dy8F2ml7CzZTayAQ==
X-Google-Smtp-Source: AFSGD/V+XKuHzWlGR6ZEW2poGni9FmNYF7S8KFdaxdHUH28CLK63KNfqYHyd3sX82H7c3OLDdEHSYcsHBmwLDF0t1Ek=
X-Received: by 2002:adf:9422:: with SMTP id 31mr9018031wrq.106.1544985413254;
 Sun, 16 Dec 2018 10:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20181214175921.6859-1-semen.protsenko@linaro.org> <20181216162605.qn2jjbyb2bgcbxgq@kdev>
In-Reply-To: <20181216162605.qn2jjbyb2bgcbxgq@kdev>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sun, 16 Dec 2018 20:36:42 +0200
Message-ID: <CAKaJLVtG=BiLHe=3X57hBgrrc-FrHG6C1vbq96wDqeWwrEP52w@mail.gmail.com>
Subject: Re: [PATCH] l2tp: Add protocol field decompression
To:     Guillaume Nault <g.nault@alphalink.fr>
Cc:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Sun, Dec 16, 2018 at 6:29 PM Guillaume Nault <g.nault@alphalink.fr> wrote:
>
> On Fri, Dec 14, 2018 at 07:59:21PM +0200, Sam Protsenko wrote:
> > When Protocol Field Compression (PFC) is enabled, the "Protocol" field
> > in PPP packet will be received without leading 0x00. See section 6.5 in
> > RFC 1661 for details. So let's decompress protocol field if needed, the
> > same way it's done in drivers/net/ppp/pptp.c.
> >
> > In case when "nopcomp" pppd option is not enabled, PFC (pcomp) can be
> > negotiated during LCP handshake, and L2TP driver in kernel will receive
> > PPP packets with compressed Protocol field, which in turn leads to next
> > error:
> >
> >     Protocol Rejected (unsupported protocol 0x2145)
> >
> > because instead of Protocol=0x0021 in PPP packet there will be
> > Protocol=0x21. This patch unwraps it back to 0x0021, which fixes the
> > issue.
> >
> > Sending the compressed Protocol field will be implemented in subsequent
> > patch, this one is self-sufficient.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  net/l2tp/l2tp_ppp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> > index 04d9946dcdba..c03c6461f236 100644
> > --- a/net/l2tp/l2tp_ppp.c
> > +++ b/net/l2tp/l2tp_ppp.c
> > @@ -236,6 +236,10 @@ static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int
> >           skb->data[1] == PPP_UI)
> >               skb_pull(skb, 2);
> >
> > +     /* Decompress protocol field if PFC is enabled */
> > +     if ((*skb->data) & 0x1)
> > +             *(u8 *)skb_push(skb, 1) = 0;
> > +
> Sorry, but PFC is PPP stuff. It's absolutely independent from the
> transport layer. Therefore, it belongs to ppp_generic.c and L2TP has
> nothing do with it.
>
> I know some other transports got it wrong, but let's stop
> re-implementing PPP features in every lower layer. Teaching ppp_input()
> about PFC is all that is needed to get the feature work correctly on
> all transports. As a bonus, it'd bring PFC support to PPPoE and would
> let us drop the duplicated code from pptp.c, ppp_async.c and
> ppp_synctty.c.
>
> As an example of the problems caused by mixing the PPP and L2TP
> layers, consider the case of L2TP sockets that aren't PPPOX_BOUND.
> They're supposed to receive the original PPP frames. Now with your
> patch if the protocol was compressed, the L2TP socket receives a fake
> header. User space didn't ask for that and has no way to figure out
> what was the original packet. To make things worse, that behaviour now
> changes depending on the kernel version.
>
> If you all agree, can we please revert this patch and properly
> implement PFC in ppp_generic.c?

How about instead of reverting I will try to provide the patch
extracting duplicated PFC code (from L2TP, PPTP, etc) to
ppp_generic.c? This one fixes actual problem, and if we are going to
add it to ppp_generic anyway, why not do it in one patch? I'm willing
to do this work in next few days. Hope there is no rush with revert?
