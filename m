Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-620268-1520999789-2-5331315675467167953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520999788; b=InoHLjqB/iWBcUDVVshsIS6rxHpbLThWBXSBHcCsQgaSWpU
    vz/SyyGs/nd4ALrg8vx/Z/4U9aHdxqI0k7NrPJ/tmxK+jJ3zmuiIkG14yNF8QwLb
    WL9IwUz8CndwHlD1Wisgd+FBgZXNH93rDivMEWLiMSWxGiAV1//5+d8Mz6YToJQ7
    1kRF6hxqRwhOYlwANXflviyjnLdQUefyBsknvW7PiLqD82LYdZo0+tLEuCL+lZ7D
    9sIHCKEO23wuLY8W76y8n+5qq/HaHldSaKgXmArJ9QmqJ52//Xk4b+ll2hMLsq+P
    7whYrxtj0GCpfU4zlVxxBLj7Gd76UPIAB/S6s7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520999788; bh=Y
    sWmXhKEjT6j4TtFcLHy0DOEawQSI1LbyUPTL5eSVkE=; b=bN5grYokQQx1cWPoS
    wMYSvrUG3ONjCiwRhb5ZV0TUfdQT4Qny2R7inf8ObIhb4oevyAFcxRMyyK6Flqr9
    jVBfAWtfls9vKEnktTZSxwzCCeQEfWWrqukWYGTZtRwwTDik9PiELHGkqT2DbKEK
    sp4qsG0zyx7hlZe9lz9F+IqN1sibwIygB7LdNOLQKE9EEbCrLrXvmCOJj9e1G7rw
    wY5vtNUk/Ml+LcDROyiZ+Rydq2kYDa33sV3eNn+UNgBT1RXUj+MGlsI/RhxJ/uW+
    QV6HIdJd0amFhMNT9Z1kUpG67SJyxGPGfhVopHL3Bx0z4qT0J1yeBadLEXlhKMIl
    Btr7A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KilrY6RC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CABf+dpI;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KilrY6RC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CABf+dpI;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtAM9PZD/G707pnBMkXrN7JZDJfuXuK6tDs++5zpJCWZmOzctJpg3Th0ulDcIai73AxNg9YsBvet+rgu2YhtfQ=
MIME-Version: 1.0
In-Reply-To: <201803132351.1SZJ68nV%fengguang.wu@intel.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
 <201803132351.1SZJ68nV%fengguang.wu@intel.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 13 Mar 2018 20:56:19 -0700
Message-ID: <CABeXuvp617xkFgMDz8WR_=e6tj2d5LDpF56R-iXCOAqM=tdm+A@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
To: kbuild test robot <lkp@intel.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 oprofile-list@lists.sf.net, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
 Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>,
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Julian Wiedmann <jwi@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 gerald.schaefer@de.ibm.com, Parisc List <linux-parisc@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, cohuck@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>,
 Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, kbuild-all@01.org,
 Stefan Haberland <sth@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is again a tricky include file ordering when linux/compat.h is
included instead of asm/compat.h. is_compat_task() is unconditionally
defined in linux/compat.h as a macro which conflicts with inline
function define in asm/compat.h for this arch.
As before, I will do the simple thing here and leave the asm/compat.h
to keep this series simple.
I will submit follow up patches to eliminate direct inclusion asm/compat.h.

I will include this also in the update.

-Deepa

On Tue, Mar 13, 2018 at 8:30 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Deepa,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on ]
>
> url:    https://github.com/0day-ci/linux/commits/Deepa-Dinamani/posix_clocks-Prepare-syscalls-for-64-bit-time_t-conversion/20180313-203305
> base:
> config: powerpc-iss476-smp_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc
>
> All errors (new ones prefixed by >>):
>
>    arch/powerpc/oprofile/backtrace.c: In function 'user_getsp32':
>>> arch/powerpc/oprofile/backtrace.c:31:19: error: implicit declaration of function 'compat_ptr'; did you mean 'complete'? [-Werror=implicit-function-declaration]
>      void __user *p = compat_ptr(sp);
>                       ^~~~~~~~~~
>                       complete
>>> arch/powerpc/oprofile/backtrace.c:31:19: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
>    cc1: all warnings being treated as errors
>
> vim +31 arch/powerpc/oprofile/backtrace.c
>
> 6c6bd754 Brian Rogan 2006-03-27  27
> 6c6bd754 Brian Rogan 2006-03-27  28  static unsigned int user_getsp32(unsigned int sp, int is_first)
> 6c6bd754 Brian Rogan 2006-03-27  29  {
> 6c6bd754 Brian Rogan 2006-03-27  30     unsigned int stack_frame[2];
> 62034f03 Al Viro     2006-09-23 @31     void __user *p = compat_ptr(sp);
> 6c6bd754 Brian Rogan 2006-03-27  32
> 62034f03 Al Viro     2006-09-23  33     if (!access_ok(VERIFY_READ, p, sizeof(stack_frame)))
> 6c6bd754 Brian Rogan 2006-03-27  34             return 0;
> 6c6bd754 Brian Rogan 2006-03-27  35
> 6c6bd754 Brian Rogan 2006-03-27  36     /*
> 6c6bd754 Brian Rogan 2006-03-27  37      * The most likely reason for this is that we returned -EFAULT,
> 6c6bd754 Brian Rogan 2006-03-27  38      * which means that we've done all that we can do from
> 6c6bd754 Brian Rogan 2006-03-27  39      * interrupt context.
> 6c6bd754 Brian Rogan 2006-03-27  40      */
> 62034f03 Al Viro     2006-09-23  41     if (__copy_from_user_inatomic(stack_frame, p, sizeof(stack_frame)))
> 6c6bd754 Brian Rogan 2006-03-27  42             return 0;
> 6c6bd754 Brian Rogan 2006-03-27  43
> 6c6bd754 Brian Rogan 2006-03-27  44     if (!is_first)
> 6c6bd754 Brian Rogan 2006-03-27  45             oprofile_add_trace(STACK_LR32(stack_frame));
> 6c6bd754 Brian Rogan 2006-03-27  46
> 6c6bd754 Brian Rogan 2006-03-27  47     /*
> 6c6bd754 Brian Rogan 2006-03-27  48      * We do not enforce increasing stack addresses here because
> 6c6bd754 Brian Rogan 2006-03-27  49      * we may transition to a different stack, eg a signal handler.
> 6c6bd754 Brian Rogan 2006-03-27  50      */
> 6c6bd754 Brian Rogan 2006-03-27  51     return STACK_SP(stack_frame);
> 6c6bd754 Brian Rogan 2006-03-27  52  }
> 6c6bd754 Brian Rogan 2006-03-27  53
>
> :::::: The code at line 31 was first introduced by commit
> :::::: 62034f03380a64c0144b6721f4a2aa55d65346c1 [POWERPC] powerpc oprofile __user annotations
>
> :::::: TO: Al Viro <viro@ftp.linux.org.uk>
> :::::: CC: Paul Mackerras <paulus@samba.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
