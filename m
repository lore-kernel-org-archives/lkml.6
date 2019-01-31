Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D847AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A914620881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfAaUj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:39:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:6796 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfAaUj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:39:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 12:39:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="112731526"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2019 12:39:27 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C0CE8301201; Thu, 31 Jan 2019 12:39:27 -0800 (PST)
Date:   Thu, 31 Jan 2019 12:39:27 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        eranian@google.com, vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Message-ID: <20190131203927.GY6118@tassilo.jf.intel.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190125160056.GG6118@tassilo.jf.intel.com>
 <CAM_iQpVtyCR=BTBkpDtbEFJ8REczpvYRTGPQnBsV=8rznXn6fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpVtyCR=BTBkpDtbEFJ8REczpvYRTGPQnBsV=8rznXn6fg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, a loop stuck looks really scary inside an NMI handler.
> Should I just go ahead to send a patch to remove this warning?
> Or probably turn it into a pr_info()?

Not at this point. Would need to fix the PMU reset first to be
more selective. 

-Andi
