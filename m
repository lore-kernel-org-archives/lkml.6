Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8CBC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E5020883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in5tpqPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E5020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeGZF6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:58:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51922 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeGZF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:58:02 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so1051058itf.1;
        Wed, 25 Jul 2018 21:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uKm24KZzs7qXHcrqGjf4E/n9HyAp/3jp8FAVHLQPIqo=;
        b=in5tpqPO3WD3gct2AYVMPOO29JR1esYBcf8ENkcWbhw643UjaCm163/t/dVqEv3apO
         /G0wwzcN5Dr1qhoC7hUtKCmbSbb/aZq+e1ViC7hPsFF5VbVU2iAf4WfVs0cKTK8Fs1Dy
         jSzRx1WbFC6FOE14x1sYYwYTDQPPbYkZwEUxyxuDrQf0YSvyLA+nuZo1VI8aB2XDmdPg
         xtz4pTXXbRVRbB7QuV4em/KJAsDmjmVoOiqotePL7btzwYqOvaCo0RPQYSvexEGa2WLk
         UFiAJjXx1EHOdlFYSwQQAkQcOJE8uAuB8jgUp+5RFq9QBqkY5Nzcb5TBj+YF1LHeeBtv
         NaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uKm24KZzs7qXHcrqGjf4E/n9HyAp/3jp8FAVHLQPIqo=;
        b=rZXxMCcNyxcJ0O4NaxKmd94+FhsXhN0Y1cilcVgntYWlePvd+489hGU4lx2OTyYQMc
         RrnsK6XyO963F6Vo2b77QJUxzvUMxKZSEktvQ7icgSdG1Apm/RrPhXQEYoz5erIUStS9
         XD3GMIKxQlq8w8apgVIFHgMb+t4UuF1QJ4eUCtip75d5gIOOqWWokh7V0r1dML3TsnsS
         ZV3Ya411Qc/PJBBr++gkqWHDDj6V8MHspFX770qcFe5grB0Y5jn0xtqxYk0cnzRTL2IF
         aJLiHvRTHcObMS65KMLHX9KN+jplMvGgT5ESF//FUG6J5z5kM9I2lTZ6I5NWMFb1PYHD
         hQ4Q==
X-Gm-Message-State: AOUpUlHv+wOBE/2y6x5++ksSCNpAOYDqZpxs8Jdnj/b3lU92i0v5apMG
        FbbWBSd/RHS0qhdxJeP/RVLXbHZe2GdKHJu8eos=
X-Google-Smtp-Source: AAOMgpfNBSl5dI6uj9AnaiyZ0Wr09YbtEI0K37nn+N0NFvGI1LrCVVEDTd3jE6MpYWSiHGPH6qXPnys6R2yIcU0mlpg=
X-Received: by 2002:a24:af5d:: with SMTP id l29-v6mr642070iti.142.1532580186077;
 Wed, 25 Jul 2018 21:43:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 21:42:25
 -0700 (PDT)
In-Reply-To: <a78450d6-698a-e819-89f4-ebbe03fdf971@gmail.com>
References: <1532524010-11855-1-git-send-email-laoar.shao@gmail.com>
 <047bc12f-9eb5-e512-10c5-6334c494c77e@gmail.com> <CALOAHbCC=oWgzcA=VhkXq0rVLBa5_TvtbKtTqESGrgxvYTtH6w@mail.gmail.com>
 <096a8a2f-ea32-2107-b2af-c246450cc3b9@gmail.com> <CALOAHbASvcEdudqpit-c=RRZ8xVD+G+0jU-ynp9PsH4_mU7xjw@mail.gmail.com>
 <CALOAHbAHgEF_=w_hbd_03NOH3h9m-4W=UJ0HCYGK0BtEyq=5Tw@mail.gmail.com>
 <70428ad9-5d59-faed-4384-36190939a19d@gmail.com> <CALOAHbBKSPQdo9bA5VFLvR448Ag30nE2Td1f6204MPZ7Nfy7ag@mail.gmail.com>
 <a78450d6-698a-e819-89f4-ebbe03fdf971@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 26 Jul 2018 12:42:25 +0800
Message-ID: <CALOAHbCLN=mZGOjDg5ML60YtUZWmTTWOHuTwj5tAxyFoabKLUw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add SNMP counter for the number of packets
 pruned from ofo queue
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:36 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 07/25/2018 09:31 PM, Yafang Shao wrote:
>> On Thu, Jul 26, 2018 at 12:06 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>>
>>>
>>> On 07/25/2018 06:42 PM, Yafang Shao wrote:
>>>
>>>>
>>>> Hi Eric,
>>>>
>>>> LINUX_MIB_TCPOFOQUEUE, LINUX_MIB_TCPOFODROP and LINUX_MIB_TCPOFOMERGE
>>>> are all for the number of SKBs, but only  LINUX_MIB_OFOPRUNED is for
>>>> the event, that could lead misunderstading.
>>>> So I think introducing a counter for the number of SKB pruned could be
>>>> better, that could help us to track the whole behavior of ofo queue.
>>>> That is why I submit this patch.
>>>
>>> Sure, and I said your patch had issues.
>>> You mixed 'packets' and 'skbs' but apparently you do not get my point.
>>>
>>
>> I had noticed that I made this mistake.
>>
>>> I would rather not add another SNMP counter, and refine the current one,
>>> trying to track something more meaningful.
>>>
>>> The notion of 'skb' is internal to the kernel, and can not be mapped easily
>>> to 'number of network segments' which probably is more useful for the user.
>>>
>>> I will send this instead :
>>>
>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>> index d51fa358b2b196d0f9c258b24354813f2128a675..141a062abd0660c8f6d049de1dc7c7ecf7a7230d 100644
>>> --- a/net/ipv4/tcp_input.c
>>> +++ b/net/ipv4/tcp_input.c
>>> @@ -5001,18 +5001,19 @@ static bool tcp_prune_ofo_queue(struct sock *sk)
>>>  {
>>>         struct tcp_sock *tp = tcp_sk(sk);
>>>         struct rb_node *node, *prev;
>>> +       unsigned int segs = 0;
>>>         int goal;
>>>
>>>         if (RB_EMPTY_ROOT(&tp->out_of_order_queue))
>>>                 return false;
>>>
>>> -       NET_INC_STATS(sock_net(sk), LINUX_MIB_OFOPRUNED);
>>>         goal = sk->sk_rcvbuf >> 3;
>>>         node = &tp->ooo_last_skb->rbnode;
>>>         do {
>>>                 prev = rb_prev(node);
>>>                 rb_erase(node, &tp->out_of_order_queue);
>>>                 goal -= rb_to_skb(node)->truesize;
>>> +               segs += max_t(u16, 1, skb_shinfo(rb_to_skb(node))->gso_segs);
>>>                 tcp_drop(sk, rb_to_skb(node));
>>>                 if (!prev || goal <= 0) {
>>>                         sk_mem_reclaim(sk);
>>> @@ -5023,6 +5024,7 @@ static bool tcp_prune_ofo_queue(struct sock *sk)
>>>                 }
>>>                 node = prev;
>>>         } while (node);
>>> +       NET_ADD_STATS(sock_net(sk), LINUX_MIB_OFOPRUNED, segs);
>>>         tp->ooo_last_skb = rb_to_skb(prev);
>>>
>>>         /* Reset SACK state.  A conforming SACK implementation will
>>>
>>
>> You patch will make it more meaningful.
>> How about the other ones?
>
> Same thing really.
>
> Note that tcp_collapse() does not currently propagate skb_shinfo(skb)->gso_segs
> when rebuilding the skbs, so this will need a fix.
>

Got it.
Thank you very much for your comment.

Thanks
Yafang
