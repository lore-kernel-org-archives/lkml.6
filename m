Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F0FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D7F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D7F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeLJF6N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:58:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:32798 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeLJF6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:58:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2018 21:58:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="100259592"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2018 21:58:11 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 9 Dec 2018 21:58:08 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.201]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.203]) with mapi id 14.03.0415.000;
 Mon, 10 Dec 2018 13:58:03 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Thread-Topic: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Thread-Index: AdSQSf5rRH8ZTwaTR0Kl+UXxB6vgiP//fUMA//93HeA=
Date:   Mon, 10 Dec 2018 05:58:02 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
 <20181210054622.GA6291@jagdpanzerIV>
In-Reply-To: <20181210054622.GA6291@jagdpanzerIV>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjMzZjUyOGEtYmI4Yy00NjM0LTg1OGMtNjc5MDUyODJmNjMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic3BKZit5NEx3dUpzVWhjYlZ6YkpGSTRcL0pNM1NZSUV5eUdldFdXWjhWdmZJdHIrbStNblg5bzU4R0ZYMjA0MHUifQ==
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



> -----Original Message-----
> From: Sergey Senozhatsky [mailto:sergey.senozhatsky.work@gmail.com]
> Sent: Monday, December 10, 2018 1:46 PM
> To: Liu, Chuansheng <chuansheng.liu@intel.com>
> Cc: akpm@linux-foundation.org; pmladek@suse.com;
> sergey.senozhatsky@gmail.com; rostedt@goodmis.org; dvyukov@google.com;
> penguin-kernel@I-love.SAKURA.ne.jp; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
> 
> On (12/10/18 05:40), Liu, Chuansheng wrote:
> > @@ -130,6 +130,13 @@ static void check_hung_task(struct task_struct *t,
> unsigned long timeout)
> >                         init_utsname()->version);
> >                 pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
> >                         " disables this message.\n");
> > +               /* When sysctl_hung_task_panic is set, we have to force
> > +                * ignore_loglevel to get really useful hung task
> > +                * information.
> > +                */
> > +               if (sysctl_hung_task_panic && !ignore_loglevel)
> > +                       ignore_loglevel = true;
> 
> 		console_verbose()?

Thanks Sergey, it is really my need. I will prepare for a new version of patch:)
