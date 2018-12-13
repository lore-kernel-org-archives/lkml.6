Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCFAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815F920811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815F920811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLMBzJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:55:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:57284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbeLMBzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:55:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 17:55:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="101117969"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2018 17:55:07 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Dec 2018 17:55:07 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Dec 2018 17:55:07 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.201]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.203]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 09:53:52 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Thread-Topic: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Thread-Index: AdSQSf5rRH8ZTwaTR0Kl+UXxB6vgiP//fUMA//93HeCAAJABgIAAP2cA//572zCAAxdpgP/+fODAAGM4r4D//nT1YA==
Date:   Thu, 13 Dec 2018 01:53:51 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A6015B695@SHSMSX101.ccr.corp.intel.com>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
 <20181210054622.GA6291@jagdpanzerIV>
 <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
 <20181210061151.GA28533@jagdpanzerIV>
 <f6e39c8f-2ca2-4a01-cf42-9ed3bc2462a8@i-love.sakura.ne.jp>
 <27240C0AC20F114CBF8149A2696CBE4A6015ABB6@SHSMSX101.ccr.corp.intel.com>
 <77864d48-ce55-a699-ee6e-60d9ec36e305@i-love.sakura.ne.jp>
 <27240C0AC20F114CBF8149A2696CBE4A6015B06E@SHSMSX101.ccr.corp.intel.com>
 <20181212101732.5kayilcr7ww5cyu5@pathway.suse.cz>
In-Reply-To: <20181212101732.5kayilcr7ww5cyu5@pathway.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTI5NmNhMGMtMzY2ZS00YjQxLWFlMGQtMmQ4ZjE3MmFjMWE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic3FYQTNIZDVrSE5WN0M1ejd6VVZhXC9GcjhcL0p2d1czSVwvRGVCbTVpK0twa2JERjFFZXFlcGRycjF1NFhFR2FlOSJ9
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
> From: Petr Mladek [mailto:pmladek@suse.com]
> Sent: Wednesday, December 12, 2018 6:18 PM
> To: Liu, Chuansheng <chuansheng.liu@intel.com>
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>; Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com>; akpm@linux-foundation.org;
> sergey.senozhatsky@gmail.com; rostedt@goodmis.org; dvyukov@google.com;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
> 
> On Wed 2018-12-12 01:16:11, Liu, Chuansheng wrote:
> >
> >
> > > -----Original Message-----
> > > From: Tetsuo Handa [mailto:penguin-kernel@i-love.sakura.ne.jp]
> > > Sent: Tuesday, December 11, 2018 6:02 PM
> > > To: Liu, Chuansheng <chuansheng.liu@intel.com>; Sergey Senozhatsky
> > > <sergey.senozhatsky.work@gmail.com>
> > > Cc: akpm@linux-foundation.org; pmladek@suse.com;
> > > sergey.senozhatsky@gmail.com; rostedt@goodmis.org;
> dvyukov@google.com;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
> > >
> > > On 2018/12/11 10:16, Liu, Chuansheng wrote:
> > > > We may enhance it by:
> > > > -       if (sysctl_hung_task_warnings) {
> > > > +       if (sysctl_hung_task_panic || sysctl_hung_task_warnings) {
> > > >                 if (sysctl_hung_task_warnings > 0)
> > > >                         sysctl_hung_task_warnings--;
> > >
> > > Why ignore sysctl_hung_task_warnings? The administrator can already
> > > configure as sysctl_hung_task_warnings == -1 && sysctl_hung_task_panic
> == 1
> > > if he/she does not want to suppress neither sched_show_task() nor
> > > debug_show_all_locks()/trigger_all_cpu_backtrace(). Someone might want
> that
> > > sysctl_hung_task_warnings == 0 (which is a request to suppress only
> > > sched_show_task()) should not be ignored by sysctl_hung_task_panic == 1
> > > (which is a request to trigger panic).
> >
> >
> > My complete idea is in patch V1 which has been sent. Paste here:
> > If sysctl_hung_task_panic == 1, I will force sched_show_task(t) and set
> > hung_task_call_panic = true
> > hung_task_show_lock = true
> 
> Please, do not mix two changes into one patch.
Thanks your suggestion.

> 
> Add console_verbose() in one patch. It is simple and
> everyone has agreed with it so far.
Has sent it out, please help review.

> 
> Force sched_show_task() when hung_task_call_panic == 1 in
> another patch. It seems to be controversial and should be
> discussed/changed separately.
I found some other points also, and will send out patches later.

