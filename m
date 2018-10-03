Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A0FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C3F20652
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsf2p/Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C3F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJCNKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:10:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39064 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCNKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:10:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so2928629plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 23:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rAOevDPZe7dnbkiFavmd+0KLnTNthcuJvJUp0SfuH2Y=;
        b=nsf2p/BlhFFzRdFqVcLMk0Bl7JIUkBM/EYlFaviVuV3X8OYH0Ej9KxRtec8rHU2b31
         /a5/uyJaR9KM/Xi7e2Qy0w4CzUDkORWLtaR/go1D9CZ+7ew0Nn6x7J7cTfFDMtbnIP8q
         SO4kJEiaGcqxi08ldPUAOmf5cCc/7K/GMhT5gjO8uwdlgpe7KXJPQufZ7P8h/ORd1SKA
         WOO1/hyWWvy6FU2HKR8YE9lZtkBi3dS17I9+7DBF7sMUb1Lbau1YEkvyrZhBYdqyTpK0
         cWJXwuw8oUC6rFS5Epfcaprer3sfHa7HuyF8A5wViQonGmQ+G65GY5m0viUxu8KieE1A
         5X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAOevDPZe7dnbkiFavmd+0KLnTNthcuJvJUp0SfuH2Y=;
        b=N0rtKeRK2yO0iBiNU+54YTp5fogiwMUnFGaut5wamOdkDUXdIT1i2RuR6esear/nwi
         yd4Yu9GcZ6MJi1L9WU+6cTUIQmayyg1EcU6loeJG08oubo5lXHshMUlDuFZpDGybHWBF
         8Wl5vbEzoc/e/N+0pw8hJagCFwjlL+ZB96xgf4HyTzPoSFizUpLvC97/H+JCF0O1FOe0
         4f2aZ9yhc+AYA4WDUSUf4B+ul5P/BAwGY8fGXEqcLL8R4qDWhH8kIYdNys1q5IFwYDMy
         kdOsr2wgr5wygoYQm9QOF3SGix8i+FFS/t6HoqLb+FIhcLDxfuAhfCIAN7ErPjbfqeht
         QHDw==
X-Gm-Message-State: ABuFfoga2GXqe11iMWwkM639WLjrouaCRkJEjO3IhS4nf0s29RbAG5aC
        QWYDhYHWXag1VuuMMqWPicA=
X-Google-Smtp-Source: ACcGV62WSMnq0atjDjUL5X/xXhhgCVLBqc+hIfyFi32tOWAeMQ5hWVtsZgSav+35Uttqb3/PMkzUFA==
X-Received: by 2002:a17:902:b784:: with SMTP id e4-v6mr11272pls.284.1538547836422;
        Tue, 02 Oct 2018 23:23:56 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
        by smtp.gmail.com with ESMTPSA id 64-v6sm1360736pfq.10.2018.10.02.23.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 23:23:55 -0700 (PDT)
Date:   Wed, 3 Oct 2018 16:23:50 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 3/7] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
Message-ID: <20181003162350.408f7f84@roar.ozlabs.ibm.com>
In-Reply-To: <210d5ce2-1f62-2458-617b-fe604b95919e@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
        <522887e5967b6619be34eb4f04565033dbed2d75.1538396658.git.christophe.leroy@c-s.fr>
        <20181003153025.35b2dd5e@roar.ozlabs.ibm.com>
        <c1b9f2db-ebca-4a2d-4f91-2dce84da31f2@c-s.fr>
        <20181003155243.70806497@roar.ozlabs.ibm.com>
        <210d5ce2-1f62-2458-617b-fe604b95919e@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 08:04:49 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 07:52, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Wed, 3 Oct 2018 07:47:05 +0200
> > Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> Le 03/10/2018 =C3=A0 07:30, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>> On Mon,  1 Oct 2018 12:30:23 +0000 (UTC)
> >>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >>>     =20
> >>>> This patch activates CONFIG_THREAD_INFO_IN_TASK which
> >>>> moves the thread_info into task_struct.
> >>>>
> >>>> Moving thread_info into task_struct has the following advantages:
> >>>> - It protects thread_info from corruption in the case of stack
> >>>> overflows.
> >>>> - Its address is harder to determine if stack addresses are
> >>>> leaked, making a number of attacks more difficult.
> >>>>
> >>>> This has the following consequences:
> >>>> - thread_info is now located at the top of task_struct. =20
> >>>
> >>> "top"... I got confused for a minute thinking high address and
> >>> wondering how you can change CURRENT_THREAD_INFO just to point
> >>> to current :) =20
> >>
> >> Would 'beginning' be less confusing ? =20
> >=20
> > Yes, good idea.
> >  =20
> >>>> @@ -83,7 +83,13 @@ int is_cpu_dead(unsigned int cpu);
> >>>>    /* 32-bit */
> >>>>    extern int smp_hw_index[];
> >>>>   =20
> >>>> -#define raw_smp_processor_id()	(current_thread_info()->cpu)
> >>>> +/*
> >>>> + * This is particularly ugly: it appears we can't actually get the =
definition
> >>>> + * of task_struct here, but we need access to the CPU this task is =
running on.
> >>>> + * Instead of using task_struct we're using _TASK_CPU which is extr=
acted from
> >>>> + * asm-offsets.h by kbuild to get the current processor ID.
> >>>> + */
> >>>> +#define raw_smp_processor_id()		(*(unsigned int*)((void*)current + =
_TASK_CPU)) =20
> >>>
> >>> This is clever but yes ugly. Can't you include asm-offsets.h? riscv
> >>> seems to. =20
> >>
> >> riscv has a clean asm-offsets.h . Our's defines constant with the same
> >> name as those defined in other headers which are included in C files. =
So
> >> including asm-offsets in C files does create conflicts like:
> >>
> >> ./include/generated/asm-offsets.h:71:0: warning: "TASK_SIZE" redefined
> >>    #define TASK_SIZE -2147483648 /* TASK_SIZE */
> >> ./arch/powerpc/include/asm/processor.h:95:0: note: this is the location
> >> of the previous definition
> >>    #define TASK_SIZE (CONFIG_TASK_SIZE)
> >>
> >> ./include/generated/asm-offsets.h:98:0: warning: "NSEC_PER_SEC" redefi=
ned
> >>    #define NSEC_PER_SEC 1000000000 /* NSEC_PER_SEC */
> >> ./include/linux/time64.h:36:0: note: this is the location of the
> >> previous definition
> >>    #define NSEC_PER_SEC 1000000000L
> >>
> >> ./arch/powerpc/include/asm/nohash/32/pgtable.h:34:0: warning:
> >> "PGD_TABLE_SIZE" redefined
> >>    #define PGD_TABLE_SIZE (sizeof(pgd_t) << PGD_INDEX_SIZE)
> >> ./include/generated/asm-offsets.h:101:0: note: this is the location of
> >> the previous definition
> >>    #define PGD_TABLE_SIZE 256 /* PGD_TABLE_SIZE */
> >>
> >> ... =20
> >=20
> > Okay.
> >  =20
> >>
> >> In v2, I had a patch to fix those redundancies
> >> (https://patchwork.ozlabs.org/patch/974363/) but I found it unconvenie=
nt. =20
> >=20
> > Because of merge conflicts, or you did not like the new names? =20
>=20
> Both, because of the amount of changes it implies, and also because of=20
> the new names. I find it quite convenient to be able to use same names=20
> both in C and ASM.

Yeah that's true. I guess this is okay for a one-off hack.

Thanks,
Nick
