Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B374C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2133D21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544124072;
	bh=L14+UrET8ZcM+P+baWEEnUb8lLvKC/05Zg7eZHMlekY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gRKX9eTQPT/yxxpUpMEvMXzdsrdmCyrCcj2FEsjXZv1x/SVORjkBkNE1g1WSZiAdH
	 yZ1xe0fUDlTAuuJE0eBTsE6HX4/WkXe1RkETcC3HmyvP6bhGKm5/iLTd6A8LaVupbD
	 9bQGmyVVI/tCl8eUjLeo7U3/o8CCfCrInC9TQ/j4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2133D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLFTVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeLFTVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:21:07 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8D452174D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544124066;
        bh=L14+UrET8ZcM+P+baWEEnUb8lLvKC/05Zg7eZHMlekY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LL1diwzXEqIfEkqUF1aKThTuJszwAALn0Y+GToQQw4bnGIixtveHHmEqQwSZi7Sa/
         n54lDPs84xtx+bFs944e9AMmLMozHyIeIcUvVPmqpLJMrRdnl6JTXNtUAxNpsqT0zd
         b5xeXYGezWmn2z5xCi0H4hiKCDc3p/l45iZ/WRw0=
Received: by mail-wm1-f46.google.com with SMTP id f81so2201098wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:21:05 -0800 (PST)
X-Gm-Message-State: AA+aEWZdLcOWBIbQ5GvSQkm5RoJSD7QMemswMrkPb1hhVhPAb/uRtPmo
        oTpEAOZC7ym1D3bl1BEzc1qzvHxJ1Yw8vdaymc4cWA==
X-Google-Smtp-Source: AFSGD/XO4l5eriCid/LOwXsFgWYvA3+YNoOzUE8guqsIrRyNLUQua1ruUi0hvXUT1Y1vSTmFzBRSNbuoRUE6bk1U2u8=
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr22138033wmc.74.1544124064357;
 Thu, 06 Dec 2018 11:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com> <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <20181204160304.GB7195@arm.com> <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
 <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
 <20181205114148.GA15160@arm.com> <CALCETrUdTShjY+tQoRsE1uR1cnL9cr2Trbz-g5=WaLGA3rWXzA@mail.gmail.com>
 <CAKv+Gu_EEjhwbfp1mdB0Pu3ZyAsZgNeaCDArs569hAeWzHMWpw@mail.gmail.com>
 <CALCETrVedB7yacMU=i3JaUZxiwsnM+PnABfG48K9TZK32UWshA@mail.gmail.com> <CAKv+Gu_Fo3qG1DaA2T1MZZau_7e6rzZQY7eJ49FQDQe0QnOgHg@mail.gmail.com>
In-Reply-To: <CAKv+Gu_Fo3qG1DaA2T1MZZau_7e6rzZQY7eJ49FQDQe0QnOgHg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 11:20:51 -0800
X-Gmail-Original-Message-ID: <CALCETrUUe+X6dAfcqkL=Lncy5RyDHx6m4s1g9QgMWPE9kOBoVw@mail.gmail.com>
Message-ID: <CALCETrUUe+X6dAfcqkL=Lncy5RyDHx6m4s1g9QgMWPE9kOBoVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jann Horn <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 11:04 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 6 Dec 2018 at 19:54, Andy Lutomirski <luto@kernel.org> wrote:
> >

> > That=E2=80=99s not totally nuts. Do we ever have code that expects __va=
() to
> > work on module data?  Perhaps crypto code trying to encrypt static
> > data because our APIs don=E2=80=99t understand virtual addresses.  I gu=
ess if
> > highmem is ever used for modules, then we should be fine.
> >
>
> The crypto code shouldn't care, but I think it will probably break hibern=
ate :-(

How so?  Hibernate works (or at least should work) on x86 PAE, where
__va doesn't work on module data, and, on x86, the direct map has some
RO parts with where the module is, so hibernate can't be writing to
the memory through the direct map with its final permissions.
