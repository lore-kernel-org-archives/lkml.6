Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A9FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD852175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="vW1JXHJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD852175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbeKNI4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:56:04 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45041 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:56:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id p82-v6so11903782oih.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 14:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vpw/c7uTiHZTfhfhEzSnaMasFFpVHALu+cwV3Ii7BsM=;
        b=vW1JXHJ5S/J2u6KQ1my7ihYxKY/3xHfdEvjE8QUCb7+XSl8Bh8taxXqE2JpoT2tgRS
         KVURDkq5WDitNxXRFMFBQ/5hZ8/gGnSN7+Exv6fiQyEpWUtZ+8NbofWlSJ2pz+fhznMU
         0kiItZ6uvU3F0iqd9qH7t1+Pb3rCJbnMffjykG9ik7uZanU/q55XcRFGRBwX1Tl/iaAe
         XZWxem3aAbaG6MLxCyHqL/ZfrhC0gqT9EqghCYmd6M3mqYu+A5mM1ZueIwPYK0cMHC5N
         2WR5wIFKZ/8bFVs2GrHONFC8pwvNyYcYxaOMHQhBMWHXFcQfTZCzMoFpABPHArtpie7M
         sd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vpw/c7uTiHZTfhfhEzSnaMasFFpVHALu+cwV3Ii7BsM=;
        b=tiz5RXNTO+i5MYKcKNPL2d1sYF4BSZ94qF7FFDZiQAVCaxxYGSorixnaVYqSEmm8B1
         M1S/DNE7jBQ/Ne1JOcmxKC9HEOQjyoe56swku8IUq5SG5XecJdXm43mNUEc/IXUb2b2a
         r2f0zZsLKdiqjEfzMx/Nw5NzaHHfcwtdR5XsDkfwmJB+DHvv3E0Q88HZ5oPpmvI6s+Jg
         hiXlQeoANfQKLXPpcY1Vn8ft8m3ZmtgaK4buoRbAo4phLZErElm8eYjFNB/oiDC9b8ad
         WQNvCW6MqDNei+IckFgKQdaElzE3P0xw/4J5FFkdcYTwDCVB+um2JorQm4OJVeQNMEq4
         vn5w==
X-Gm-Message-State: AGRZ1gKepNLcWHvMF/zsC/wL3ZjZqjM1vJ//CJ/kz4dAsCv6BX0mXa+o
        7XW9eKYZU6noJTEQ4nDNPQVHOCuPJhegfA==
X-Google-Smtp-Source: AJdET5epGv71a94V9i+fNMBiO3onUtqCMVTDcsDgDSYzuAmtYKgEM7pNVLOe4PgbrTmPAtvwewayDA==
X-Received: by 2002:aca:f08a:: with SMTP id o132-v6mr4390286oih.39.1542149741698;
        Tue, 13 Nov 2018 14:55:41 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id i49sm9791973otb.18.2018.11.13.14.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 14:55:40 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id j202-v6so11899085oih.10;
        Tue, 13 Nov 2018 14:55:40 -0800 (PST)
X-Received: by 2002:aca:f5d4:: with SMTP id t203-v6mr4316346oih.98.1542149740186;
 Tue, 13 Nov 2018 14:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20181112231344.7161-1-timofey.titovets@synesis.ru>
 <20181113022516.45u6b536vtdjgvrf@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi744_8NA30V0aWCpFi_=WSaA+18h3njOTQG0SFUVdXi8bg@mail.gmail.com> <CA+CK2bB0C-PCdaHS7YiLf5iZWn1bATg2y32ogL1FSw7LY9E7SQ@mail.gmail.com>
In-Reply-To: <CA+CK2bB0C-PCdaHS7YiLf5iZWn1bATg2y32ogL1FSw7LY9E7SQ@mail.gmail.com>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Wed, 14 Nov 2018 01:55:04 +0300
X-Gmail-Original-Message-ID: <CAGqmi74uqeqxD4n=pb=3v48sSfk-pQhk7eTHkuTLxegFAq-D9A@mail.gmail.com>
Message-ID: <CAGqmi74uqeqxD4n=pb=3v48sSfk-pQhk7eTHkuTLxegFAq-D9A@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 21:43, Pavel=
 Tatashin <pasha.tatashin@soleen.com>:
>
> > > Is it really necessary to have an extra thread in ksm just to add vma=
's
> > > for scanning? Can we do it right from the scanner thread? Also, may b=
e
> > > it is better to add vma's at their creation time when KSM_MODE_ALWAYS=
 is
> > > enabled?
> > >
> > > Thank you,
> > > Pasha
> >
> > Oh, thats a long story, and my english to bad for describe all things,
> > even that hard to find linux-mm conversation several years ago about th=
at.
> >
> > Anyway, so:
> > In V2 - i use scanner thread to add VMA, but i think scanner do that
> > with too high rate.
> > i.e. walk on task list, and get new task every 20ms, to wait write sema=
phore,
> > to get VMA...
> > To high rate for task list scanner, i think it's overkill.
> >
> > About add VMA from creation time,
> > UKSM add ksm_enter() hooks to mm subsystem, i port that to KSM.
> > But some mm people say what they not like add KSM hooks to other subsys=
tems.
> > And want ksm do that internally by some way.
> >
> > Frankly speaking i didn't have enough knowledge and skills to do that
> > another way in past time.
> > They also suggest me look to THP for that logic, but i can't find how
> > THP do that without hooks, and
> > where THP truly scan memory.
> >
> > So, after all of that i implemented this in that way.
> > In first iteration as part of ksm scan thread, and in second, by
> > separate thread.
> > Because that allow to add VMA in fully independent way.
>
> It still feels as a wrong direction. A new thread that adds random
> VMA's to scan, and no way to optimize the queue fairness for example.
> It should really be done at creation time, when VMA is created it
> should be added to KSM scanning queue, or KSM main scanner thread
> should go through VMA list in a coherent order.

How you see queue fairness in that case?
i.e. if you talk about moving from old VMA to new VMA,
IIRC i can't find any whole kernel list of VMAs.

i.e. i really understood what you don't like exactly,
but for that we need add hooks as i already mentioned above.
(And i already try get that to kernel [1]).

So, as i wrote you below, i need some maintainer opinion
in which way that responsible person of mm see 'right' implementation.

> The design of having a separate thread is bad. I plan in the future to
> add thread per node support to KSM, and this one odd thread won't
> break things, to which queue should this thread add VMA if there are
> multiple queues?

That will be interesting to look :)
But IMHO:
I think you will need to add some code to ksm_enter().
Because madvise() internally call ksm_enter().

So ksm_enter() will decide which tread must process that.
That not depends on caller.

Thanks.

> Thank you,
> Pasha
>
- - -
1. https://lkml.org/lkml/2014/11/8/206
