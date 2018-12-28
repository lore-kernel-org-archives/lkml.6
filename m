Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B44DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B62218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbeL1BbS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:31:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:55625 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeL1BbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:31:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 17:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,407,1539673200"; 
   d="scan'208";a="113754196"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 27 Dec 2018 17:31:16 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 27 Dec 2018 17:31:16 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 27 Dec 2018 17:31:15 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.196]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.160]) with mapi id 14.03.0415.000;
 Fri, 28 Dec 2018 09:31:12 +0800
From:   "Wang, Kemi" <kemi.wang@intel.com>
To:     Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "Davidlohr Bueso" <dave@stgolabs.net>
CC:     "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ldufour@linux.vnet.ibm.com" <ldufour@linux.vnet.ibm.com>,
        "lkp@01.org" <lkp@01.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Wang, Kemi" <kemi.wang@intel.com>
Subject: RE: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1%
 regression
Thread-Topic: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1%
 regression
Thread-Index: AQHUdMWPUnemr3UzVU6RWrhq1FnjvaVA8FWAgAAm6ACAACL3gIAABy0AgFJutVA=
Date:   Fri, 28 Dec 2018 01:31:11 +0000
Message-ID: <25017BF213203E48912DB000DE5F5E1E76365678@SHSMSX101.ccr.corp.intel.com>
References: <20181105050813.GP24195@shao2-debian>
 <CAHk-=wi8BNNTp+Xt4ROz1TqGgFT-c6-Hmmc9yW0B6p2FTFwJTg@mail.gmail.com>
 <f901e346-6203-371d-a39a-ed9231187570@suse.cz>
 <CAHk-=wjZ1C2iL79jOuC9ysvX2oRpUjoqXirvY0NRuLC0eQ8nbg@mail.gmail.com>
 <60ef3584-6f3a-1a9a-94d1-3d4a5b9f1e56@redhat.com>
In-Reply-To: <60ef3584-6f3a-1a9a-94d1-3d4a5b9f1e56@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDdmOTVlZDAtYzcwNi00YmE1LTllNDktZjA2ZTZmZTk3MjNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibDAwbHBQWUVPcGs3NHowRnZicTVjOHJXdjA2UDc5K002VHcxK0d2cG1USmw3bEJzbFJtZXNUQ1lxN0hUMFJYKyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Waiman
   Did you post that patch? Let's see if it helps.

-----Original Message-----
From: LKP [mailto:lkp-bounces@lists.01.org] On Behalf Of Waiman Long
Sent: Tuesday, November 6, 2018 6:40 AM
To: Linus Torvalds <torvalds@linux-foundation.org>; vbabka@suse.cz; Davidlohr Bueso <dave@stgolabs.net>
Cc: yang.shi@linux.alibaba.com; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Matthew Wilcox <willy@infradead.org>; mhocko@kernel.org; Colin King <colin.king@canonical.com>; Andrew Morton <akpm@linux-foundation.org>; ldufour@linux.vnet.ibm.com; lkp@01.org; kirill.shutemov@linux.intel.com
Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1% regression

On 11/05/2018 05:14 PM, Linus Torvalds wrote:
> On Mon, Nov 5, 2018 at 12:12 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>> I didn't spot an obvious mistake in the patch itself, so it looks
>> like some bad interaction between scheduler and the mmap downgrade?
> I'm thinking it's RWSEM_SPIN_ON_OWNER that ends up being confused by
> the downgrade.
>
> It looks like the benchmark used to be basically CPU-bound, at about
> 800% CPU, and now it's somewhere in the 200% CPU region:
>
>                   will-it-scale.time.percent_of_cpu_this_job_got
>
>   800 +-+-------------------------------------------------------------------+
>       |.+.+.+.+.+.+.+.  .+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+..+.+.+.+. .+.+.+.|
>   700 +-+             +.                                            +       |
>       |                                                                     |
>   600 +-+                                                                   |
>       |                                                                     |
>   500 +-+                                                                   |
>       |                                                                     |
>   400 +-+                                                                   |
>       |                                                                     |
>   300 +-+                                                                   |
>       |                                                                     |
>   200 O-O O O O O                O                                          |
>       |           O O O  O O O O   O O O O O O O O O O O                    |
>   100 +-+-------------------------------------------------------------------+
>
> which sounds like the downgrade really messes with the "spin waiting
> for lock" logic.
>
> I'm thinking it's the "wake up waiter" logic that has some bad
> interaction with spinning, and breaks that whole optimization.
>
> Adding Waiman and Davidlohr to the participants, because they seem to
> be the obvious experts in this area.
>
>                             Linus

Optimistic spinning on rwsem is done only on writers spinning on a
writer-owned rwsem. If a write-lock is downgraded to a read-lock, all
the spinning waiters will quit. That may explain the drop in cpu
utilization. I do have a old patch that enable a certain amount of
reader spinning which may help the situation. I can rebase that and send
it out for review if people have interest.

Cheers,
Longman


_______________________________________________
LKP mailing list
LKP@lists.01.org
https://lists.01.org/mailman/listinfo/lkp
