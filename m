Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114EDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0A620861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfAVDcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:32:15 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:13033 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbfAVDcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:32:14 -0500
X-IronPort-AV: E=Sophos;i="5.56,504,1539619200"; 
   d="scan'208";a="52542904"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Jan 2019 11:32:13 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 39BF14C4A89A;
        Tue, 22 Jan 2019 11:32:11 +0800 (CST)
Received: from [10.167.226.222] (10.167.226.222) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 22 Jan 2019 11:32:12 +0800
To:     <linux-kernel@vger.kernel.org>
CC:     <paulmck@linux.ibm.com>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, "Li, Philip" <philip.li@intel.com>,
        <lkp-developer@eclists.intel.com>
From:   Su Yue <suy.fnst@cn.fujitsu.com>
Subject: rcutorture: meaning of "End of test: RCU_HOTPLUG"
Message-ID: <996df745-8434-b92c-bad9-334cc6bf4b7f@cn.fujitsu.com>
Date:   Tue, 22 Jan 2019 11:40:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.222]
X-yoursite-MailScanner-ID: 39BF14C4A89A.ABCC3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suy.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys
   While running rcutorture tests with "onoff_interval", some tests
failed and results show like:

=====================================================================
[  316.354501] srcud-torture:--- End of test: RCU_HOTPLUG: nreaders=1 
nfakewriters=4 stat_interval=60 verbose=2 test_no_idle_hz=1 
shuffle_interval=3 stutter=5 irqreader=1 fq\
s_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 
test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 
stall_cpu_holdoff=10 stall_cpu_irqsoff=0 n_ba\
rrier_cbs=0 onoff_interval=3 onoff_holdoff=0
====================================================================

I am wondering that meaning of "RCU_HOTPLUG". Is it expected because
cpu hotplug is enabled in the test? Or just represents another type of
failure?

Thanks,
Su


