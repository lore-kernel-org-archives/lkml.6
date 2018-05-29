Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2698890-1527628600-2-6281129027794475497
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527628599; b=D996bEpyaF7sMADS+m0TwhR6xDzi3ckXeo9d59g2HfGZ/PEgMu
    sDva45sMXXWOuEXpJdMCYUqm+VJ6ns4s2zUM4CesN4LqmG519Ni9pJenL71tZRUR
    IUljpwM9xeVCQoM50YeU2l9OG3gjleh6eApZxlyi34ylSW05p3ZeEeQDYDTY/1JX
    +KXkLWT6Xd29SJsMgDyaI0ZrHXM6AhUc6NpDhqJbCxLnHrn5G86givHRoS/7DKqc
    RJ31R8E4H1nwitHi4eIlEF6grRYIofOYeVM46oz/CcpY0TCGT/KwtRCh8jyhyAe0
    5I1437NRlBer9UHNyZf+OA/c26NMFMcd+KIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527628599; bh=e70SJevAUkLPMYiSHBqd+184NigYHVlFIH2iIth8n9
    I=; b=ki797kg0TWY0/CAMVv7Qc6tMA1owtd8H5nA++7kvTQ4UR9GfMSaHHXf0cE
    xOUFV2eIZLlLAPgznx17837w8LY26bjV8J7um6v+6sB0OyIS74NJzSVpe6q6kofs
    xq6WE4Uygd+rETnskOcldDO7+hqh0NXCnGWoLtKNhi3MVYQzksGZ03UCAJpqX3Mm
    /m0qj46HIpIo1zzRoP3Kn3w3bZPaVlNlQGkHk12JU3527jNNSYZWd9YGWTSrQsHh
    n/+PTVcC/T+9FBWp4YPSTKIX3BUc42SJK69FpvZjzgrjfo/ERwNwwsT2uvYLS1iH
    H2dK6QTX/Ljo3vhVn8Qta9afgs9g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org
    header.i=@linux-foundation.org header.b=HDfwbNuY header.a=rsa-sha256
    header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=crZMj8No;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org
      header.i=@linux-foundation.org header.b=HDfwbNuY header.a=rsa-sha256
      header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=crZMj8No;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIgfGv4/9pMUnkSThLI+K/gneuFDsexRG4XzizkfOyszjjWMP6wG/Zi0Z2rCLx5d0ZGygq4hCFA70p470vSey4ZC/qjOq5x/ClaWI3kYuAWzCjtZm8Nb
    ZYFANTzJvL00otjYIrlNgc7P0bxWvpzJH4x27kywRaLJflcqsY58dl53yxeCLLa7ZX5TYqA02u4kv9rX4Jq1A9Ze/dGfVdT5DspKRoqIv4JoBt0zHLJ/L5H4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QwXkXS6CuYGAfkA2HJMA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966900AbeE2VQh (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 17:16:37 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:46795 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966847AbeE2VQg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2018 17:16:36 -0400
X-Google-Smtp-Source: ADUXVKJ8RrR6vDSQkPLyayqLp/LBk4IAuSrGiTcG5W940Dz1mmFbaF+7Y5TYWipExjATLUQYDDshbFeo8tPUC3UXlnI=
MIME-Version: 1.0
References: <20180529190332.GO3803@linux.vnet.ibm.com> <Pine.LNX.4.44L0.1805291521570.1458-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1805291521570.1458-100000@iolanthe.rowland.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 May 2018 16:10:02 -0500
Message-ID: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 3:49 PM Alan Stern <stern@rowland.harvard.edu>
wrote:

> Putting this into herd would be extremely difficult, if not impossible,
> because it involves analyzing code that was not executed.

Does it?

Can't we simplify the whole sequence as basically

     A
     if (!B)
         D

for that "not B" case, and just think about that. IOW, let's ignore the
whole "not executed" code.

If B depends on A like you state, then that already implies that the write
in D cannot come before the read of A.

You fundamentally cannot do a conditional write before the read that the
write condition depends on. So *any* write after a conditional is dependent
on the read.

So the existence of C - whether it has a barrier or not - is entirely
immaterial at run-time.

Now, the *compiler* can use the whole existence of that memory barrier in C
to determine whether it can re-order the write to D or not, of course, but
that's a separate issue, and then the whole "code that isn't executed" is
not the issue any more. The compiler obviously sees all code, whether
executing or not.

Or am I being stupid and missing something entirely? That's possible.

               Linus
