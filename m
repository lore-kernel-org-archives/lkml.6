Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2751116-1520410992-2-17938968066369983699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 3.2, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520410991; b=vnIzNB1aXvWGBVFqThZaT1TQXsI40krbf0rxxfVRyVYQIVO
    p1oiSqMc65pI/RhcP4Au8emtFXMYPSZsEmsxQeDquTrQmK4mDWL5SIyqG058k0fp
    5/SjgN7vN2OEY3FA5YgG9X1K+FwdwZlmPPH64ZQwK0YXc/3Acjb1f48PoM4O9yhk
    dXokVlRC4qGp33eWKBwRMEgkrM7Jh8lFhwqrjMD7nWHs8WNSuvYSKPZiyGh5obhw
    eOBrf19x/Je9xUavinHPy7q05LB7Oa9tTVf3/sBWhWgnCR5sW4Uocjkjpic6yU55
    haBc03wYqitL3mvPELmiqY2hp6pucRzW1XS2UXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520410991; bh=WttraJ5dvU34IdqyF/HE0SDlKd
    PdGNxK5pRu8zFcooY=; b=b7KMxxmIFrFkpn1Ie1ze9dyXRat5HB6Yrj6njJwm7v
    J1eaxqvgmCIiz9B+Wqht3mt+7JZfglobitY9oXfl+IA0uMjNmy4aKYIrEkDs43RC
    /gAGA7Hg6QAVY8vM8plkXNHvl+HoYKO/Go3ruT12Xgqhf35sUcjUAPv1sB99Al2l
    NztwuxDCu4zR9+t0mrQaZAkPQPBaTZgkAPwuJgd1R0pRpIEJ430i+6c24i0jprqe
    nhuVNaSrFmbvnAbo+F6RqXxerm4ejDc7Zgbj7XX90KfeWJYIQ8tmvySGWCb0xTrN
    jkzyMKRWESQgqJKXgDowsVvmw97Qrs9ohfKjIJF8gBew==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aqsaydk/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YOSseAI4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aqsaydk/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YOSseAI4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeCGIXI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 03:23:08 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43015 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbeCGIXD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 03:23:03 -0500
X-Google-Smtp-Source: AG47ELvJB97wzQlAYXMS59do6yFdGSePduRI1Bv5wtGJ1Yuque00sS3CtCD3QmN/+AkG9c4icXJgdw==
Date: Wed, 7 Mar 2018 09:22:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ilya Pronin <ipronin@twitter.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sangwon Hong <qpakzk@gmail.com>, stable@vger.kernel.org,
        Taeung Song <treeze.taeung@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/9] perf/urgent fixes
Message-ID: <20180307082258.ldhidzjvdekhhi5g@gmail.com>
References: <20180306172343.16546-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306172343.16546-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 58bdf601c2de6071d0386a7a6fa707bd04761c47:
> 
>   Merge branch 'i2c/for-current-fixed' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2018-03-03 14:55:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.16-20180306
> 
> for you to fetch changes up to 8f2c9efabe1ed212b88ce1c5cf5e768385c9222e:
> 
>   perf record: Combine some auxtrace initialization into a single function (2018-03-06 12:03:39 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Be more robust when drawing arrows in the annotation TUI, avoiding a
>   segfault when jump instructions have as a target addresses in functions
>   other that the one currently being annotated. The full fix will come in
>   the following days, when jumping to other functions will work as call
>   instructions (Arnaldo Carvalho de Melo)
> 
> - Prevent auxtrace_queues__process_index() from queuing AUX area data for
>   decoding when the --no-itrace option has been used (Adrian Hunter)
> 
> - Sync copy of kvm UAPI headers and x86's cpufeatures.h (Arnaldo Carvalho de Melo)
> 
> - Fix 'perf stat' CVS output format for non-supported counters (Ilya Pronin)
> 
> - Fix crash in 'perf record|perf report' pipe mode (Jiri Olsa)
> 
> - Fix annoying 'perf top' overwrite fallback message on older kernels (Kan Liang)
> 
> - Fix the usage on the 'perf kallsyms' man page (Sangwon Hong)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> The following changes since commit 317660940fd9dddd3201c2f92e25c27902c753fa:
> 
>   perf/x86/intel/uncore: Fix Skylake UPI event format (2018-03-04 09:59:00 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.16-20180306
> 
> for you to fetch changes up to de19e5c3c51fdb1ff20d0f61d099db902ff7494b:
> 
>   perf tools: Fix trigger class trigger_on() (2018-03-06 11:31:14 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Be more robust when drawing arrows in the annotation TUI, avoiding a
>   segfault when jump instructions have as a target addresses in functions
>   other that the one currently being annotated. The full fix will come in
>   the following days, when jumping to other functions will work as call
>   instructions (Arnaldo Carvalho de Melo)
> 
> - Prevent auxtrace_queues__process_index() from queuing AUX area data for
>   decoding when the --no-itrace option has been used (Adrian Hunter)
> 
> - Sync copy of kvm UAPI headers and x86's cpufeatures.h (Arnaldo Carvalho de Melo)
> 
> - Fix 'perf stat' CSV output format for non-supported counters (Ilya Pronin)
> 
> - Fix crash in 'perf record|perf report' pipe mode (Jiri Olsa)
> 
> - Fix annoying 'perf top' overwrite fallback message on older kernels (Kan Liang)
> 
> - Fix the usage on the 'perf kallsyms' man page (Sangwon Hong)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf auxtrace: Prevent decoding when --no-itrace
>       perf tools: Fix trigger class trigger_on()
> 
> Arnaldo Carvalho de Melo (3):
>       perf annotate browser: Be more robust when drawing jump arrows
>       tools headers: Sync copy of kvm UAPI headers
>       tools headers: Sync x86's cpufeatures.h
> 
> Ilya Pronin (1):
>       perf stat: Fix CVS output format for non-supported counters
> 
> Jiri Olsa (1):
>       perf record: Fix crash in pipe mode
> 
> Kan Liang (1):
>       perf top: Fix annoying fallback message on older kernels
> 
> Sangwon Hong (1):
>       perf kallsyms: Fix the usage on the man page
> 
>  tools/arch/x86/include/asm/cpufeatures.h   |  1 +
>  tools/include/uapi/linux/kvm.h             |  2 ++
>  tools/perf/Documentation/perf-kallsyms.txt |  2 +-
>  tools/perf/builtin-record.c                |  9 +++++++++
>  tools/perf/builtin-stat.c                  |  2 +-
>  tools/perf/builtin-top.c                   |  2 +-
>  tools/perf/perf.h                          |  1 +
>  tools/perf/ui/browsers/annotate.c          | 25 +++++++++++++++++++++++++
>  tools/perf/util/auxtrace.c                 | 15 +++++++++------
>  tools/perf/util/record.c                   |  8 ++++++--
>  tools/perf/util/trigger.h                  |  9 +++++----
>  11 files changed, 61 insertions(+), 15 deletions(-)

Pulled, thanks a lot Arnaldo!

Note that there's a new, minor conflict between perf/core and perf/urgent - I 
resolved it and merged perf/urgent into perf/core, please double check my 
resolution.

	Ingo
