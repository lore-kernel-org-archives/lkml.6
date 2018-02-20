Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeBTK4u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:56:50 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:41535 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeBTK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:56:49 -0500
Date: Tue, 20 Feb 2018 16:26:14 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        davem@davemloft.net, ganeshgr@chelsio.com, nirranjan@chelsio.com,
        indranil@chelsio.com, rahul.lakkireddy@chelsio.com
Subject: Appending firmware/hardware dump to vmcore during kernel panic
Message-ID: <20180220105613.GA9766@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have a requirement to collect firmware/hardware state of the
underlying NIC during kernel panic.  We are doing this in cxgb4
driver, using panic notifier list [1].  cxgb4 registers a callback
function to the panic notifier list, which gets invoked during kernel
panic. In the callback function, firmware/hardware dump is collected
into pre-allocated buffer and then extracted later from the vmcore,
for post-analysis.

Is this approach of using panic notifier correct?  Any suggestions are
much appreciated.

Thanks,
Rahul

[1] https://patchwork.ozlabs.org/patch/873830/
