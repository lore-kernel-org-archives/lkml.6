Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831BFFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227A32083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="13gz6Scm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227A32083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeINTSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:18:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:18:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so4449324pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QAiE/eKbkOat13BRz4fptI+M/Apebmd/oEEZ29NTEC4=;
        b=13gz6ScmzXw1Ek7Zc1O59cxv914cku+xzFCCI97/u0CSlp2s5ygBfNgMR5BdgouNeL
         EYvhf4LfdRqiwrNj3OSl3Ly6TG76o687zD+GpalsAj/wY2nPxUAXN3iJR2MqkNOc5Lnu
         JZNd1u75ZI3z5k1ahZpwLpDfvV1wgDsM0tKRHYrB5I4hAAwK2m+BvAonyz3A+A40psV5
         SDiJTId9XL3DJX0QOIYODBlib/pTD3CTW8m8azGzHhEsuOQecR5FcS6Lj84CLBK7Rzfy
         kYYzyYDSFU/As6iovQBOxN/MF+yvhqy1dz8UoJjVNDTpS8RfDFISxQdjZxrWh+xK0HOg
         XMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QAiE/eKbkOat13BRz4fptI+M/Apebmd/oEEZ29NTEC4=;
        b=LdbCUmgOwHaGTgl+UaWqF0k4Q7ziX3izrisarLvsJOsx/Ho5+OuLpzzYMH0qH7rDV1
         UWhQZ7fQ8LPTT/xKWvOmjLPmzGOX0q6O0JTXS/gCfE8Sgjp+f5bM1t4M1fbAu3+Yv7fl
         GELsdDybUNUFH2hqIthw+aO0dLVWeMgk1UeOJ36Q08KednTWmbggcqKBEjcZbhiLywFo
         uOzKbG1EYV1pCuCvMiv6hNTsmK0oJWVfhblNM2DM6yDGgUbTFbQNEOEBjx39ZJ6ok8UI
         6wyxPl8I3qB0FOlR7VZChph0rPXHLW0iNmFWLx/THG8OEvGkcFwNb9hOfrAKKRmOrcI5
         5uug==
X-Gm-Message-State: APzg51A/EmAFR3kvMAI1qHN9HzurGmf/ooQC8Q9ug5hrA78Edx/NvQo0
        86Aig2nPx242+9qXPXS2X4yFSz99fxU=
X-Google-Smtp-Source: ANB0VdbmuzBA7zb0M2J1+Z8F7fiLXz7yiFS6ytTW0xxy2Hzh4J3i16JwR8xR2Xz355R1pkHkc77b+A==
X-Received: by 2002:a63:fd52:: with SMTP id m18-v6mr12144802pgj.304.1536933844727;
        Fri, 14 Sep 2018 07:04:04 -0700 (PDT)
Received: from [192.168.0.239] (c-71-202-137-17.hsd1.ca.comcast.net. [71.202.137.17])
        by smtp.gmail.com with ESMTPSA id p73-v6sm11595309pfk.186.2018.09.14.07.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:04:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 11/11] x66/vdso: Add CLOCK_TAI support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180914125119.081037164@linutronix.de>
Date:   Fri, 14 Sep 2018 07:04:02 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ABB53D42-2A06-41B9-8A8C-40B39CD0289D@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <20180914125119.081037164@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 14, 2018, at 5:50 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> With the storage array in place it's now trivial to support CLOCK_TAI in
> the vdso. Instead of extending the array to accomodate CLOCK_TAI, make use=

> of the fact that:
>=20
> - CLOCK ids are set in stone
> - CLOCK_THREAD_CPUTIME is never going to be supported in the VDSO so
>   the array slot 3 is unused
> - CLOCK_TAI is id 11 which results in 3 when masked with 0x3
>=20
> Add the mask to the basetime array lookup and set up the CLOCK_TAI base
> time in update_vsyscall().

That=E2=80=99s... horrible. In an amazing way. Can you add BUILD_BUG_ON some=
where to assert that this actually works?

>=20
> The performance impact of the mask operation is within the noise.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> arch/x86/entry/vdso/vclock_gettime.c    |    2 +-
> arch/x86/entry/vsyscall/vsyscall_gtod.c |    4 ++++
> arch/x86/include/asm/vgtod.h            |    6 +++++-
> 3 files changed, 10 insertions(+), 2 deletions(-)
>=20
> --- a/arch/x86/entry/vdso/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vclock_gettime.c
> @@ -140,7 +140,7 @@ notrace static inline u64 vgetcyc(int mo
>=20
> notrace static int do_hres(clockid_t clk, struct timespec *ts)
> {
> -    struct vgtod_ts *base =3D &gtod->basetime[clk];
> +    struct vgtod_ts *base =3D &gtod->basetime[clk & VGTOD_HRES_MASK];
>    u64 cycles, last, ns;
>    unsigned int seq;
>=20
> --- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
> @@ -51,6 +51,10 @@ void update_vsyscall(struct timekeeper *
>    base->sec =3D tk->xtime_sec;
>    base->nsec =3D tk->tkr_mono.xtime_nsec;
>=20
> +    base =3D &vdata->basetime[VGTOD_TAI];
> +    base->sec =3D tk->xtime_sec + (s64)tk->tai_offset;
> +    base->nsec =3D tk->tkr_mono.xtime_nsec;
> +
>    base =3D &vdata->basetime[CLOCK_MONOTONIC];
>    base->sec =3D tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
>    nsec =3D tk->tkr_mono.xtime_nsec;
> --- a/arch/x86/include/asm/vgtod.h
> +++ b/arch/x86/include/asm/vgtod.h
> @@ -19,9 +19,13 @@ struct vgtod_ts {
> };
>=20
> #define VGTOD_BASES    (CLOCK_MONOTONIC_COARSE + 1)
> -#define VGTOD_HRES    (BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC))
> +#define VGTOD_HRES    (BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(C=
LOCK_TAI))
> #define VGTOD_COARSE    (BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_=
COARSE))
>=20
> +/* Abuse CLOCK_THREAD_CPUTIME_ID for VGTOD CLOCK TAI */
> +#define VGTOD_HRES_MASK    0x3
> +#define VGTOD_TAI    (CLOCK_TAI & VGTOD_HRES_MASK)
> +
> /*
>  * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same t=
ime
>  * so be carefull by modifying this structure.
>=20
>=20
