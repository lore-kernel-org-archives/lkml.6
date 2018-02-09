Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeBIJv4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:51:56 -0500
Received: from foss.arm.com ([217.140.101.70]:44946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbeBIJvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:51:55 -0500
Subject: Re: [PATCH] coresight replicator: set default y after Kconfig rename
To: Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <3a431646-4153-0ad3-675c-ee3ca88f08aa@arm.com>
Date: Fri, 9 Feb 2018 09:51:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 21:03, Kim Phillips wrote:
> Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
> replicator naming") changed the Kconfig symbol name from
> QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
> was being set in my juno build script, which left the new symbol unset,
> causing the following unexpected grief:
> 
>   # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
>   ..<snip>..
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>   mmap size 528384B
>   AUX area mmap length 4194304
>   perf event ring buffer mmapped per cpu
>   failed to mmap AUX area
>   failed to mmap with 12 (Cannot allocate memory)
> 
> Make it default y to help not surprise unsuspecting users.

I think the best way to address this issue is to set the proper errno when
we fail to build a path, say -ENODEV, that could give us a better clue
on what is going wrong. Have you checked the dmesg to see if it complains
about "build path" failure ?

Cheers
Suzuki
