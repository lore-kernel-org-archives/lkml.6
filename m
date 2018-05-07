Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1216624-1525709063-2-2491753288272056258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525709063; b=ZDaIPGLN+Z2pwgUVb86pU30j0wdBZ2HYRyLm9OEE+Gqao2UyH3
    IQsst4vZoYYitXmYbelonW9UZj8ew2soAYSGsRZtwGyoNOSjJTmv6QZpgochfdhM
    8CZRNTDJmTenlbnpWV37nIx0hm0Uh+6KoVQSAbg64Zyi9oWrMzKEskgWD8QNpSuP
    NBfb82aDJhA63Q+atV6tp7RPCfHmB8Pnv31v6xZd0DJXKXd203L0YLaEaju9XPLx
    dKKGMSjGAphMV/+mpGPxsL2oYZF7lQfgxPBC/J0CMW/EDfUteBDrlbbhzHj9ygbh
    dblZTupev7aV13M0Dv+2ri3rirUushcJjReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525709063; bh=V8430Yf2cE0D7Zj6Fe/G9AoxLIg45KH53g7C0uu2Rg
    Q=; b=UQEvgocb3trxKme7M2NyVVnp+EV8PL4qdLC1cynux/nGTJUv1ULoM34AtJ
    OHa8qxVVleIehB0SIevP2/281LZT0rJJf5qA+z6j4mGj1wkm9qCh2lQzniJDwdYQ
    /kner3ANLue9Q1BrbFXNoA/qIi932i1csStmsh3MqRucHsCIiIv/WVfaARc38Yw6
    NpclQj03J5yH0sOm539w9SF9ad6feDTHNUKxEwVNEBSQXe2SLYDT+wfGcJqTrRxt
    spM/NEXs7HAZ9VGi6SHSHYPzb8q7iZNwZe827KhyYb8nSB3HjJygasF6mGxfcpZU
    8xlZxWb0+NL4uUo/x/dBfYn34PYQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=DK/+EfP3 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=jzT7uRJV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=DK/+EfP3 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=jzT7uRJV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOS91IUuoGUjznPQCb4bhuuDJDIWVKYwt3X3cYR/WZ8IHEGZXCcSCIEUx44i/62ylzDtnKJVuLJR8e4HIZjlKbO8ulh2bvnBtfr7+XwCOyriaraOnaan
    e7vI2Yrrh6ZUIgYy3dcqSsI/WmgRT3DS+Y7jdJCa4OvX4zbku1DS49PLN5/ul3dT37k4J6s+AVYKMW2XsLxv2j5zIpHRB3dW4LLfzMLu67otYUbBVu/IAXoe
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=wi13LW8sokUA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=rWkr9Ua9AAAA:8
    a=tOO0nKmCAAAA:8 a=pGLkceISAAAA:8 a=myMo6P5KhVgz8Xuta9YA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Qv-QrLrHZjTXZfLJ-zom:22 a=Gz67Kf0DkuxJ4rqyVRET:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeEGQEV (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 12:04:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35255 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbeEGQEU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 12:04:20 -0400
X-Google-Smtp-Source: AB8JxZqYi/UBrns3oLnHL98rCdO80uG/BwApkfHRtVERig15PeayzyYpa3wnvswv8p9B6sgIjIwQwubRgzHCFYRFU8w=
MIME-Version: 1.0
In-Reply-To: <20180507084240.GA26491@jamesdev>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
 <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
 <CAEdQ38HfabRWgfLTStuZDOz0yjnfMNRc5beRdVcQhFfMi1SFKg@mail.gmail.com> <20180507084240.GA26491@jamesdev>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 7 May 2018 09:03:58 -0700
Message-ID: <CAEdQ38FDSqRbikxZZ4uVmyT0JkV1uGOdtiEjwJafbDb9m4vDtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
To: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 7, 2018 at 1:42 AM, James Hogan <jhogan@kernel.org> wrote:
> On Sun, May 06, 2018 at 12:33:21PM -0700, Matt Turner wrote:
>> On Tue, Apr 17, 2018 at 3:11 AM, James Hogan <jhogan@kernel.org> wrote:
>> > Use CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING
>> > instead of undefining the inline macros in the alpha specific
>> > asm/compiler.h. This is to allow asm/compiler.h to become a general
>> > header that can be used for overriding linux/compiler*.h.
>> >
>> > A build of alpha's defconfig on GCC 7.3 before and after this series
>> > (i.e. this commit and "compiler.h: Allow arch-specific overrides" which
>> > includes asm/compiler.h from linux/compiler_types.h) results in the
>> > following size differences, which appear harmless to me:
>> >
>> > $ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
>> > add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
>> > Function                                     old     new   delta
>> > cap_bprm_set_creds                          1496    1664    +168
>> > cap_issubset                                   -      68     +68
>> > flex_array_put                               328     344     +16
>> > cap_capset                                   488     500     +12
>> > nonroot_raised_pE.constprop                  348       -    -348
>> > Total: Before=5823709, After=5823625, chg -0.00%
>> >
>> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> > Signed-off-by: James Hogan <jhogan@kernel.org>
>> > Cc: Richard Henderson <rth@twiddle.net>
>> > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>> > Cc: Matt Turner <mattst88@gmail.com>
>> > Cc: linux-alpha@vger.kernel.org
>>
>> Looks fine to me.
>>
>> Acked-by: Matt Turner <mattst88@gmail.com>
>
> Thanks
>
>>
>> Should I take it through the alpha tree?
>
> I'll take all 3 through the MIPS tree if thats okay with you, as its a
> prerequisite to allowing MIPS to override stuff in linux/compiler-gcc.h
> using asm/compiler.h, which is needed to fix build breakage in 4.17.

Thanks. That works for me.
