Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeDTMi5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:38:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:9469 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTMi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:38:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="43381269"
Date: Fri, 20 Apr 2018 20:38:52 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Riku Voipio <riku.voipio@linaro.org>,
        Frantisek Hrbata <fhrbata@redhat.com>,
        Masahiro Yamada <yamada.m@jp.panasonic.com>,
        linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [gcov_module_notifier] WARNING: CPU: 0 PID: 155 at
 mm/slab_common.c:996 kmalloc_slab+0x1f/0x79
Message-ID: <20180420123852.ox5xcmwgj4krzapf@wfg-t540p.sh.intel.com>
References: <20180419025854.uasnqkaflr45zeat@wfg-t540p.sh.intel.com>
 <4e2d71d1-e945-e2c3-cf8f-e19df52df6f5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4e2d71d1-e945-e2c3-cf8f-e19df52df6f5@linux.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Apr 20, 2018 at 01:08:07PM +0200, Peter Oberparleiter wrote:
>On 19.04.2018 04:58, Fengguang Wu wrote:
>> FYI this happens in mainline kernel 4.17.0-rc1.
>> It at least dates back to v4.5 .
>
>This is likely the result of compiling the kernel with GCC 7 while
>specifying that gcov-kernel should expect GCC <= 3.4 format data:
>
>dmesg:
>> (gcc version 7.3.0 (Debian 7.3.0-1)) #31 Mon Apr 16 23:17:50 CST 2018
>
>.config:
>> # CONFIG_GCOV_FORMAT_AUTODETECT is not set
>> CONFIG_GCOV_FORMAT_3_4=y
>> # CONFIG_GCOV_FORMAT_4_7 is not set
>
>As such, it is an expected test failure. Assuming that this is a
>randconfig test, my recommendation would be to blacklist
>"CONFIG_GCOV_FORMAT_3_4=y" when using GCC >3.4.

Ah OK, thanks! It looks easy to fix for us. Interestingly there's
the default GCOV_FORMAT_AUTODETECT option, however the randconfig
test obviously (blindly) will try other options if ever they are
selectable.

Thanks,
Fengguang
