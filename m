Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E556ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23E9208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="cH7FRJFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23E9208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbeGLVAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:00:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37702 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732583AbeGLVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:00:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id x10-v6so11409902pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q1Cd2NZGsiwiAqO4rvurU5q8igwq3KhHLdfmIkZ3XSk=;
        b=cH7FRJFzuxEYwD0oRvSVtV0AIOgfUnMjZyGR4lAzr6tX6niRPFtLumWBnqLO34hdWC
         uXdhdzsV4WpmVpKYxuXE9mtihKMG0Se3mycTQAIBNUnPzAcy3iNyzIyiztUy/1ZJ50kD
         2jHt2nTnt/FzF2vdgy8P0g7pyRpl48wnEnygZHh+C1eYK3uvBQgPZsWF9V5kpC+ivBRb
         Ms5SyWNTjPbD5oLAn+C/q4NJUWxy3/Ub/BFGmL+ETNduq+oAkCw7f6LlCTQTzWYw/HGt
         DW4R4dUrCYPy0ZNh0YrTaIa7sUzf+9b+/B0PsXrIvkyMOpUqNzWHa+AvGt+i/rMkuw3x
         QBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q1Cd2NZGsiwiAqO4rvurU5q8igwq3KhHLdfmIkZ3XSk=;
        b=bS/ddWzjhEVOjrZhcagaZ2yHVj44JreEvUmv3g1dQOyRfak3/6+jv54cqgzcMgyttF
         4gk0lpq2vdPVyDtzjHnik7iIzF7bSubnSywkGsV8nnR/HEHmx2kMaj4bt4Mc2I+bWhSU
         UulWuLjI7ZIeWQ8HW5uQ7hzEPHXPHzVYzqLmw6hM+yIaOLeRT1N1nIMpOfuO9LqAH4Nd
         lT5jBgItouphJE5nsYuuV2OTaeQhzNxWJi5toDnbXPlUXv+3S3AAU06HvM0dHqauoKQr
         bywCh1gZZlR72m7AUqezlvDom8RTVCNWHSOmFa+Cxp8+7lRHTK3rQM4/EOa6+ZUYC6oI
         +eqA==
X-Gm-Message-State: AOUpUlFrfGtgJ8o3slHq1MSHQ4roxbkcdRW1j9j9JOPrkHSRAxg0SaWu
        38BeBsUkBaCiL1AtbrVp0MjM6g==
X-Google-Smtp-Source: AAOMgpfSxNuJNTArc3NpGUTj59JTLPc+54ItSoNupYr9HB5d8scNz6MmkL4Ynb1kj7mL5j9kadRbCg==
X-Received: by 2002:a62:3b03:: with SMTP id i3-v6mr3948474pfa.197.1531428555695;
        Thu, 12 Jul 2018 13:49:15 -0700 (PDT)
Received: from [100.125.106.90] (24.sub-174-237-8.myvzw.com. [174.237.8.24])
        by smtp.gmail.com with ESMTPSA id s1-v6sm14376273pfj.53.2018.07.12.13.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:49:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 03/39] x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <1531308586-29340-4-git-send-email-joro@8bytes.org>
Date:   Thu, 12 Jul 2018 13:49:13 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>, jroedel@suse.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <823BAA9B-FACA-4E91-BE56-315FF569297C@amacapital.net>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-4-git-send-email-joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> From: Joerg Roedel <jroedel@suse.de>
> We want x86_tss.sp0 point to the entry stack later to use
> it as a trampoline stack for other kernel entry points
> besides SYSENTER.

Makes sense: sp0 will be the entry stack. But:

>=20
>=20
>    /* Offset from the sysenter stack to tss.sp0 */
> -    DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.s=
p0) -
> +    DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.s=
p1) -
>           offsetofend(struct cpu_entry_area, entry_stack_page.stack));
>=20

The code reads differently. Did you perhaps mean TSS_task_stack?

Also, the =E2=80=9Ctop of task stack=E2=80=9D is a bit weird on 32-bit due t=
o vm86. Can you document *exactly* what goes in sp1?

