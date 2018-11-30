Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F97CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F161C20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F161C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeLAC2k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:28:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:7701 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeLAC2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:28:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 07:19:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="117853437"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga004.fm.intel.com with ESMTP; 30 Nov 2018 07:19:00 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 30 Nov 2018 07:19:00 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.203]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.46]) with mapi id 14.03.0415.000;
 Fri, 30 Nov 2018 23:18:58 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: RE: rcu_preempt caused oom
Thread-Topic: rcu_preempt caused oom
Thread-Index: AdSHvQIr70OYynHSTxKgLAvVXX+0Zv//yKOAgAAWeAD//li4UIADPhuAgAAJSYD//3lRYA==
Date:   Fri, 30 Nov 2018 15:18:58 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52A1263F@SHSMSX104.ccr.corp.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com>
        <20181129130647.GG4170@linux.ibm.com>   <20181129142712.GA16607@linux.ibm.com>
        <CD6925E8781EFD4D8E11882D20FC406D52A1243D@SHSMSX104.ccr.corp.intel.com>
        <20181130144317.GQ4170@linux.ibm.com>
 <20181130101631.618d955f@gandalf.local.home>
In-Reply-To: <20181130101631.618d955f@gandalf.local.home>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWM2OGMyYTctM2Q2MS00ZTgxLWE4MjEtMDQyNjY3MTc5M2NlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ01odXFaVlYwKzRGMUMxendoMmNrNWlwMkdRNFpuSjZBajdNZTBaeEZSVzk3N2ZBZXZ6aGZEREs4bE54ZkRqaiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the kernel cmdline:

Kernel command line: androidboot.acpio_idx=0  androidboot.bootloader=efiwrapper-02_03-userdebug_kernelflinger-06_03-userdebug androidboot.diskbus=00.0 androidboot.verifiedbootstate=green androidboot.bootreason=power-on androidboot.serialno=R1J56L6006a7bb g_ffs.iSerialNumber=R1J56L6006a7bb no_timer_check noxsaves reboot_panic=p,w i915.hpd_sense_invert=0x7 mem=2G nokaslr nopti ftrace_dump_on_oops trace_buf_size=1024K intel_iommu=off gpt loglevel=4 androidboot.hardware=gordon_peak firmware_class.path=/vendor/firmware relative_sleep_states=1 enforcing=0 androidboot.selinux=permissive cpu_init_udelay=10 androidboot.android_dt_dir=/sys/bus/platform/devices/ANDR0001:00/properties/android/ pstore.backend=ramoops memmap=0x1400000$0x50000000 ramoops.mem_address=0x50000000 ramoops.mem_size=0x1400000 ramoops.record_size=0x4000 ramoops.console_size=0x1000000 ramoops.ftrace_size=0x10000 ramoops.dump_oops=1 vga=current 
i915.modeset=1 drm.atomic=1 i915.nuclear_pageflip=1 drm.vblankoffdelay=

-----Original Message-----
From: Steven Rostedt <rostedt@goodmis.org> 
Sent: Friday, November 30, 2018 11:17 PM
To: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: He, Bo <bo.he@intel.com>; linux-kernel@vger.kernel.org; josh@joshtriplett.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>
Subject: Re: rcu_preempt caused oom

On Fri, 30 Nov 2018 06:43:17 -0800
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> Could you please send me your list of kernel boot parameters?  They 
> usually appear near the start of your console output.

Or just: cat /proc/cmdline

-- Steve
