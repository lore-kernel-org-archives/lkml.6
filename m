Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777DBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE7822360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE7822360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbeKNCxG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:53:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:30164 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeKNCxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:53:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 08:54:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="107922207"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2018 08:54:11 -0800
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.124]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.237]) with mapi id 14.03.0415.000;
 Tue, 13 Nov 2018 08:54:11 -0800
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH tip/core/rcu 13/41]
 ethernet/intel/ixgbe: Replace synchronize_sched() with synchronize_rcu()
Thread-Topic: [Intel-wired-lan] [PATCH tip/core/rcu 13/41]
 ethernet/intel/ixgbe: Replace synchronize_sched() with synchronize_rcu()
Thread-Index: AQHUeqH0Z8b0Yl1eCEigYKTs6wgVp6VN7YUw
Date:   Tue, 13 Nov 2018 16:54:10 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32A057@ORSMSX104.amr.corp.intel.com>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-13-paulmck@linux.ibm.com>
In-Reply-To: <20181111194410.6368-13-paulmck@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2Q0NzhmYTYtZTgxNC00OWZmLTkwYjktZWE0YzBjNGI0N2JlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQnFzOW1GcHJJYlcyUWZ2aDB1K1VxWFkwcTJEYzR5czI5YkJEVFh1TjM4UVhTaU5lUkdtUkpyeVFadHR4XC9YOHAifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Paul E. McKenney
> Sent: Sunday, November 11, 2018 11:44 AM
> To: linux-kernel@vger.kernel.org
> Cc: tglx@linutronix.de; David S. Miller <davem@davemloft.net>;
> peterz@infradead.org; fweisbec@gmail.com; jiangshanlai@gmail.com;
> josh@joshtriplett.org; rostedt@goodmis.org; oleg@redhat.com;
> dhowells@redhat.com; edumazet@google.com;
> mathieu.desnoyers@efficios.com; dipankar@in.ibm.com;
> joel@joelfernandes.org; intel-wired-lan@lists.osuosl.org; akpm@linux-
> foundation.org; Paul E. McKenney <paulmck@linux.ibm.com>;
> mingo@kernel.org
> Subject: [Intel-wired-lan] [PATCH tip/core/rcu 13/41] ethernet/intel/ixgbe:
> Replace synchronize_sched() with synchronize_rcu()
> 
> Now that synchronize_rcu() waits for preempt-disable regions of code as
> well as RCU read-side critical sections, synchronize_sched() can be replaced
> by synchronize_rcu().  This commit therefore makes this change.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <intel-wired-lan@lists.osuosl.org>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


