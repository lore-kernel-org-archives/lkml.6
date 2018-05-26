Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1566595-1527355874-2-16826730571828762039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527355874; b=MB/e4GGQTEVFdSWLn5g0YZHFgADji6PEL3WE4cp+1JyDWvaSwB
    d8xhEwfbn1Sj9pChLLEznCoI8n9bxzv+MWN2DIno39JgM5sCl0s+ZWzvPsp9gHFe
    U2u3N1j3CjrE+oI4+f0nIWJrkwk+QrMw1ZKUc2zFAT1RndMbnVtR+paWDCwxbxqk
    QgBmnogqWgC2whf8aBDYN9pdLV3f6U7t5Mj6TugsR9xUHit1pNjpW2vN52K1N9kf
    OlmfjOiTjnraL8OIAcbHTQc6XHfv3+itzKJFxSC9WnaoJZzO87GpekitQkPTJoWq
    9HqEMI//chia/pCrDHPCVO2tOrtv/vaDBRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527355874; bh=3vH3j4NUow/BfzzTlnbho+33LAuLFnseGsdE/Zcv3d
    E=; b=LoU61nu86qDyyXGmZzqOWSHZNe6nNhGS1msK8fEN/IuzUcjVn10zjXj97G
    dHJWnMtw4P4JdDJnrF4/nDp0gCgw7HjYaAkYBxgY63Z/QRHpwUoGWudnN7A4i6eE
    /TZqK6rGNN2qsZcCHzYll5JuRpsjMG7TCi6tSUpOFrMcaJMPgVx/1ycfJwhUBurO
    Sc18uc9KagdopaDCGcVekJ14bQ9HMDI9k5MDZU0Jt7cbVpp64vLEVWy+02DD15C1
    tJefcTSJG/lLZHxBqJvzlosxToCVPwQGyrxctt4S9Imr1QBD9si5NGGqCOO1COfT
    BPfuwxUxGXL/z6W6xwoQhORzfEFA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=kF+6+6I1 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qBA4HUpy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=kF+6+6I1 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qBA4HUpy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP7tIN7W4+jtFTBiNfAerfjtPY2xpKQCAtuQAupJ7au3tD8u6qXZrXXhDL6sIxUX97celZcKXl633Jc2dOAHzeLYkE+e5pKKiXUR9yQhMwgwSDkCDbiw
    3lhzwgJ6r6hxCGgNjEOVsnsE9SX6kCKLnLBJPuiyXxxEtoA2QZyrULFDfOSrmqxbB9Nux/bSxQyG3h+UtWu94JJ1ex6w0K2rl0LhN6T7M7sVfxQygHzIcHhS
    dlEcIpGmDD5Elxs8XiZ/Qg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=8r6i9kuyV-oA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8
    a=VwQbUJbxAAAA:8 a=4fXfT1HcpZxzbPMSoUMA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032136AbeEZRbJ (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 13:31:09 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45103 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032007AbeEZRbI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 May 2018 13:31:08 -0400
X-Google-Smtp-Source: AB8JxZoqB5LCqIBBMJFXbIQbPByDlBx8tCUwQKEjKZ5fgWuAuQ7+jgL2lpBYIoVgtq4GhgrawGDs63l3jtfTo7/Lji8=
MIME-Version: 1.0
In-Reply-To: <20180526154819.GA14016@avx2>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com> <20180526154819.GA14016@avx2>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sat, 26 May 2018 19:30:47 +0200
Message-ID: <CAJHCu1LgSUJdiZEfParCH7aLERWM1bgwC7e8wQKgmkNE01_4KA@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-26 17:48 GMT+02:00 Alexey Dobriyan <adobriyan@gmail.com>:
> On Sat, May 26, 2018 at 04:50:46PM +0200, Salvatore Mesoraca wrote:
>> Prevent a task from opening, in "write" mode, any /proc/*/mem
>> file that operates on the task's mm.
>> /proc/*/mem is mainly a debugging means and, as such, it shouldn't
>> be used by the inspected process itself.
>> Current implementation always allow a task to access its own
>> /proc/*/mem file.
>> A process can use it to overwrite read-only memory, making
>> pointless the use of security_file_mprotect() or other ways to
>> enforce RO memory.
>
> You can do it in security_ptrace_access_check()

No, because that hook is skipped when mm == current->mm:
https://elixir.bootlin.com/linux/v4.17-rc6/source/kernel/fork.c#L1111

> or security_file_open()

This is true, but it looks a bit overkill to me, especially since many of
the macros/functions used to handle proc's files won't be in scope
for an external LSM.
Is there any particular reason why you prefer it done via LSM?

Thank you,

Salvatore
