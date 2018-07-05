Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D43C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3118D2401C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3118D2401C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeGEAm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 20:42:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:30057 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752899AbeGEAm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 20:42:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 17:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="54503962"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.124])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2018 17:42:55 -0700
Date:   Thu, 5 Jul 2018 08:39:10 +0800
From:   Ye Xiaolong <xiaolong.ye@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Subject: Re: [lkp-robot] [x86/entry/64/compat] 8bb2610bc4:
 kernel_selftests.x86.test_syscall_vdso_32.fail
Message-ID: <20180705003910.GD10005@yexl-desktop>
References: <20180704065414.GD23907@yexl-desktop>
 <CA+55aFwSD8T1dusD_Q14MhAxQcYG===ZTdS+CXuT-odj88xWkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwSD8T1dusD_Q14MhAxQcYG===ZTdS+CXuT-odj88xWkA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04, Linus Torvalds wrote:
>On Tue, Jul 3, 2018 at 11:58 PM kernel test robot <xiaolong.ye@intel.com> wrote:
>>
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 8bb2610bc4967f19672444a7b0407367f1540028 ("x86/entry/64/compat: Preserve r8-r11 in int $0x80")
>> [...]
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>So that commit is expected to fix things, but it also *enabled* the
>selftests to warn about the change.
>
>Did you run the new selftest on an old kernel?
>
>It looks that way, because you talk about running the selftests for
>commit 8bb2610bc496 (which is 4.17-rc2+), but the dmesg you include is
>some ancient version"
>
>    Linux version 4.12.0-10998-g6974f0c

Just double checked the attached dmesg, the version seems correct, did you
check the right one?

[    0.000000] Linux version 4.17.0-rc2-00006-g8bb2610 (kbuild@cairo) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Thu Jun 7 15:10:14 CST 2018      


Thanks,
Xiaolong
>
>Hmm. Some of those self-tests are very much expected to break on old kernels.
>
>                  Linus
