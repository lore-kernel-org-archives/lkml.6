Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1671606-1523296813-2-5037703226188840735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523296812; b=B2GPSFzb0MI0Zx6+PZlJbClpOtsPtYQp8PvhJtE2cHHEsMoOFx
    ia0Jw7ZHmhGJowttL5Qkvogo+y3Vxl1Pb5OxklYnKt16oZWmNE3NazolukPSGODV
    a4faYOc5wKncaw22u6VAiEur96oJpEzCHclpnSzK7jGh/PrFAW98E/jHWVhjBnsx
    DGvF80TOXkGsQTjrW/vNMx7Gr9VijopQrjpbN1SCUGQRfmdLbyRUEbWJp1u+lmRY
    KhIYNfaw99nNkh8SWdvkeljfA9pZH2YnUCauGfWYzcqY+2LHRxyp3q7/lpH3zdYI
    JTv4xnquduYSgOAxuWZ7mNqQsCktXco3qZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523296812; bh=Awt/yXU7ICL5PKLger72lZJ9KI+tOExZ7zLYSZLr/O
    U=; b=YeQBGcOnqbi9+UJKvJwrh5nDYuPfACbFwWVYutf5A3S8KFrRSuunNbg53l
    gmTd13BSQBb2+zv1l1JgJJ1w/KxMBlhZrlrOUeCS7Co7QLjciVwl/HenHjlmTjRS
    N1hLDL/Jj42ODcJ6roQBKdxkZJoHzouoNy1jF6zSpj3xn9p6ojBfZd190OA6KK6r
    tsU/kMnU06nEdJWvKEDqvRSeuv0vDczxHtX5iCnyugy6lr86q36Dnt8Mklj41IKW
    kxsVNT+OZWFiz1nvrHH8zF1T1lsNmo3BG3Vqk8VwrjHt3NKhZ7x3jqA07pdMiMdp
    j0PiViHTgAYpiSA3wNTxJhBxqh0Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=FrucLBJf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JvqZkVWX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=FrucLBJf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JvqZkVWX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHdomeBlMdXGVEnrpWJv6SWfzhpsAq3XpBekIVUsmCMSX1F+x1yJKPvo1RMPiVA34ecuN4XObKb86qpqB5fRm1qUtlhveV39i0QurmvWzJ1M7sfrvzIH
    W+ZJ6c0RiGMO+UlAdqCMySzoUvnaGOJOIZXpFv/3wXw1khmOH+D7sIAcydx0ZeVDcHtOWV68J8PWgv63TwwhKtg/S60h9ftoP42XYFNnJAQTUFKYwVCur6hK
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=IhJ4GjL3kV1zgQ4HsXsA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDISAJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 14:00:09 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33032 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeDISAI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Apr 2018 14:00:08 -0400
X-Google-Smtp-Source: AIpwx49EfUgEPJW4wdL+NQ5Mkir7Gv/WdXYmzoGt7F7lt/1uUNhnQZ2ZEWeoh/j7wmi0I4w5YjPXjPrjtH9KFh+ueOQ=
MIME-Version: 1.0
In-Reply-To: <20180409002738.163941-65-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com> <20180409002738.163941-65-alexander.levin@microsoft.com>
From: Chenbo Feng <fengc@google.com>
Date: Mon, 9 Apr 2018 11:00:06 -0700
Message-ID: <CAMOXUJkEomBfpBLbfaZTG9SyGGAvtG_zoA3CfMtxW4BUOSX6sg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.4 065/162] tcp: Add a tcp_filter hook before
 handle ack packet
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 8, 2018 at 5:28 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> From: Chenbo Feng <fengc@google.com>
>
> [ Upstream commit 8fac365f63c866a00015fa13932d8ffc584518b8 ]
>
> Currently in both ipv4 and ipv6 code path, the ack packet received when
> sk at TCP_NEW_SYN_RECV state is not filtered by socket filter or cgroup
> filter since it is handled from tcp_child_process and never reaches the
> tcp_filter inside tcp_v4_rcv or tcp_v6_rcv. Adding a tcp_filter hooks
> here can make sure all the ingress tcp packet can be correctly filtered.
>
> Signed-off-by: Chenbo Feng <fengc@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  net/ipv4/tcp_ipv4.c | 2 ++
>  net/ipv6/tcp_ipv6.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 61c93a93f228..2eb9a1747f25 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1639,6 +1639,8 @@ process:
>                 }
>                 if (nsk == sk) {
>                         reqsk_put(req);
> +               } else if (tcp_filter(sk, skb)) {
> +                       goto discard_and_relse;
>                 } else if (tcp_child_process(sk, nsk, skb)) {
>                         tcp_v4_send_reset(nsk, skb);
>                         goto discard_and_relse;
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 74cbcc4b399c..7d7f0999a919 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1428,6 +1428,8 @@ process:
>                 if (nsk == sk) {
>                         reqsk_put(req);
>                         tcp_v6_restore_cb(skb);
> +               } else if (tcp_filter(sk, skb)) {
> +                       goto discard_and_relse;
>                 } else if (tcp_child_process(sk, nsk, skb)) {
>                         tcp_v6_send_reset(nsk, skb);
>                         goto discard_and_relse;
> --
> 2.15.1
There is a bug fix for this patch upstream:
"d624d276d1ddacbcb12ad96832ce0c7b82cd25db tcp: fix possible deadlock
in TCP stack vs BPF filter", Please make you include that as well if
you want to add this patch to stable.
