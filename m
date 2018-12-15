Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1899C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAE62084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 18:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/K8VTex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeLOSwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 13:52:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46644 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeLOSwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 13:52:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so7526825edt.13;
        Sat, 15 Dec 2018 10:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gh9VSBUiyRxEelqw76QjxfGZ6ARrZNgGUj+3Pb21AwU=;
        b=B/K8VTexnUfAYVE5+QSoU4ojriHhgCqraUBWkBnJhFtbhnjqzQDofKoyUlaMtS6OZS
         GDaehYyxd1dhcnMC4EQOGVNa8y9k7BYLJNsb4IRalSHCuOqJsxGcIy1bYjim4d88Fhwn
         fzIqQ7p8gL1hckM29JQOzB4fXU0jBRlIY/VNuPjrDfUo+JeSXjTa9zoWHDlxun/zfYCa
         iiUqCIGhezB3dr7NveEMjRSl0eZ0sCbMPGtHi8iKx4Z/ZJP16bjV1xk6pTL1OCEygZVz
         /VYjT2FabCOmXBdb+B18/3SHz/bUYk01ZrIT3xNLeGKrInQMBjgaG3eU8twgGtO/te/1
         AaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gh9VSBUiyRxEelqw76QjxfGZ6ARrZNgGUj+3Pb21AwU=;
        b=KeZcF5VPrjrimSfWOlG+zmqQqrfTCKL+puoqHdRhtNBI1UL56gRyqIo8OWRmWINH+4
         9wZhZFagl3gn1DAIA4B1FNM4AkY4Qz4wOEiW7CiiKtHiyhnmGt67DXnBpfy6bYJl+ZZx
         X6Hc+8eZwQcyZaPLVBYaPAc1daavfpZu0zEx6bDXPmnvRhoib8m0sArTB5chq3h4VmVn
         clt60tFm5U3+aM0f8GTFtJRfRccWUipUZ1mK1sz9z5iynOqcbW/Ttcb01CN3YnyaHmRR
         DAvANfoMAU8Ay2sn6GqU0Q3hTHiPXCb1joY1qql/4pcRdoPfyy6wgtOX96ZhRA0MS+IT
         6pkA==
X-Gm-Message-State: AA+aEWZF+BN/4S6S7Q9g7njBwr4HYT1bYrDGOn+msDGjbbxNt+0TyU0/
        WwIoIienMQkApqLUOp9n7BY0NmLaQRuSir3Pj9o=
X-Google-Smtp-Source: AFSGD/VjPbWkQ6thqkJiI2L6m19jcZPx/3Iyc74A01BVpicbYAbwk87k1xqAnNHOJMx/tMt3Vum8TneQJWrjxJCOPe0=
X-Received: by 2002:a50:ac81:: with SMTP id x1mr7341008edc.71.1544899927565;
 Sat, 15 Dec 2018 10:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-7-deepa.kernel@gmail.com> <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
 <CABeXuvpAZfd6gAdJbKxsOowXnDnwyQQRuYMJ-6LDo9BsRDDj-g@mail.gmail.com>
 <CAF=yD-L4xTU-KXsQ=uU36fEKv5St=69mmKqT8sD1mAmT_hfuVQ@mail.gmail.com> <CABeXuvqrZgEDF5RYQEPJ8RyXDg0uvXx_qMq=2ER8Bc9RXFPDGQ@mail.gmail.com>
In-Reply-To: <CABeXuvqrZgEDF5RYQEPJ8RyXDg0uvXx_qMq=2ER8Bc9RXFPDGQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 15 Dec 2018 13:51:31 -0500
Message-ID: <CAF=yD-KFYdXRgL-HpAJLLHuywMcaBGfz7sDL35DBNs0hoq+zxQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 3 reasons for not doing this:
>
> 1. We do not want to break userspace. If we move this to
> linux/socket.h all the userspace programs now have to include
> linux/socket.h or get this definition through a new libc.
> 2. All the socket options are together in the file asm/socket.h. It
> doesn't seem good for maintainability to move just a few bits
> elsewhere.
> 3. There are only 4 arches (after the series is applied) that have
> their own asm/socket.h. And, this is because there seems to be
> significant differences to asm-generic/socket.h that don't seem
> logically obvious to group and eliminate some of the defines.

Agreed. All good reasons to leave as is.

> Also for the other comment. The reason the conditionals were not
> consistent is because they were not consistent to begin with.

The only difference I see is an inversion of the test. Nesting order
is the same:

        int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
        ...
        if (need_software_tstamp) {
                if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
                } else {
                }
        }

vs

                if (sock_flag(sk, SOCK_RCVTSTAMP)) {
                        if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
                        } else {
                        }
                }

I suggest just adding something like

        if (need_software_tstamp) {
+              if (sock_uses_new_tstamp(sk) {
+                   __sock_recv_timestamp_new(msg, sk,
ktime_to_timespec64(skb->tstamp));
+              } else if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
                } else {
                }

and

                if (sock_flag(sk, SOCK_RCVTSTAMP)) {
+                      if (sock_uses_new_tstamp(sk) {
+                           __sock_recv_timestamp_new(msg, sk, ts);
+                      else if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-                       if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
                        } else {
                        }

I think we can use the same helper for both the sock and tcp variant.
The only intended difference between the two functions, as described
in the tcp_recv_timestamp function comment, is the absence of an skb
in the tcp case. That is immaterial at this level.

Note also (2) tentative helper function sock_uses_new_tstamp(const
struct sock *sk) instead of testing sock_flag(sk, SOCK_TSTAMP_NEW)
directly. Since the .._NEW variants are equivalent to .._OLD on 64-bit,
I wonder if we can just compile out the branch. Something like

    static inline bool sock_uses_new_tstamp(const struct sock *sk) {
            return (sizeof(time_t) != sizeof(__kernel_long_t)) &&
                       sock_flag(sk, SOCK_TSTAMP_NEW);
    }

> I'm trying to follow your request to keep code churn to minimal.
> It's just that I moved to a different function as that seemed logical
> to me. Do you prefer me to remove that refactoring?

Yes, please avoid rearranging existing code as much as possible.

If there is any refactoring to be done, I think it would be to
deduplicate the shared logic between __sock_recv_timestamp and
tcp_recv_timestamp. I think the first can be rewritten to reuse the
second, if the only difference really is that the first takes an skb with
embedded timestamps, while the second directly takes a pointer to
struct scm_timestamping.

Either way, that's out of scope for this patchset.
