Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291E5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE39E208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eew4t0Wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE39E208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeHTTit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:38:49 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41167 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTTis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:38:48 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so26796446oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v+k+o1T0cZ9w0718XRpCNDH2s4NkFEzOI5V8LWnkCwU=;
        b=eew4t0WjgPTc9zJOhkIFxkEwXyfCLlKC8ygLJ5oheX7noKAMIdolChE+jc3av4ipuG
         BQ8Ty6mflK8JbCLZyyvzWZHabt1vpxZIYKA3vCQY8DsVWV2FN8LYYV1H3bAlddXKwgbH
         8oH6TFS9TFjSUp2sCTvZMVZUkXndH7nslLMQolc1nKPQFfLlHTwQ0OdEw571sYmLlMHR
         84T/08rhNhx8OjB80gD7m02QeU/ye9Kt9gaOvFP8y0R4xK7dIcxVor98zYumwy5g8jPk
         0AHfX2K05i9GWeHJr6AlyN84/G7pKoCyHwG2WJ2L+nCFQfKpqXdWW6I/IrpoXgoqOtGc
         zYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v+k+o1T0cZ9w0718XRpCNDH2s4NkFEzOI5V8LWnkCwU=;
        b=kOPHhssTUBrIAIdS9FCdiycC3+9F/QT/nLri2XwumhFOL7tzvO5I2eVcZM852Cy7Tj
         V4xN+KlV9wmcw4z3jbjJ97rLoqWXSGgfx1B1O3xOQAS/LzCKNtolLtxyETaXjicpT/4j
         5/wlk6Gh3coGKjbSpAazOxmnDNr/g9FO8Jj9/gBp43eB9clSu9WSbxf8svqYlJPcuhgw
         IOmVZLp3MTX6ZzmV0O/7sMsFa1gSuI710hah4y3wyEFohp3yO8I7t8Ide+KEE1nMUrHu
         EeNf8ewq4W77rJPdTmbXZz9/UnPGqI+f61p58MpcG2+2TxGhS5rlPV0srvh2aejJodgp
         QHJQ==
X-Gm-Message-State: AOUpUlEAkoE+2q97aa/wNzK6bEyz6ASqYUbZ//Xxj8Szh95oSbDxR6dK
        E3er3b/GipryftNn1NYa6CX/AU+GMbDk27RvJ6ZSkw==
X-Google-Smtp-Source: AA+uWPy3Kvka7d6mct296X5TbtN4/RPTtAEIVmc2kI074PeyFHx7/Y07Wz8tY8G2vd2H0XF6/0Vmy5ny9GUx5lnaiJc=
X-Received: by 2002:aca:4141:: with SMTP id o62-v6mr15599309oia.24.1534782150415;
 Mon, 20 Aug 2018 09:22:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3408:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 09:22:29
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1808201758250.1551@nanos.tec.linutronix.de>
References: <20180807222535.143193-1-jmattson@google.com> <alpine.DEB.2.21.1808201758250.1551@nanos.tec.linutronix.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 20 Aug 2018 09:22:29 -0700
Message-ID: <CALMp9eTSNA_52tdgqeqMpBYMkPTvhGtwwWyGMwQKH3cyiS0agA@mail.gmail.com>
Subject: Re: [PATCH] x86/spectre: Expand test for vulnerability to empty RSB exploits
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Fred Jacobs <fjacobs@vmware.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 9:00 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 7 Aug 2018, Jim Mattson wrote:
>
> > Skylake-era Intel CPUs are vulnerable to exploits of empty RSB
> > conditions. On hardware, platform vulnerability can be determined
> > simply by checking the processor's DisplayModel/DisplayFamily
> > signature.  However, when running in a VM, the operating system should
> > also query IA32_ARCH_CAPABILITIES.RSBA[bit 2], a synthetic bit that
> > can be set by a hypervisor to indicate that the VM might run on a
> > vulnerable physical processor, regardless of the
> > DisplayModel/DisplayFamily reported by CPUID.
> >
> > Note that IA32_ARCH_CAPABILITIES.RSBA[bit 2] is always clear on
> > hardware, so the DisplayModel/DisplayFamily check is still required.
> >
> > For all of the details, see the Intel white paper, "Retpoline: A
> > Branch Target Injection Mitigation" (document number 337131-001),
> > section 5.3: Virtual Machine CPU Identification.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > Reviewed-by: Peter Shier <pshier@google.com>
>
> That has been superseeded by:
>
>   fdf82a7856b3 ("x86/speculation: Protect against userspace-userspace spectreRSB")
>
> right? At least it does not apply anymore...

Right. It doesn't appear that Skylake CPUs get any special treatment any more.
