Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754007AbeBLTMZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:12:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:59494 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753446AbeBLTMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:12:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="gz'50?scan'50,208,50";a="30834776"
Date: Tue, 13 Feb 2018 03:11:22 +0800
From: kbuild test robot <lkp@intel.com>
To: Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc: kbuild-all@01.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org, rananta@codeaurora.org
Subject: Re: [PATCH] perf: Add support for creating offline events
Message-ID: <201802130238.0csUa67V%fengguang.wu@intel.com>
References: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Raghavendra,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.15]
[also build test ERROR on next-20180212]
[cannot apply to tip/perf/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Raghavendra-Rao-Ananta/perf-Add-support-for-creating-offline-events/20180213-023250
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   kernel//events/core.c: In function 'perf_event_init_cpu':
>> kernel//events/core.c:11152:2: error: implicit declaration of function 'perf_deferred_install_in_context'; did you mean 'perf_install_in_context'? [-Werror=implicit-function-declaration]
     perf_deferred_install_in_context(cpu);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     perf_install_in_context
   cc1: some warnings being treated as errors

vim +11152 kernel//events/core.c

 11131	
 11132	int perf_event_init_cpu(unsigned int cpu)
 11133	{
 11134		struct perf_cpu_context *cpuctx;
 11135		struct perf_event_context *ctx;
 11136		struct pmu *pmu;
 11137	
 11138		perf_swevent_init_cpu(cpu);
 11139	
 11140		mutex_lock(&pmus_lock);
 11141		cpumask_set_cpu(cpu, perf_online_mask);
 11142		list_for_each_entry(pmu, &pmus, entry) {
 11143			cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 11144			ctx = &cpuctx->ctx;
 11145	
 11146			mutex_lock(&ctx->mutex);
 11147			cpuctx->online = 1;
 11148			mutex_unlock(&ctx->mutex);
 11149		}
 11150		mutex_unlock(&pmus_lock);
 11151	
 11152		perf_deferred_install_in_context(cpu);
 11153	
 11154		return 0;
 11155	}
 11156	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
NNeGiqnMjK/IBYvS/P8DU2CW7QZhAAA=

--X1bOJ3K7DJ5YkBrT--
