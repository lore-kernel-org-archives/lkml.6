Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965134AbeCCB4p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 20:56:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:12687 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965064AbeCCB4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 20:56:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,414,1515484800";
   d="scan'208";a="31078699"
Date: Sat, 3 Mar 2018 09:56:41 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, LKP <lkp@intel.com>,
        "Hao, Shun" <shun.hao@intel.com>
Subject: Re: ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
Message-ID: <20180303015641.amwarmtsskxcnnv5@wfg-t540p.sh.intel.com>
References: <201803011134.bk1IHi9I%fengguang.wu@intel.com>
 <a7358051-b4a0-c07c-1747-f4702abf220f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a7358051-b4a0-c07c-1747-f4702abf220f@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 04:25:45PM +0000, Robin Murphy wrote:
>On 01/03/18 03:18, kbuild test robot wrote:
>> Hi Robin,
>>
>> First bad commit (maybe != root cause):
>
>I have to admit I'm slightly intrigued how this commit could possibly
>appear relevant to the IA64 build at all, let alone to this error :/

Yeah it looks like a bisect error -- the commit merely changed an ARM
header file.

Thanks,
Fengguang

>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   97ace515f01439d4cf6e898b4094040dc12d36e7
>> commit: e1a50de37860b3a93a9d643b09638db5aff47650 arm64: cputype: Silence Sparse warnings
>> date:   12 days ago
>> config: ia64-allmodconfig (attached as .config)
>> compiler: ia64-linux-gcc (GCC) 7.2.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git checkout e1a50de37860b3a93a9d643b09638db5aff47650
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=ia64
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
>>     ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>
>
