Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C7A206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="I0w3oL3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C7A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeLDXlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:41:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38516 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeLDXlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:41:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so9011681pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 15:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vE0KKDVrzDXdR9YDAVJw8HT19GAGJlZECwz3eHArjk8=;
        b=I0w3oL3B3xluuat3axa1N9PZPDqVwh0v3Qr6gUUr7PBs9wXfPSHbUdCmnBIOCzR/zm
         UDvpQMRI82E0kyM2PUYwl46DgfdfO1IPNEr+P1ZZls25KGZm0uXCeFBqU1cIHt7NlmCo
         DF5JNqagX0MNoikdskNiLm6OWl8+xJre65pliIzyJfhGPFEReM2kk2PlLoIHW9PYvOXm
         noZBhzOOi0VwQK+JUz5n/gvDZ8Jq5B027NsSqKX9dyqw2SIe4wTS9izAufjxMCavia4A
         Ro26twHRdkFyLbUl+7VxUi2fWF5wlTlOhh/rkfYDBhKVnHcLpGMrZ51Yg3TqQ2qyV7Kr
         EvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vE0KKDVrzDXdR9YDAVJw8HT19GAGJlZECwz3eHArjk8=;
        b=cw6fjQyWlrkIZWGGV+egM08ozzwUUatjpsA4xwn07QlzIS+0ixEFaRyMBSSSVo5Ohv
         MA38NxdutBTf97kqtIUYo3JziBN9N/uUDqaHGGSKTkPJAgrWVb4Hrt4lx1CIYFFPnrSk
         ANWQd+wnyTNWyWazyMmwCCk69TJbLkS+YIpnkoic8bcmDuFN1pIDArHBLSEm6GCBR0WK
         iAnhocyDIsuVai4mZb2nz1+Wekw+kgXixfYWS7vDrJe5vfK1xZV7hWOAtwwvOD4h7QAf
         ZZenBXrWboOrZ7vwixdl7MxMDlNAj8WMUwnMObS2VwX02uk0EWytMf0M3MBq7/ubuyA/
         wOeg==
X-Gm-Message-State: AA+aEWbhLmM3+pV7U+UCPVxGjMAW1MteNdkS/kEl5c9z2rGAzYGeDDU/
        QEzxQ0U4zTbu0MePXLijoYwGeUYrxCo=
X-Google-Smtp-Source: AFSGD/VuOZ7V8G56y4v1bJqwmwxghiHNq9BTag8EGc6H4KxD/kcrmH5NpWivrGr3bZdVtL4cuOsLdQ==
X-Received: by 2002:a62:8dd9:: with SMTP id p86mr21814220pfk.143.1543966863345;
        Tue, 04 Dec 2018 15:41:03 -0800 (PST)
Received: from ?IPv6:2600:1010:b05a:3e8f:cd65:4915:ea8d:fbab? ([2600:1010:b05a:3e8f:cd65:4915:ea8d:fbab])
        by smtp.gmail.com with ESMTPSA id b27sm24937330pfh.113.2018.12.04.15.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:41:02 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/4] Static calls
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181204180835.29f9aa03@vmware.local.home>
Date:   Tue, 4 Dec 2018 15:41:01 -0800
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE66E7C9-5735-48B3-A001-E9FCDA46E177@amacapital.net>
References: <cover.1543200841.git.jpoimboe@redhat.com> <20181204180835.29f9aa03@vmware.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 4, 2018, at 3:08 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>=20
> Where did this end up BTW?
>=20
> I know that there's controversy about the
> CONFIG_HAVE_STATIC_CALL_OPTIMIZED option, but I don't think the=20
> CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED version was controversial. =46rom the
> v1 patch 0 description:
>=20
> There are three separate implementations, depending on what the arch
> supports:
>=20
>  1) CONFIG_HAVE_STATIC_CALL_OPTIMIZED: patched call sites - requires
>     objtool and a small amount of arch code
>=20
>  2) CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED: patched trampolines - requires
>     a small amount of arch code
>=20
>  3) If no arch support, fall back to regular function pointers
>=20
> My benchmarks showed the best improvements with the
> STATIC_CALL_OPTIMIZED, but it still showed improvement with the
> UNOPTIMIZED version as well. Can we at least apply 2 and 3 from the
> above (which happen to be the first part of the patch set. 1 comes in
> at the end).

Sounds good to me.

>=20
> I would also just call it CONFIG_STATIC_CALL. If we every agree on the
> optimized version, then we can call it CONFIG_STATIC_CALL_OPTIMIZED.
> Have an option called UNOPTIMIZED just seems wrong.

My objection to all the bike shed colors so far is that we *always* have sta=
tic_call() =E2=80=94 it=E2=80=99s just not always static.

Anyway, I have a new objection to Josh=E2=80=99s create_gap proposal: what o=
n Earth will kernel CET do to it?  Maybe my longjmp-like hack is actually be=
tter.


