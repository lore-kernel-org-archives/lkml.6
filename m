Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B301DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533C7208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVu5/Be4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533C7208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeH1DBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:01:23 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39202 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1DBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:01:23 -0400
Received: by mail-oi0-f65.google.com with SMTP id c190-v6so1221564oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIhkFPEB3HSC62HBYwM8qrc3OYJJPvPmXsLDQTpmepw=;
        b=UVu5/Be4PzNfeLI4dfxd25tipZ0h9m/ovnTAdTQHf/bVEq916WGurhgid7XwYB7WcE
         z33Z7WrLPRCd15zeJ4yj4ZuDkNSUf/cFRnaYDrJSeCb4KRkwuu8dtxePxrPnmjdP+N5u
         cm0KKLGoRPnexVsPNgDNFkkM5C7A8DyFFkYBL66fAI3xAxxCBWVc/GGNxqvAqFiSMDHO
         ocYHxSG7RuzyEGosp51090Pg8q8n7FOMQCAnsaZDTEWRcVramLvVGeXPdkqFQ6w3WJQd
         0agHNtfmOGUQ3wnRUnf/oPE1R9rLUngAxFD1slFc5oKDMOQuRXzMSXQor7nEz8J/1lZ8
         thqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIhkFPEB3HSC62HBYwM8qrc3OYJJPvPmXsLDQTpmepw=;
        b=Jj93gjdsuRL1/vrZqth4OLlsU+WWrd/2Ixq/3hDtffpf4dT6z1pNcTNHpV6DdP/Y5L
         leAa9Cc9B5q0OwFbHTmALx2JgfA1hCKsh/ekSak5YnWjxhC/Mx6tSY5F1CqS+Q2Gxj77
         bdcACDuFsxpqhGaW1vNrL/hPIWGwKsOp7TCZfL6L86JINTfdETaCAAaOS3okwWKk5yYZ
         ZrTdSyvTBUWicuA5fwP3fZItFXnyb3y2C0UevLKl/Jt/g+hjzmJYPMnXn5Qq8Nclm3Jr
         vgfwWMb2kxgG4Osg/NkMCUfM0sMNS1WMRRxTSEQ1RTfB4wXkmz3COqb6EnTs0LiIfPVM
         RS3g==
X-Gm-Message-State: APzg51DMXR0oK6CbJh0JOHtuh9zyRc/O03nqrqtL4uBRFEqf27Y3f3zI
        oE6Eweenbc1+hxrAazfgEB4Jk93FVyRCzsxkHv307Q==
X-Google-Smtp-Source: ANB0VdaydxBWecF09P84nIKwwAZr0AeX7DmuCdM5KmPq+vWzxaIhJSCY8djdaYyUtcdnGIp+LH8AT6RNaoH93fRxql8=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr682647oif.348.1535411557463;
 Mon, 27 Aug 2018 16:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
In-Reply-To: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Aug 2018 01:12:11 +0200
Message-ID: <CAG48ez2DkjrvmP57JvbC+4ee0qCXCEXEyYuA4YApWGX_k29y_w@mail.gmail.com>
Subject: Re: [PATCH] x86/nmi: Fix some races in NMI uaccess
To:     Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 1:04 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> In NMI context, we might be in the middle of context switching or in
> the middle of switch_mm_irqs_off().  In either case, CR3 might not
> match current->mm, which could cause copy_from_user_nmi() and
> friends to read the wrong memory.
>
> Fix it by adding a new nmi_uaccess_okay() helper and checking it in
> copy_from_user_nmi() and in __copy_from_user_nmi()'s callers.

What about eBPF probes (which I think can be attached to kprobe points
/ tracepoints / perf events) that perform userspace reads / userspace
writes / kernel reads? Can those run in NMI context, and if so, do
they also need special handling?
