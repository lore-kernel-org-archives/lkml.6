Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585E0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F9720883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K71Fm2BV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfAIFUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:20:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42651 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfAIFUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:20:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so4659844lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 21:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uJF0p7fQ248srHNRxbrVzUHjAWsWAZnZpiQmRtXe6s=;
        b=K71Fm2BV8Xu7gXVNYFQ/10ufdWXhUqJjTS3m2TL2IXUWPmy7pTEAbY2t2nsFP63VnV
         2jmfj0x4EAKwstaccBAMKpQ4N9OK05+4EeYMx1GG6+YE07ZvGUo5UCLW0NbFfWF5/hB2
         ODOEeP+cNczibQ5HQEP3NAZ3EInROK+z9aC4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uJF0p7fQ248srHNRxbrVzUHjAWsWAZnZpiQmRtXe6s=;
        b=EK4dzpIT/xskve6Q7q+93ZbfGQ87IcdpioMLeKs5l/7nopWlyjF2iCaH1NgXQ+MVIi
         SYaFbr7ZvlnU/2vYplIMZmmk3S3t1OATS3k4IgmZTEbXeW3Bn4/Q3KOuKeg5JV3riPLH
         yI5CuGhc2zV8NaAKTnzoe1UIuCyEmC4N4TqUVY9rZy6AWY4y5coFOIwX4f2Y8QtcUr6k
         4b7LV7kBlqW3QRmy0KfqBrus/jWU4PVvKl4UZ/eUec+riwAmgwpmu5yry3nPy9CtSyt2
         Ufdj13wUmMChjdfzTaBIEZ5Bmycikn9wEOM7YW2GWg9j6jVF4D8SqEGScGki+74CjZnd
         mP9A==
X-Gm-Message-State: AJcUukfzLtGmZu5fQUk3lrvKVy1tqAqoUtKv19hZM1DvBO3x6b12wAvx
        xynyZe9QGkdPX1WiuKe9Q7qwKuBJViQ=
X-Google-Smtp-Source: ALg8bN77V6BDSODQpRXT5BZwkA1c7KxIpRz80eAkHZ8dotiiwD5mBF3WZBqlQ3YhKJ9bqOJm/qBpMg==
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr2654440lfi.57.1547011210381;
        Tue, 08 Jan 2019 21:20:10 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id a18-v6sm14443028ljk.86.2019.01.08.21.20.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 21:20:09 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id v1-v6so5405946ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 21:20:09 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr2459742ljh.59.1547011208853;
 Tue, 08 Jan 2019 21:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20190102154038-mutt-send-email-mst@kernel.org>
 <0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com> <20190106221832-mutt-send-email-mst@kernel.org>
 <c15a17b3-b604-a105-af44-a7e6dfd79801@redhat.com> <20190106230224-mutt-send-email-mst@kernel.org>
 <CAPcyv4iXFy0jfoQ_jQYq2yA7cqu4_Jcap4mvQesRRrV-hahGvQ@mail.gmail.com>
 <20190107084853-mutt-send-email-mst@kernel.org> <CAPcyv4jf-4=2oGJrdvMBeRiAJnQoKbYhwZDD+5ZEH+xgDaOzRQ@mail.gmail.com>
 <20190107172517-mutt-send-email-mst@kernel.org> <CAPcyv4iQMQxZC8ehr2OP8_rqpuCeSWn5xyKN64JSyfR8_r7eOg@mail.gmail.com>
 <20190108232459-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190108232459-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Jan 2019 21:19:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjDQCttbTZjEC8DbZdq8=eTpS2e-9jQQD+WdutFArzHwQ@mail.gmail.com>
Message-ID: <CAHk-=wjDQCttbTZjEC8DbZdq8=eTpS2e-9jQQD+WdutFArzHwQ@mail.gmail.com>
Subject: Re: __get_user slower than get_user (was Re: [RFC PATCH V3 0/5] Hi:)
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 8:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Linus, given that you just changed all users of access_ok anyway, do
> you still think that the access_ok() conversion to return a speculation
> sanitized pointer or NULL is too big a conversion?

I didn't actually change a single access_ok().

I changed the (very few) users of "user_access_begin()" to do an
access_ok() in them. There were 8 of them total.

It turns out that two of those cases (the strn*_user() ones) found
bugs in the implementation of access_ok() of two architectures, and
then looking at the others found that six more architectures also had
problems, but those weren't actually because of any access_ok()
changes, they were pre-existing issues. So we definitely had
unfortunate bugs in access_ok(), but they were mostly the benign kind
(ir the "use arguments twice - a real potential bug, but not one that
actually likely makes any difference to existing users)

Changing all 600+ users of access_ok() would be painful.

That said, one thing I *would* like to do is to just get rid of
__get_user() and __put_user() entirely. Or rather, just make them do
exactly the same thing that the normal "get_user()"/"put_user()"
functions do.

And then, _within_ the case of get_user()/put_user(), doing the
access_ok() as a data dependency rather than a lfence should be easy
enough.

                     Linus
