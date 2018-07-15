Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A29DECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DC32087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyPj61lY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DC32087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeGOWTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 18:19:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36860 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbeGOWTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 18:19:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so30005604wro.3;
        Sun, 15 Jul 2018 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lsQnFH/YzjJxBMeuL9m7OSZBdHT6BGAWWXRLvJdwuuk=;
        b=CyPj61lY69r6+rnh8BMJnYDHpj9Lp9Zc6Hd+6CtZIssKZISx19q9WIUHxzVJcsqz13
         +ejEpX12hqSClUceQh29Gwbp4j92GzuXKdtftZ50PDgZ3zPK2FjYTTbgryw7MhK9HjFi
         ccW825HnQubR4v31Y3OXah/p/8jpgPkLLjWuff6hdzXX4Mmqdl6B3w29zvtkLoXPTcvg
         Mwm2Gpzx4tu0jzrEO7usJgFqJ785tSaXkWxZjpSiBgEnn+Uum1YMRR6Khef2aKgApdO9
         QJKtGevhi6XqvwwSF3EJTSNHTWVowK6N7+R5xepJFzwsO9IFekMUYQmsjCG9GOx0Lpzp
         Unxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lsQnFH/YzjJxBMeuL9m7OSZBdHT6BGAWWXRLvJdwuuk=;
        b=Kj4HkJHspaGFHDwdY55weIN/zcA86QA5AMOFdR5sjiTassz9IZTdMgzrk/XeW9tsNj
         W9yfJJtyipLHU1QYs05MmD3QWlq48jQ3iBTib4GNomjiLwAwG64scP8BwfIM/4ukSLOS
         YP/Nec5UuDL/MHvFlAw5W75gpBaYCaffYiuQTPmi2Dr0IZW837Lpfbek3FBVjhx8lu4G
         YMWaRXKNGsALwq5mbmTgUbByk3HbzbEa/slXJwoNoizB3hArrFDygmZ/OzQwqVG8eC8g
         6kWA3HgbJj3A/CovAI6hMeSr9d3eP+PX+X5XkGhUI9Uku6WeLypNr4iDLtJSluEf+if6
         G1Qw==
X-Gm-Message-State: AOUpUlEayXsxxFrohYCyh/xAsZWTuK7+vrmqXdOA7G3CShc0j4An1IR+
        mSCuI0bFNZWH6NxNaexvfmuo+g==
X-Google-Smtp-Source: AAOMgpez/hoXqLlCUu8QceGjjhWgJSax4DBUcfO3zdkv65wkf5sWJW98C9xT0UlnIKvWsol40w1CXA==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr208223wrd.253.1531691695940;
        Sun, 15 Jul 2018 14:54:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 31-v6sm32610165wra.26.2018.07.15.14.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 14:54:55 -0700 (PDT)
Date:   Sun, 15 Jul 2018 23:54:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [kbuild ack?] Re: [PATCH v6 0/9] x86: macrofying inline asm for
 better compilation
Message-ID: <20180715215452.GA14040@gmail.com>
References: <20180622172212.199633-1-namit@vmware.com>
 <BA4C0931-A51D-41AE-B918-C37EFFF35840@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BA4C0931-A51D-41AE-B918-C37EFFF35840@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> > I ran some limited number of benchmarks, and in general the performance
> > impact is not very notable. You can still see >10 cycles shaved off some
> > syscalls that manipulate page-tables (e.g., mprotect()), in which
> > paravirt caused many functions not to be inlined. In addition this
> > patch-set can prevent issues such as [1], and improves code readability
> > and maintainability.

Ok, that's good enough as a benefit, I suppose.

> > Nadav Amit (9):
> >  Makefile: Prepare for using macros for inline asm

This non-trivial kbuild patch needs an Acked-by from Masahiro.

Thanks,

	Ingo
