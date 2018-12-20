Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0A32186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWkOiBfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbeLTOFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:05:04 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35182 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732459AbeLTOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:05:03 -0500
Received: by mail-ed1-f52.google.com with SMTP id x30so1861165edx.2;
        Thu, 20 Dec 2018 06:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P96dO+RnB6/wo1HJ4PWqBZan7w0KjLZLC/S9mNKKJFc=;
        b=rWkOiBfQgbwRDz3DUtOtAgzfN/L8yYMIn9tw2giP4QqAo8SNtK/ZVsU9muQb51NuYW
         xq+jmP1L0KohqDEeBIPz7SFT0mm1ETpcSm1J0SehD8s8RDPkxb5kY2v5LEtekFaFelPa
         NwapkatfYEh0tCUnwpSxa6LUlogUnEqgMTdibBpi4lAUXU3+u0gLfV7AcBpiFW1mDccY
         bdcSg68bbShms38F9p4IqrIVZEXQMAR8xog0jtAVihwWU3EfhpyN9J+GaQYHNPWs/U3r
         /pX+MAV9eL6RitspApn323FwitojF+r2opGLoMJ70cfrLEEOng552RdTAEH1zZUXWMLy
         v6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P96dO+RnB6/wo1HJ4PWqBZan7w0KjLZLC/S9mNKKJFc=;
        b=a4N/362smALFgrCu3iNwuR9NOq2pUL0acu1CcI+lvsGTWUYf1c3gTKBdp7lwuBthBQ
         kbagGw511Y5p8OpkucnkaWTpsgOw5sU59z7A5OAQBqxRV4c7P4u71velTnAAtwQ+PCXM
         OXC6nG7ANui2AalLhp6SyttdhuycRP2jU3VgGxj1ib9WaZIoqVohRp1Fcf8sU6RbXf/8
         Ia+Zvj21ztndMVWrJU7WImGcgJPAwi7RyOyWBB/cxkG6UNCq+npTPElhTux/tiGWD9Lx
         oMat6BxOAxylFMEITkArPobcVM2GElLYJjSwi3jZrENZLfNb17PuAgb+Wm5mxBiVwC1b
         0PCQ==
X-Gm-Message-State: AA+aEWbECCMWpcHiBFVPWz1Z1l+t1mYPIE3gCOHsTkUKgs1F9S2uU86i
        nNcdaFUNLF4aREMaC/p9c4ViI5rpaKodIFgaEKw=
X-Google-Smtp-Source: AFSGD/WMUm2KYF1Frrfp8T1pUE2AuhDrV4Vz9Ees1MgAPEvkDgj38c+jNtqFFvskDqXnMEPWKQ7qXrGV9jqMbvkFM50=
X-Received: by 2002:a17:906:1604:: with SMTP id m4-v6mr19473727ejd.167.1545314701567;
 Thu, 20 Dec 2018 06:05:01 -0800 (PST)
MIME-Version: 1.0
References: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com> <20181220091207.GA25942@splinter>
In-Reply-To: <20181220091207.GA25942@splinter>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 20 Dec 2018 09:04:25 -0500
Message-ID: <CAF=yD-LJe_YjH-ssVb1c+yvEvKSDgBzUFMD8NxWKCKOEJPw30w@mail.gmail.com>
Subject: Re: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764
 __skb_flow_dissect
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Willem de Bruijn <willemb@google.com>,
        Michael S Tsirkin <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 6:15 AM Ido Schimmel <idosch@idosch.org> wrote:
>
> +Willem
>
> On Thu, Dec 20, 2018 at 08:45:40AM +0100, Christian Borntraeger wrote:
> > Folks,
> >
> > I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
> > Maybe someone has a quick idea.
> >
> > [85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318
>
> I managed to trigger this warning as well the other day, but from a
> different call path:
>
> [280155.348610]  fib_multipath_hash+0x28c/0x2d0
> [280155.348613]  ? fib_multipath_hash+0x28c/0x2d0
> [280155.348619]  fib_select_path+0x241/0x32f
> [280155.348622]  ? __fib_lookup+0x6a/0xb0
> [280155.348626]  ip_route_output_key_hash_rcu+0x650/0xa30
> [280155.348631]  ? __alloc_skb+0x9b/0x1d0
> [280155.348634]  inet_rtm_getroute+0x3f7/0xb80

inet_rtm_getroute builds a new packet with inet_rtm_getroute_build_skb
here without dev or sk.

> Problem is the synthesized skb for output route resolution does not have
> skb->dev or skb->sk set. When a multipath route is hit and
> net.ipv4.fib_multipath_hash_policy is set the flow dissector is called
> with this skb and the warning is triggered.
>
> I plan to fix it by setting skb->dev to net->loopback_dev.

The device can be chosen based on iif in inet_rtm_getroute? A first
thought, I don't know this code very well.

Let me know if you want me to take a stab at that patch. IPv6 probably
will need the same.

> I assume we
> want to keep this warning to prevent call paths which will otherwise
> silently fallback to standard flow dissector instead of the BPF one.

Indeed, the warning is there to sniff out paths that do not follow
what I thought was an invariant. If there are too many exceptions, I
may have to revisit that assumption. But for now, let's see if we can
address these edge cases.

> I'm not familiar with tap code, so someone else will need to patch this
> case, but it looks like:
>
> tap_sendmsg()
>     tap_get_user()
>         skb_probe_transport_header()
>             skb_flow_dissect_flow_keys_basic()
>                 __skb_flow_dissect()
>
> skb->dev is only set later in the code.

tap_get_user uses sock_alloc_send_pskb (through tap_alloc_skb) to
allocate the skb. So skb->sk should be set at the time of
skb_probe_transport_header. I'm not sure how this path triggers the
warning.
