Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5EC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAE820855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="uzfgwJ7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAE820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeKJEp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:45:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43387 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbeKJEp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:45:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id g7-v6so1327120pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yn2ADpYGFJB8QoUsSxyXC9rSSLPefLmyAe8EvMBchbQ=;
        b=uzfgwJ7F3iERagD3R4Ktl0VEFJwr7mVJq2bEjb747G9Za4oEykPZX/UkOOxECq1URl
         kvi4uH56mtDvNdNp+BHy7daR0oFOs/Gmz6l/+dZeHfiklyMGatkrJN+eEOaTwGBwzz//
         gwSAwQEwWhfovTnzcuMkZ81pjPiIVwjp8E39mrcXj7m+hLiy2gsqvVa2SumXwWorcglD
         SRcX08LNyq2xMwpmtDqlo2SfbTKo0eWJODi1xvdhbZt+2aC1ubjlhLKLWrvOGsi0gC8M
         1X651CeFqIWl/r1FF7qj4QBGhHEzPFSxB7PlRAZFT3HuIyrXDlDQGXDZTJdolJZ1cKxW
         V4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yn2ADpYGFJB8QoUsSxyXC9rSSLPefLmyAe8EvMBchbQ=;
        b=JroGoRwTPtsNa686cG+ccS0sY4nK1bp1u9Kt6VmCw2XZLIG9T9EnUgO/I7G5sZe9Ft
         FfsWFhrS0gj/IztRpwpe+YIlBK3HT4WU1XDT42uaccfHj+PM9gbpoG7+UO/Kzz3FFtTP
         iijMEp2L9TTmR9pQOc8hSLMzUCsQVj6trGQHEgjV8JaiKPvBry8SOH3ZESTCyzPTbHT4
         G6OvtZy3eHKeQn83kmL+NSne7+wKLYwlZngMNgmr32Em67SZz0p8ly+Mw7o0SuwR3DWA
         1ama2jEcXO0U3JfveckPUq1m725Vvc2Kc21ogmiYJpf3OVWlrdEfhcG7kpyzfNwwFmGK
         8K3w==
X-Gm-Message-State: AGRZ1gIom6SOWANZ7QFP3crTJdhEW9dIoTB6ARlo658CBhBMDDiky1eV
        fxtBKYa4fyOTOnv/GNpDvHadhe/94rs=
X-Google-Smtp-Source: AJdET5dTNo933eUXe+O7iTuhs7n4dBeBH6s+BX/eyhjwCmpDpq1KBhARCg5KlpqhSFFjgfqwXFQLjw==
X-Received: by 2002:a62:a5b:: with SMTP id s88-v6mr10532145pfi.136.1541790215160;
        Fri, 09 Nov 2018 11:03:35 -0800 (PST)
Received: from ?IPv6:2600:1010:b002:666:dc7a:5a83:1f2b:9078? ([2600:1010:b002:666:dc7a:5a83:1f2b:9078])
        by smtp.gmail.com with ESMTPSA id l64sm5784003pge.73.2018.11.09.11.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 11:03:34 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 06/13] arc: define syscall_get_arch()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075013A59239B@us01wembx1.internal.synopsys.com>
Date:   Fri, 9 Nov 2018 11:03:32 -0800
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C398ED8-30BC-4483-B5CF-1EB2F2699B0D@amacapital.net>
References: <20181109031605.GF21511@altlinux.org> <C2D7FE5348E1B147BCA15975FBA23075013A59239B@us01wembx1.internal.synopsys.com>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 8:50 AM, Vineet Gupta <vineet.gupta1@synopsys.com> wrot=
e:
>=20
>> On 11/8/18 7:16 PM, Dmitry V. Levin wrote:
>> syscall_get_arch() is required to be implemented on all architectures
>> that use tracehook_report_syscall_entry() in order to extend
>> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>>=20
>> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>> ---
>> arch/arc/include/asm/syscall.h | 6 ++++++
>> include/uapi/linux/audit.h     | 1 +
>> 2 files changed, 7 insertions(+)
>>=20
>> diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscal=
l.h
>> index 29de09804306..5662778a7411 100644
>> --- a/arch/arc/include/asm/syscall.h
>> +++ b/arch/arc/include/asm/syscall.h
>> @@ -9,6 +9,7 @@
>> #ifndef _ASM_ARC_SYSCALL_H
>> #define _ASM_ARC_SYSCALL_H  1
>>=20
>> +#include <uapi/linux/audit.h>
>> #include <linux/err.h>
>> #include <linux/sched.h>
>> #include <asm/unistd.h>
>> @@ -68,4 +69,9 @@ syscall_get_arguments(struct task_struct *task, struct p=
t_regs *regs,
>>    }
>> }
>>=20
>> +static inline int syscall_get_arch(void)
>> +{
>> +    return AUDIT_ARCH_ARC;
>> +}
>> +
>=20
> Does ptrace (or user of this API) need a unique value per arch. Otherwise i=
nstead
> of adding the boilerplate code to all arches, they could simply define AUD=
IT_ARCH
> and common code could return it. Also the EM_xxx are not there in
> include/uapi/linux/elf.h to begin with since libc elf.h already defines th=
em.

A lot of architectures allow multiple audit_arches at runtime due to compat s=
upport and similar features, so it really does want to be a function.  The g=
oal of this patch set is to get it supported everywhere.

>> #endif
>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> index 818ae690ab79..a7149ceb5b98 100644
>> --- a/include/uapi/linux/audit.h
>> +++ b/include/uapi/linux/audit.h
>> @@ -375,6 +375,7 @@ enum {
>>=20
>> #define AUDIT_ARCH_AARCH64    (EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH=
_LE)
>> #define AUDIT_ARCH_ALPHA    (EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)=

>> +#define AUDIT_ARCH_ARC        (EM_ARC)
>> #define AUDIT_ARCH_ARM        (EM_ARM|__AUDIT_ARCH_LE)
>> #define AUDIT_ARCH_ARMEB    (EM_ARM)
>> #define AUDIT_ARCH_CRIS        (EM_CRIS|__AUDIT_ARCH_LE)
>=20
> So I don't have the context of this patch (or coverletter) but what exactl=
y are we
> trying to do with this (adding LE to audit)  - what happens when an arch i=
s
> capable of either and is say built for BE ?

The primary intent is that the triple (audit_arch, syscall_nr, arg1, ..., ar=
g6) should describe what system call is being called and what its arguments a=
re.  I=E2=80=99m personally not sure what, if any, technical value there is i=
n the LE bit.

I do think it makes sense for BE and LE to have different values.=
