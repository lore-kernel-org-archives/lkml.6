Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-990390-1524211124-2-7463725217158493165
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524211124; b=jUnKAtdQMulZ5w7hAihkD8K+o/jXmNye4wyJL72LkFyziZA+9f
    5gucSvkOdBH6z0rpy3WTuVLOrkMP7V8dvmDKkmr09k5Bmq57z0uShCTKUZDxuyKC
    k/4QUa+xy5+byGj9g7qu1+Q5ormDaiSGoVNF6KknEhkQWKgbuHMhVqzgMsmBi7cT
    5yDquJwMY1Zan0TlW2sziITCIQMA5D+e9js+IsbToWrArCvcFxbfsdvPXxmijFXO
    Q8dvT9Nfj9dQAcmn4VdkH7oxHAzOw3CwatkjMEJOZ8x5ZGEV6ZirkwhSPHWHMpDC
    T19VrSCQOxUGpNYcoAdeoanaUjmm6IbyEJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524211124; bh=7hizPu69vVpgc44NglxzXxSntzmNambQ8LeQD896uC
    E=; b=W4cegtp96Uo9qFDXTYhC//ZoD4+4oaedU/es7SvtZizPdPod/ovxtBX0OB
    /rknRpei+uHB+Fo0hHR7XURJ4DInQr4J0DBpzhHiDdYhZS9PCx5bDunHgTabD+vK
    ++ZlOSkKwUJ5bXJpQ6UOgyi4TFvx3MJWWV6CwSCUqGdlxjz8Zd8YqvIR2P4RnKHN
    RwhesqhX2P8+1+HoFna+O5hRrdv1C2hkz0cJgdmuNX2/ZFdSNGxV2M1Z9M82I+Tg
    a0nmFiVg0AG2yFYu8qQwviqzBbGlomHUNEfV7aB1OQE+ST2EZi9of5LcfKVAP0/1
    COlVX7KhUJ5zhfXpcNuA1dpUWEsQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=k37mhGlX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ko8KGphz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=k37mhGlX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ko8KGphz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLIQlz/OORlW6od6Nc30KGvFC8KvduaL6g8hyuyf2oYObL8N4lyBTMJG3ZuxsK25rMsXFoJHJe0DbVdkNvJHRymII67pSvpzKqt1Jm9uV4Y5UFaC6Fz9
    RHNSK5yVlOOJmX+daPGpJexFSZF9j50/LqdH6FzMViCqHhjroEjU84zQ8eFz8R6Xq3AiBz6tTbbnx9Gv69SdS0zQsoBWGabJDQurYBKzb3f9kDWzH+8Rp3Bo
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=dmTx0TcGlETd0u4mwdoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbeDTH63 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 03:58:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42695 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeDTH60 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Apr 2018 03:58:26 -0400
X-Google-Smtp-Source: AB8JxZrRyZ6k002QS9Q1occohyKgpunn2fXCxVeCrcoLr1KtLtdkKWSVfze8QRo+8GFnEBnHRVkLV04/b5K3sp7pNkM=
MIME-Version: 1.0
In-Reply-To: <20180420075407.GA7119@osiris>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-5-arnd@arndb.de>
 <20180420075407.GA7119@osiris>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 09:58:24 +0200
X-Google-Sender-Auth: eVOYssfyI36gGjjuqQplKA-NT7Y
Message-ID: <CAK8P3a1_TLs=QZuMVbbAGMEct+SBg2wZ663Kq2RJN5mgU1ZCtw@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] y2038: s390: Remove unneeded ipc uapi header files
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 9:54 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Thu, Apr 19, 2018 at 04:37:24PM +0200, Arnd Bergmann wrote:
>> The s390 msgbuf/sembuf/shmbuf header files are all identical to the
>> version from asm-generic.
>>
>> This patch removes the files and replaces them with 'generic-y'
>> statements, to avoid having to modify each copy when we extend sysvipc
>> to deal with 64-bit time_t in 32-bit user space.
>>
>> Note that unlike alpha and ia64, the ipcbuf.h header file is slightly
>> different here, so I'm leaving the private copy.
>>
>> To deal with 32-bit compat tasks, we also have to adapt the definitions
>> of compat_{shm,sem,msg}id_ds to match the changes to the respective
>> asm-generic files.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/s390/include/asm/compat.h      | 32 ++++++++++++------------
>>  arch/s390/include/uapi/asm/Kbuild   |  3 +++
>>  arch/s390/include/uapi/asm/msgbuf.h | 38 ----------------------------
>>  arch/s390/include/uapi/asm/sembuf.h | 30 -----------------------
>>  arch/s390/include/uapi/asm/shmbuf.h | 49 -------------------------------------
>>  5 files changed, 19 insertions(+), 133 deletions(-)
>>  delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
>>  delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
>>  delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h
>
> FWIW,
>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks, added to the patch.

     Arnd
