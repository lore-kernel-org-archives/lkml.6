Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DEBECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A89420846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A89420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbeGWH7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:59:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbeGWH7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:59:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19DD4402346D;
        Mon, 23 Jul 2018 06:59:17 +0000 (UTC)
Received: from krava (ovpn-204-187.brq.redhat.com [10.40.204.187])
        by smtp.corp.redhat.com (Postfix) with SMTP id D80F9111DCF7;
        Mon, 23 Jul 2018 06:59:11 +0000 (UTC)
Date:   Mon, 23 Jul 2018 08:59:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>, lkp@01.org
Subject: Re: [lkp-robot] [perf tools]  600b7378cf:
 perf-sanity-tests.Share_thread_mg.fail
Message-ID: <20180723065910.GA7523@krava>
References: <20180712142023.16915-3-jolsa@kernel.org>
 <20180722075323.GB23613@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722075323.GB23613@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 23 Jul 2018 06:59:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 23 Jul 2018 06:59:17 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 03:53:24PM +0800, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 600b7378cf43f522e88027874f11f63b6fbf53d8 ("[PATCH 2/4] perf tools: Add threads__get_last_match function")
> url: https://github.com/0day-ci/linux/commits/Jiri-Olsa/perf-tools-Fix-top-crashes/20180714-075809

SNIP

>   LD       plugin_function-in.o
>   LINK     plugin_function.so
>   CC       plugin_xen.o
>   LD       plugin_xen-in.o
>   LINK     plugin_xen.so
>   CC       plugin_scsi.o
>   LD       plugin_scsi-in.o
>   LINK     plugin_scsi.so
>   CC       plugin_cfg80211.o
>   LD       plugin_cfg80211-in.o
>   LINK     plugin_cfg80211.so
>   GEN      libtraceevent-dynamic-list
>   LINK     perf
>   GEN      perf-archive
>   GEN      perf-with-kcore
>   GEN      python/perf.so
> make: Leaving directory '/usr/src/linux-perf-x86_64-randconfig-s5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf'
> 2018-07-16 20:55:35 cd /usr/src/linux-perf-x86_64-randconfig-s5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf
> 2018-07-16 20:55:35 mkdir -p /pkg
> 2018-07-16 20:55:36 mkdir -p /kbuild/obj/consumer/x86_64-randconfig-s5-07160434
> 2018-07-16 20:55:36 cp /pkg/linux/x86_64-randconfig-s5-07160434/gcc-7/600b7378cf43f522e88027874f11f63b6fbf53d8/vmlinux.xz /tmp
> 2018-07-16 20:55:37 unxz -k /tmp/vmlinux.xz
> 2018-07-16 20:55:40 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-randconfig-s5-07160434
> ignored_by_lkp: BPF filter
> ignored_by_lkp: LLVM search and compile
> ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
> ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
> ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
> ignored_by_lkp: builtin clang support
> 2018-07-16 20:55:41 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 1
>  1: vmlinux symtab matches kallsyms                       : Ok
> 2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 2
>  2: Detect openat syscall event                           : FAILED!
> 2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 3
>  3: Detect openat syscall event on all cpus               : FAILED!
> 2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 4
>  4: Read samples using the mmap interface                 : FAILED!
> 2018-07-16 20:55:43 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 5
>  5: Test data source output                               : Ok
> 2018-07-16 20:55:44 sudo /usr/src/linux-perf-x86_64-randconfig-s5-07160434-600b7378cf43f522e88027874f11f63b6fbf53d8/tools/perf/perf test 6
>  6: Parse event definition strings                        : FAILED!

yea, there's v2 already pulled in by Arnaldo,
that fixes this

thanks,
jirka
