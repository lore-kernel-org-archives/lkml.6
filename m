Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAD5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAF120652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="cSmNPpap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAF120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeIHDlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:41:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44826 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIHDlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:41:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so7654671pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+CkIIU1FDMQ+9nxoiDmvGoKQtYlxKl/Ujcn3S4w9bvs=;
        b=cSmNPpapKZNR4O/Yd7d9NxRMxfbAzUtdUcoNHknmJ335S5BnEasZHceBjgGgWffmD4
         nPVG+FtpLCHsZ5gycRV98rRHAVrSZHAOrZtK4jE7baHO3mJXKQJS3M750hl7edbZNtjK
         8R6pjt9o0nqouwf4l4O4/2d7bjdLEsfrHIsgZLSsSeybZeZHu6fzxQwsIUgWIJvleZmJ
         xzUbgwZ8hTmqBPkLF/Xlg6/NI7+PJLWaST79GoSDVCo9fFpEcSAx4r7mCFLRsQYucnYW
         nhzZWwP1jhQXcHP+Yg+0Sr0HO0QecjoO9dk0o+K89UKbpQeJkbjNfQ5XKYdPc2NhoUBM
         pf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+CkIIU1FDMQ+9nxoiDmvGoKQtYlxKl/Ujcn3S4w9bvs=;
        b=U1bt6wcRfuk3IffkRLZ1cAyGmZWQQRR0dCFuM1RKHxOLkyaPbQD/ggrhkor3s3N1UN
         HYo2LRyNo7scH3RRiYObz99+eQAmpP6YJKa8Lz3fEEt68GVtmG2O8HqDxYPmo4/VDKb7
         ERbXrumUNPNagGdZGGcheN5BAuqBZn8jtmwKMwC2IvRapdbXVgEOmdxqwHd5pbR3KRbt
         hk4BHvvt5OOOJQkBev4fNVrFUpc9GCphiVUsCb/PEWeZfeIoGIPT6xnpRhmagCHHPGqu
         DEOGghrUNmdZJGN8jYjKxGDLSJ2Fs1wzL0GmfXJiXePORYWJ9T7bNveULtI+fM4Lsb5T
         A4jQ==
X-Gm-Message-State: APzg51A8Wlf1mYANJljB/wgFgqEY0zEXLBy7BGdPMs5ZG1Uzxwv7IljZ
        GYqaGBXhK696XDW5fhe0ayxlHQ==
X-Google-Smtp-Source: ANB0VdY3lil0u4iMvD3JUy61xYeGrfJctj68J4Hax/7SEWrQ4A5IuoyMmWyxXV6434BauVrq5m7g0A==
X-Received: by 2002:a63:2043:: with SMTP id r3-v6mr10585936pgm.105.1536361102490;
        Fri, 07 Sep 2018 15:58:22 -0700 (PDT)
Received: from ?IPv6:2600:1010:b062:3446:55bd:a895:1fd7:cbdb? ([2600:1010:b062:3446:55bd:a895:1fd7:cbdb])
        by smtp.gmail.com with ESMTPSA id i5-v6sm19056171pfe.140.2018.09.07.15.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 15:58:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 7/8] x86/mm/vsyscall: consider vsyscall page part of user address space
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180907194902.63F36CFE@viggo.jf.intel.com>
Date:   Fri, 7 Sep 2018 15:58:19 -0700
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        luto@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <17109C42-4679-4042-A22E-E686FCB96012@amacapital.net>
References: <20180907194852.3C351B82@viggo.jf.intel.com> <20180907194902.63F36CFE@viggo.jf.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 7, 2018, at 12:49 PM, Dave Hansen <dave.hansen@linux.intel.com> wro=
te:
>=20
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> The vsyscall page is weird.  It is in what is traditionally part of the
> kernel address space.  But, it has user permissions and we handle faults
> on it like we would on a user page: interrupts on.
>=20
> Right now, we handle vsyscall emulation in the "bad_area" code, which
> is used for both user-address-space and kernel-address-space faults.  Move=

> the handling to the user-address-space code *only* and ensure we get there=

> by "excluding" the vsyscall page from the kernel address space via a check=

> in fault_in_kernel_space().

I assume the motivation is that you want to simplify the kernel error path. I=
f so, can you mention this?

The patch itself is Reviewed-by: Andy Lutomirski <luto@kernel.org>, although=
 adding an unlikely() somewhere might be nice.=20

>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> ---
>=20
> b/arch/x86/mm/fault.c |   36 ++++++++++++++++++++++++------------
> 1 file changed, 24 insertions(+), 12 deletions(-)
>=20
> diff -puN arch/x86/mm/fault.c~vsyscall-is-user-address-space arch/x86/mm/f=
ault.c
> --- a/arch/x86/mm/fault.c~vsyscall-is-user-address-space    2018-09-07 11:=
21:48.720751896 -0700
> +++ b/arch/x86/mm/fault.c    2018-09-07 11:21:48.724751896 -0700
> @@ -873,18 +873,6 @@ __bad_area_nosemaphore(struct pt_regs *r
>        if (is_errata100(regs, address))
>            return;
>=20
> -#ifdef CONFIG_X86_64
> -        /*
> -         * Instruction fetch faults in the vsyscall page might need
> -         * emulation.
> -         */
> -        if (unlikely((error_code & X86_PF_INSTR) &&
> -                 is_vsyscall_vaddr(address))) {
> -            if (emulate_vsyscall(regs, address))
> -                return;
> -        }
> -#endif
> -
>        /*
>         * To avoid leaking information about the kernel page table
>         * layout, pretend that user-mode accesses to kernel addresses
> @@ -1192,6 +1180,13 @@ access_error(unsigned long error_code, s
>=20
> static int fault_in_kernel_space(unsigned long address)
> {
> +    /*
> +     * The vsyscall page is at an address above TASK_SIZE_MAX,
> +     * but is not considered part of the kernel address space.
> +     */
> +    if (is_vsyscall_vaddr(address))
> +        return false;
> +
>    return address >=3D TASK_SIZE_MAX;
> }
>=20
> @@ -1357,6 +1352,23 @@ void do_user_addr_space_fault(struct pt_
>    if (sw_error_code & X86_PF_INSTR)
>        flags |=3D FAULT_FLAG_INSTRUCTION;
>=20
> +#ifdef CONFIG_X86_64
> +    /*
> +     * Instruction fetch faults in the vsyscall page might need
> +     * emulation.  The vsyscall page is at a high address
> +     * (>PAGE_OFFSET), but is considered to be part of the user
> +     * address space.
> +     *
> +     * The vsyscall page does not have a "real" VMA, so do this
> +     * emulation before we go searching for VMAse
> +     */
> +    if (unlikely((sw_error_code & X86_PF_INSTR) &&
> +             is_vsyscall_vaddr(address))) {
> +        if (emulate_vsyscall(regs, address))
> +            return;
> +    }
> +#endif
> +
>    /*
>     * Kernel-mode access to the user address space should only occur
>     * inside well-defined areas of code listed in the exception
> _
