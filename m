Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeBBQXe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:23:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeBBQX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:23:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA5121724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 2 Feb 2018 13:23:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: s390 unistd.h & perf
Message-ID: <20180202162322.GF26905@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hendrik,

	I noticed, after fast forwarding my perf/urgent branch to
torvalds/master, that this appears in my perf build:

Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/unistd.h' differs from latest version at 'arch/s390/include/uapi/asm/unistd.h'

	Looking at the log for that file I noticed this cset:

4381f9f12e79 ("s390/syscalls: use generated syscall_table.h and unistd.h header files")

	Can you please take a look how this affects the syscall table
generation process in tools/perf and how can we proceed to silence that
warning, i.e. to update the copy we have in tools/?

Thanks,

- Arnaldo
