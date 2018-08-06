Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88E8C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E2E21A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1rbZkRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E2E21A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbeHFXow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:44:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33231 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeHFXow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:44:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so6799624pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNbo4Lz512c9S1QxtplyU1YCWC3f9Uhb8794/CbRgaU=;
        b=S1rbZkRPF2zE/ZIlC1wz8qAtDicYkyc88k/7cpWu0buF2znPFBfqaADmdXMzHvYull
         pNF5X6+eeXCv5g7NOsdM1P9Oo4SiiU6FUpzS2H6j3adA6pNzwK92yMX6Nqi1YGvF4txx
         rLrHf6LsgSKK/HG7+CytBkb6UGowjrCOQwFshqSaYw4obp1KRu07/sOhmVCjVpl9NBK7
         ok2uAVuJKyHyM+ho2Sp15BOBcjzMbzD+eOlVKjNWVcu7ClN1wqy9JmYLMH7qMQ2A+vRq
         itxy/EUYJSAtx3L66ozg0QiBe/jnVqPohxU13IaXRIs+dV2cpZYFvYoZyECeD+laF91i
         NK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNbo4Lz512c9S1QxtplyU1YCWC3f9Uhb8794/CbRgaU=;
        b=Vj4ddXJ94uX/3rFxTQI5Kf4NVTFp9EJcdn0ByAuxhcLK7BKTaxuo205kS8jz4ZWeXa
         JUHoyAhHxKMgXjYSWF1NfdBhTGS5w/igXBJdwYRqGPj/EtfX8QI1VlpbqFpvd/bIWaWg
         nDwyZs9PcvC1ayLIRCb4A8LiOm19guwdOTk5Aw6ayfeuHwjsJffhLeNM0oWlgk6TooVN
         g3lUuo5oCnGcYDY7YotfcE1Nb8iDENoobRd+NWRxqaFVWCwqSocJylJYltF9fp/o7gAE
         vOCA1ggtydFbKOByCyRxzEe4L72Cr5xg0H0eT0KvUqdZMscFOFyXTg+Vqpyypz15V68z
         BTsQ==
X-Gm-Message-State: AOUpUlHBAuzLdyywPPwuKeqgbPmKmvKj7hF2QGiUieoiYTBiRfBZEalN
        /jTY+aInbisLbpFvhmZMees9BHJiJr2vzEvQQztPvERH8WyilQ==
X-Google-Smtp-Source: AAOMgpeiYxLgdXxkkA0Zed8O0b0eOvd0vNjjxoJbCRUSrOvaeSLEOlt9hMLO4isNXBupASLiWx2wE4EuJH9yKIES7Cw=
X-Received: by 2002:a62:8186:: with SMTP id t128-v6mr10306351pfd.192.1533591231991;
 Mon, 06 Aug 2018 14:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180803170550.164688-1-ndesaulniers@google.com> <tip-208cbb32558907f68b3b2a081ca2337ac3744794@git.kernel.org>
In-Reply-To: <tip-208cbb32558907f68b3b2a081ca2337ac3744794@git.kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Aug 2018 14:33:41 -0700
Message-ID: <CAKwvOdmxaE7p-fgaaeCE17bbTf0iYmHQgWT2D6FM7U5fwUoN1Q@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/irqflags: Provide a declaration for native_save_fl
To:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        david.laight@aculab.com, LKML <linux-kernel@vger.kernel.org>,
        jdelvare@suse.de, Ingo Molnar <mingo@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org, sedat.dilek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 1:33 PM tip-bot for Nick Desaulniers
<tipbot@zytor.com> wrote:
>
> Commit-ID:  208cbb32558907f68b3b2a081ca2337ac3744794
> Gitweb:     https://git.kernel.org/tip/208cbb32558907f68b3b2a081ca2337ac3744794
> Author:     Nick Desaulniers <ndesaulniers@google.com>
> AuthorDate: Fri, 3 Aug 2018 10:05:50 -0700
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Sun, 5 Aug 2018 22:30:37 +0200
>
> x86/irqflags: Provide a declaration for native_save_fl
>
> It was reported that the commit d0a8d9378d16 is causing users of gcc < 4.9
> to observe -Werror=missing-prototypes errors.
>
> Indeed, it seems that:
> extern inline unsigned long native_save_fl(void) { return 0; }
>
> compiled with -Werror=missing-prototypes produces this warning in gcc <
> 4.9, but not gcc >= 4.9.
>
> Fixes: d0a8d9378d16 ("x86/paravirt: Make native_save_fl() extern inline").
> Reported-by: David Laight <david.laight@aculab.com>
> Reported-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: hpa@zytor.com
> Cc: jgross@suse.com
> Cc: kstewart@linuxfoundation.org
> Cc: gregkh@linuxfoundation.org
> Cc: boris.ostrovsky@oracle.com
> Cc: astrachan@google.com
> Cc: mka@chromium.org
> Cc: arnd@arndb.de
> Cc: tstellar@redhat.com
> Cc: sedat.dilek@gmail.com
> Cc: David.Laight@aculab.com
> Cc: stable@vger.kernel.org

Not sure if this was going to be cleaned up in an automated way, but
looks like this commit message drops the comment to stable as to how
far back it should go:

# 4.17, 4.14, 4.9, 4.4

also, there were tested by's reported:

Tested-by: David Laight <david.laight@acuab.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

--
Thanks,
~Nick Desaulniers
