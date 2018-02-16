Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1149420-1518819288-2-79640454055526332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518819287; b=ubacXRDCxobcR1uLqW2KF7BBo3R4oouDIbq1SfTmK0qtbwe
    h+Bigj1/lN66q8nBEwLbxoZII/OfQ5MWe8UXm++oDVgreUG5jsYmKLvx/Cxx1S+n
    OWyOjKbn7KXlSytm+SYBWIIe5cg3Bfiktwm2zLos2zO13KG+oCkT4CIfKPikKy8j
    Je6EWDzZ8WpM8YtfuyViKskb4O2BfGZ9LMFheP8L69/1cs+4cHoxDFH2ilqlHDJA
    MmGce9W3Ns42vyBvcCnYjDlVAn0e9lXenxqSwcVFDt+xyOxUfTQxHdG496yhmLOJ
    ZAjBeOn+WCa1RlCussHgTKrEOui5/Eoz/X32B3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518819287; bh=L61ZDg728KZAzr3/BY9aFxj9EaTECzZpzbYFfQ
    BGQzo=; b=MmO7qN8xrByMH0M8TNLRIl/1tAFy6Sjy+DxRd4Q+xvVgvidE2JIEv8
    hcKdSpKfPnKudHfS1A8dbNDuJI43VGjoSzlIKmse0XtN9eTJ9lLl6Qbb6pvkS99B
    PXKBrryTPaK1+NXpzJ29IMQRcGKQ4OXJLoTx8LmyTXly2XXEhWmKBcbvdk7nRq1H
    JDl55GYZHfjg4PwYpxWgKCY+y06kqxhz9xPbGOg87mz2oJjmJW91OfIn4Z/ixYIU
    G0lqwMZumxU9KELEdkVUGgXs+sP7JHtfz8X+5JKnEy+/8s+D/JWF6a0WPpT6pZ12
    mstBer34FTAzcha++6NaubI65p2C/+Sg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ksf3fP8a x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aPR1NoVf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ksf3fP8a x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aPR1NoVf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750743AbeBPWOo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 17:14:44 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33951 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeBPWOn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 17:14:43 -0500
X-Google-Smtp-Source: AH8x224tS/Wrv/a1RU4E36gFGH3N4+KHFD9yXtVF/hgHzQIPzaW3eLloRiRqVp+mPkoJyW+qIohzLH2CElBZZB2hWeI=
MIME-Version: 1.0
In-Reply-To: <20180216170346.497114b3@gandalf.local.home>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-2-arnd@arndb.de>
 <20180216170346.497114b3@gandalf.local.home>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 16 Feb 2018 23:14:42 +0100
X-Google-Sender-Auth: JV-eV7hLrZPyu7HbmBY_BGUMtXA
Message-ID: <CAK8P3a1ZvA3dk8qRXaF_yjirYTYkvuCggh8x7QU_p+vMxpTPNA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Kconfig: disable PROFILE_ALL_BRANCHES for compile testing
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E . MORIN" <yann.morin.1998@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <mmarek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:03 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 16 Feb 2018 22:41:11 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> This can easily double the time for compiling a driver but does not
>> provide any benefit for the compile tester, so it's better left disabled.
>>
>> In addition, any 'inline' function that is not also 'static' and that
>> contains an 'if' causes a warning like
>>
>> include/linux/string.h:212:2: note: in expansion of macro 'if'
>>   if (strscpy(p, q, p_size < q_size ? p_size : q_size) < 0)
>>   ^~
>> include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
>>
>> without this patch, and I could not come up with a nice fix for that.
>> In combination with my patch to always enable 'CONFIG_COMPILE_TEST'
>> during 'randconfig' builds, we can at least hide these warnings for
>> most users.
>
> This looks like it fixes the same issue that was already fixed and is
> in Linus's tree.
>
>  http://lkml.kernel.org/r/9199446b-a141-c0c3-9678-a3f9107f2750@infradead.org
>
> See commit 68e76e034b6b1 ("tracing: Prevent PROFILE_ALL_BRANCHES when
> FORTIFY_SOURCE=y")

Ah, right. I missed that when I wrote the new changelog text for this old
patch of mine. It also means I should rebase the patch so it applies
on mainline, as I still want PROFILE_ALL_BRANCHES to be disabled
in COMPILE_TEST kernels for the build speed aspect.

Greg, could you add the 68e76e034b6b1 commit to 4.14-stable and
4.15-stable in the meantime?

        Arnd
