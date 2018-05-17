Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeEQUmz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:42:55 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34966 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeEQUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:42:53 -0400
Date: Thu, 17 May 2018 16:42:52 -0400 (EDT)
Message-Id: <20180517.164252.466789510812778167.davem@davemloft.net>
To: mmullins@fb.com
Cc: netdev@vger.kernel.org, davejwatson@fb.com,
        linux-kernel@vger.kernel.org, aviadye@mellanox.com, doronrk@fb.com
Subject: Re: [PATCH net] tls: don't use stack memory in a scatterlist
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526588924.24138.2.camel@fb.com>
References: <20180516174841.2119-1-mmullins@fb.com>
        <20180517.145056.1635507477734784563.davem@davemloft.net>
        <1526588924.24138.2.camel@fb.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mullins <mmullins@fb.com>
Date: Thu, 17 May 2018 20:28:46 +0000

> On Thu, 2018-05-17 at 14:50 -0400, David Miller wrote:
>> I'm surprised this problem wasn't discovered sooner.  How exactly did you
>> discover it?  Did you actually see it trigger or is this purely from code
>> inspection?
> 
> Honestly, I'm not sure how it got uncovered, but it was observed at
> runtime.  Doron Roberts-Kedes hit a null pointer dereference so we
> turned on CONFIG_DEBUG_SG -- then it became a proper
> BUG_ON(!virt_addr_valid(buf)); in sg_set_buf.

Fair enough, thanks for the info.
