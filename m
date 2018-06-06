Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9EE2B60263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeFFJ5j (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:57:39 -0400
Received: from foss.arm.com ([217.140.101.70]:38760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeFFJ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:57:37 -0400
Subject: Re: [PATCH v4 14/14] coresight: allow the coresight core driver to be
 built as a module
To: Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-15-kim.phillips@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <46a026b2-0140-c1c0-2205-f5750233b152@arm.com>
Date: Wed, 6 Jun 2018 10:57:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180605210710.22227-15-kim.phillips@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 10:07 PM, Kim Phillips wrote:
> Allow to build coresight as a module.  This enhances
> coresight developer efficiency by allowing the development to
> take place exclusively on the target, and without needing to
> reboot in between changes.
> 
> - Kconfig becomes a tristate, to allow =m
> - append -core to source file name to allow module to
>    be called coresight by the Makefile
> - modules can have only one init/exit, so we add the core bus
>    register/unregister function calls to the etm_perf init/exit
>    functions, since coresight.c does not have etm_pmu defined.

It feels a bit weird to move the coresight core specific steps to
etm_perf_init. Why not call etm_perf_init from coresight init routine
and keep everything core specific in the coresight-core.c ?


Suzuki
