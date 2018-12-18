Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5245EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDB1214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeLRAIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:08:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:30032 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbeLRAIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:08:01 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 16:08:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="99489609"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2018 16:08:00 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9A836300B49; Mon, 17 Dec 2018 16:08:00 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:08:00 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
Message-ID: <20181218000800.GB25620@tassilo.jf.intel.com>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20181217225020.GA16520@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217225020.GA16520@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:50:20PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 20, 2018 at 10:59:47PM +0100, Arnd Bergmann wrote:
> > Hi Nico, all,
> > 
> > I was playing with ARM link-time optimization handling earlier this
> > month, and eventually got it to build cleanly with randconfig kernels,
> > but ended up with a lot of ugly hacks to actually pull it off.
> 
> How are we dealing with the fact that LTO can break RCU in very subtle
> and scary ways?
> 
> Do we have a compiler guy on board that has given us a compiler switch
> that kills that optimization (and thereby guarantees that behaviour for
> future compilers etc..) ?

Can you actually define what optimization you are worred about?

If there are optimizations that cause problems they likely happen
even without LTO inside files. The only difference with LTO is that it
does them between files too.

-Andi
