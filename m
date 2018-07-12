Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C65208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Etl64dA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C65208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeGLUzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:55:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38376 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbeGLUzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:55:25 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so11164139pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WhN3lg8bybU36qZeDIFnd/5XIeJLEF9x4C2s/8d+HTw=;
        b=Etl64dA3oXFyKBbTAAckFItwkRDqK2Q64K0mG1/upc6WMVtugxB9YdGmryC8YBgmQR
         6YHR9+bZOAlGuXfBT++aKMMfcPzAD1W7VdCRjkwMH6xMpDaTnP8O9Rh88ApisYaggNQa
         3v72vOPSctgV4c5U+Vp6/O88A3obX0hi8t3NFVmHFfVffwqMxiNA+fAp8f2XOJ4GYOlv
         f2r3trWR8M5oXjYdYi4NUurhJ64jyJwYnESMMrbVlHrojVksSm3qKURdsR+OhVQaS6Tp
         RQdICEzMsg2PWeUwC5b8C3yCrxFQTiEYlCx4CcV2vJYeCl7J/BrKzOwmd3pjxLM3szC/
         ka5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WhN3lg8bybU36qZeDIFnd/5XIeJLEF9x4C2s/8d+HTw=;
        b=D+cajmCHhjU9xkjmJ26p9/jDJRfMXo+yS49eiimvas5iXlYRpYdOjdU+GQ+WIxaqUm
         OazzdQ2eACuWZYXHj5i8lVbZeG24mID0gjjujnSVN8PQept4MIr7S0WSlK1Db2wig1JX
         dUUKwcoLWaZepnlYXHmiOVyfs1o0Af9RO5IHXfOOh0zsHmrSx1MITHxp7JZUQsku/i25
         GiR0EYomk8+j5jucihKJixDyRMkcIUqmBJi1mSfQCaeJcCjPTZIqCLXmheQcsw5Iv7bK
         7Yk4YAHIqZv9pFw9wVgJE6gOmxWog65qm24+HtNsvy20ZjQG04Jpgq8fuWM4Lrr4MTXJ
         0ppw==
X-Gm-Message-State: AOUpUlGhWjsFUbQI5TbuzEwE9qh+EW36unfrzYORrvhzBEZE4URPZQ6n
        15yGfkBMEN7iifnhRpWQXL7OLaKKK5Q=
X-Google-Smtp-Source: AAOMgpfpFOmDvYTn3XmJKeHqQIwzO2opDcBz78ZjUA/wJC8c8iimXLOWrZGazP/rCvG1E9FM06TRkQ==
X-Received: by 2002:a17:902:704c:: with SMTP id h12-v6mr3520143plt.237.1531428250458;
        Thu, 12 Jul 2018 13:44:10 -0700 (PDT)
Received: from ?IPv6:2600:1011:b01e:e4d1:54df:ba07:cac1:aeab? ([2600:1011:b01e:e4d1:54df:ba07:cac1:aeab])
        by smtp.gmail.com with ESMTPSA id z9-v6sm5118321pfi.150.2018.07.12.13.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:44:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 02/39] x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry_stack
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <1531308586-29340-3-git-send-email-joro@8bytes.org>
Date:   Thu, 12 Jul 2018 13:44:07 -0700
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
Message-Id: <2FB5A671-8497-4A55-B0E9-082FA4259D1D@amacapital.net>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-3-git-send-email-joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> From: Joerg Roedel <jroedel@suse.de>
>=20
> The stack address doesn't need to be stored in tss.sp0 if
> we switch manually like on sysenter. Rename the offset so
> that it still makes sense when we change its location.
>=20
> We will also use this stack for all kernel-entry points, not
> just sysenter. Reflect that in the name as well.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

But, if there=E2=80=99s another version, please fix this comment:

>=20
>=20
>=20
>    /* Offset from the sysenter stack to tss.sp0 */

Here

> -    DEFINE(TSS_sysenter_sp0, offsetof(struct cpu_entry_area, tss.x86_tss.=
sp0) -
> +    DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.s=
p0) -
>           offsetofend(struct cpu_entry_area, entry_stack_page.stack));
>=20
> #ifdef CONFIG_STACKPROTECTOR
> --=20
> 2.7.4
>=20
