Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B6DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2582088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFEg5uDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2582088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeG1EsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 00:48:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38926 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeG1EsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 00:48:15 -0400
Received: by mail-it0-f68.google.com with SMTP id g141-v6so10023530ita.4;
        Fri, 27 Jul 2018 20:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ngTwG3AyKoLbVmOXZlv8PTFVymmOH84nJz8xqQxkx6o=;
        b=qFEg5uDEd/7tM54+zfrD+/tc9UEXg131sv0mdv3qWL6VEZWhff8JUnu5OzeYTjkhXC
         ePlE15MlpR9LAlxKDHpYCxUPkVc9Q772lmnNdbu/jmEkxFOFKIfRwa8bZ7fLoRsqTOKv
         bU1mGJDz8xpqjzkjkedy4IZcJip8nM6yt8/uDFQc0mWrPqP+/jukoEa334RTHFKJEl5D
         TwxJRAh3VBpKd/WRdN3ZvuIjRCiGNMqitmDABB/5VDfmE4GR0wvUp5UOMLpHqgzqYcGN
         Ws3XZAswm2uW6a5FgQJj/BYrptgaA4om2pITaPsHvuCGK7l51N4To3UsPLGXTPuE+jtF
         HiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ngTwG3AyKoLbVmOXZlv8PTFVymmOH84nJz8xqQxkx6o=;
        b=S2Er4MGsI9nEBK0syq4aUvK5g+0/hvxNDKn5E+A7JDQStuSOpjJ1NTiK3jZIFZARY1
         XdfABYMed/ZZHjQM0EoPt2ftC9PNagz7+HkaI1aWF2APiaHeHKd22bGo6Daywlz2qZfE
         q076qSBdVZ1J8dvW+8k5wJuRxiu2hRqnccjCbGGFPGlwYRvlMoYwaTOnMMTCUBaGl9/h
         bT2W97fNNM9/DL10QzklQQmp2GLf2QImn4OHSXAvPRsZRBuxXBb67yuQiSpQzSCvSYW6
         SsOvFIpRzaExXNU4Uz/ykWIZ403iQb8I0O6J4nRtIag9FKXgzikMsB9/VUhwijiq+7Zz
         g2qg==
X-Gm-Message-State: AOUpUlE44Q0CTidESVP7jjihkCN5vB5Xoz2UlIwzH0lQwRjg8nh1+h2+
        lloWRHa3c9Qxp5TNbP5iIlnlhJNds8y2+mdicAU=
X-Google-Smtp-Source: AAOMgpf5dkJFaXu29lhu8clLm2VDltoRrGoTX79jsQsX1PHBtYdA/a3veMX6LCiBPsNiS2uwvS8kuDm19iWyA98wPhY=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr7602050itb.38.1532748206140;
 Fri, 27 Jul 2018 20:23:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 20:22:45
 -0700 (PDT)
In-Reply-To: <CANn89iKFH_F0_Ri76Zsez2Nn8JZ9obprsk+OE7i+enGC=n8Syw@mail.gmail.com>
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
 <1532746900-11710-2-git-send-email-laoar.shao@gmail.com> <CANn89iKFH_F0_Ri76Zsez2Nn8JZ9obprsk+OE7i+enGC=n8Syw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 28 Jul 2018 11:22:45 +0800
Message-ID: <CALOAHbABtVpnjSUFjYYvscPEjSUOA8Hp=JeX+_fCU5Zfaasvbw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: propagate GSO to the new skb built in
 tcp collapse
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 11:13 AM, Eric Dumazet <edumazet@google.com> wrote:
> On Fri, Jul 27, 2018 at 8:02 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> Currently the collapsed SKB doesn't propagate the GSO information to the
>> new SKB.
>> The GSO should be propagated for better tracking, i.e. when this SKB is
>> dropped we could know how many network segments are dropped.
>
> What is "the GSO"  ?
>

I mean gso_segs, gso_type and gso_size, which are all set in GRO.

>>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> ---
>>  net/ipv4/tcp_input.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 90f83eb..af52e4e 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -4893,6 +4893,8 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
>>                 if (!nskb)
>>                         break;
>>
>> +               skb_shinfo(nskb)->gso_size = skb_shinfo(skb)->gso_size;
>> +               skb_shinfo(nskb)->gso_type = skb_shinfo(skb)->gso_type;
>
> Why gso_size and gso_type are important ?
>
> Where later in the stack these values are used ?
>

I'm not sure it is important or not.
I just worry it may be used latter.

>>                 memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>>  #ifdef CONFIG_TLS_DEVICE
>>                 nskb->decrypted = skb->decrypted;
>> @@ -4906,18 +4908,24 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
>>
>>                 /* Copy data, releasing collapsed skbs. */
>>                 while (copy > 0) {
>> -                       int offset = start - TCP_SKB_CB(skb)->seq;
>>                         int size = TCP_SKB_CB(skb)->end_seq - start;
>> +                       int offset = start - TCP_SKB_CB(skb)->seq;
>
>>
>>                         BUG_ON(offset < 0);
>>                         if (size > 0) {
>> -                               size = min(copy, size);
>> +                               if (copy >= size)
>> +                                       skb_shinfo(nskb)->gso_segs +=
>> +                                               max_t(u16, 1, skb_shinfo(skb)->gso_segs);
>> +                               else
>> +                                       size = copy;
>> +
>
> So... what happens if copy was partial ?
>

In the current patch, if copy was parial, the gso_segs are in the
orignal SKB as it will not be freed now.
If that is not ok, what about the bellow change ?

else {
    size = copy;
    skb_shinfo(nskb)->gso_segs +=  DIV_ROUND_UP(size,
skb_shinfo(nskb)->gso_size);
}

> Your patch does not really fix the uncertainty, it merely shifts it a bit.
