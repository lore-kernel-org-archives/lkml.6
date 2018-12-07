Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DEAC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0352E20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7ayPQB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0352E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeLGRpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:45:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38957 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeLGRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:45:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so2271270pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRaR9AFH4lYbLJ0IzmRZKFikdLE1iqTX6inMLw0Ga3Q=;
        b=d7ayPQB8W5xLLnuzDz7WVtXW3K+VUtmeAkYXrEevX9gsr7TVfTdDonsfcHKXSUwua3
         QR0ncX57D/bT5rB6b11kCx1VVqkp4Wz7blTN17NHmDRZ9qdXlUUmsrN1vYN18ctMguRe
         8jUMUylMZU/F3vVDZ6z/1jeQFVMZLDHFYwdWaacZbjtxjlNdZ51WJ3kPQ5iduMRZwFPk
         8FsiBjX9JeApy+MqVw89qK26Y0ANwfoOIf6aMXqcl8ADVb/ihYQ8d7M56dRPmUGCT6Ou
         dgOsk+EDarRLSBKTewKxMBS3V403NrKj3LP2Jpc6B8hNcAG/q93f2h6EQ1ycLfLhXNj2
         EclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRaR9AFH4lYbLJ0IzmRZKFikdLE1iqTX6inMLw0Ga3Q=;
        b=WLH40QKP82/V5WNXphBKrmkf/dobYsLn8uwsMMFOZh+wIhfxMB40/hiwMI8wj/IBZ3
         wCIO6GwQmfMT0exeaSw+GANhDEEoTsnVwVWIFshHp9zewRkg2wUvSiK4ewU0mrotwiQx
         Hb7+3UXCNq+SxulaUJCFGNfXa1h2AbjVFw/lzEQAWbsNe6uLbU0QkuyAm4BasQ5V2MF1
         eHHen6l4oF64+v0jq9ooGOg5sV4DXOVPAseGJSb0oHAKBpEuWTnUwPX7dEO11p3Iyb0o
         2kRwTlFPETuGFSI+tAKqDKFzru3BgrT8tykNBaNSYEsFIWPC2dQty6JPgFvxF3XF2VT5
         Bygg==
X-Gm-Message-State: AA+aEWbvvfbaizIE5peQHXuZojo3iSDGvXWiPV0qc9t4ElOB22uMmUjX
        SUgJPGCZg7txfDXXsyaclwILUVVGOzEGptdO9qCR2Q==
X-Google-Smtp-Source: AFSGD/URhRwdQBICCF+UqChNszzyAyzkL/tXRKhE6OM9W3tNYw48W5cvqYE27UTKdLdRF6gcjnqTXEFHqiHmmyVF6KM=
X-Received: by 2002:a65:4683:: with SMTP id h3mr2641860pgr.225.1544204753805;
 Fri, 07 Dec 2018 09:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20181206191231.192355-1-ndesaulniers@google.com> <20181207101814.GA9385@zn.tnic>
In-Reply-To: <20181207101814.GA9385@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Dec 2018 09:45:42 -0800
Message-ID: <CAKwvOd=75MRjaDbEjHRaMTm1MSC1wkLxPKhH_S3KXreP8yU9Uw@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: drop implicit common-page-size linker flag
To:     bp@alien8.de
Cc:     luto@kernel.org, Fangrui Song <maskray@google.com>,
        Andi Kleen <ak@linux.intel.com>, andi@firstfloor.org,
        Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>, Rui Ueyama <ruiu@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        rafael@espindo.la, Stephen Hines <srhines@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 2:18 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Dec 06, 2018 at 11:12:31AM -0800, ndesaulniers@google.com wrote:
> > These are implied by the target architecture and for x86_64 match the
> > max-page-size. The default for non-NaCl x86_64 is 0x1000 (4096).
> >
> > In bfd the common page size is defined as 0x1000 (4096) for non-NaCl
>
> Sodium Chloride?

Google's Native Client, a technology for running native code in a web
browser.  It's since been superseded by Portable Native Client (pNaCl)
and to an extent Web Assembly.  It seems that BFD still contains code
for NaCl.

>
> > x86_64 targets:
> >
> > bfd/elf64-x86-64.c:
> > 4998:#define ELF_COMMONPAGESIZE             0x1000
> >
> > For gold, the common page size is defined as 0x1000 (4096) for non-NaCl
> > x86_64 targets:
> >
> > gold/x86_64.cc:
> > 1413:  0x1000, // common_pagesize (overridable by -z common-page-size)
> > 1442:  0x1000, // common_pagesize (overridable by -z common-page-size)
> >
> > (ELF_COMMONPAGESIZE also defaults to ELF_MAXPAGESIZE when not set
> > explicitly for a target architecture in bfd/elfxx-target.h, but that's
> > not relevant for x86_64).
> >
> > Because it's implied by the target architecture, it's of questionable
> > use to implement in LLD.  This patch resolves one of the issues towards
> > using LLD to link an x86_64 kernel.
>
> LLD?

LLD is LLVM's linker.
https://lld.llvm.org/

>
> I can only guess what this commit message is about and have to look at
> the patch itself and then look at the LD(1) man page and rhyme up what
> it is aiming to do.
>
> How about rewriting it for mere mortals?

How does this sound:
TL;DR
-z common-page-size's default value is based on the target
architecture.  arch/x86/entry/vdso/Makefile sets it to the
architecture default, which is implicit and redundant.  Drop it.

-- 
Thanks,
~Nick Desaulniers
