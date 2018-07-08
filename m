Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F3C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C02F2089B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3AvNrPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C02F2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933156AbeGHVxp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:53:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41905 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932545AbeGHVxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:53:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id b12-v6so12371121edt.8;
        Sun, 08 Jul 2018 14:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFTUo6Y8LTv3Q+UrduEPZaUcZMTwIN0Nt1VkwILEzhM=;
        b=u3AvNrPB261q53cmGIbYzuToQdld85V/Yc+L8qLUn0MIgwX86fvOa6LyLJ8jkQGSQh
         pbJ/DmATavAGibyWHQBx+XzMizErkPOig3ymw0Yu0J5knBzgn0nKTaz+ykCJAfQ4lQzI
         NCWIosp5RHEAbKMda36IZInteepBsarNNoIu453PVgdnH4v6Ul5jyFHYW1z8t+G+QJGJ
         VT+GAKvaSYIFXLvVPZnCAVr3aeav9fCq1eth7mBueAtAHoOhAOFe6X0V6txloURL8VHZ
         SKyLvNJPqVabUwENilyKoSu+AbslpYLAdt35TdrleUnkHQQlSciTpVAk0GY7aaHP85uL
         FDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFTUo6Y8LTv3Q+UrduEPZaUcZMTwIN0Nt1VkwILEzhM=;
        b=X6FAbQeat6RqxCizx1n6lBNhGq2k6agO7rAEkTrypwZfBDeOhj6KqueAWwBt/n9tEe
         3bEnrbc8CawOPvaTV8S9NLRTDTiCmZCLRuvo2OcMGoItialoW+WN2tr71i1TCJNw0j9S
         9THvlvcW/ySC2JKoyz4GoSvG560m+g+NAl/GKkT9vCscu6QC/tKUjkqy/EtrNeB+iDsO
         r+2RC4djDJhURUx47JleU9wpiQrwswUmlnVXznOomR9nEV4lrUUKsJRyBOp5rzcTji4O
         Im7bwWWEbzGOYkqH9JssLa4Aat9Yak14Ax2Hi5FzHgP2gVgt9f7wh1+T2g1qxhjHDARf
         9+bQ==
X-Gm-Message-State: APt69E0l+/9O9q6WkVH4Bb1j809ekHpb1PPwzfXK3h6pc9oda+SmZp9B
        vu3p3c+NVgYKKWEEqwdk7nuKRNlQnphjCRpe5RE=
X-Google-Smtp-Source: AAOMgpfqebch24pD0V+xeQdarcOz2p7ukeQSB+y87n4kvKkVsWProq8PHYTUeMDcEk8hnUeR8RTVLtWS/4SqERGgwRY=
X-Received: by 2002:a50:ba3b:: with SMTP id g56-v6mr20077022edc.85.1531086821878;
 Sun, 08 Jul 2018 14:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <5e5dfd01-bad6-55b0-cfd1-75f7ec769e89@gmail.com> <20180708092718.17605-1-humbabek@gmail.com>
In-Reply-To: <20180708092718.17605-1-humbabek@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 8 Jul 2018 17:53:05 -0400
Message-ID: <CAF=yD-KPcgK=UYxwTL2Drn9wZgKHtNrcUqGP=Q4PLCYiWTtnNQ@mail.gmail.com>
Subject: Re: [PATCH] move smp_rmb() after load of status
To:     humbabek@gmail.com
Cc:     David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, ktkhai@virtuozzo.com,
        Kees Cook <keescook@chromium.org>,
        Mike Maloney <maloney@google.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -394,25 +394,30 @@ static void __packet_set_status(struct packet_sock *po, void *frame, int status)
>  static int __packet_get_status(struct packet_sock *po, void *frame)
>  {
>         union tpacket_uhdr h;
> -
> -       smp_rmb();
> +       int status;
>
>         h.raw = frame;
>         switch (po->tp_version) {
>         case TPACKET_V1:
>                 flush_dcache_page(pgv_to_page(&h.h1->tp_status));
> -               return h.h1->tp_status;
> +               status = h.h1->tp_status;
> +               break;
>         case TPACKET_V2:
>                 flush_dcache_page(pgv_to_page(&h.h2->tp_status));
> -               return h.h2->tp_status;
> +               status = h.h2->tp_status;
> +               break;
>         case TPACKET_V3:
>                 flush_dcache_page(pgv_to_page(&h.h3->tp_status));
> -               return h.h3->tp_status;
> +               status = h.h3->tp_status;
> +               break;
>         default:
>                 WARN(1, "TPACKET version not supported.\n");
>                 BUG();
> -               return 0;
> +               status = 0;
> +               break;
>         }
> +       smp_rmb();
> +       return status;
>  }
>
>  static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec *ts,
> --
> 2.17.1
>
> Sorry for a lack of information- it is the first my patch.
>
> The opposie smp_wmb() is in: https://elixir.bootlin.com/linux/v4.15/source/net/packet/af_packet.c#L415

__packet_get_status in the common path synchronizes with userspace
code, not with __packet_set_status. See __v2_tx_user_ready in
tools/testing/selftests/net/psock_tpacket.c from an example.

On receive, the smp_wmb in tpacket_rcv ensures that a frame is filled
before the kernel updates the status field to TP_STATUS_USER. So that
is not the purpose of the smp_wmb in __packet_set_status.

Digging through the original PACKET_TX_RING discussion (below)
it appears that the intent of that smp_wmb was intended either to ensure
that the frame was fully written before freeing the skb (when called from
tpacket_destruct_skb) or even to ensure that the frame was fully written
before calling flush_dcache_page on the underlying shared page.

The latter would explain its analogue in __packet_get_status,
though it is not implemented as a barrier between the field access
and page flush in either function in the final patch.

From http://lists.openwall.net/netdev/2008/10/31/70:

    >> Also, when you set the status back to TP_STATUS_KERNEL in the
    >> destructor, you need to add the following barriers:
    >>
    >> __packet_set_status(po, ph, TP_STATUS_KERNEL);
    >> smp_mb();   // make sure the TP_STATUS_KERNEL was actually written to
    >> memory before this - couldn't this actually be just a smp_wmb?
    >> flush_dcache_page(virt_to_page(ph));  // on non-x86 architectures like
    >> ARM that have a moronic cache (i.e cache by virtual rather than
    >> physical address). on x86 this is a noop.
    >>
    >
    > So, If my understanding of those memory barriers is correct, we should
    > have a smp_rmb() before status reading and smp_wmb() after status
    > writing in skb destructor and send procedure.

> On my eye smp_rmb() should be moved *after* actual read of status to be ensured that no read after __packet_get_status() happens before actual read of status.
>

That sounds reasonable. But we should understand the intent of the
existing code before making changes. That was not the purpose of this
barrier, it appears.
