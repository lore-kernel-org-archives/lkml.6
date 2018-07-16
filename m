Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26534ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBA320862
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="un3FWlSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBA320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeGPWr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:47:58 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:33208 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeGPWr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:47:57 -0400
Received: by mail-ed1-f44.google.com with SMTP id x5-v6so27451501edr.0;
        Mon, 16 Jul 2018 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7L98SG0wF99wGgDdet73KdfJbaiqbi0oQeKSSEOUk8M=;
        b=un3FWlSnt7yxXBtfk8eUJz19hmJ11qj7Pcx0JFVQDl4Fx5Q5nN322F3Jtk2mFyJOsl
         vlKZr5xSbuhikiyoKIk+17hTQrrEiIZhUOQ8/WqPwUdUvGZtBm/F8h7UsHMJgGPqMll3
         lRJ87dAFb0o0k70zDbNCTESYA9JraKdB6UwFz/gTIEZyg+veTAnxGlopGGQ7gVz62xat
         r/4LKvQxBp9IxqqHDE0fKdd6RdSvBif9y5dWbsOpnIL3aM5T+fEB4zpNH90liKTX7LLc
         NA7FyfbHblz1irz3EAx51yyHCzh509rQsCW3MBbLiUbHWjWC+pfahzW4JSUX85QmHJ94
         Mv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7L98SG0wF99wGgDdet73KdfJbaiqbi0oQeKSSEOUk8M=;
        b=eKTDQTVnTKAbjaCmuwxyDlYjfOWW1a2MOhPKIE5xWFxdbN/lEqhf7GGFXA9XzkR4Mh
         MOGAbGwhnN9loXEL3Nqu+r2RifsVKQ22Mx9r+r+gywJs2+cGufMuGlCH0kuZoy38npb0
         lCIEk4I5AAnyCEdYlRiWmCWrgnJpOku99OLkZPln7BZb6qd5Z3f0h2u/npsEWqaYdIxW
         5L7sTC6a7GYk1URBnWeAiD0bUxLLwGioItCp4gTyzmd4N/LwzSY/Tgaio+k7V1h5fYEF
         cEsyjeH1yUcUwwmxCjUY63BMMZH9KH/fp2z8NqZlOFDLrN/6O4cZymLb5+KGoyebOk/R
         mkBQ==
X-Gm-Message-State: AOUpUlEd3BXwFsIWW883a0LdKOjaX85Np3pBGNEif0CgC45MAw2RHoIL
        XHreLVGLt16J2boWkU7wa003AaxExjjP4ZnfDp4=
X-Google-Smtp-Source: AAOMgpdixzAK1BB79QgN87ymmyBTGzQ8ZRuIEn7aIGDQ1c5/A2o+7JumG9SpBPdUt3X0EAOihbfeSMIoRx9DdPNzrCk=
X-Received: by 2002:a50:ba3b:: with SMTP id g56-v6mr19344855edc.85.1531779510754;
 Mon, 16 Jul 2018 15:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <1531653191-6456-1-git-send-email-baoyou.xie@gmail.com>
In-Reply-To: <1531653191-6456-1-git-send-email-baoyou.xie@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 16 Jul 2018 15:17:54 -0700
Message-ID: <CAF=yD-+N6BBcbKFo3B=FmVcp9VD+NUr2mfk-qkvtkVZYDhsRHQ@mail.gmail.com>
Subject: Re: [PATCH v2] datagram: return from __skb_recv_datagram() as soon as possible
To:     baoyou.xie@gmail.com
Cc:     David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pombredanne@nexb.com, Tobias Klauser <tklauser@distanz.ch>,
        Matthew Dawson <matthew@mjdsystems.ca>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 4:17 AM Baoyou Xie <baoyou.xie@gmail.com> wrote:
>
> We got a soft lockup in a heavy busy cloud server where RIP is
> at _raw_spin_unlock_irqrestore+0x1b/0x40:
>         [] finish_wait+0x56/0x70
>         [] __skb_recv_datagram+0x3fb/0x5a0
>         [] ? datagram_poll+0x100/0x100
>         [] skb_recv_datagram+0x41/0x60
>         [] netlink_recvmsg+0x62/0x450
>         [] sock_recvmsg+0xbf/0x100
>         [] ? futex_wait+0x193/0x280
>         [] ? finish_task_switch+0x108/0x170
>         [] SYSC_recvfrom+0xe8/0x160
>         [] ? __schedule+0x3c8/0x990
>         [] SyS_recvfrom+0xe/0x10
>         [] system_call_fastpath+0x16/0x1b
>
> In fact, a mistake exists in __skb_recv_datagram(). For example,
> if a datagram come in persistently after go through the socket
> queue, then __skb_wait_for_more_packets() will find out that the
> last peeked skb is not the real last one, so it return 0. this
> results in long time outer loop, and can trigger soft lockup.

Is this with MSG_PEEK?

If the above occurs, that implies that the queue is not empty so the
next iteration of the loop in __skb_recv_datagram should return
the oldest packet on the queue.

This is a netlink socket. Those do not support SO_PEEK_OFF,
simplifying the problem somewhat.

I do not yet see how this can loop until timeout if data is queued.

> So this patch changes the loop condition to prevent soft lockup.

Bounding waiting time in this manner should not be needed, as
__skb_wait_for_more_packets reduces remaining timeo on wake.
