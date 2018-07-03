Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6126E24339
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rp7b6MW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6126E24339
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbeGCXEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:04:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36421 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCXES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:04:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so3823071wmc.1;
        Tue, 03 Jul 2018 16:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ffo/YhWUFazTAZr5g4vyqL8gajjndHd0ibzFaShHYv4=;
        b=rp7b6MW9HCVe9/QEXZiEtcUN/yWKrV8qF+kMLhMr0aiIxEn7vBvjeA+FhY4wNFH/mn
         obfmX9hPwn+wejiDgeT9HVJsJreplEMkhWdTCZSfKFiJUQDMNy2kwWiSqa7mARtXccZS
         jhbJjtcP77CLJh5uK+0w3nf3XzWa2t+Vk1uDX5pTsTmfDA72fG/S5n/WsgLruMSp9qPm
         NgtfkhaMdnojbK2oRVB7JPiYb1BCUuzLNAVeYG69PVNRXJ1WCcdL3mN2TvwKhJRg1OJp
         J1lW8CoPL9dtYSEl4T8WQNL8DWFLIEauEwEOwh/Rgb1AC220+RNzxP/Y92shBctxcDVH
         BFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ffo/YhWUFazTAZr5g4vyqL8gajjndHd0ibzFaShHYv4=;
        b=c0Wi0P7c63tsyohHB8A3aiYcBNG70FGkARMXYD9FW3jsEo5iyvbzxgaC4wL0hFJQcL
         ORiatZ43HRMgYaIRNTSmxfDkNptxr2IJMc2+7nWY2tXdzYA3bVrppUcD9lOrO+KOnS6W
         IPit/oPeKEprM0qbfFxQ8Np6TA8L091uNXruDtZs1q5txatCKWMZdmyHgLgfQwJWYzn+
         lFFHyvW/5c62SRbtPtvA2zTsDKr8/ff9jFM7Jm2fVjI4haJQul1hmbp8IN4DP2kvtRbU
         Bblv859g+dakbkwv68PATT290zykbSlB+afAuPUa3KxiPWgnWNCXK73feXrv20JzS+Yj
         5NXg==
X-Gm-Message-State: APt69E0/SFzQ7YmHVdYY3aSibbx43HTtwZ44OAJ44IQJoWOQULE4iO9f
        w/F7W/HmHNvSuyalYZS6o7vTFwW4YBQvNZmsBxo=
X-Google-Smtp-Source: AAOMgpc56XT4XpuZQLm6oC+KPYNvZpXZohn506gVRDoj80k72BBuY6Mp4WMO327dZ3qiDjjfOwprAlwlI5pAGALGdJw=
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr18409wme.159.1530659057222;
 Tue, 03 Jul 2018 16:04:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8a8a:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 16:03:36 -0700 (PDT)
In-Reply-To: <CADVnQymzHMfjLKRRu0AmYa6PX6YXzyZ-2sF9TjyVfLZs6GVZTw@mail.gmail.com>
References: <20180703072113.19910-1-jmaxwell37@gmail.com> <CADVnQymzHMfjLKRRu0AmYa6PX6YXzyZ-2sF9TjyVfLZs6GVZTw@mail.gmail.com>
From:   Jonathan Maxwell <jmaxwell37@gmail.com>
Date:   Wed, 4 Jul 2018 09:03:36 +1000
Message-ID: <CAGHK07BgzM1Nwz_NnG3=YQPLD=U3p9LRUuPftFw4j-V6m90zMg@mail.gmail.com>
Subject: Re: [net-next,v1] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     Neal Cardwell <ncardwell@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jon Maxwell <jmaxwell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 12:13 AM, Neal Cardwell <ncardwell@google.com> wrote:
> On Tue, Jul 3, 2018 at 3:21 AM Jon Maxwell <jmaxwell37@gmail.com> wrote:
>>
>> v1 contains the following suggestions by Neal Cardwell:
>>
>> 1) Fix up units mismatch regarding msec/jiffies.
>> 2) Address possiblility of time_remaining being negative.
>> 3) Add a helper routine to do the rto calculation.
>>
>> Every time the TCP retransmission timer fires. It checks to see if there is a
>> timeout before scheduling the next retransmit timer. The retransmit interval
>> between each retransmission increases exponentially. The issue is that in order
>> for the timeout to occur the retransmit timer needs to fire again. If the user
>> timeout check happens after the 9th retransmit for example. It needs to wait for
>> the 10th retransmit timer to fire in order to evaluate whether a timeout has
>> occurred or not. If the interval is large enough then the timeout will be
>> inaccurate.
>>
>> For example with a TCP_USER_TIMEOUT of 10 seconds without patch:
>>
>> 1st retransmit:
>>
>> 22:25:18.973488 IP host1.49310 > host2.search-agent: Flags [.]
>>
>> Last retransmit:
>>
>> 22:25:26.205499 IP host1.49310 > host2.search-agent: Flags [.]
>>
>> Timeout:
>>
>> send: Connection timed out
>> Sun Jul  1 22:25:34 EDT 2018
>>
>> We can see that last retransmit took ~7 seconds. Which pushed the total
>> timeout to ~15 seconds instead of the expected 10 seconds. This gets more
>> inaccurate the larger the TCP_USER_TIMEOUT value. As the interval increases.
>>
>> Add tcp_clamp_rto_to_user_timeout() to determine if the user rto has expired.
>> Or whether the rto interval needs to be recalculated. Use the original interval
>> if user rto is not set.
>>
>> Test results with the patch is the expected 10 second timeout:
>>
>> 1st retransmit:
>>
>> 01:37:59.022555 IP host1.49310 > host2.search-agent: Flags [.]
>>
>> Last retransmit:
>>
>> 01:38:06.486558 IP host1.49310 > host2.search-agent: Flags [.]
>>
>> Timeout:
>>
>> send: Connection timed out
>> Mon Jul  2 01:38:09 EDT 2018
>>
>> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
>> ---
>>  net/ipv4/tcp_timer.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>> index 3b3611729928..82c2a3b3713c 100644
>> --- a/net/ipv4/tcp_timer.c
>> +++ b/net/ipv4/tcp_timer.c
>> @@ -22,6 +22,23 @@
>>  #include <linux/gfp.h>
>>  #include <net/tcp.h>
>>
>> +static __u32 tcp_clamp_rto_to_user_timeout(struct sock *sk)
>> +{
>> +       struct inet_connection_sock *icsk = inet_csk(sk);
>> +       __u32 rto = icsk->icsk_rto;
>> +       __u32 elapsed, user_timeout;
>> +
>> +       if (!icsk->icsk_user_timeout)
>> +               return rto;
>> +       elapsed = tcp_time_stamp(tcp_sk(sk)) - tcp_sk(sk)->retrans_stamp;
>
> Thanks. The local logic seems OK to me now, but from reading
> retransmits_timed_out() it looks like at this point in the code we are
> not guaranteed that tcp_sk(sk)->retrans_stamp is initialized to
> something non-zero. So we probably need a preceding preparatory patch
> that factors out the first few lines of retransmits_timed_out()  into
> a helper frunction to get the start_ts for use in this calculation.
> Perhaps:
>
> u32 tcp_retrans_stamp():
>        start_ts = tcp_sk(sk)->retrans_stamp;
>        if (unlikely(!start_ts)) {
>                head = tcp_rtx_queue_head(sk);
>                if (!head)
>                        return 0;
>                start_ts = tcp_skb_timestamp(head);
>        }
>        return start_ts;
>
> And then the new tcp_clamp_rto_to_user_timeout() can use the helper:
>
> ...
> retrans_stamp = tcp_retransmit_stamp(sk);
> if (!retrans_stamp)
>    return rto;
> elapsed = tcp_time_stamp(tcp_sk(sk)) - retrans_stamp;
> ...
>
> Eric wrote those lines to recalculate start_ts, so we may want to wait
> until Eric returns to review this before merging the resulting patch
> series.
>

You are right. tcp_clamp_rto_to_user_timeout() should do the
same check as retransmits_timed_out() in regards to
tcp_sk(sk)->retrans_stamp. I'll add that to v2/test and then Eric can
comment on that if he has any input when he returns.

Thanks for all your help.

Regards

Jon

> neal
