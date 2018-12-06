Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186DC20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdVU1IP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186DC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLFTgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:36:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36510 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeLFTgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:36:42 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so3384593itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1+TJbYA25R4+OFlYDVkshbeK/dem3I9OyORouedZy84=;
        b=CdVU1IP7myqvZPU/i/feoQ4iU/vLsS39I1qoZuvKscLBMgqKRwMLgTj5pqCQwqBp0B
         dOXn3YlIMisVkQ7H04X3o8qaqhGHk43hkH+9NSX/IRCA0+Un8UlfCtCxiABQYkQxMDMW
         NteoxkvQdo6gtlAGSQ8/eEJkbkbDfZeh9LBXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1+TJbYA25R4+OFlYDVkshbeK/dem3I9OyORouedZy84=;
        b=UnYSqohtULhdGB+12viCI5CvaHMpZZ0O6CJGHHtDVm1QXuY1ubDuLAIwG3EQCZpace
         FuWLgnwQIxitZdRsOYDAc3S2Naf+09J69WUvv58HnQE/znkkjBqjPDUO+P9r5I3j67GM
         QLDM0kd1J0Pk7fKzM09YL+GtuksBqsol1ljlmcn5ptmZvp2GW5e/1Ws8s09wFZ9b3okE
         gL4+FWpsN85zt7gxi2DemJCaofpKlUAjIS300Nc8UqDDP430IrtRevpkSwAOJa0Ahk3b
         bH4W0Mwi4uVVrP2Pd2mzbmVdQ6mZ7VWugFQwjk0r2AiVcL30jN2rxK4XOiDzf44B86nu
         HWjA==
X-Gm-Message-State: AA+aEWbU0200Z7gF58LIKt99gcHWSWQP4Yuc2TxQ/CKyj5XQo1TpTKEb
        QFnsVsO54W5eoQTyY62Qrx5HchRDXCz9+rowZ/TgVQ==
X-Google-Smtp-Source: AFSGD/XIzJAwq7wIeHN0Mtq3YOyVL8i0AfCWi+jncoLZZCf0ft6Gqkqrwvd6vxdDiy2T51txYxy1pt8WOYWzrLsPdHY=
X-Received: by 2002:a24:710:: with SMTP id f16mr17962971itf.121.1544125000637;
 Thu, 06 Dec 2018 11:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20181204160304.GB7195@arm.com> <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
 <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
 <20181205114148.GA15160@arm.com> <CALCETrUdTShjY+tQoRsE1uR1cnL9cr2Trbz-g5=WaLGA3rWXzA@mail.gmail.com>
 <CAKv+Gu_EEjhwbfp1mdB0Pu3ZyAsZgNeaCDArs569hAeWzHMWpw@mail.gmail.com>
 <CALCETrVedB7yacMU=i3JaUZxiwsnM+PnABfG48K9TZK32UWshA@mail.gmail.com>
 <CAKv+Gu_Fo3qG1DaA2T1MZZau_7e6rzZQY7eJ49FQDQe0QnOgHg@mail.gmail.com>
 <CALCETrUUe+X6dAfcqkL=Lncy5RyDHx6m4s1g9QgMWPE9kOBoVw@mail.gmail.com>
 <CAKv+Gu8pQcb_5AoRS8yyvT0FxHTe=yUQYNoQX2z6mysyC9noZA@mail.gmail.com> <20181206193108.GA21002@arm.com>
In-Reply-To: <20181206193108.GA21002@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Dec 2018 20:36:28 +0100
Message-ID: <CAKv+Gu-NhxUFuce+tZmpiZPLrsNaKWKjtHAg0-6iBnR1VEWc0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jann Horn <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, kristen@linux.intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, anil.s.keshavamurthy@intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        naveen.n.rao@linux.vnet.ibm.com,
        "David S. Miller" <davem@davemloft.net>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 20:30, Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Dec 06, 2018 at 08:23:20PM +0100, Ard Biesheuvel wrote:
> > On Thu, 6 Dec 2018 at 20:21, Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Thu, Dec 6, 2018 at 11:04 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Thu, 6 Dec 2018 at 19:54, Andy Lutomirski <luto@kernel.org> wrot=
e:
> > > > >
> > >
> > > > > That=E2=80=99s not totally nuts. Do we ever have code that expect=
s __va() to
> > > > > work on module data?  Perhaps crypto code trying to encrypt stati=
c
> > > > > data because our APIs don=E2=80=99t understand virtual addresses.=
  I guess if
> > > > > highmem is ever used for modules, then we should be fine.
> > > > >
> > > >
> > > > The crypto code shouldn't care, but I think it will probably break =
hibernate :-(
> > >
> > > How so?  Hibernate works (or at least should work) on x86 PAE, where
> > > __va doesn't work on module data, and, on x86, the direct map has som=
e
> > > RO parts with where the module is, so hibernate can't be writing to
> > > the memory through the direct map with its final permissions.
> >
> > On arm64 at least, hibernate reads the contents of memory via the
> > linear mapping. Not sure about other arches.
>
> Can we handle this like the DEBUG_PAGEALLOC case, and extract the pfn fro=
m
> the pte when we see that it's PROT_NONE?
>

As long as we can easily figure out whether a certain linear address
is mapped or not, having a special case like that for these mappings
doesn't sound unreasonable.
