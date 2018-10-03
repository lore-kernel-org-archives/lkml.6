Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ACBC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1175F20878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQEC6duc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1175F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJCMjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:39:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35319 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:39:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so2894280plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8SQvWieqe/Eb6yw/WYj1GWGB7oORzXy2L84m4cX0Ejw=;
        b=fQEC6ducxFixdTINpUkC7qCYU4/LJQScxyxoeHW3Kyjs6CM0yxdk9DPS3jiFoxaTM8
         kEnYVS4ba7iHqIEp8aJH5RTLAJBN4mRDZN7fY5bBcZFR9y3/HqKgg2PrGrx5wd8uGfhB
         juGglZIDge7qzMoOINT58yAwjmOY9fMH3pK6cr/0ecqHDACGIW+vou+tr5CDDPkpKs6l
         KWwxq00BKgdbHm1eLhyMoSixxPdMZvd57WkFtqxdiywG+SXV2nNRJEnmZ/xn5gMbpzQx
         6++Ef5GEPFzASdVJ/V7drqxx1gmepSya5lMqgu9UtmLjcyRSwP+BzUhZA75WC2uCm/Ux
         b4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8SQvWieqe/Eb6yw/WYj1GWGB7oORzXy2L84m4cX0Ejw=;
        b=KuuBwtBjvbYzUOHhe0lhMSTwEVsTfJC1PXI7ynVgmWRngI3YrdT3kpimmk3WVlUzrb
         FEDJmjKvinY3eVbAObF1u0RS8xPHwHFtNceuslNT40jjV/EgqOkBUYnKG0AcTDtBkgy4
         5W069dqdh5al/3xP706EIhlj3eEPJTUA64A+4evHU8fTxuv5Rs9JpcTNi8HPgtH4E9h3
         jTZbctkna2Ti6f8GqcNyAxvy9Mtg9piaPxRnE6gFZjiW8hTq5fEnBhVQJmOYtaocdxOk
         YyRhj0kPTxSR+QWMbaVu2KRA85lSKT2LNKGF5oa88cPjJsU4VC4ysLSFAgFBIS9kWT59
         iJ4A==
X-Gm-Message-State: ABuFfohJzK1eJQjlS3b7IoUOHupcduES7prXjyvEL+pA3jXgOuye3qTA
        fBCgWtzEMcFizJakg6syZFKS92lT
X-Google-Smtp-Source: ACcGV60Rh9LSr/fS1ZQ7e5A2gmGGQFErtSjK6ZfOzCxOUkMMU3VJyt+kA/MN6E9YQKcs3jYgsj+GVA==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3-v6mr20175150plb.80.1538545969279;
        Tue, 02 Oct 2018 22:52:49 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
        by smtp.gmail.com with ESMTPSA id t22-v6sm652470pfk.141.2018.10.02.22.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:52:48 -0700 (PDT)
Date:   Wed, 3 Oct 2018 15:52:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 3/7] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
Message-ID: <20181003155243.70806497@roar.ozlabs.ibm.com>
In-Reply-To: <c1b9f2db-ebca-4a2d-4f91-2dce84da31f2@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
        <522887e5967b6619be34eb4f04565033dbed2d75.1538396658.git.christophe.leroy@c-s.fr>
        <20181003153025.35b2dd5e@roar.ozlabs.ibm.com>
        <c1b9f2db-ebca-4a2d-4f91-2dce84da31f2@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 07:47:05 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 07:30, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Mon,  1 Oct 2018 12:30:23 +0000 (UTC)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> This patch activates CONFIG_THREAD_INFO_IN_TASK which
> >> moves the thread_info into task_struct.
> >>
> >> Moving thread_info into task_struct has the following advantages:
> >> - It protects thread_info from corruption in the case of stack
> >> overflows.
> >> - Its address is harder to determine if stack addresses are
> >> leaked, making a number of attacks more difficult.
> >>
> >> This has the following consequences:
> >> - thread_info is now located at the top of task_struct. =20
> >=20
> > "top"... I got confused for a minute thinking high address and
> > wondering how you can change CURRENT_THREAD_INFO just to point
> > to current :) =20
>=20
> Would 'beginning' be less confusing ?

Yes, good idea.

> >> @@ -83,7 +83,13 @@ int is_cpu_dead(unsigned int cpu);
> >>   /* 32-bit */
> >>   extern int smp_hw_index[];
> >>  =20
> >> -#define raw_smp_processor_id()	(current_thread_info()->cpu)
> >> +/*
> >> + * This is particularly ugly: it appears we can't actually get the de=
finition
> >> + * of task_struct here, but we need access to the CPU this task is ru=
nning on.
> >> + * Instead of using task_struct we're using _TASK_CPU which is extrac=
ted from
> >> + * asm-offsets.h by kbuild to get the current processor ID.
> >> + */
> >> +#define raw_smp_processor_id()		(*(unsigned int*)((void*)current + _T=
ASK_CPU)) =20
> >=20
> > This is clever but yes ugly. Can't you include asm-offsets.h? riscv
> > seems to. =20
>=20
> riscv has a clean asm-offsets.h . Our's defines constant with the same=20
> name as those defined in other headers which are included in C files. So=
=20
> including asm-offsets in C files does create conflicts like:
>=20
> ./include/generated/asm-offsets.h:71:0: warning: "TASK_SIZE" redefined
>   #define TASK_SIZE -2147483648 /* TASK_SIZE */
> ./arch/powerpc/include/asm/processor.h:95:0: note: this is the location=20
> of the previous definition
>   #define TASK_SIZE (CONFIG_TASK_SIZE)
>=20
> ./include/generated/asm-offsets.h:98:0: warning: "NSEC_PER_SEC" redefined
>   #define NSEC_PER_SEC 1000000000 /* NSEC_PER_SEC */
> ./include/linux/time64.h:36:0: note: this is the location of the=20
> previous definition
>   #define NSEC_PER_SEC 1000000000L
>=20
> ./arch/powerpc/include/asm/nohash/32/pgtable.h:34:0: warning:=20
> "PGD_TABLE_SIZE" redefined
>   #define PGD_TABLE_SIZE (sizeof(pgd_t) << PGD_INDEX_SIZE)
> ./include/generated/asm-offsets.h:101:0: note: this is the location of=20
> the previous definition
>   #define PGD_TABLE_SIZE 256 /* PGD_TABLE_SIZE */
>=20
> ...

Okay.

>=20
> In v2, I had a patch to fix those redundancies=20
> (https://patchwork.ozlabs.org/patch/974363/) but I found it unconvenient.

Because of merge conflicts, or you did not like the new names?

Thanks,
Nick
