Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5420C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1F9213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+ec1scs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1F9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJDQEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:04:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35522 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeJDQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:04:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so9061568wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=83P2dvg1cXHB7jtJWUE/b28+Sf5/oJK7GJm847GksEs=;
        b=h+ec1scst3lKxWcLqZpqvqdFSsIXy8jKeZ/jItqq8StlQW0QF+jslq+3Av2AeohzNR
         +wyTArg/0qqYffm9eg9VHYWCmKrXGi7fAoCoeecDlfqoFYUrSqbZ9FAgZER90xxCCZct
         uRqxMa6L9bNcE17rIATiuyivW6T539zS0mIWnOxoe/mRdiP5m/thSdI3PUA+i1pQNhkb
         fuBf/psvQLjbfovJ1Tw+SLTfZsfAOZOhr2+lbX2pRQlNH324h+m8cJIoE8ktYgAvRKRp
         g4Xjdgvo8/u1P8KCGH/AFyxbAlpIuh7uktvYVh8Kz0tH8Nsb91UawsXfP970nkOPdWXW
         m5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=83P2dvg1cXHB7jtJWUE/b28+Sf5/oJK7GJm847GksEs=;
        b=knRHTDPGzu+vfUwBemKvUEwAasnHGKlRCDQvJPzXWs9/fUOo2QWwAT/MOyJmDjNiin
         wb4b9qWY80+2b1sZws4LBUGWCNRlaK7lFDwhsjzksGTcr7CL3uKFEXmsiJwEeX+HYu7P
         HatOF/6/KTZwJM5qYFxnIOWvkUKSc8bG78VutDTy+JRSmpXqR/F3MsAZf8LJWMGl17iA
         Y+2lAewffWzDvCLNzftOskRZ7u31FNLOqImk4GOKtXeJ7fJUDnky5kr7tpqPSBtkBCyv
         U/rkyCHLVhgOkLX0quRwxPk7m58WJcGAofjYcr/9aNdMp8x5/TpOCafqxNmVnVXFq2ov
         OWRA==
X-Gm-Message-State: ABuFfogepetZsFmNeaIZEd/DyQl3DGLLdMOlp+k2yH6twfh1QsWhxl8p
        Ex8+E/DBm64FT0y9e6frW4A=
X-Google-Smtp-Source: ACcGV60gKe98Ezu0emnswWjf4l/GV+uekf16pS4eKtdy6Lw63eduuJsWAa48vwgKlRqKQgmc2wrI4g==
X-Received: by 2002:adf:a1dd:: with SMTP id v29-v6mr4008779wrv.50.1538644345000;
        Thu, 04 Oct 2018 02:12:25 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t14-v6sm3267957wmi.35.2018.10.04.02.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 02:12:24 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:12:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181004091222.GB21864@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com>
 <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> I can run some tests. (@hpa: I thought you asked about the -pipe overhead;
> perhaps I misunderstood).

Well, tests are unlikely to show the overhead of extra lines of this
magnitude, unless done very carefully, yet the added bloat exists and is not even
mentioned by the changelog, it just says:

  Subject: [PATCH v9 02/10] Makefile: Prepare for using macros for inline asm

  Using macros for inline assembly improves both readability and
  compilation decisions that are distorted by big assembly blocks that use
  alternative sections. Compile macros.S and use it to assemble all C
  files. Currently, only x86 will use it.

> I guess you regard to the preprocessing of the assembler. Note that the C 
> preprocessing of macros.S obviously happens only once. That’s the reason
> I assumed it’s not that expensive.

True - so first we build macros.s, and that gets included in every C file build, right?

macros.s is smaller: 275 lines only in the distro test build I tried, which looks
a lot better than my first 4,200 lines guesstimate.

> Anyhow, I remember that we discussed at some point doing something like
> ‘asm(“.include XXX.s”)’ and somebody said it is not good, but I don’t
> remember why and don’t see any reason it is so. Unless I am missing
> something, I think it is possible to take each individual header and
> preprocess the assembly part of into a separate .s file. Then we can put in
> the C part of the header ‘asm(".include XXX.s”)’.
> 
> What do you think?

Hm, this looks quite complex - macros.s is better I think. Also, 275 straight assembly lines is 
a lot better than 4,200.

Another, separate question I wanted to ask: how do we ensure that the kernel stays fixed?
I.e. is there some tooling we can use to actually measure whether there's bad inlining decisions 
done, to detect all these bad patterns that cause bad GCC code generation?

Thanks,

	Ingo
