Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbeE2EeY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:34:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:54448 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeE2EeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:34:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,455,1520924400";
   d="scan'208";a="59895285"
From: "Lu, Aaron" <aaron.lu@intel.com>
To: "mhocko@kernel.org" <mhocko@kernel.org>,
        "Ye, Xiaolong" <xiaolong.ye@intel.com>
CC: "tj@kernel.org" <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@01.org" <lkp@01.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>
Subject: Re: [LKP] [lkp-robot] [mm, memcontrol] 309fe96bfc:
 vm-scalability.throughput +23.0% improvement
Thread-Topic: [LKP] [lkp-robot] [mm, memcontrol] 309fe96bfc:
 vm-scalability.throughput +23.0% improvement
Thread-Index: AQHT9nk1DFpK5n5lQ0aJAjUphuX/f6REhKwAgAD+9QA=
Date: Tue, 29 May 2018 03:15:51 +0000
Message-ID: <dbd727326f53648ed114e03a85085b6b4655fda2.camel@intel.com>
References: <20180528114019.GF9904@yexl-desktop>
         <20180528120318.GB27180@dhcp22.suse.cz>
In-Reply-To: <20180528120318.GB27180@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.159.135]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AB02E2F7091CD47ADF1DC6B3598E1CD@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4T4YZpE023400

On Mon, 2018-05-28 at 14:03 +0200, Michal Hocko wrote:
> On Mon 28-05-18 19:40:19, kernel test robot wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed a +23.0% improvement of vm-scalability.throughput due to commit:
> > 
> > 
> > commit: 309fe96bfc0ae387f53612927a8f0dc3eb056efd ("mm, memcontrol: implement memory.swap.events")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> This doesn't make any sense to me. The patch merely adds an accounting.
> It doesn't optimize anything. So I strongly suspect the result is just
> misleading or the test (environment) misconfigured. Not the first time
> I am seeing something like that I am afraid.
> 

Most likely the same situation as:
"
FYI, we noticed a -27.2% regression of will-it-scale.per_process_ops
due to commit:


commit: e27be240df53f1a20c659168e722b5d9f16cc7f4 ("mm: memcg: make sure
memory.events is uptodate when waking pollers")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
"

Where the performance change is due to layout change of
'struct mem_cgroup':
http://lkml.kernel.org/r/20180528085201.GA2918@intel.com
