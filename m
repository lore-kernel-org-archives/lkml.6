Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-937799-1521271991-2-15771131762341875957
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521271990; b=Q4u5e6U4NAC4xYCfJrHwcecNEdFfwKDwWYzF9Vkpmbyroc8
    qKZAjVqh2YydcHeMfAju73OqqDNJavMxW3M8b4uNmjCZlAUDGQFzs6cL2OIwy+XM
    F/dgLh0SF5jRK7m9Gjel7IYJPtg5YPzFfVoSepYFV0hNSvgSC7zVx+135CBqlBBb
    K3P0oIecmyGlHDTYGriQ4AMOymoSmBK73wUGLYbfWkvB/v+AET28eKEJfTkzVzv7
    3hnblljsk45/Df++USOqDa1HgES55tkA7rwpz95HmPulpqJn40iICc1Z1u2uLaaG
    INa9udqR2cNI/Rx0UsSEt+kYhPdB9xM7SlTVZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1521271990; bh=rSViV5rffgWkzHc+TPQ7M+lvJFXX4Nsleexvy/lmZYI=; b=b
    jhq0DuoybX73wQOhaOSkp4bfvLiowoIupRXs3iUKrC+IOv4/5Lr3vJ6icJs4v/5x
    b7KMFGcnYXeEu632YuT998sGxie/3BCpqEbk7ZQc9DdJ1z5VwKui4ht0hGhndoGb
    DvzFtQiAKpQoRQopBeJIDyN1KGlMDJHOc98U+Qw1YUf6/z3+BVy2ODVcExkdl7pp
    QvEWOTjNh3Yh/3zA9YHM+M7shTkvgMRuXAlbwWZN+ccjVao5bSvaFE21g6wiU96v
    HIQM9Qq4kNMx395woeHNFZuJ3jSxfmzukijWHkUIDdOKdcJ0GH0wp4LA7DVlQSWg
    VOg3lAToMW5kpw30/MidQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,319,1517904000"; d="scan'208";a="34618259"
Date: Sat, 17 Mar 2018 15:32:50 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH v4 02/10] include: Move compat_timespec/ timeval
 to compat_time.h
Message-ID: <20180317073250.6qfmyv45hc2jmyk4@wfg-t540p.sh.intel.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
 <201803132313.a4R8Y434%fengguang.wu@intel.com>
 <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
 <CAK8P3a1fxWAK94GH0cpzh6CHXgL4uJuDNCGpdJen5ib1HH1xoA@mail.gmail.com>
 <CABeXuvpFfD+a6tSSOvni=v23DuJ-bWeZwmnzg4SU+TR=WHxs7Q@mail.gmail.com>
 <CAK8P3a1p1PruO_KsiE-sGAZdmoAVi2E3zZ+SXMzU=AZsb-RY-A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a1p1PruO_KsiE-sGAZdmoAVi2E3zZ+SXMzU=AZsb-RY-A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
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
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org,
 linux-s390 <linux-s390@vger.kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 09:04:04AM +0100, Arnd Bergmann wrote:
>On Thu, Mar 15, 2018 at 3:51 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> On Wed, Mar 14, 2018 at 1:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wed, Mar 14, 2018 at 4:50 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>>> The file arch/arm64/kernel/process.c needs asm/compat.h also to be
>>>> included directly since this is included conditionally from
>>>> include/compat.h. This does seem to be typical of arm64 as I was not
>>>> completely able to get rid of asm/compat.h includes for arm64 in this
>>>> series. My plan is to have separate patches to get rid of asm/compat.h
>>>> includes for the architectures that are not straight forward to keep
>>>> this series simple.
>>>> I will fix this and update the series.
>>>>
>>>
>>> I ran across the same thing in two more files during randconfig testing on
>>> arm64 now, adding this fixup on top for the moment, but maybe there
>>> is a better way:
>>
>> I was looking at how Al tested his uaccess patches:
>> https://www.spinics.net/lists/linux-fsdevel/msg108752.html
>>
>> He seems to be running the kbuild bot tests on his own git.
>> Is it possible to verify it this way on the 2038 tree? Or, I could
>> host a tree also.
>
>The kbuild bot should generally pick up any branch on git.kernel.org,
>and the patches sent to the mailing list. It tests a lot of things
>configurations, but I tend to find some things that it doesn't find
>by doing lots of randconfig builds on fewer target architectures
>(I only build arm, arm64 and x86 regularly).
>
>I remember that there was some discussion about a method
>to get the bot to test other branches (besides asking Fengguang
>to add it manually), but I don't remember what came out of that.

People can send email to me or lkp@intel.com for adding new git URLs
to 0day tests. Such requests are very welcome. Server load is not a
problem -- don't worry about your git pushes adding our test load.
By default all branches in a git tree will be tested, unless there are
explicit blacklist/whitelist.

We also have scripts to scan git.kernel.org/github/LKML looking for
possible new git URLs to add to 0day kbuild tests. However depending
on the team's maintenance pressure they may or may not run frequently.

Thanks,
Fengguang
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
