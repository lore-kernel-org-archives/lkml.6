Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B67C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691FF20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmhOsNbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691FF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeKHLtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:49:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39944 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeKHLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:49:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so22918580qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 18:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kJUlrcCko11y6JNAky0WYvrE6gks0DWEgoaAF6uESxA=;
        b=cmhOsNbgcmmg1H8tPpiKsX3fKbSYmCiHkKi/iRBwAYUKLpf+9xc2FPQO8374vguJZy
         gxoTW+9fxlzYp+/pd/fST3GhrTB35hIMYn8UpovCMf6wiPHo27W4ku/sY2lXrBfKOP6F
         8Rue1nXL6KD6u4cVChdxEGMMgjHfj7QEzc+SMbvxKzAc33o6TDvMkb5rsCoRFVdQCiN0
         iZywnPlLHcL+jO7uAujsyqLs+iE4rEtGSnctwlIDsScwXvng3vox1JEkYvQgYl0yfMj7
         jBgesh0oaLRooNuES01FghmNLlLj04K0ma8bxQ5c+9xP4/SGf2atQxZ0mg2vHuwq5wDE
         Gklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kJUlrcCko11y6JNAky0WYvrE6gks0DWEgoaAF6uESxA=;
        b=LRw//SicxFH+5R7XSHDK8CIQKfcP2EGpXr1xym4vDdm7YLTsIFDzdOtJhAZZ5jyuJR
         nUK7JNm6L227pnbgQb4psr2ULoONSia1iqiicrjJMMznwmOjfDe058RnIKCbobw6oNZ+
         G8rKMBcSST/sQlkIpQclg0yr1pJMbXmUVdRGD5Z+uiNtkYln6M19JK+lSrw0sMO+Pz8t
         /UJ+LvJRXKzibCqP2OreAvHymKzYKeLHA81yWk76b3ZpfxV+P69TNqwPt7We74KOuG7z
         iePwNqnw1ZiLt0ad77CYEhjdEGHfYHWRB6j5UjUTe2zF63limNldpOmNFFpEnheWyC38
         OHfA==
X-Gm-Message-State: AGRZ1gJ/IPk2j/QbBLvJI+TBVB+p0hE9UCTTBIEnTWjjevLG19CI9UDl
        JxnooCkZG5B6SSTmGUa+kI6wF5H91qKdHyESiw4=
X-Google-Smtp-Source: AJdET5eOfcFw8DvuyXiHnIzHAEp3O3OPLmCl+b0gA6W596bF2PpgW2dtmKIJ+a0lbGeoZ/Edsd7+tjM/pX+TSOxGsmY=
X-Received: by 2002:a37:3293:: with SMTP id y141mr2394679qky.132.1541643361270;
 Wed, 07 Nov 2018 18:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20181107161505.42769-1-smuchun@gmail.com> <20181107173140.GK9761@hirez.programming.kicks-ass.net>
In-Reply-To: <20181107173140.GK9761@hirez.programming.kicks-ass.net>
From:   Muchun Song <smuchun@gmail.com>
Date:   Thu, 8 Nov 2018 10:15:49 +0800
Message-ID: <CAPSr9jGXPr-fcywjBTmGa5myeKSoGn+N3ybs9b2s2ayfU=sL2A@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Introduce prio_{higher,lower}() helper for
 comparing RT task prority
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for your review.

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2018=E5=B9=B411=E6=9C=888=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 08, 2018 at 12:15:05AM +0800, Muchun Song wrote:
> > We use a value to represent the priority of the RT task. But a smaller
> > value corresponds to a higher priority. If there are two RT task A and =
B,
> > their priorities are prio_a and prio_b, respectively. If prio_a is larg=
er
> > than prio_b, which means that the priority of RT task A is lower than R=
T
> > task B. It may seem a bit strange.
> >
> > In rt.c, there are many if condition of priority comparison. We need to
> > think carefully about which priority is higher because of this opposite
> > logic when read those code. So we introduce prio_{higher,lower}() helpe=
r
> > for comparing RT task prority, which can make code more readable.
> >
> > Signed-off-by: Muchun Song <smuchun@gmail.com>
> > ---
> >  kernel/sched/rt.c | 68 ++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 46 insertions(+), 22 deletions(-)
> >
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 9aa3287ce301..adf0f653c963 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -101,6 +101,28 @@ void init_rt_rq(struct rt_rq *rt_rq)
> >       raw_spin_lock_init(&rt_rq->rt_runtime_lock);
> >  }
> >
> > +/**
> > + * prio_higher(a, b) returns true if the priority a
> > + * is higher than the priority b.
> > + */
> > +static inline bool prio_higher(int a, int b)
> > +{
> > +     return a < b;
> > +}
> > +
> > +#define prio_lower(a, b)     prio_higher(b, a)
> > +
> > +/**
> > + * prio_higher_eq(a, b) returns true if the priority a
> > + * is higher than or equal to the priority b.
> > + */
> > +static inline bool prio_higher_eq(int a, int b)
> > +{
> > +     return a <=3D b;
> > +}
> > +
> > +#define prio_lower_eq(a, b)  prio_higher_eq(b, a)
>
> I think you only need the less thing, because:
>
> static inline bool prio_lower(int a, int b)
> {
>         return a > b;
> }
>
> prio_higher(a,b) :=3D prio_lower(b,a)
> prio_higher_eq(a,b) :=3D !prio_lower(a,b)
> prio_lower_eq(a,b) :=3D !prio_lower(b,a)

Yeah, it can be simpler here. Thanks for your advice.
I will send a v2 patch which will fix it.

>
> Now, I'm not sure if that actually improves readability if you go around
> and directly substitute those identities instead of doing those defines.
>

When I first read rt.c, I couldn't quickly realize which priority was highe=
r
in if condition. With this patch applied, if I know what's the meaning
of prio_higher()
or prio_lower() so that I can quickly know who's priority is higher.
So I think that
it can improves readability.

> The other option is of course to flip the in-kernel priority range the
> right way up, but that's a much more difficult patch and will terminally
> confuse people for a while.

Yeah, it is very difficult. There may be a lot of code than should be modif=
ied.
If we are not careful enough, there is a chance that something will be miss=
ed.
