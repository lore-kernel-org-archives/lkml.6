Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA42C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707E22081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+4jRmj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707E22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeK2DyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:54:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46365 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeK2DyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:54:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so26580376qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4wIa46nYNcihPc6RPt8MydsLd97oD6hAlMJVZ7KOdbg=;
        b=B+4jRmj0Tjoz8I7A2PIVF4+p1uiHxewRD+0nLd069oE0M8qnf8oDjYgp/KdGAgesTy
         lSELxIHvl9auOfv1i59DWVCrQaWm1RrAZmYyVaqTUP7D4FgQDjVDoVI5yht+Kj0w2apO
         84iF0p+1V1nGQFatr+2D/OrIdSIy9aFMKPFgx4uP1VwiWfB1tEZrbR3160/8m6FLbICt
         cvAwpScmcDfjri27IdcJyu6iVF0Pr/9CQ8hUdr6neROkkjlT0sIQJhct0j9STaznZCYt
         ZAynlWdqtZEUMJTJAwkl0XynRTAQa2PnAf3UcacCIp21iO5K/IYJqjiesIBS7mhLyUFy
         iRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4wIa46nYNcihPc6RPt8MydsLd97oD6hAlMJVZ7KOdbg=;
        b=V/iKrKAu5C+Gh2MgrA5fMh28jsYFFrxHW3sdWSBmG2glXhxSY/gutcKIMs0BDURl6k
         ZxSts4dzUSGYDwkcDrUEMXfvfKy/g+keUptkLVQ9e3Nd8CzgCF7HritxIx/2jiRRVmnL
         pNKsJEBN+1ykgdm/qyI2WVbrhIhs64hGT8G0DglhIb6rMqeC/SP4HrOJPaq01VcYF7Ob
         dDxRyPmGv3ZAQcjL75BNohVSGnDO+tSr6rqouO+L+OBIhOOqYVAH5or2kqd9Of/jLkSc
         W8OD52LKZOT8w0dm6N6O44EKvQPpzdURofF5QoANO/qKy6akvmZ8x6VqDdT81yi5VKb9
         Boqg==
X-Gm-Message-State: AGRZ1gKCWMeFhRYWXKCTi2hiza+o5pwT3PabZ5DEpjfVRnnJEFKCXset
        6K/D6xAA3h1rgejqgE6xfn/K7T8eEfvaOTIXwig=
X-Google-Smtp-Source: AJdET5eohxBZItPhrhkgeXlIof+Gd4yUAtNLylIPUBmW5utWhvZVJXb1Dwo0+QDeI1Xsvvql3d6G1EZ7AWz9SMDMVek=
X-Received: by 2002:ac8:2c79:: with SMTP id e54mr36175624qta.17.1543423907616;
 Wed, 28 Nov 2018 08:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20181119141003.6470-1-smuchun@gmail.com> <CALAqxLUUpGfDzOoDyPA4LFyzFyVmiT4wKLUWa5Tin8eypJBCDQ@mail.gmail.com>
 <CAPSr9jFVDaXUZw0LKEX81TrCmeQ+tw1bt0g_tK7J1s9qtOdEwg@mail.gmail.com>
 <alpine.DEB.2.21.1811212143030.1665@nanos.tec.linutronix.de> <alpine.DEB.2.21.1811281614220.1532@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811281614220.1532@nanos.tec.linutronix.de>
From:   Muchun Song <smuchun@gmail.com>
Date:   Thu, 29 Nov 2018 00:51:36 +0800
Message-ID: <CAPSr9jFNGxWZBhF8d9z6GbKVLp5oj-bn-=96DsRBfFJJ_Xn=Vg@mail.gmail.com>
Subject: Re: [PATCH] timers: Make the lower-level timer function first call
 than higher-level
To:     tglx@linutronix.de
Cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi tglx,

I'm sorry. Thanks for your reminder.

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2018=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Song,
>
> On Wed, 21 Nov 2018, Thomas Gleixner wrote:
> > On Tue, 20 Nov 2018, Muchun Song wrote:
> > > Follow the current code logic, the timer0 function is called until th=
e
> > > function call of timer1-5 is completed. So the delay of timer0 is the=
 time
> > > spent by other timer function calls. If we can call the timer functio=
n in
> > > the following order, this should be more friendly to lower-level time=
rs.
> > >
> > >         timer0->timer1->->timer2->->timer3->->timer4->->timer5
> > >
> > > Although not friendly to higher-level timers, higher-level has larger
> > > granularity. Therefore the delay has less impact on higher-level.
> >
> > Well yes, that's clear. But is it a problem in practice and if so, what=
 is
> > the measurable benefit.
>
> Polite reminder. Can you please describe what the practical relevance is =
of
> that and what real world problem you are solving? Ideally with numbers
> backing it up.
>

I just think that this change might be better for me when I read the code.
Maybe what I think is not a problem. So if there is something wrong,
please ignore the patch. Sorry.

Thanks.
