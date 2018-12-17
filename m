Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC45C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F2920874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbeLQOOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:14:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:11513 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732120AbeLQOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:14:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 06:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="260130501"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.251.10.185]) ([10.251.10.185])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2018 06:14:13 -0800
Subject: Re: WARNING in __rcu_read_unlock
To:     paulmck@linux.ibm.com, Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>
References: <0000000000005e47a2057d0edc49@google.com>
 <20181216190412.GE4170@linux.ibm.com>
 <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
 <20181217112916.GG4170@linux.ibm.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
Date:   Mon, 17 Dec 2018 06:14:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181217112916.GG4170@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/2018 3:29 AM, Paul E. McKenney wrote:
> As does this sort of report on a line that contains simple integer
> arithmetic and boolean operations.;-)
> 
> Any chance of a bisection?

btw this looks like something caused a stack overflow and thus all the weirdness that then happens

