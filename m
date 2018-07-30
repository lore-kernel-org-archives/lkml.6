Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810B6FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C89C205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqUtja3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C89C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeG3RcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:32:24 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55007 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeG3RcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:32:24 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so17918002itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ElJjk5oiPMLdMkEMLgXEVW93Kmm2P8oEmyOBlRwuYvU=;
        b=YqUtja3kk0/jxy+KmwM7yAko8JCH40saV3YxBw+UagVE5NqWBXPt1GwNrukyGQNeJm
         ipPET7zPZDZWR6eCoHWgSWFuKSYidynCYIbkdtmQPFNb2IjmwgIyrejs4cFQNNjm1j3G
         1zN3F4hAwOgTQh+xCN48chJ5R8MYoiSe1qBVu3WO9hjSafuMxDHmUVhAHpuwcjtbrHSo
         sCM3I26a/BzMzxdNVYjsWK5fRdGWDM+KTmvEoohU94D0dOTHEMvr/DytGWTR5DILppaP
         mek2OlINXDXZpv8j+Yek9kpsdrknwmVugXsKnSFhWCJlru8eF4ep3oLsSEAzbDA8Rgit
         4nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElJjk5oiPMLdMkEMLgXEVW93Kmm2P8oEmyOBlRwuYvU=;
        b=DS1mC2mKA2f3leqtdWRQdEZGkkNfNn11aZnHxcxdeay3W8Y4x7CCdz3u5ahlZovBuw
         D+Kzbf0GLDTXOksft3LB7xe5RTq0zTb+Xzz5LHaU+gGS7/KIee1CHWbmVM0lKv6C0zpT
         MGB/m7MOHS6xXAM3T6c6sSjR3RKmNPOlg3Uz2kSKzU3qr3GH7ZHD0idRtjG1d3Nct4dw
         g/TGN7vPT9awuioCwN0HoIsiY75yw9tFdgrE6Pjw6XnyoWfjjo3BiGihDJeHV+LF5Uh3
         3HKOrvCq08cIaTInndvYc7rBJyc7le5hnTrWtXs8/Oa4GiPThPUaMc6VkENnbPv4XuM0
         M8/g==
X-Gm-Message-State: AOUpUlE8tdERgnPdo6zhWWWTuBBu4ObU+Uruz3F99NWKh7YEt5oQ/r03
        0115FQ23eWbYttKaYQRVlCcGqiKiX56OcuVxMgfXbw==
X-Google-Smtp-Source: AAOMgpfdOCSmMIQ9GUvW2hr8gtEOD6K9cjqwEZwq9bfQthW4lCmwm9EJ76QXycvtYkjL4OtWGg93DevRJRK31oZSsDQ=
X-Received: by 2002:a02:1294:: with SMTP id 20-v6mr17332008jap.141.1532966207204;
 Mon, 30 Jul 2018 08:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
 <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
 <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com>
 <CANn89iKXPu=RKkLop4NJWZLixE__qYV2S=PngSj6ienuvWWL8g@mail.gmail.com>
 <CALOAHbAjtNf1LOhWEJMKNEEHSxjfEKiVV22KPUK88CTzt-eW0w@mail.gmail.com>
 <CANn89i+12HvAsvk9crDcqGh=v-DvLjuGQCOzVTPVDTUhHgeDiw@mail.gmail.com>
 <CALOAHbBFuASgsQK+iiAE+ebPOg5zjtzauYaN_Xtmfc9_wjTFgw@mail.gmail.com>
 <CANn89i+0peAq_BS3Ge-h2_MENHQAHtf8D_M0gzgchK6CxU8D+Q@mail.gmail.com> <CALOAHbBy6wEwDcVaWx9PG35jknwkhM-Y-TVyis3TpVQYr5K-Jw@mail.gmail.com>
In-Reply-To: <CALOAHbBy6wEwDcVaWx9PG35jknwkhM-Y-TVyis3TpVQYr5K-Jw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 30 Jul 2018 08:56:35 -0700
Message-ID: <CANn89iK4KLHww-R2JmNr-tYVcUWevq6ceFQW0qE2mJCsq6eL-g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: call tcp_drop() in tcp collapse
To:     Yafang Shao <laoar.shao@gmail.com>,
        Brendan Gregg <bgregg@netflix.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:40 PM Yafang Shao <laoar.shao@gmail.com> wrote:

> Should we put NET_INC_STATS(sock_net(sk),  mib_idx) into the funtion
> tcp_drop() ?
> Then we could easily relate the sk_drops with the SNMP counters.
>
> Something like that,
>
>     static void tcp_drop(struct sock *sk, struct sk_buff *skb, int mib_idx)
>     {
>         int segs = max_t(u16, 1, skb_shinfo(skb)->gso_segs);
>
>         atomic_add(segs, &sk->sk_drops);
>         NET_ADD_STATS(sock_net(sk), mib_idx, segs);
>         __kfree_skb(skb);
>     }

We had a discussion during netconf, and Brendan Gregg was working on
an idea like that,
so that distinct events could be traced/reported.

I prefer letting Brendan submit his patch, which not only refactors
things, but add new functionality.

Thanks.
