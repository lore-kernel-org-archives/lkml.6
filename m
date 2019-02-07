Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9954C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ABB2080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dNLd/+cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBGLvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:51:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43792 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBGLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:51:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so8996058lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKxl5AOq2toGrb7lGuGYh0UiKlBbE/oIUUUVrLfwH8Q=;
        b=dNLd/+ccUJdzVwIhA6Biw+4S5f5lKTs9YbSp6l45WHTWHcZlVavOKiz+hwKTwSBmvM
         zY5wdpgRpV9VSXqIdcwl/LoKTkOtqm5rizwv6TGt34M7fdDAhFOr8DvWNayF7CisaX4G
         JgjeMi3D/HZWfhP0OxpWbicGElvKtXm40SLLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKxl5AOq2toGrb7lGuGYh0UiKlBbE/oIUUUVrLfwH8Q=;
        b=IWYXBlWixV1m11JQIlPfI8I/+UnrBUrB4RQNQDc1bgwQg/Nv5feFmh+gPgU7/x+M8p
         uh4Gm3kclslR8wTreo2v9p5mbtwzKbSOW6ebgPusDyytUNvNFNK8zW77lTa2SfMOaRi5
         zItKHh8FwBgosKAqR4zB5uzzL/6MoB/lggrhjCwes7qnYoEbVsIM2MdBxOdsa70JEeiD
         7OMw7Qj3Ae6/SNWBJvOkHMq8LhY5R4+ZsO/bXkwMa1fV8VYlRIyOr+GKwXSauzODxWUG
         UIAf9Iq6R655L500ET6tE1ZmHvLJpF8mQsQhNm+4keb75aP+kWZLVYujL/xBB7D+9zkt
         Os9g==
X-Gm-Message-State: AHQUAuaqAoDniAgG8Qf01MpvAArntKzggrQ0UFRgdMdgNm6Wd/V58BvO
        lHl6z7p4aBw3nze9dzVcI04Yg1GzYkXszQ==
X-Google-Smtp-Source: AHgI3IbabYSLCAh3tNUrGQn6giMTlXdn+3o83TRTydmOjgYHG633JqqMsbjQtSNwdGWbLQm39UuiQw==
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr10507303lji.113.1549540270638;
        Thu, 07 Feb 2019 03:51:10 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a20-v6sm4247853ljf.28.2019.02.07.03.51.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 03:51:09 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id z25-v6so2523104ljk.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:51:09 -0800 (PST)
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr9401807ljg.87.1549540269230;
 Thu, 07 Feb 2019 03:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20181224231106.GA27438@gmail.com> <20190207001737.GA32096@agluck-desk>
 <20190207101846.GB32511@hirez.programming.kicks-ass.net>
In-Reply-To: <20190207101846.GB32511@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Feb 2019 11:50:52 +0000
X-Gmail-Original-Message-ID: <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
Message-ID: <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v4.21
To:     Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 10:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So now the question is where to put it back in, I'm thinking this might
> want to be in __cpa_addr().

Wasn't one of the goals to *not* keep the real virtual address around
to avoid speculation, since we don't want some random speculation
using that address to then trigger more MCE's?

If you re-generate the canonical address in __cpa_addr(), now we'll
actually have the real virtual address around for a lot of code-paths
(pte lookup etc), which was what people wanted to avoid in the first
place.

NOTE! I may be *entirely* off on this, and just confused about exactly
which speculative accesses people were worried about.

But at the same time, looking at all the other cases, it does look
like we need to do it in __cpa_addr(), because we also have other tsts
for an actual valid virtual address, ie all the

        vaddr = __cpa_addr(cpa, cpa->curpage);
        if (!(within(vaddr, PAGE_OFFSET,
                    PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))) {

kind of checks.

What's the exact rule and path from "set_mce_nospec()" (which is what
sets that "decoy" address with the high bit clear) to when we can then
use the address for tlb flushing?)

Adding Dan Williams to the participants, because it's really only
set_mce_nospec() that triggers this, and where should try to be
careful that that path really doesn't use the actual real virtual
address. He touched it last.

But I guess the whole decoy_addr thing goes back to Tony Luck and
commit ce0fa3e56ad2 ("x86/mm, mm/hwpoison: Clear PRESENT bit for
kernel 1:1 mappings of poison pages").

Do we really need it?

               Linus
