Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B69C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EB324E1D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6CWLZJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EB324E1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbeGCEnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:43:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39297 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeGCEnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:43:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so730835wmc.4;
        Mon, 02 Jul 2018 21:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q2d0YiRcxSDjUQkoiSElRS+K1xWA3Uky6RIy9XUMUi4=;
        b=o6CWLZJpH6sVgQouRFHR9mAkVLG2l9YOwVCcVnH+t/qyCUy5yPIMSdDovO25SwRXOJ
         jkZUmhqHsVFCzAXYETVziuqsSzEdEYocLgfU8SqMTrkrC9nWD5EmBfi6aBZAJ/5+o//n
         s5x+LkrOEUANQZLVu2E+N7JX4eSr7IDwUQQVMYQOrMgvZ1YGniOaNg+1fpXvXI1jlF7W
         8oROsQuc/M/Ro1OKjV7usMC6Ckx7P0gpW3Bowx1Vq6Rq9fYNyVJKYyCHIRrljApNuWya
         o6xRH19LyVWLuwUCf3RErtu/DXGUhWMy7L1e1oD881YchXuZmZkjucqG7vsGiDKbN5xD
         +UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q2d0YiRcxSDjUQkoiSElRS+K1xWA3Uky6RIy9XUMUi4=;
        b=YnL+N5ggfYLEYuYlNDwIrbIEzafPABtVqEbTZiV5OHN6KhuAtIJrV2HLrPIOO7McKf
         VS3P60B4uuOQ92uIR0AjsU8payyMAC0ziY+KnySOzXHEi2si8mIYrPkShl9mYO959Vkg
         atMqdnn1JMULSkNHsuBpNBVwrUkPkkJ0R/fUz66DG0+aM0IhqNpue2pkVt1FW35jUJBE
         azPNHWzjuvEcYfcunSABXYzuXyW4zN6s6Oh1pe8rvTq2ekTcAooyKBmfcGJXHf2sKfA2
         C0qLKYNiWM80yuosRwDqsmA1qUG5jtM1jkWBPpUUfSRftNuxNv/2Mdf/I6LbFU2WtVZQ
         tujA==
X-Gm-Message-State: APt69E38MLuLOSg9XKXuLRyaTHMYq0QlIytj4UtdrGY2nxsXre87LZUv
        j4XsnKw9yUEPFVeD+f0SfAAQs+p/r2pRsGBKMQ4=
X-Google-Smtp-Source: AAOMgpfCnTkGzJIePJNbtFajwnSy5etb9egN2C0xjnpbNWUd9RbF0btsbMZw4o7qPKU1pt8nJuU7gUTleSc85a7636I=
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr9611531wme.159.1530592987110;
 Mon, 02 Jul 2018 21:43:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8a8a:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 21:42:26 -0700 (PDT)
In-Reply-To: <CAGHK07BAWS2iNs2CYLQPLz-vKCP2TRAEAqR8oKkv2o_cOoFLUA@mail.gmail.com>
References: <20180703011726.8301-1-jmaxwell37@gmail.com> <CADVnQynNGbmBvheBdzzr5K8BVUXewzr61ZNsTz-mteE3eGUm3g@mail.gmail.com>
 <CAGHK07BAWS2iNs2CYLQPLz-vKCP2TRAEAqR8oKkv2o_cOoFLUA@mail.gmail.com>
From:   Jonathan Maxwell <jmaxwell37@gmail.com>
Date:   Tue, 3 Jul 2018 14:42:26 +1000
Message-ID: <CAGHK07AOPe_uoSweBwGa5a30uiqqgmUFPP_aUOP20Y8o0dCwSg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
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

On Tue, Jul 3, 2018 at 1:15 PM, Jonathan Maxwell <jmaxwell37@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 1:00 PM, Neal Cardwell <ncardwell@google.com> wrote:
>> On Mon, Jul 2, 2018 at 9:18 PM Jon Maxwell <jmaxwell37@gmail.com> wrote:
>>>
>>> Every time the TCP retransmission timer fires. It checks to see if there is a
>>> timeout before scheduling the next retransmit timer. The retransmit interval
>>> between each retransmission increases exponentially. The issue is that in order
>>> for the timeout to occur the retransmit timer needs to fire again. If the user
>>> timeout check happens after the 9th retransmit for example. It needs to wait for
>>> the 10th retransmit timer to fire in order to evaluate whether a timeout has
>>> occurred or not. If the interval is large enough then the timeout will be
>>> inaccurate.
>>>
>>> For example with a TCP_USER_TIMEOUT of 10 seconds without patch:
>>>
>>> 1st retransmit:
>>>
>>> 22:25:18.973488 IP host1.49310 > host2.search-agent: Flags [.]
>>>
>>> Last retransmit:
>>>
>>> 22:25:26.205499 IP host1.49310 > host2.search-agent: Flags [.]
>>>
>>> Timeout:
>>>
>>> send: Connection timed out
>>> Sun Jul  1 22:25:34 EDT 2018
>>>
>>> We can see that last retransmit took ~7 seconds. Which pushed the total
>>> timeout to ~15 seconds instead of the expected 10 seconds. This gets more
>>> inaccurate the larger the TCP_USER_TIMEOUT value. As the interval increases.
>>>
>>> Fix this by recalculating the last retransmit interval so that it fires when
>>> the timeout should occur. Only implement when icsk->icsk_user_timeout is set.
>>>
>>> Test results with the patch is the expected 10 second timeout:
>>>
>>> 1st retransmit:
>>>
>>> 01:37:59.022555 IP host1.49310 > host2.search-agent: Flags [.]
>>>
>>> Last retransmit:
>>>
>>> 01:38:06.486558 IP host1.49310 > host2.search-agent: Flags [.]
>>>
>>> Timeout:
>>>
>>> send: Connection timed out
>>> Mon Jul  2 01:38:09 EDT 2018
>>>
>>> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
>>> ---
>>>  net/ipv4/tcp_timer.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>>> index 3b3611729928..94491a481722 100644
>>> --- a/net/ipv4/tcp_timer.c
>>> +++ b/net/ipv4/tcp_timer.c
>>> @@ -407,6 +407,7 @@ void tcp_retransmit_timer(struct sock *sk)
>>>         struct tcp_sock *tp = tcp_sk(sk);
>>>         struct net *net = sock_net(sk);
>>>         struct inet_connection_sock *icsk = inet_csk(sk);
>>> +       __u32 time_remaining = 0;
>>>
>>>         if (tp->fastopen_rsk) {
>>>                 WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
>>> @@ -535,6 +536,12 @@ void tcp_retransmit_timer(struct sock *sk)
>>>                 /* Use normal (exponential) backoff */
>>>                 icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
>>>         }
>>> +       if (icsk->icsk_user_timeout) {
>>> +               time_remaining = jiffies_to_msecs(icsk->icsk_user_timeout) -
>>> +                              (tcp_time_stamp(tcp_sk(sk)) - tcp_sk(sk)->retrans_stamp);
>>> +               if (time_remaining < icsk->icsk_rto)
>>> +                       icsk->icsk_rto = time_remaining;
>>> +       }
>>
>> Thanks, a more precise user timeout sounds nice. A couple thoughts:
>>
>> (a) The  icsk->icsk_rto is in jiffies, and the time_remaining is in
>> msecs, so it looks like there is a units mismatch here in the
>> comparisons and assignment.
>>
>> (b) It also seems like the time_remaining could be negative, because
>> (a) the icsk_user_timeout is not involved in the baseline RTO
>> calculation, so that perhaps the first RTO to fire might be beyond the
>> icsk_user_timeout AFAIK, and (b) if the machine is very busy then the
>> timer handler can be delayed beyond the targeted icsk_user_timeout.
>> But time_remaining is a __u32, and  icsk->icsk_rto is also a __u32, so
>> it seems like a negative number in time_remaining would usually be
>> treated as a very large unsigned positive number in this comparison:
>>
>> +               if (time_remaining < icsk->icsk_rto)
>>
>> (c) If the user timeout is changed between RTO expirations to push the
>> user timeout further in the future,  then it seems like this commit
>> will have side effects that left the icsk->icsk_rto in a weird state
>> that does not do the expected exponential backoff correctly.
>>
>> (d) There are also wrapping issues to watch out for, since the
>> tcp_time_stamp(tcp_sk(sk)) and tcp_sk(sk)->retrans_stamp are
>> milliseconds, which will wrap every 49 days or so. Seems like the code
>> is OK in that respect.
>>
>> (e) It also might be nice to put this logic in a helper, rather than
>> growing the body of tcp_retransmit_timer().
>>
>> What about something like (pseudocode):
>>
>> --
>>
>> static __u32 tcp_clamp_rto_to_user_timeout(sk):
>>    rto = icsk->icsk_rto;
>>    if (!icsk->icsk_user_timeout)
>>       return rto;
>>    elapsed = tcp_time_stamp(tcp_sk(sk)) - tcp_sk(sk)->retrans_stamp;
>>    user_timeout = jiffies_to_msecs(icsk->icsk_user_timeout);
>>    if (elapsed >= user_timeout)
>>       rto = 1;  /* user timeout has passed; fire ASAP */
>>    else
>>       rto = min(rto, msecs_to_jiffies(user_timeout - elapsed));
>>    return rto;
>>
>> tcp_retransmit_timer():
>> ...
>>   rto = tcp_clamp_rto_to_user_timeout(sk);
>>   inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, rto, TCP_RTO_MAX);
>>
>
> Thanks Neal, that looks like a good idea. Let me test that out in my reproducer.
>
> Regards
>
> Jon
>

Thanks for your input and suggestions Neal.

Results were positive in the reproducer. I'll tidy the patch up a bit and submit
as v1 with your ideas.

>> --
>>
>> neal
