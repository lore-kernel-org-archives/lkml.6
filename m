Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0F2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED61721473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URamF8oY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED61721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJSAWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:22:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeJSAWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:22:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so890525wmw.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eZg4LqAT4bwj83IEq5yb+qAy7n8yCN5SFaAC+PTrVQc=;
        b=URamF8oYe4m6hCyOw6hlLIWfQ9IcosX4LVqtdybozHxlcX/A8USXV03kuYt84mCkv/
         QkBLu4Jlr7+xEUFJbjK4wwwdifs79Vqh+Hx5NQsCqt3TvZvUI+RraGDnZ6FbTN0PuL/2
         e5gM3EFH8ftV4TsuOfP4uyZaM+f5pcB6izwCTtfYJiXd00d4svfcX1vGnS3baLPDYmhr
         wdmQGt/nhXO7hr1Zd7rU64n4mjGyKfCLz4sJkcy2Sj+2/ydmqwjBx9bmysydEEYQHwWS
         ctjUSeaL7Oa5hSMxyiiYew7TmUyKSSRjBo0k8YD//hS9TJQ3y8WCt69LOS8kNV8grxvJ
         yxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eZg4LqAT4bwj83IEq5yb+qAy7n8yCN5SFaAC+PTrVQc=;
        b=IgzMDKYuch4hlKobMeNAu3TlYjpcZ2cGElMlKfjZXlUpLZX3kA4LkohXSikUY8PMeU
         UlDxJBkk5jyFMQvv0cCaYbk6CstnawRzRzE7L8EmgGz8u5dkiXYxeHYFhihsOscyOTO0
         Hiphr5ZKhhh4Ub5wy9AWMFYgzs3lzNbaFo7N4Fa0nLZwCW2VNwEUDXAr1SQzNzLxvkxZ
         yvLTZEZ6fLlvOqruJF5PWH7LI8PV6kcF/MmqZb3XbVTIXpAEhkb7n3EDzTjEwl/Zn1x7
         WzNhVQjCtwlWLWfPj2JZGa0XjwC1vFY72mnhhDyyrqD2h0+HLPH9wYbcOY01up2r4pmU
         vWhw==
X-Gm-Message-State: ABuFfoi+1LN4U8BPQ4mKDNSCf1p7FECkwWJr/dmC+FgN5qLvO5wSJAro
        lsTZtKd7h/UwRrRnCMq1QWVHhK3RGm9W57I4HsE=
X-Google-Smtp-Source: ACcGV63BozkoF5btuUzRQW1cP/gZHFbfTIMgnq+wFfvCGxStsHsHshYD9oFBFUrFzH/pJ14oySEjwo6QvSkZYMZ8o0c=
X-Received: by 2002:a1c:5e49:: with SMTP id s70-v6mr985319wmb.131.1539879654681;
 Thu, 18 Oct 2018 09:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181018142133.12341-1-tiny.windzz@gmail.com> <20181018161019.GA7573@gmail.com>
In-Reply-To: <20181018161019.GA7573@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 19 Oct 2018 00:19:42 +0800
Message-ID: <CAEExFWsjmuMQ5nUGQSp5PUmbCvS-EPQPkh60q3LgQ-sh96VXxA@mail.gmail.com>
Subject: Re: [PATCH] softirq: modify comments about PF_MEMALLOC in __do_softirq
To:     mingo@kernel.org
Cc:     joel@joelfernandes.org, tglx@linutronix.de, rostedt@goodmis.org,
        frederic@kernel.org, Paul McKenney <paulmck@linux.vnet.ibm.com>,
        alexander.levin@verizon.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, 18 Oct 2018
>Ingo Molnar <mingo@kernel.org> wrote:
>* Yangtao Li <tiny.windzz@gmail.com> wrote:
>
>> ---
>>  kernel/softirq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>> index 6f584861d329..6193e1d1b30d 100644
>> --- a/kernel/softirq.c
>> +++ b/kernel/softirq.c
>> @@ -257,7 +257,7 @@ asmlinkage __visible void __softirq_entry __do_softi=
rq(void)
>>   int softirq_bit;
>>
>>   /*
>> - * Mask out PF_MEMALLOC s current task context is borrowed for the
>> + * Mask out PF_MEMALLOC as current task context is borrowed for the
>>   * softirq. A softirq handled such as network RX might set PF_MEMALLOC
>>   * again if the socket is related to swap
>>   */
>
>Can I add your Signed-off-by?
>
>Thanks,
>
> Ingo

yeah=EF=BC=8CThanks

-- Yangtao Li

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
On Fri, Oct 19, 2018 at 12:10 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> > ---
> >  kernel/softirq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 6f584861d329..6193e1d1b30d 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -257,7 +257,7 @@ asmlinkage __visible void __softirq_entry __do_soft=
irq(void)
> >       int softirq_bit;
> >
> >       /*
> > -      * Mask out PF_MEMALLOC s current task context is borrowed for th=
e
> > +      * Mask out PF_MEMALLOC as current task context is borrowed for t=
he
> >        * softirq. A softirq handled such as network RX might set PF_MEM=
ALLOC
> >        * again if the socket is related to swap
> >        */
>
> Can I add your Signed-off-by?
>
> Thanks,
>
>         Ingo
