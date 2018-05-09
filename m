Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965401AbeEIVlL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 17:41:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935325AbeEIVlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 17:41:10 -0400
Date: Wed, 9 May 2018 16:41:08 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: <linux-kernel@vger.kernel.org>, <acme@kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <philip.li@intel.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2] perf test shell: Add -D to check dynamic symbols for
 ubuntu/debian
Message-Id: <20180509164108.3fd8f5c71c2fa11d0c474067@arm.com>
In-Reply-To: <1525851929-20233-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1525851929-20233-1-git-send-email-lizhijian@cn.fujitsu.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018 15:45:29 +0800
Li Zhijian <lizhijian@cn.fujitsu.com> wrote:

> On Ubuntu and Debian, we can't find any symbol including "inet_pton" from 'nm -g'
> root@vm-lkp-nex04-8G-5 ~# nm -g /lib/x86_64-linux-gnu/libc-2.25.so | grep inet_pton
> nm: /lib/x86_64-linux-gnu/libc-2.25.so: no symbols
> 
> it looks libc.so has different symbol compositions at different distros

I'm wondering if that is because libc6-dbg isn't installed?:

ubuntu$ nm -g /usr/lib/debug/lib/x86_64-linux-gnu/libc-2.26.so | grep inet_pton
0000000000136340 W inet_pton
0000000000136010 T __inet_pton_length

Kim
