Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBC3208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9p5SzC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBC3208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbeGKChQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:37:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37876 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbeGKChP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:37:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so882452wmh.2;
        Tue, 10 Jul 2018 19:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nRWRgznFFi80zEbm4C47FpyOl+Ew19gqtlF1TqbAlh8=;
        b=T9p5SzC3YMcIGV9QIOG5GjR3Gz2V/70lwAOP8fGz3KzbMklSOKW1KybgNlJDM0WY8g
         /5lCVW+9/AmjtoK0r0e3SiEKUSeqXiU2C60HA+t/y/ZFuZEUCrNf9TKC1yVzZPtqwGbN
         xuIr4rpX3f9vSTc1w9M89n5uHs8JBGc3ar663WE56Ji4ryt7JKks7fX5yImTQZbTX+4+
         CFd6/8/mdyc94iW64pf1fgFn/eNQoR2iXBcEDRyEpPyB0ulPTU10NSV4rlF5mijyDsQf
         /IL3VJX/yL0LpWtY1hECrXJ3/okkusQ8ffp9D2NLppZjUQBbt/wYQ1vPppfNOYD1fHy5
         +Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nRWRgznFFi80zEbm4C47FpyOl+Ew19gqtlF1TqbAlh8=;
        b=o97lgsFSSH9mDPbcwa4HmzqfnuxHgf17EU0NwH3XH1t1opGtCL6ydoJHbegfdSfI3a
         GADWywLEw9zlZz9WFOTYw6hXgj9+xRp37zyaj5g76R3wJx/orElTLDDR/7zJ7dqyIos0
         vIESSFXiudzFBkFdSJ05g7/ffi6j9z+1ajquCJ2EuD032XedBaK5LQZkxHHEEQWUZZ+k
         B7zr/gXtgFSqegC0y4gYN0e0JmvoGSN2/5ecHEXjQSc3oilbOZwehW67zZHDifLIk07N
         JMjB4oQ/OU61LIKLthCxHhnjPYtdeCoiIE3WCzI92pJjXcGKMeyYS6rv8iRU0Xk0/evP
         1mMw==
X-Gm-Message-State: APt69E3KWALYBgt4N5PR9e/wc9T/JPxZcY/gY2bC1jLOpViVpEpJgUhJ
        q9Dou/tJXu/pfIKaSLK5z81oNLRiz17uYRA0azU=
X-Google-Smtp-Source: AAOMgpcLrzHRCeOJLUfAqpABpvJPdX0sG9X3WCMr4aJpNBkBj6wMHe3bNaTTr4mQx5G0VHb/Yjt/ciSCH7jwuahsPIo=
X-Received: by 2002:a1c:37cd:: with SMTP id e196-v6mr15112153wma.84.1531276514778;
 Tue, 10 Jul 2018 19:35:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8a8a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 19:34:34
 -0700 (PDT)
In-Reply-To: <46861e12-1ae5-374f-e907-87ba6241de5f@gmail.com>
References: <20180710065147.27647-1-jmaxwell37@gmail.com> <3f856638-52bc-6630-a3d2-2b50f1bf7e48@gmail.com>
 <c29f1535-3c5d-e588-862c-ba948363c973@gmail.com> <CAGHK07Aoa81QN+LmVttJQ56Sn+R-KyksYqZxSYL5-5reDRt3WA@mail.gmail.com>
 <46861e12-1ae5-374f-e907-87ba6241de5f@gmail.com>
From:   Jonathan Maxwell <jmaxwell37@gmail.com>
Date:   Wed, 11 Jul 2018 12:34:34 +1000
Message-ID: <CAGHK07BOhqiYsKkmVD70q-YVDfF8zhkFfFODpbFyf900fz1B7A@mail.gmail.com>
Subject: Re: [net-next,v3] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        David Laight <David.Laight@aculab.com>,
        kuznet <kuznet@ms2.inr.ac.ru>,
        yoshfuji <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jon Maxwell <jmaxwell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 12:04 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 07/10/2018 05:33 PM, Jonathan Maxwell wrote:
>> On Tue, Jul 10, 2018 at 10:48 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>>
>>>
>>> On 07/10/2018 05:38 AM, Eric Dumazet wrote:
>>>
>>>> Note that if we always do jiffies_to_msecs(icsk->icsk_user_timeout) in TCP,
>>>> we also could change the convention and store msecs in this field instead of jiffies.
>>>>
>>>> That would eliminate the msecs_to_jiffies() and jiffies_to_msecs() dance.
>>>>
>>>> (That would be done in a patch of its own, of course)
>>>
>>> tcp_keepalive_timer() does use icsk->icsk_user_timeout directly in jiffies unit,
>>> but considering keeapalive timers are rarely used, this point would have to
>>> do the msecs_to_jiffies() conversion.
>>
>> and also if icsk->icsk_user_timeout = 0, then timeout in retransmits_timed_out()
>> is in jiffies and that would need to addressed.
>
> Absolutely, this is what I was suggesting.
>
> Pseudo code for this part, before your changes.
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 3b3611729928f77934e0298bb248e55c7a7c5def..cae7bbc956ed51e9d381650957f54550cc0967d9 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -183,8 +183,9 @@ static bool retransmits_timed_out(struct sock *sk,
>                 else
>                         timeout = ((2 << linear_backoff_thresh) - 1) * rto_base +
>                                 (boundary - linear_backoff_thresh) * TCP_RTO_MAX;
> +               timeout = jiffies_to_msecs(timeout)'
>         }
> -       return (tcp_time_stamp(tcp_sk(sk)) - start_ts) >= jiffies_to_msecs(timeout);
> +       return (tcp_time_stamp(tcp_sk(sk)) - start_ts) >= timeout;
>  }
>
>  /* A write timeout has occurred. Process the after effects. */
>
>

That makes sense thanks. I'll look into this and get a patch together.
