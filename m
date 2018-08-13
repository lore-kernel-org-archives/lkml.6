Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A262AC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A24521747
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iz8KbD2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A24521747
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeHMPrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:47:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37264 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeHMPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:47:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so7632851pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8bro0dRfUsq78o3rcr0XiDCeEJTSQCV4zsfqezZ8Dzk=;
        b=iz8KbD2Y/ctaBoqtNgFKVb+Frj/sRtuCoPtyFKqFijEy/RtDB7Pm5WekA5js1kXcwA
         jpKZlYmhjL7l0MloaadTdpm+jdrBY2VP2wWsOoXj2Exfj5pX2jmjtI/9b+na8Fz8FnqL
         c5PmW8r4oHX+jMNKhG8XxnNvBN1dageexwF2VN6p9ZRLN+JIf+Z/syaIEgV2z9DZikEp
         IJu9qQrfrLLOo9iiZcOoOZCBgYSlk1WImvP6Stnv9IKn68ks6qbOOBFXr2hNNROAYywm
         2sjKSk+JfHYVtbIEjNpk6hytmVVsAJ9CIzEnieOHv/+phPOzzAs6rTCsm1ABShgSicis
         MATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8bro0dRfUsq78o3rcr0XiDCeEJTSQCV4zsfqezZ8Dzk=;
        b=ESwpGCYUeRnDK8Lk0Ze4GJo+0LacAAtpcu/HFQ4XkK6aEWzJen3cTFNqS0fzYF6jzT
         d6P3H74xA8C97q5FmuphFGgsB5IlkutyAyA1vqGwgoG+ueqsL5MRFm4He30Wbla9qmGZ
         sAjHo16C9/V/t7dNBF1sXdDXORuJoaXDhq9OCosYXn+SLXgHgg2H6sqW7Nw0HZ4El9L9
         W3nHlXDj6OWxmOz4lZNycJuJCTC+8kJDd8G6a9yCaIX4SkHVcIuyX7SVAlwuvMH42hvM
         hWTYrp6XtHOovQ9Xkb2/oNqfEtVA8rUa85JNdlgtOKrq/P9mmOqryev7Oj3fRzxRvVdB
         kDyA==
X-Gm-Message-State: AOUpUlEqprvb2e0kVVDZgEQGPIQzP0NC2fE6PC2dtXAyYT4RphfMd+1m
        xFENgiL2RLMU4EOjBhQQ+yhegIuEUpugJx0Sflst7w==
X-Google-Smtp-Source: AA+uWPwBRN7XeMpY0GUn7sJ89xh6o8jzLsmJhCS72sgOnv2pSft9ahu6g/0z5ZcABLVhvfraNtEqluYN1JaCab+Q8MQ=
X-Received: by 2002:a63:d443:: with SMTP id i3-v6mr17522868pgj.216.1534165511339;
 Mon, 13 Aug 2018 06:05:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 13 Aug 2018 06:04:50
 -0700 (PDT)
In-Reply-To: <20180813014815.GB6777@nautica>
References: <20180811144254.23665-1-tomasbortoli@gmail.com>
 <20180811144254.23665-2-tomasbortoli@gmail.com> <5B70E0D1.2080300@huawei.com> <20180813014815.GB6777@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 13 Aug 2018 15:04:50 +0200
Message-ID: <CACT4Y+YQckNWVcBoW1WtH=5pEU5KXB8J8A=QssWx8nbp5GtNnw@mail.gmail.com>
Subject: Re: [V9fs-developer] [PATCH 2/2] 9p: Add refcount to p9_req_t
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     piaojun <piaojun@huawei.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 3:48 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> piaojun wrote on Mon, Aug 13, 2018:
>> Could you help paste the reason of the crash bug to help others
>> understand more clearly? And I have another question below.
>
> The problem for tcp (but other transports have a similar problem) is
> that with a malicious server like syzkaller they can try to submit
> replies before the request came in.
>
> This leads in the writer thread trying to write a buffer that has
> already been freed, and if memory has been reused could potentially leak
> some information.
>
> Now, with the previous patches this is based on this would be a slab and
> the likeliness of it being sensitive information is rather low (it would
> likely be some other packet being sent twice, or a mix and match of two
> packets that would have been sent anyway), but it would nevertheless be
> a use after free.
>
>
> There is a second advantage to this reference counting, that is now we
> have this system we will be able to implement flush asynchronously.
> This will remove the need for the 'goto again' in p9_client_rpc which
> was making 9p threads unkillable in practice if the server would not
> reply to the flush requests.


Fixing unkillalble task would be nice. Don't know how much they are of
a problem in real life, but fixing them would allow fuzzer to find
other, potentially more critical bugs in 9p. These "task hung" crashes
are quite unpleasant for the fuzzer.

Thanks for all recent 9p work, Tomas!


> Even if the server replies I've always found myself needing to hit ^C
> multiple times to exit a process doing I/Os and I think fixing that
> behaviour will make 9p more comfortable to use.
>
>
>> > diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
>> > index 20f46f13fe83..686e24e355d0 100644
>> > --- a/net/9p/trans_fd.c
>> > +++ b/net/9p/trans_fd.c
>> > @@ -132,6 +132,7 @@ struct p9_conn {
>> >     struct list_head req_list;
>> >     struct list_head unsent_req_list;
>> >     struct p9_req_t *req;
>> > +   struct p9_req_t *wreq;
>>
>> Why adding a wreq for write work? And I wonder we should rename req to
>> rreq?
>
> We need to store a pointer to the request for the write thread because
> we need to put the reference to it when we're done writing its content.
>
> Previously, the worker would only store the write buffer there but
> that's not enough to figure what request to dereference.
>
>
> I personally don't think renaming req to rreq would bring much but it
> could be done in another patch if you think that'd be helpful; I think
> it shouldn't be done here at least to make the patch more readable.
>
> --
> Dominique
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
