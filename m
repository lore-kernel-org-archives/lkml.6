Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F27ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E99F208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeSH9tki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E99F208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeGPXrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 19:47:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33335 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbeGPXrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 19:47:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so24589153wrp.0;
        Mon, 16 Jul 2018 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xjd2nmE9gXC4UcmwyvRyAn4YxHLRqgMkLAyhWEivx44=;
        b=SeSH9tki6eVyVjwv/kZGY85eg3k3LSXOsAFwmS/Weuut6IRPoUcNHSLkKqy4qrcdrr
         2a5RRjwXaZwECTz8bc1LghOfzWOp/MxN8vFGqRRR4Lydt7je5KVmLXPatjkKVQiJ68bg
         YvnQwW2IV4FZbz0uDchI+r/o7FUpaJdGBBrA7pPN/4DysFLqGbsiEdQ1at7EorMjRrFU
         LP1o77NG8E3iHUAh3WJcMw+U/251+nsZ83mHW065+a0EbY9sRuB38p3ulg2Sbmpb2ECx
         Fuv4ehzItHn/gVDJNBfV/LsYC0NRBKyTiiHVPfOG78R2vBmqx2r/PgnmOcuwLnx9/iZ7
         e7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xjd2nmE9gXC4UcmwyvRyAn4YxHLRqgMkLAyhWEivx44=;
        b=ep8rPE0WAHSL6rYV+Fqqe96GyYVbiuWUH5gEWcPqb/uVN6mgGwAaX/+ZequDt/6p3n
         DC0OjQwAduEmxcNLFZuRissdbtN5/KuduY+0MDMFsLwiotxNn9XHpa1hw9jHtOezikLy
         CfcvdGU8sVfmLmLYS4L9Dcfxjgs0IfyHu/0cgrzZghn7cjSL/XGABroNFVNqaq3DY5x9
         fTboci2jQ17d5ZRqp9CbsqTjTiWPirJ7yEGS1kbWKAYdJCP6ofIauw33wuFJTG5uez8y
         hKiKXGp5zEAaKKyT66uAECVVY6PgYEf7QixaI/TFHEYGqYARFA3oF5xutlrMwl7iBthk
         RO2A==
X-Gm-Message-State: AOUpUlFjStB1iAFoBWl8kMv6Kk51UTLSZNzi336tJw0BQ0C+jyhM5Vn6
        qh5+BRLeJdSTw+8mGLcKuYdh8mAnLVJDqn2KwIg=
X-Google-Smtp-Source: AAOMgpd7loCJNbDNu9QjsrzSn+Pjvp5819i1B1LKlGTqRbleBLkuHL/ZD5blQdZgOk6Yib748EEcBF5HtGfomwekE7o=
X-Received: by 2002:adf:fec8:: with SMTP id q8-v6mr9935637wrs.164.1531783096308;
 Mon, 16 Jul 2018 16:18:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8a8a:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 16:17:35
 -0700 (PDT)
In-Reply-To: <9a96cc7d-e7bd-5be2-9ce4-e74918773560@gmail.com>
References: <20180713004919.18608-1-jmaxwell37@gmail.com> <9a96cc7d-e7bd-5be2-9ce4-e74918773560@gmail.com>
From:   Jonathan Maxwell <jmaxwell37@gmail.com>
Date:   Tue, 17 Jul 2018 09:17:35 +1000
Message-ID: <CAGHK07Ay_cz640be+psTs4_acrYTnO4Thf7LzajhJ0b=v-o3RA@mail.gmail.com>
Subject: Re: [net-next, 3/3] tcp: convert icsk_user_timeout from jiffies to msecs
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

Sorry Eric, my bad. I'll do another version with the indentation fixed and
reformatting of min_t() and resubmit.

On Tue, Jul 17, 2018 at 2:00 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 07/12/2018 05:49 PM, Jon Maxwell wrote:
>> The final patch in this series. Create the tcp_clamp_rto_to_user_timeout()
>> helper routine. To calculate the correct rto, so that the TCP_USER_TIMEOUT
>> socket option is more accurate. Taking suggestions and feedback into account
>> from Eric Dumazet, Neal Cardwell and David Laight. Due to the 1st commit we
>> can avoid the msecs_to_jiffies() and jiffies_to_msecs() dance.
>>
>> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
>> ---
>>  net/ipv4/tcp_timer.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>> index 8ab8c9645294..d4d4b30a6bec 100644
>> --- a/net/ipv4/tcp_timer.c
>> +++ b/net/ipv4/tcp_timer.c
>> @@ -36,6 +36,22 @@ u32 tcp_retransmit_stamp(const struct sock *sk)
>>       return start_ts;
>>  }
>>
>> +static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
>> +{
>> +     struct inet_connection_sock *icsk = inet_csk(sk);
>> +     u32 elapsed, start_ts;
>> +
>> +     start_ts = tcp_retransmit_stamp(sk);
>> +     if (!icsk->icsk_user_timeout || !start_ts)
>> +             return icsk->icsk_rto;
>> +     elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
>> +     if (elapsed >= icsk->icsk_user_timeout)
>> +             return 1; /* user timeout has passed; fire ASAP */
>> +     else
>> +             return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(icsk->icsk_user_timeout -
>> +                          elapsed));
>
>         if (elapsed >= icsk->icsk_user_timeout)
>                 return 1; /* user timeout has passed; fire ASAP */
>
>         return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(icsk->icsk_user_timeout - elapsed));
>
> Thanks !
