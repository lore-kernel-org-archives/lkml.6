Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452D0C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9438269AC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mBIszP4d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MleXalUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9438269AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755215AbeF0A0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:26:05 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:39671 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeF0A0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:26:03 -0400
Received: by mail-yb0-f176.google.com with SMTP id k127-v6so96495ybk.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y6lxYohc24doOq4uCkFytsJeC9N6NKtK8Luo156ZlQ0=;
        b=mBIszP4dfvNY8YK8SUJrC92fNtdAH1+Sr0PK0/JQnDQI/iXx3XFomQXpVJwN9eweDw
         dBA+xboRASJR14dCZ//moefaROLjE5/J3jJwAFp/r3fvzeBICPKPIkpXGyVgYjLLzYbA
         0N/LtkE/ghMUm21gcWbi/TH87YZ/YDrGxweBb3mHE0QxkyvemwQY6uBSbGKUC7/TTN6D
         RQDLi0s5Pp4/hgJmc5dG19xo8DMo7d7SlcOtMjV/jsfEFaZZyvYSYKK3qsrxqzcVlfXT
         r830EH0UceMsckbRfPjyxiAANG/nlGDfBVphrWb+1EoY/z5dk2NxJ0hLsbXxGo3Z6H6n
         y6sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y6lxYohc24doOq4uCkFytsJeC9N6NKtK8Luo156ZlQ0=;
        b=MleXalUtu5Hc7JohQMDaxkCe9QEdM08MMEkrSkZz8SU1PDGWmZHG2/kflaz3omYFEF
         HD467HX+Q+Ih2HkcmfWuPV/dMQHLqQKlvIWstrPxww6vvMgZHJNmohEc5v9WQSb4pJXq
         6t/OC7Sb/eyk/5hKp8MI64HKXe0b6bjchIGcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=y6lxYohc24doOq4uCkFytsJeC9N6NKtK8Luo156ZlQ0=;
        b=UoaVBgwN7QkgayW0OwQqqAjkLr+M3H7IxnCIDddjA1eh2kmZeKFH7+knyBZS+6TZ8z
         LLTlX+Hn+JhldaLi/70MfxxmtrDJ3QVKI9DghBeVjxz9uOB2BFiW9j2NNpVaI4kE9HLL
         WBw2sgidghRFVRaAgr2EapOohEBC3H+nVgUnV+8UhOcL65LOYvhQdyMAOnazNOMrLa2a
         5FbUzyRQE1NqMjGhBVfdFm3Z9Yy2jgDQIqn9FhWl5ewDydJtGki6JQ66gJN2Mfuy+whT
         Em+NRjgrcRPJJxywifIjPIhwgH0GmYfyzZ4lxluFL3J3rcQkO1QHYlL8j7M6er/A67uF
         nveg==
X-Gm-Message-State: APt69E3fAuCbZdbv9zdd192721M/zUy/A4SxkrbRR5jElG5/PG0Ot6n7
        EKQnHN9pcyPYPu56GFojuPQSRuPbf34lozlW3mMIcg==
X-Google-Smtp-Source: ADUXVKIeEKwpqKr+aMskncBU4MEmIBs8L7RYmgof2Nc5d0sCXvijh87e9O1Qk2NUvbujkxh5CX41iRfnA9NVvNoAPd4=
X-Received: by 2002:a25:be4e:: with SMTP id d14-v6mr1918092ybm.309.1530059162260;
 Tue, 26 Jun 2018 17:26:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 17:26:01
 -0700 (PDT)
In-Reply-To: <b4841a84-cf65-f3fb-13b3-ea0a15f47bde@iogearbox.net>
References: <000000000000d48c8e056f5b6c67@google.com> <alpine.DEB.2.21.1806240849150.8650@nanos.tec.linutronix.de>
 <20180624.161411.1560796210597132716.davem@davemloft.net> <20180624100249.GA9493@gmail.com>
 <b4841a84-cf65-f3fb-13b3-ea0a15f47bde@iogearbox.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 26 Jun 2018 17:26:01 -0700
X-Google-Sender-Auth: NCQUYs85eWcEg5IrG5CBinj2OYA
Message-ID: <CAGXu5jKndtFL7D7T00GmziYaazs7v0t4DWPp_2fdGh2tRnuuEQ@mail.gmail.com>
Subject: Re: set_memory_* (was: Re: BUG: unable to handle kernel paging
 request in bpf_int_jit_compile)
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Ingo Molnar <mingo@kernel.org>, David Miller <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot+a4eb8c7766952a1ca872@syzkaller.appspotmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, X86 ML <x86@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Rik van Riel <riel@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 3:53 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> In any case, for pairs like set_memory_ro() + set_memory_rw() that are also used
> outside of bpf e.g. STRICT_MODULE_RWX and friends which are mostly default these
> days for some archs, is the choice to not check errors from there by design or from
> historical context that it originated from 'debugging code' in that sense (DEBUG_RODATA /
> DEBUG_SET_MODULE_RONX) earlier? Also if no-one checks for errors (and if that would
> infact be the recommendation it is agreed upon) should the API be changed to void,
> or generally should actual error checking occur on these + potential rollback; but
> then question is what about restoring part from prior set_memory_ro() via set_memory_rw()?
> Kees/others, do you happen to have some more context on recommended use around this
> by any chance? (Would probably also help if we add some doc around assumptions into
> include/linux/set_memory.h for future users.)

If set_memory_* can fail, I think it needs to be __must_check, and all
the callers need to deal with it gracefully. Those markings aren't
"advisory": they're expected to actually do what they say.

-Kees

-- 
Kees Cook
Pixel Security
