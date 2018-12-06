Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F33C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121AD20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqJ+TXVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121AD20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeLFTXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:23:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43002 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbeLFTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:23:33 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so1278465ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AuQHmkflHUXBiQLptcaBPw7KGurSXS2ND8rkREtR754=;
        b=CqJ+TXVYSgaeVJbTrmmnh37zS5SOkAn73llCPRZJ8OKeoG95r/51LJ2PFtjBCUGlsy
         d+O0Sb2BI2rV1dvnTcJ8BC9CYuGZq7T2cGprG6kEQ19YtzcDblUKM+mW4wr4qLzCCNYi
         4MwnQ8XVUSt6Bh7HB3WsYhF/ITQFDxBs3uQco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AuQHmkflHUXBiQLptcaBPw7KGurSXS2ND8rkREtR754=;
        b=QsS1onwhlepv7E1dr0w439tJTdIAgk3rawuHX7HDwYfdKAsP1ZHcBR/R47UvUpH+ci
         btymGygLcCX1LQO7YvEiHjhFviyEJd2TLXL6QnFEfdbwaTA/tbQyv04/SikcXun9fuWh
         8yA+OM8ywvsTm5qViQci3cFsOQwDHCXddBO3M/9HhNwYgdQMoik1yHwlr9YPCIQ/WiFz
         2euetty/3CAhTph1CiSoDESHmrfgXqBykESgcansEq0ajhgm85SWD1N8spE/a4n7kBxR
         m/Tpok27idQUpwIaHBUXq0AYQU7EwhQmuTWl4KV+InKWZ+1eLkxVXQ8TCsoWTDjqfNVm
         LEag==
X-Gm-Message-State: AA+aEWZyc+b4bHiXRbOHDfzvEiZfWT0nkAvovIaJMzKf9VpGvpvONHd2
        7kB+FXy4g6PzFlO+630C02Y/zHYD/HwWDz7jZiTsvA==
X-Google-Smtp-Source: AFSGD/XVMlvNaTjA7QKObX99zqLrgaF1fZt2v8Z1Aq3wgXIIJWLLFTuM8IneiL9d3QN8zHv91OpQHhksosAw0Uh8VIQ=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr24087141iob.170.1544124212172;
 Thu, 06 Dec 2018 11:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com> <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <20181204160304.GB7195@arm.com> <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
 <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
 <20181205114148.GA15160@arm.com> <CALCETrUdTShjY+tQoRsE1uR1cnL9cr2Trbz-g5=WaLGA3rWXzA@mail.gmail.com>
 <CAKv+Gu_EEjhwbfp1mdB0Pu3ZyAsZgNeaCDArs569hAeWzHMWpw@mail.gmail.com>
 <CALCETrVedB7yacMU=i3JaUZxiwsnM+PnABfG48K9TZK32UWshA@mail.gmail.com>
 <CAKv+Gu_Fo3qG1DaA2T1MZZau_7e6rzZQY7eJ49FQDQe0QnOgHg@mail.gmail.com> <CALCETrUUe+X6dAfcqkL=Lncy5RyDHx6m4s1g9QgMWPE9kOBoVw@mail.gmail.com>
In-Reply-To: <CALCETrUUe+X6dAfcqkL=Lncy5RyDHx6m4s1g9QgMWPE9kOBoVw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Dec 2018 20:23:20 +0100
Message-ID: <CAKv+Gu8pQcb_5AoRS8yyvT0FxHTe=yUQYNoQX2z6mysyC9noZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>,
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

On Thu, 6 Dec 2018 at 20:21, Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Dec 6, 2018 at 11:04 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 6 Dec 2018 at 19:54, Andy Lutomirski <luto@kernel.org> wrote:
> > >
>
> > > That=E2=80=99s not totally nuts. Do we ever have code that expects __=
va() to
> > > work on module data?  Perhaps crypto code trying to encrypt static
> > > data because our APIs don=E2=80=99t understand virtual addresses.  I =
guess if
> > > highmem is ever used for modules, then we should be fine.
> > >
> >
> > The crypto code shouldn't care, but I think it will probably break hibe=
rnate :-(
>
> How so?  Hibernate works (or at least should work) on x86 PAE, where
> __va doesn't work on module data, and, on x86, the direct map has some
> RO parts with where the module is, so hibernate can't be writing to
> the memory through the direct map with its final permissions.

On arm64 at least, hibernate reads the contents of memory via the
linear mapping. Not sure about other arches.
