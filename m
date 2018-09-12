Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D1C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF4E20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="c7bpqklV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF4E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeILUw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:52:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46233 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeILUw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:52:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id t19-v6so1154346ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=42SJlqJZuu6SRLlPyMRMzajgqPPjYpEJjmPYlo2xirU=;
        b=c7bpqklVClPc1F0Cr0VdTzbVWZpKzFr00ZoyAk/ZWWQOW/Hh5+Cy5610kskcc0Yf0d
         AkGSsxJjbZgeNscOn9JXVy+0BVLV+XcjnGn89euzqK2pwTkbhuWCWAkUD12j7PlMSYCk
         UdmyL2l/F0ojvYAywuE8UZ4T5yWLAjlxd8kMli8/IBcsHyU/pLWyfHnuhJ5/VH/taMWL
         uCwxdTusZ+uxLI9PsWIrPGB9eWhD7PPko+y9SGYYR0A/yHip0S9/zGtV44BuSmInn4zY
         FOT/hXoFn+puMDhRSa8lQQ/ypEgTIMHCK9ghMBZgoSILdW1CNFyxHqUSPUtdBH5RV6Bc
         7MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=42SJlqJZuu6SRLlPyMRMzajgqPPjYpEJjmPYlo2xirU=;
        b=kqGT91PMUJ6jlN+Rpd9+C8K1L6VAHj6UrRTnHUQshBbRj964VFGCXNf405i8ORzeAX
         ibDyd43y7Ri2qPDebnNDXFhYN7dnd2xKufBNmGbkDP1aBJHM/VubZfTYJgbu11YBwjV6
         6Co3Vn4OtrcICgUNl5OVdRyI+THTwJnWK6vjztnC4qjf21aONa3v+VHAVx/T2tUa3JxF
         X5PoHr1mmwz0MOUhE3qDwtJh9jpmFPDoeRG+6uj/OAoAyHjZdCRUSaOXAoEQ0vO4AaZo
         gzOUs/so8I7UlMwP7o5vOwE2un/xwl4cz4f+xpgJcsItAf39HMW3Sg5i3V4hRwk+1UZ4
         FiGQ==
X-Gm-Message-State: APzg51Bc6+XE95JJa+h2uN5e31caJn4ADoWc+7Y5r2E+cIqGIF/NxmwP
        amYgXUaAgzbfTZX04v7tw6RDcA==
X-Google-Smtp-Source: ANB0VdbtFge3F/dwAXw1CjkP1uiGUgWanqBi4LAb0oQhwgNqhl20HpbgyNb1MckgsQqQp34cVHG+Dg==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7-v6mr3040276plt.128.1536767241244;
        Wed, 12 Sep 2018 08:47:21 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:9592:4a20:451a:68da? ([2601:646:c200:7429:9592:4a20:451a:68da])
        by smtp.gmail.com with ESMTPSA id z5-v6sm1757890pfh.83.2018.09.12.08.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:47:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 10/10] x86/fpu: defer FPU state load until return to userspace
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180912133353.20595-11-bigeasy@linutronix.de>
Date:   Wed, 12 Sep 2018 08:47:19 -0700
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <650FC457-7E4C-473A-9E5F-EAFC74F6444B@amacapital.net>
References: <20180912133353.20595-1-bigeasy@linutronix.de> <20180912133353.20595-11-bigeasy@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 12, 2018, at 6:33 AM, Sebastian Andrzej Siewior <bigeasy@linutronix=
.de> wrote:
>=20
> From: Rik van Riel <riel@surriel.com>
>=20
> Defer loading of FPU state until return to userspace. This gives
> the kernel the potential to skip loading FPU state for tasks that
> stay in kernel mode, or for tasks that end up with repeated
> invocations of kernel_fpu_begin.
>=20
> It also increases the chances that a task's FPU state will remain
> valid in the FPU registers until it is scheduled back in, allowing
> us to skip restoring that task's FPU state altogether.
>=20
>=20

> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -101,14 +101,14 @@ void __kernel_fpu_begin(void)
>=20
>    kernel_fpu_disable();
>=20
> -    if (fpu->initialized) {
> +    __cpu_invalidate_fpregs_state();
> +
> +    if (!test_and_set_thread_flag(TIF_LOAD_FPU)) {

Since the already-TIF_LOAD_FPU path is supposed to be fast here, use test_th=
read_flag() instead. test_and_set operations do unconditional RMW operations=
 and are always full barriers, so they=E2=80=99re slow.

Also, on top of this patch, there should be lots of cleanups available. In p=
articular, all the fpu state accessors could probably be reworked to take TI=
F_LOAD_FPU into account, which would simplify the callers and maybe even the=
 mess of variables tracking whether the state is in regs.=
