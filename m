Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AC4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA55D2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA55D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeK2TyR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:54:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:1663 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbeK2TyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:54:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 00:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="254329563"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2018 00:49:38 -0800
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 29 Nov 2018 00:49:38 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 29 Nov 2018 00:49:37 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.203]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.176]) with mapi id 14.03.0415.000;
 Thu, 29 Nov 2018 16:49:35 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
CC:     "Zhang, Jun" <jun.zhang@intel.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: rcu_preempt caused oom
Thread-Topic: rcu_preempt caused oom
Thread-Index: AdSHvQIr70OYynHSTxKgLAvVXX+0Zg==
Date:   Thu, 29 Nov 2018 08:49:35 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzY5YTcxMWUtMDQ2My00Yjg4LTljOWMtZDIxZGYwYWM2NzQzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVmx3S0dJKzBOZm8yOGVmc1NxK1ZGbERNRU8wYWxrSmJGOGJ3RldXeWtlQnB5SVBsZXNSa1FoZksrR09wd2k2MyJ9
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

Hi, 
      we test on kernel 4.19.0 on android, after run more than 24 Hours monkey stress test, we see OOM on 1/10 2G memory board, the issue is not seen on the 4.14 kernel.
we have done some debugs:
1. OOM is due to the filp consume too many memory: 300M vs 2G board.
2. with the 120s hung task detect, most of the tasks will block at __wait_rcu_gp: wait_for_completion(&rs_array[i].completion);
[47571.863839] Kernel panic - not syncing: hung_task: blocked tasks
[47571.875446] CPU: 1 PID: 13626 Comm: FinalizerDaemon Tainted: G     U     O      4.19.0-quilt-2e5dc0ac-gf3f313245eb6 #1
[47571.887603] Call Trace:
[47571.890547]  dump_stack+0x70/0xa5
[47571.894456]  panic+0xe3/0x241
[47571.897977]  ? wait_for_completion_timeout+0x72/0x1b0
[47571.903830]  __wait_rcu_gp+0x17b/0x180
[47571.908226]  synchronize_rcu.part.76+0x38/0x50
[47571.913393]  ? __call_rcu.constprop.79+0x3a0/0x3a0
[47571.918948]  ? __bpf_trace_rcu_invoke_callback+0x10/0x10
[47571.925094]  synchronize_rcu+0x43/0x50
[47571.929487]  evdev_detach_client+0x59/0x60
[47571.934264]  evdev_release+0x4e/0xd0
[47571.938464]  __fput+0xfa/0x1f0
[47571.942072]  ____fput+0xe/0x10
[47571.945683]  task_work_run+0x90/0xc0
[47571.949884]  exit_to_usermode_loop+0x9f/0xb0
[47571.954855]  do_syscall_64+0xfa/0x110
[47571.959151]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
3. after enable the rcu trace, we don't see rcu_quiescent_state_report trace in a long time, we see rcu_callback: rcu_preempt will never response with the rcu_invoke_callback.
[47572.040668]      ps-12388   1d..1 47566097572us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
[47572.040707]      ps-12388   1d... 47566097621us : rcu_callback: rcu_preempt rhp=00000000783a728b func=file_free_rcu 4354/82824
[47572.040734]      ps-12388   1d..1 47566097622us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf
[47572.040756]      ps-12388   1d..1 47566097623us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Prestarted
[47572.040778]      ps-12388   1d..1 47566097623us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
[47572.040802]      ps-12388   1d... 47566097674us : rcu_callback: rcu_preempt rhp=0000000042c76521 func=file_free_rcu 4354/82825
[47572.040824]      ps-12388   1d..1 47566097676us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf
[47572.040847]      ps-12388   1d..1 47566097676us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Prestarted
[47572.040868]      ps-12388   1d..1 47566097676us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
[47572.040895]      ps-12388   1d..1 47566097716us : rcu_callback: rcu_preempt rhp=000000005e40fde2 func=avc_node_free 4354/82826
[47572.040919]      ps-12388   1d..1 47566097735us : rcu_callback: rcu_preempt rhp=00000000f80fe353 func=avc_node_free 4354/82827
[47572.040943]      ps-12388   1d..1 47566097758us : rcu_callback: rcu_preempt rhp=000000007486f400 func=avc_node_free 4354/82828
[47572.040967]      ps-12388   1d..1 47566097760us : rcu_callback: rcu_preempt rhp=00000000b87872a8 func=avc_node_free 4354/82829
[47572.040990]      ps-12388   1d... 47566097789us : rcu_callback: rcu_preempt rhp=000000008c656343 func=file_free_rcu 4354/82830
[47572.041013]      ps-12388   1d..1 47566097790us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf
[47572.041036]      ps-12388   1d..1 47566097790us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Prestarted
[47572.041057]      ps-12388   1d..1 47566097791us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
[47572.041081]      ps-12388   1d... 47566097871us : rcu_callback: rcu_preempt rhp=000000007e6c898c func=file_free_rcu 4354/82831
[47572.041103]      ps-12388   1d..1 47566097872us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf
[47572.041126]      ps-12388   1d..1 47566097872us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Prestarted
[47572.041147]      ps-12388   1d..1 47566097873us : rcu_grace_period: rcu_preempt 23716088 AccWaitCB
[47572.041170]      ps-12388   1d... 47566097945us : rcu_callback: rcu_preempt rhp=0000000032f4f174 func=file_free_rcu 4354/82832
[47572.041193]      ps-12388   1d..1 47566097946us : rcu_future_grace_period: rcu_preempt 23716088 23716092 0 0 3 Startleaf

Do you have any suggestions to debug the issue?
