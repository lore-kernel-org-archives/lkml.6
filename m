Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1541C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9D8206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gAitKGTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfBVXkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:40:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39893 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfBVXkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:40:11 -0500
Received: by mail-lf1-f67.google.com with SMTP id m11so2977336lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEtrxitrgwVOScKKZEaL4kHo4/Jod3iOAiSvJEfNQec=;
        b=gAitKGTOMM1O5T7dNf9iE/yXjhHKAA+HTPPAX8dfV1fKtrvQrM8mkFfs5RmfKRDGdw
         HW3/pUkt2DxAsChipmx48mKN7f/yiNYsecfzYHWGEne2qiiwza9eEds7Lp+E2DzsLyqs
         ZAGpyc6Kpe4OOWub731MYXLnYr42huGsF82Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEtrxitrgwVOScKKZEaL4kHo4/Jod3iOAiSvJEfNQec=;
        b=HXgsrmN2QwXF7gODR2jXmnjQE27mIdsI/QB41rMH3+RTQZMfBJWPOdUPdXA5mos1Jj
         5pCg2RJTONP48bD43ndcX7InNfdQIASIySjkuv9kpJQF8Z/2CX5BlJNKxTrzYevJGk0/
         xquGADvOdm9iBd54eVnUTfXP5dQYmgtOlDfWkLSdhcnIarkh4plcpD0tEDer6FyzCPkz
         bpUqIXWIXefb7nU85yc13Y/eGkHVyT7mluodZbXxOmVqfe7lzCL7zV2JxsSve7x4RkP0
         yTGGHALvseH19r/d96ktVhGZ3302Ygz5e4+62Y+Hrb3rABl/qD2Y4RFZrzIbU9xZMHF1
         wVvQ==
X-Gm-Message-State: AHQUAubawc4A+xigiPavWQmujqUHUpzfffUlawMqSS4Ai7x29NPdD7fc
        d4Sn63ndYpKYbrrIXEs4sG4u+nb6tY0=
X-Google-Smtp-Source: AHgI3IYDgd89nRbQRYUflrLpy6M7jgGXpxS4bUmcJ8yeEzJzUHGvQ+NE2R7XCiyRYy9p3QcZ/FHoSQ==
X-Received: by 2002:ac2:5624:: with SMTP id b4mr4172634lff.41.1550878808704;
        Fri, 22 Feb 2019 15:40:08 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id x2sm765733ljj.79.2019.02.22.15.40.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 15:40:08 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id l5so3020861lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:40:08 -0800 (PST)
X-Received: by 2002:a2e:6e09:: with SMTP id j9-v6mr3598767ljc.118.1550878456116;
 Fri, 22 Feb 2019 15:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net> <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net> <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com> <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de> <20190222222635.GK14054@worktop.programming.kicks-ass.net>
In-Reply-To: <20190222222635.GK14054@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 15:34:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHS_Dk2A7NPWi1KWGf5Ds1Yha_LnsjrWSF84+TyG54xA@mail.gmail.com>
Message-ID: <CAHk-=wiHS_Dk2A7NPWi1KWGf5Ds1Yha_LnsjrWSF84+TyG54xA@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 2:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So find the below patch -- which spotted fail in ptrace.c
>
> It has an AC_SAFE(func) annotation which allows marking specific
> functions as safe to call. The patch includes 2 instances which were
> required to make arch/x86 'build':

Looks sane enough to me.

Can you make it do DF too while at it? I really think AC and DF are
the same in this context. If you call an arbitrary function with DF
set, things will very quickly go sideways (even if it might work in
practice as long as the function just doesn't do a memcpy or similar)

              Linus
