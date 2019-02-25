Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46776C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144732087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oY+4Jn3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfBYRHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:07:47 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39547 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfBYRHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:07:45 -0500
Received: by mail-vk1-f196.google.com with SMTP id i68so2277752vke.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pKwOVj8Yab9TCZOoi7Y9nvn2bdj+O7Z13S2tQI59uQ=;
        b=oY+4Jn3uuwKiH9Aew063D3JeT7eBF0/AOgiAlLYmzl3rnFfv0QLr8RdEowT+UnTYJW
         inHqDrc+DcbTSLCRceQjO2O+SiKYADLAAdH4KdKfQtEr6XqwFLRUNMCYWhJ4M0Dfg3KS
         mK8Yk+8p3c6jXCg+8PMT30TTn/0OrOo3D8p5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pKwOVj8Yab9TCZOoi7Y9nvn2bdj+O7Z13S2tQI59uQ=;
        b=tChNTLPXz1Tvkc+WQEfuPHPeyX0XuVhxC6JCxid+/JUOg2XTxJXn7//Is3tSFyPhdf
         Fno9pKChNa+OzHwur0VThsUYDsmiKG6L5lOjrI27QvlMPq7potMas/G/Sk/FzxspJ74M
         3wVWhAI7jxxU2VtlccPECYW0UcCJlhfND7SC8LIKZ2gHUkz2kJwOklI+2rf0t37Ce9SE
         ahUT3RE1gAoUFrHll/Qil33InxSpLkc0TlKXwO4z2JaWMiD5eqw/94zXJRu3JE3X+0M2
         Wdd8x6hZMdbjncW2u3r9Usih8nNxv+EkbvOpvuNF3p3EScPnMJcTW7GpxBMbLMQBRHRx
         8GWg==
X-Gm-Message-State: AHQUAuZJF2iykLcwEsEnioPNRiXZEv/VC5HBQVLcCPT34spAW8cM0wOo
        ZNQzEp+mPWyM/tfoHTRZROpSeOCTwZc=
X-Google-Smtp-Source: AHgI3IZ2Md+mE7TO9qJvwaUBBSV0cNRS30eMzT5lnUrUuu9Cdx+k4DNtAMbQJXtfp4DQSG9aer0HDg==
X-Received: by 2002:a1f:a14f:: with SMTP id k76mr9486997vke.15.1551114464351;
        Mon, 25 Feb 2019 09:07:44 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id f71sm2342133vke.41.2019.02.25.09.07.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:07:43 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id v26so9066813uap.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:07:41 -0800 (PST)
X-Received: by 2002:a67:6f44:: with SMTP id k65mr9357427vsc.222.1551114461014;
 Mon, 25 Feb 2019 09:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
 <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
 <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
 <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190223124746.d021973004c7c892c3b3fde1@kernel.org> <20190223194421.725a03fd@oasis.local.home>
 <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
 <CAGXu5j+4g0YRkbZ7mq-3Zgc7aWCU-hx6+G_onW+DdK+mYcqPDA@mail.gmail.com> <CALCETrXrjxkL1pYu-SDnfNL+99N4h+yuLEzab5ytwczWNgFyRg@mail.gmail.com>
In-Reply-To: <CALCETrXrjxkL1pYu-SDnfNL+99N4h+yuLEzab5ytwczWNgFyRg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Feb 2019 09:07:28 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+uo8sFgEd9ORdoPdae_aBxnrFE6bAN_etsiCaFGMvurQ@mail.gmail.com>
Message-ID: <CAGXu5j+uo8sFgEd9ORdoPdae_aBxnrFE6bAN_etsiCaFGMvurQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 8:58 AM Andy Lutomirski <luto@kernel.org> wrote:
> I sure hope that pagefault_disable() already takes care of this.
> Otherwise we have major problems already.

Okay, cool. I missed that bit. :)

-- 
Kees Cook
