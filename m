Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C20C04EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28CE2089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5jUuMA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28CE2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeKQLHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:07:47 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35145 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbeKQLHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:07:47 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so467902itj.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 16:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=7SJs0z6fMe0y+z6dvi1jUk0Bv0I1maRi2aHfLWKL26Q=;
        b=X5jUuMA3OszPeeZfrrhS7mirSeaHEN7CaAuaoOXsKsEhLIWdzjESCRnObdxcC6fzOo
         LHwqXIjA+bNOr+JVZPTDYBjpomiBA7cEWQ7h0wKTIxiNe+xqAHKsy5SL/UxfH3oYpOwp
         bwmM0B+Xe7SV5jfd3QgaNDgTOum2fZ0H19pHb7vPaaGt//J0DH9617RW2LtZuIbjImYf
         OV7SvEnyUg+SadxT98VpvgDA6ZqYQh3Mbz2o61tzxn1/bdpANhJq2KTOEqYMSyg+H5zP
         rtI+dpRc95+tI92mcjG/zyAyzNuOim88XB71uP1bTGXxNgf9bQi6CeUhd4THdiyVw+Mk
         TKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=7SJs0z6fMe0y+z6dvi1jUk0Bv0I1maRi2aHfLWKL26Q=;
        b=nRMEBJqvmv/YhoUHzojjeK2a3Wvm+tC8oHY7cWMRvW4zjXyKCb+MbaR8MegudHU7dn
         6FXhmeXJHvUDCzvLH7w4RRIO+vvnJA/et4i9TDCsGc73zEtsc8yU1rxaw32+baChkCkN
         XGd0Thu+ofQo89/B0UC8KENfrWVzJm4bhjer9F9ARbPMamvBDfgvOHjVGvfcKHVS5DWd
         gP8RiV812w1UdtZA3N06Edn278jts2shLv/XA1o4xXyDjbtqxWj8NExpSgHZe6NSqMPM
         y4blWWW5mQOIZ/9OwEa6KucTWJqO4QEgbH755zvS2/KBA1tFygAZOYu69nkJJnVfSVe3
         YOBw==
X-Gm-Message-State: AGRZ1gLJQykZqbQM8KK47NUiypu6+D7SSD+KYJn//5SYEFBHVw11veKQ
        wQ2hb7r2tK6WwYRSCF7pNQ5f/eWY0Yhp+iViEcswvw==
X-Google-Smtp-Source: AJdET5coQKUA9br9jlVluVYN8bRaak1bhIzme42albYAoh+SaLUuNQr6TV3K//UMlH83vLXLOocMdTM70bAmcL3q6gU=
X-Received: by 2002:a02:8904:: with SMTP id o4mr9342017jaj.35.1542415987409;
 Fri, 16 Nov 2018 16:53:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 16:52:46
 -0800 (PST)
In-Reply-To: <CACT4Y+aLOqSqdfRYEyQB33MSXXb-3=APs5B1ZHsXJ2XYXF_Ppw@mail.gmail.com>
References: <CACT4Y+Z6SS2AzYnMjbx_cmrataCLUhdjAx8XyYAnTMdVzndH5w@mail.gmail.com>
 <CACT4Y+aLOqSqdfRYEyQB33MSXXb-3=APs5B1ZHsXJ2XYXF_Ppw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Nov 2018 16:52:46 -0800
Message-ID: <CACT4Y+bxBnWr0oa5=YHnPAtN2DAypSNFEm5k_YOUqGsgb-4XOQ@mail.gmail.com>
Subject: Re: KASAN poisoning for skb linear data
To:     David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        andreyknvl <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 1:20 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Jan 15, 2018 at 3:15 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> Hi,
>>
>> As far as I understand pskb_may_pull() plays important role in packet
>> parsing for all protocols. And we did custom fragmentation of packets
>> emitted via tun (IFF_NAPI_FRAGS). However, it seems that it does not
>> give any results (bugs found), and I think the reason for this is that
>> linear data is rounded up and is usually quite large. So if a parsing
>> function does pskb_may_pull(1), or does not do it at all, it can
>> usually access more and it will go unnoticed. KASAN has an ability to
>> do custom poisoning: it can poison/unpoison any memory range, and then
>> detect any reads/writes to that range. What do you think about adding
>> custom KASAN poisoning to pskb_may_pull() and switching it to
>> non-eager mode (pull only what was requested) under KASAN? Do you
>> think it has potential for finding important bugs? What amount of work
>> is this?
>
> Filed https://bugzilla.kernel.org/show_bug.cgi?id=199055 for this so
> it's not get lost.

Bringing this up after we discussed this with Dave on plumbers.

There are 2 strategies for making KASAN aware of exact skb linear
buffer semantics.
1. Just using kmalloc/free each time with precise size.
2. Using KASAN annotations:

void kasan_poison_shadow(const void *address, size_t size, u8 value);
void kasan_unpoison_shadow(const void *address, size_t size);

https://github.com/torvalds/linux/blob/master/mm/kasan/kasan.c#L57
https://github.com/torvalds/linux/blob/master/include/linux/kasan.h#L38

If we use annotations we can keep more of the existing skb logic.
But AFAIU this way we won't be able to detect all accesses after a
potential reallocation.

There are also annotations for explicit checks:
https://github.com/torvalds/linux/blob/master/include/linux/kasan-checks.h#L6
But not sure we need them here (maybe more appropriate for places
where KASAN does not see memory accesses e.g. a driver handing off a
packet to DMA).


I don't think it makes sense to make any more complex than necessary
in the name of performance, at least initially. This will be enabled
only under #ifdef KASAN.

If somebody gives us any prototype, we can assess (1) if it works and
(2) if it catches any new bugs.

Thanks
