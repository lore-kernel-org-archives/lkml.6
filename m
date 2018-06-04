Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1873391-1528136584-2-8074570890100540474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528136583; b=IS2TS0/5swk/mXBTfZAN/ICrczddcPHMBvEYZInQn/r6/SPuI7
    x4w1u/6245IyDeP1W2KfBCcCTqjdLsWDj5z1ieCF3AW3WAzAK5wnq+n+12ZbZHWt
    AzjnF3Fv314HCmh3FNNv+2iX0Q4c48xMl2PdpTU1wmRwHlnItq8/+qpFNE+DTrq7
    cOqM1jnfGgFLjYsNYuhuLwuvgtOG0hw2C07R72Tj90E1DJ/4RtssOfedCu+GhmDG
    Zf71be1w4dc8w+enur0txr1Vnbe2DrbRhrnDv49E3SD4jRWMeXFehjAbc112yE1z
    YewEFXreTnu1JlgedzgXOxlmNC32nP7mgY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1528136583; bh=x+7btZWPS+Z
    lhhb7R1/oTwrTUXmKmIHxHQ6ZBhS1iLM=; b=C4dDhtzJj8RT6WMSybpZBI0sQnn
    4l2cnYYK4PN3wMFd84154k0L+c6g7pm+qjqvQdAxJbWLOTUJB14QNLT0XgMbpxqV
    sRqhGIGrh8PMG/Fi944uviq0npYYZEZmRgtZx4LnPqq3/KXSPfMatQJ/h+982mKd
    r6uUbVPGpSvcd/Od72brxP1kD5LDvMXIO6mV5Pqblhr0YeKb9xUd1RJkLYYjc5gd
    w2j4PMtDcM6nNq9VLHiaSz+xQ76sNqSDkwXCdwo66qULOMVFeOUc2BDTh1qYUu/C
    HNDct09gtts7727EatbEGTtmqb5W/b69IgAna0YBa1Bj5j9tXBRLlRN+YEw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCSR9r0lXy5shoeKMQGb5jJ6c2ocFZuZFzm2AUY2lQBexVt6/MolZZ6ue25gIH9ZaMJvFcGfLbHWsgEcq2LOtxvcQXd093v/sfSLu999ReIOaiCiLoPD
    VwK4S8qeI78kFDVlxDWhLfy9oAYBUn7BZSXZ/sN/1TCCs2AnIFm7BUk1RjO33DNnJVBvR75b/GHPba81lsBnvSD7X4ezAKVAy6bbgY6Yf0i95jl3aI/2+1yo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=Xl__L6BWcknylrun5T8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbeFDSXC (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 14:23:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751015AbeFDSXB (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 14:23:01 -0400
Date: Mon, 4 Jun 2018 14:22:59 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jun 4 (md/dm-writecache.c)
Message-ID: <20180604182259.GA5440@redhat.com>
References: <20180604215911.75399f6e@canb.auug.org.au>
 <0e3fa62d-727e-ccb8-53ae-a6aaa6c506e2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e3fa62d-727e-ccb8-53ae-a6aaa6c506e2@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jun 04 2018 at 12:06pm -0400,
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 06/04/2018 04:59 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20180601:
> > 
> 
> on x86_64:
> 
> In file included from ../drivers/md/dm-writecache.c:8:0:
> ../drivers/md/dm-writecache.c: In function ‘writecache_status’:
> ../include/linux/compiler.h:61:17: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘int’ [-Wformat=]
>    static struct ftrace_branch_data   \
>                  ^
> ../include/linux/device-mapper.h:550:46: note: in definition of macro ‘DMEMIT’
>       0 : scnprintf(result + sz, maxlen - sz, x))
>                                               ^
> ../include/linux/compiler.h:48:24: note: in expansion of macro ‘__branch_check__’
>  #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
>                         ^
> ../drivers/md/dm-writecache.c:414:35: note: in expansion of macro ‘unlikely’
>  #define writecache_has_error(wc) (unlikely(READ_ONCE((wc)->error)))
>                                    ^
> ../include/linux/compiler.h:56:23: note: in expansion of macro ‘__trace_if’
>  #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>                        ^
> ../include/linux/compiler.h:251:2: note: in expansion of macro ‘if’
>   if (check)       \
>   ^
> ../include/linux/compiler.h:258:22: note: in expansion of macro ‘__READ_ONCE’
>  #define READ_ONCE(x) __READ_ONCE(x, 1)
>                       ^
> ../drivers/md/dm-writecache.c:414:44: note: in expansion of macro ‘READ_ONCE’
>  #define writecache_has_error(wc) (unlikely(READ_ONCE((wc)->error)))
>                                             ^
> ../drivers/md/dm-writecache.c:2196:32: note: in expansion of macro ‘writecache_has_error’
>    DMEMIT("%ld %llu %llu %llu", writecache_has_error(wc),
>                                 ^
> 
> s/%ld/%d/

AFAICT, this is the correct fix:
https://patchwork.kernel.org/patch/10438865/

Not seen any response to it (Steven and Ingo were emailed, Arnd and LKML
were cc'd).

Mike
