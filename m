Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E9921738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfBUNjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:39:40 -0500
Received: from www62.your-server.de ([213.133.104.62]:44716 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUNjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:39:40 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwoZV-0005pS-Ix; Thu, 21 Feb 2019 14:39:29 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwoZV-000LBJ-9w; Thu, 21 Feb 2019 14:39:29 +0100
Subject: Re: [bpf] 568f196756: BUG:assuming_atomic_context_at_kernel/seccomp.c
To:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
References: <20190221133556.eqzclahgngq53s64@inn2.lkp.intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cdd8143b-7719-b51e-5a6a-6bdc065cc773@iogearbox.net>
Date:   Thu, 21 Feb 2019 14:39:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190221133556.eqzclahgngq53s64@inn2.lkp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25366/Wed Feb 20 12:52:59 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2019 02:35 PM, kernel test robot wrote:
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 568f196756ad9fe2b49c46bbf6a9de1b190438b4 ("bpf: check that BPF programs run with preemption disabled")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Fyi, false positive and already fixed in bpf-next.

(https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=435b3ff5b08a99a15647be32735abf8db66cea9a)
