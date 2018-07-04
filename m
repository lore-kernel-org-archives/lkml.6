Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC347C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E285240CB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNlIWmL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E285240CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeGDXfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 19:35:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38957 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752937AbeGDXfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 19:35:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so114867wre.6;
        Wed, 04 Jul 2018 16:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p9opAcSO0RnsCyqZl5PK1gPkL6JVP02xw58FUbGrMsM=;
        b=uNlIWmL5RhbJYWG3nZa58oQ1ZxzBLbHDdkGpE6QjK1kFz9hhANegn6q1pwBpxhKWk3
         CZbOeCjEvDSj2wdhHVXpf0ukKyyKv8frfJ+LE7m55Wnu58Zwu5Q3ieDUzD28hWCa6zho
         nXSDrZ5WRljUo9R+rHdmsP3CfojE8HRIf9etvgdtaxcYYWgaibmpbxDI1kZjfDwrkFMC
         wJ9hvUpBd4um/aowyDnb5tZ/Ef/Qr7yRib9KJNh3RqgX1opqYtlYf56aWHLbd3WhBta5
         ZF+17e3Usf7KqMU3C7E/ukV0LVPtguUPUkjnTQvpT/LqptDy+M6OORqYGNgjMTNk7CPo
         eq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p9opAcSO0RnsCyqZl5PK1gPkL6JVP02xw58FUbGrMsM=;
        b=QeZ1uCc2/c2fqzAwJ3DfpX028F6D+LlMW5EoL9HkkWYcbngf9VTdlmoXg8QnY7aSri
         +qm+0bX68k5kGNfa3DTqbNT9hr24VyMAo+ijE/JPwtBx+Z63uirgz+zMS3UddraczuUA
         z1pRL/GEx6EX7Awfkg8tau7kytin0omWRfo8XXwXixoJhZsg3L7jyxBdwhvFIQaIeXo7
         1u1QGigzVMNjXtft1GZfk/mMWkndHHaX8jagcS/ok7hXlj1RMtaZiJ86GpKfu6c4jO7M
         r5uQ261Bh6ck8MG/+HNt6HTIj+jNUMPswNu7S5XRrx+54srXB9IJB+8Ty4mpz7tzRs5Y
         O7pA==
X-Gm-Message-State: APt69E0BeNR7O4E+sgRJNzqvCsFXnkm7zOC7EkLOpSjBUF9M1wZQY0PU
        YR5EMZVE+/Br2SmsOEpzdlV8/GPk0/8lqAWfBJg=
X-Google-Smtp-Source: AAOMgpcnRaUIQAX9Y9TJ0dgQKKcpq7bFRPkqep5rPRUWSB1iEt/xzdEIPtvzbI09XtCO6wwD2NWNU59igWzdF1DWgxo=
X-Received: by 2002:adf:e78d:: with SMTP id n13-v6mr2792347wrm.136.1530747304517;
 Wed, 04 Jul 2018 16:35:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8a8a:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 16:34:23 -0700 (PDT)
In-Reply-To: <2a78c5cbb53248289b54505aece15584@AcuMS.aculab.com>
References: <20180704000608.17360-1-jmaxwell37@gmail.com> <CADVnQykfvmWyOJxT7_nHPOvfNEwi7+Hz2qJPooPpNLmdMWChYw@mail.gmail.com>
 <2a78c5cbb53248289b54505aece15584@AcuMS.aculab.com>
From:   Jonathan Maxwell <jmaxwell37@gmail.com>
Date:   Thu, 5 Jul 2018 09:34:23 +1000
Message-ID: <CAGHK07Afdys4WHEjsekSChbFVGwWVccofSS+Bk357m8=1BfJBw@mail.gmail.com>
Subject: Re: [net-next,v2] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     David Laight <David.Laight@aculab.com>
Cc:     Neal Cardwell <ncardwell@google.com>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "jmaxwell@redhat.com" <jmaxwell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's wait for Eric to review. Then I'll put together the next version.

Regards

Jon

On Thu, Jul 5, 2018 at 12:57 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Neal Cardwell
>> Sent: 04 July 2018 15:14
>>
>> On Tue, Jul 3, 2018 at 8:06 PM Jon Maxwell <jmaxwell37@gmail.com> wrote:
>> >
>> > Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
>> > ---
>> >  net/ipv4/tcp_timer.c | 48 +++++++++++++++++++++++++++++++++++++++---------
>> >  1 file changed, 39 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>> > index 3b3611729928..d129e670d02a 100644
>> > --- a/net/ipv4/tcp_timer.c
>> > +++ b/net/ipv4/tcp_timer.c
> ...
>> > +static __u32 tcp_clamp_rto_to_user_timeout(struct sock *sk)
>> > +{
>> > +       struct inet_connection_sock *icsk = inet_csk(sk);
>> > +       __u32 rto = icsk->icsk_rto;
>
> Why cache rto past all the function calls until it is needed?
>
>> > +       __u32 elapsed, user_timeout;
>> > +       unsigned int start_ts;
>>
>> I'd suggest u32 here for start_ts (per the rationale above).
>>
>> > +
>> > +       start_ts = tcp_retransmit_stamp(sk);
>> > +       if (!icsk->icsk_user_timeout || !start_ts)
>> > +               return rto;
>> > +       elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
>> > +       user_timeout = jiffies_to_msecs(icsk->icsk_user_timeout);
>> > +       if (elapsed >= user_timeout)
>> > +               rto = 1;  /* user timeout has passed; fire ASAP */
>> > +       else
>> > +               rto = min(rto, (__u32)msecs_to_jiffies(user_timeout - elapsed));
>>
>> My sense is that min_t would be preferred here, e.g:
>>
>>   rto = min_t(__u32, rto, msecs_to_jiffies(user_timeout - elapsed));
>
> Think I'd just write the conditional...
>
>> > +       return rto;
>> > +}
>
> Looks to me like it doesn't correctly allow for the conversions
> between millisecond and jiffies either.
> I suspect the msecs_to_jiffies() call can return zero (unless it rounds up).
> Coding with a signed 'time until user timeout' might make it simpler.
>
>         David
>
>
