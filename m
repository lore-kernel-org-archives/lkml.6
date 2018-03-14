Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2597693-1521060749-2-9728478022030020374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521060749; b=gNYWucOs9roHoqUWjHpgjy7YY3GX7SGIrpnqY0U7okDbiPq
    4hewj9WifZVs7MbNvR4T36Rz66A17lO7MkEfK9HuE6Ta8H3eXEczD4pSKYd+l3pu
    1Nq3l57COS6RyiqDXsRUxMpMz7wKA5rhxv4b2Dxbz5tkWa3nnrf973afKXuTAod9
    KqxUW5wdOm6pPyUNBL+D5MkKFF5RSCCU6nEJvmByjzMCx4b3RC8kw6vTAB/rcttT
    JvTCVjjG2ENAblCCzh/OD09GlcFBNIkTSKFwY2lVHqt7SiBw8dej9ByptuRuG+HM
    MfI2k1AOwB/hKioD1f3ibAe2wlwBozMqpTxyuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521060749; bh=p
    IartfpIGMo8JSA1kqrB3n9zbLxLO3hMbdOIQNtsyLU=; b=KEVeYBEr/LnPcz4Cg
    34XSsJja3hQ9cVQjrwETsnO5TaXdf2Bn9Bq3UzHOy8ufvJ+C8PJMT61kmDn50JIA
    uqX66FlkWf6Teg4xTorUYqgPVd3a+ZTmSRnUz0Mh75fmNHYk+MhTEpzzKk4JXGX5
    aMgWQnDbQZSuGMI7mjIpS681sMmqGgb8aCT6sKdW6K3eVYjrVYc4UBlNB913dlG6
    NFOT0XZwbAW9XC4wYffwmVwXJlHuJg2LJaMso68Pqo8iXMc3e5RyeKf2oD8uSiSe
    X42rlD0cfpbCVvfAKOWFYZFttBCQgjGV9I5tstz1RpRqmaThv0AXrrwyfDF7oc4Y
    lEUdw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KkexHSMH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EFRTe2nl;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KkexHSMH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EFRTe2nl;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvxs8tI4ovw4LYYl9WnjOgPeVdJtaAfQjx47VJzx8+UktWw9SmhCiypE7XQ2V4v84urAT3Y9dTr7i/ZSrAncvY=
MIME-Version: 1.0
In-Reply-To: <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
 <201803132313.a4R8Y434%fengguang.wu@intel.com>
 <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 21:52:21 +0100
X-Google-Sender-Auth: QhLFsyx3N4JlhiSHq39H04slYE8
Message-ID: <CAK8P3a1fxWAK94GH0cpzh6CHXgL4uJuDNCGpdJen5ib1HH1xoA@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v4 02/10] include: Move compat_timespec/ timeval
 to compat_time.h
To: Deepa Dinamani <deepa.kernel@gmail.com>
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Will Deacon <will.deacon@arm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 oprofile-list@lists.sf.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>,
 Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Julian Wiedmann <jwi@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ursula Braun <ubraun@linux.vnet.ibm.com>, gerald.schaefer@de.ibm.com,
 Parisc List <linux-parisc@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, cohuck@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
 kbuild-all@01.org, Stefan Haberland <sth@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 4:50 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> The file arch/arm64/kernel/process.c needs asm/compat.h also to be
> included directly since this is included conditionally from
> include/compat.h. This does seem to be typical of arm64 as I was not
> completely able to get rid of asm/compat.h includes for arm64 in this
> series. My plan is to have separate patches to get rid of asm/compat.h
> includes for the architectures that are not straight forward to keep
> this series simple.
> I will fix this and update the series.
>

I ran across the same thing in two more files during randconfig testing on
arm64 now, adding this fixup on top for the moment, but maybe there
is a better way:

commit 4f3e9e1211799a79b201a1af309a1ec3864147ec
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Mar 14 18:23:16 2018 +0100

    arm64: fix perf_regs.c

    arch/arm64/kernel/perf_regs.c: In function 'perf_reg_abi':
    arch/arm64/kernel/perf_regs.c:50:6: error: implicit declaration of
function 'is_compat_thread'; did you mean 'is_compat_task'?
[-Werror=implicit-function-declaration]
    arch/arm64/kernel/hw_breakpoint.c: In function 'is_compat_bp':
    arch/arm64/kernel/hw_breakpoint.c:182:16: error: implicit
declaration of function 'is_compat_thread'; did you mean
'is_compat_task'? [-Werror=implicit-function-declaration]

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm64/kernel/hw_breakpoint.c
b/arch/arm64/kernel/hw_breakpoint.c
index 413dbe530da8..74bb56f656ef 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -30,6 +30,7 @@
 #include <linux/smp.h>
 #include <linux/uaccess.h>

+#include <asm/compat.h>
 #include <asm/current.h>
 #include <asm/debug-monitors.h>
 #include <asm/hw_breakpoint.h>
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 0bbac612146e..1b463a4efe49 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -6,6 +6,7 @@
 #include <linux/bug.h>
 #include <linux/sched/task_stack.h>

+#include <asm/compat.h>
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
