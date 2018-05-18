Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-222706-1526672476-2-10408352718041847453
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526672476; b=QgjIHZPQWvumvIHlqCBrBXRPpfbKIkabOypX3n4HNJgRRXB90R
    ZurVITQYbw9ec//7NtHsd3P2Q4jtEGqMTWjLFXCAaRZ7jD234fTuHGkv5N4P+HDE
    5IgUMBzRM4I1XDBnZKyONq4Fad7/m0S8uLS0tIIPMcaL/G8SB+T9MMhVuzvvq3mF
    U9uFjASfp7PGIzYjIwZk2L9CcwlLjzPRGr0fcr6luCK6uZ9SAYH7wrB74MydQPZI
    49M03nRasWgi+5ySoC8djGl2Yy5kypvjNw028s5xKxzkPRfKDcupqr4w1xpEF2Sz
    utUTAl3K3WW65jFmLcgD9wKga6+T0nAvwS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526672476; bh=KnWArrUyXd4XBId5uAb83LozRzPwgRTPrV9pFkrM8o
    M=; b=a9RDQ7nZAeqDPIgC/96CgS21eA2DGpqgJ2bxpJhfJ7mhRoqXM1++KoijZg
    KEhgC4O52jVSqQDe6MCfV3CJyrQkAyikXFHvdYkHHDbq/pP8A2a/Zm87MoDhLZwO
    AEnFdlVBjnNAKWrwDqbWM9D7Dxu9JpzSeqfYH92nZCAHLqTtPENCnGJcR94KBfOP
    cZrpaT8yPbQ79l3E84dne5YhsXiEATzNt4Ar1e6EsKmssa084Ie/8utjgM2huWM6
    ssMD9Y7PjSJi/3fhN/og4IZyEf/OsBztgnt22bfx4YkOrhu0H5RX/kWufQaacoAT
    YwhpzVpruO7nOUFB3MkBXSWCKtZw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=amacapital-net.20150623.gappssmtp.com
    header.i=@amacapital-net.20150623.gappssmtp.com header.b=i7541pM3
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=saytkpGf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amacapital.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=amacapital-net.20150623.gappssmtp.com
      header.i=@amacapital-net.20150623.gappssmtp.com header.b=i7541pM3
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=saytkpGf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amacapital.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM9x/hCdR9zg/uPSZZAdrHFktqEzX+stL4ZNqhRPMPyWIhFLCccs5Z8nbUV+dL0KAANzy+B1F3nlUKrKJmJwM3dHh8Dp3yriMys0aRTLG7IuKmTrZJx8
    YpCmF2vd29HdAm5DRkYlWg9m06QsXAKkwdY/jO7QZxMGTpXrcQNpVdSmlEwbUZKr/2q8UA/wIgdnZgdx/i4FBjv4QNDKRwoSJcC82noWrWnc+Kn67O131/fx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=qZz5626rkYImA__wivsA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbeERTlO (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 15:41:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40117 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERTlN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 15:41:13 -0400
X-Google-Smtp-Source: AB8JxZq+a+GgxxcuhTKkzcyMEJZS+LJP0RcXoTGSDAmjsawNdN21vj4HYdgu+b+EEt8sgtOB7MOfHikzQeoQxOsKhjk=
MIME-Version: 1.0
References: <20180518091721.7604-1-jslaby@suse.cz> <20180518091721.7604-18-jslaby@suse.cz>
In-Reply-To: <20180518091721.7604-18-jslaby@suse.cz>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 18 May 2018 12:41:00 -0700
Message-ID: <CALCETrXwc05073E7A8KG-2dKqNyz=C2zrAQfBqWhjuChfSd5fQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/28] x86/asm: use SYM_INNER_LABEL instead of GLOBAL
To: Jiri Slaby <jslaby@suse.cz>
Cc: Ingo Molnar <mingo@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 2:17 AM Jiri Slaby <jslaby@suse.cz> wrote:

> GLOBAL had several meanings and is going away. In this patch, convert
> all the inner function labels marked with GLOBAL to use SYM_INNER_LABEL
> instead.

> Note that retint_user needs not be global, perhaps since commit
> 2ec67971facc ("x86/entry/64/compat: Remove most of the fast system call
> machinery"), where entry_64_compat's caller was removed. So mark the
> label as LOCAL.


> -GLOBAL(entry_SYSCALL_64_after_hwframe)
> +SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)

I've missed all the context here.   I agree that GLOBAL is misleading, and
"inner label" is nice.  But this is a rather wordy macro.  Would:

INNER_LABEL_GLOBAL(name)

be better?  (With just INNER_LABEL(name) for the local version?)
