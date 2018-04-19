Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4107594-1524173083-3-143735959153287740
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
    1524173082; b=NO9lhQxfU4QEQ2g94du+m9xbxLm4RtzycVgGVNp5hridJ6lM3v
    711Zx79TSq2T+ipbsWRQ/vRSCKDL83/DaDBDwRYk4Nl6sU0+0h12w0A318fobepi
    Xn5ibW7EYzTmtxQxb40V59Yg0qWFMXWOBGjMzMwlmhM9eqQfT6tStF2Osq1YwX07
    MfdKxnMObO5l/upQpINhHx2KMueYoD2drZRTjPQ88YODHHGkey0i3vgCgHSotbYI
    Cr5vSGgoNYYE4OEJNNupfIoPf3PO52veQBWTGMuQj4eiq2mm8S3Ip6GUKTQNNkbR
    ENOyJcv47TEW/rmgw+/vLHmhsBWMQj0PRYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524173082; bh=KezQqwcFbFp/VAY4+o7Q7vkp8ACCJiP3SjCj6dAQQk
    A=; b=vyIyX9k3VxwSuTrmphMIF1KPZH+H57akqlqkDbSx+BdlL9kBVXqCSPV9MB
    3RXzejD1NvdDy5H1mefZoML86AS5S8VNI0robE32TYgjRQhlyz3HOFXC9BqGxRCl
    X8UKEhJYpiUkH19GZie8NzD7yBZ7IqFcTt9e52e00QrXS1HDtlm8ixQd+TSzL0pm
    vSX2T3nhzOrhy69ErxvUsTyY/F/kcgYeyoMnGqSaJiRVxdgvvn0Ih5QGUsH4CyGH
    qCuWYQF4vCb5OFYjJ9y8u5rKNt8zJsQ5jmSEsRIjISOqdQkKe7g21uTcHLyYMe+d
    A5SFANnQKyc/URDqHxeq9AD5r5Bg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PwCk3/d0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ik34SOfI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PwCk3/d0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ik34SOfI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNz/panqVD/yvriBf+OM54WFXkPcoOOfLIwdQ037L5870D5pCP5o+FJlrfNcs8YLaJYa4SrnZb81TCqQkfjU7ESYw4268jnzpxGlqjzbDVnSYFTRXLDB
    wi4QBrXN0GZo/uL29cGmkyAP01vzXck+cU3OmztMCG15iWP1o8ay6V4E4JHaJcWM9r3vexuy7wW3Hc5ulaDfbN+e9A88lBxe2JlGSFeowmgZhK02/EAnIOUt
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=dl2G8iAkYs_fG4qekb4A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbeDSVYk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 17:24:40 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41444 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSVYi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 17:24:38 -0400
X-Google-Smtp-Source: AB8JxZrhXLgdJ1+Jfq+pp9JoGaTu2YgiLLK1OoJtno7XhBLVHJyz7JVvJI3qt8ir5mfG9d6tFRBsjJzovpLtVgmOcBU=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a196QYoM1egagMuZw4WhiwRiO83Qpj0CxoCeVQBEaj-gw@mail.gmail.com>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-2-arnd@arndb.de>
 <87efjbnswr.fsf@xmission.com> <CAK8P3a196QYoM1egagMuZw4WhiwRiO83Qpj0CxoCeVQBEaj-gw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 23:24:36 +0200
X-Google-Sender-Auth: sfBM_45QNy4kZ-7Da423oVXWhFk
Message-ID: <CAK8P3a2KR+0ZE5jHSmO6pSuiRPH83p75KetuQuHL1atChcTJGA@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Thu, Apr 19, 2018 at 5:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Apr 19, 2018 at 4:59 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> I suspect you want to use __kernel_ulong_t here instead of a raw
>> unsigned long.  If nothing else it seems inconsistent to use typedefs
>> in one half of the structure and no typedefs in the other half.
>
> Good catch, there is definitely something wrong here, but I think using
> __kernel_ulong_t for all members would also be wrong, as that
> still changes the layout on x32, which effectively is
>
> struct msqid64_ds {
>      ipc64_perm msg_perm;
>      u64 msg_stime;
>      u32 __unused1;
>      /* 32 bit implict padding */
>      u64 msg_rtime;
>      u32 __unused2;
>      /* 32 bit implict padding */
>      u64 msg_ctime;
>      u32 __unused3;
>      /* 32 bit implict padding */
>      __kernel_pid_t          shm_cpid;       /* pid of creator */
>      __kernel_pid_t          shm_lpid;       /* pid of last operator */
>      ....
> };
>
> The choices here would be to either use a mix of
> __kernel_ulong_t and unsigned long, or taking the x32
> version back into arch/x86/include/uapi/asm/ so the
> generic version at least makes some sense.
>
> I can't use __kernel_time_t for the lower half on 32-bit
> since it really should be unsigned.

After thinking about it some more, I conclude that the structure is simply
incorrect on x32: The __kernel_ulong_t usage was introduced in 2013
in commit b9cd5ca22d67 ("uapi: Use __kernel_ulong_t in struct
msqid64_ds") and apparently was correct initially as __BITS_PER_LONG
evaluated to 64, but it broke with commit f4b4aae18288 ("x86/headers/uapi:
Fix __BITS_PER_LONG value for x32 builds") that changed the value
of __BITS_PER_LONG and introduced the extra padding in 2015.

The same change apparently also broke a lot of other definitions, e.g.

$ echo "#include <linux/types.h>" | gcc -mx32 -E -xc - | grep -A3
__kernel_size_t
typedef unsigned int __kernel_size_t;
typedef int __kernel_ssize_t;
typedef int __kernel_ptrdiff_t;

Those used to be defined as 'unsigned long long' and 'long long'
respectively, so now all kernel interfaces using those on x32
became incompatible!

       Arnd
