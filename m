Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3496624-1527666909-2-9304602453209508876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527666909; b=a3hoIpw5We6mIXtGRswyL5oAZECJfDgJoqVSt6LmKj2IcsQLrV
    /Qd5WtwR2IFKM6ReMW0hb1s5/vlTHYvRo+1yPOKifENwVU/Fu4JtBxatAFVwAd9J
    3R7lkbIqKLSFqPJr+X7Ij2Rmvve1MUC6d1tCmJVKOhag3r7O7tXFgHXambJL5tF9
    W9LQWM9KAYQhC7TN8sMmHZabqSIGbwdODF7EhJd4sJs23hY2ncXIxHQyQsz+6D98
    aNp7JyTe3zvu91QUjV1tNh8HjDviZAtzjEz+ZuY/hkCSkriI4Y4UYwD9krmCgnEQ
    MBkw2BbJ6rYpoXeji0RbvAAqGvMrF+oF6ZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527666909;
    bh=c9Sj2oOGr2bPbdmLuWkTkq+D6KOaNRZOk8mTb4aKkAs=; b=VARiDHb8MCAE
    1VegP4uw0l48cH6eeR18hhofBWrLbDbn02+wXBiQMhLtPIausMLR1pKDx9jx+reY
    Jbdo9mBodXDJcua4Wj2fDcF8sybEkffXAk2QQaz9XxWS/etaBSuRyPuZwYyUC2A2
    4/yDNdTqkkvm0tiGIouCWvkSc680m7g+OsF3JzAhCt1u5rkjQf5zzkTrxajHzXhH
    VI69GSMYAXUeoHp3hUD3MNn7YocG/RvK/vgoYcimj7LVXQ6RL0g31ncuA7VMX9cX
    BGIz6HD3cI9c6Et7SUKGtoloOjD2XUfXed6PKwv8WfTSSeX1jNIuy6HYUzSr++aa
    Tghoum6yfA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=cogentembedded-com.20150623.gappssmtp.com
    header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=ADmk56Xx
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=BcFNU54m;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=cogentembedded.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=cogentembedded-com.20150623.gappssmtp.com
      header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=ADmk56Xx
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=BcFNU54m;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=cogentembedded.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBis2S2ITSs+MDhoiTq1yfLnnrC1j1xC81U6PkPEnkugdJrkY2L+xN9T7r01g0ihp33RUHz1IbPrQrBKv95E4vNSVasvp31CvZIk7IGzLbLZ/aEfbttV
    UAIzlpkJHHv9DXXnt9mzW0gJxzaSgLPPOkCicadk2hejgu6ojl6HTrq6PreLzhQ/UbW2I4pUaPx//aZ1B8cZCFmNm5GSQBLxU1QVPiZ5EKC0sRo3gU1+Xb1n
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=tBb2bbeoAAAA:8 a=PtDNVHqPAAAA:8 a=_BGUAAqz3DGLcvd3qjYA:9 a=QEXdDO2ut3YA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935389AbeE3HzF (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 03:55:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42026 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935776AbeE3HzE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 May 2018 03:55:04 -0400
X-Google-Smtp-Source: ADUXVKL2XCVtbHAfeJVPQ3IWbjTPj2PLHPB104aoScOAa5dWEFvH+clZaZJAK+vcdibMZNLI7Ygmag==
Subject: Re: [PATCH] signal/sh: Stop gcc warning about an impossible case in
 do_divide_error
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-16-ebiederm@xmission.com>
 <20180420145514.GP3094@brightrain.aerifal.cx>
 <CAMuHMdXxL+k_SitLXV1LJDHJmCY1HiUnZSk7MM64rcgs75nLiw@mail.gmail.com>
 <87h8mqo6at.fsf_-_@xmission.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <8a890c7c-771a-2f10-6dc1-145a9f75e48a@cogentembedded.com>
Date: Wed, 30 May 2018 10:54:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87h8mqo6at.fsf_-_@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 5/29/2018 6:00 PM, Eric W. Biederman wrote:

> Geert Uytterhoeven <geert@linux-m68k.org> reported:
>>    HOSTLD  scripts/mod/modpost
>>    CC      arch/sh/kernel/traps_32.o
>> arch/sh/kernel/traps_32.c: In function 'do_divide_error':
>> arch/sh/kernel/traps_32.c:606:17: error: 'code' may be used uninitialized in this function [-Werror=uninitialized]
>> cc1: all warnings being treated as errors
> 
> It is clear from inspection that do_divide_error is only called with
> TRAP_DIVZERO_ERROR or TRAP_DIVOVF_ERROR, as that is the way
> set_exception_table_vec is called.  So let gcc know the other cases
> should not be considered by returning in all other cases.
> 
> This removes the warning and let's the code continue to build.

    Lets. :-)

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: c65626c0cd4d ("signal/sh: Use force_sig_fault where appropriate")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[...]

MBR, Sergei
