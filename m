Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbeCMPdR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:33:17 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47540 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeCMPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:33:14 -0400
Date: Tue, 13 Mar 2018 11:33:13 -0400 (EDT)
Message-Id: <20180313.113313.629581257230548483.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: build warning after merge of the net-next tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <67db5ac6-9816-4bf1-c594-72697c426466@embeddedor.com>
References: <20180313171153.1614c11e@canb.auug.org.au>
        <67db5ac6-9816-4bf1-c594-72697c426466@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 13 Mar 2018 06:46:24 -0500

> Hi Stephen,
> 
> On 03/13/2018 01:11 AM, Stephen Rothwell wrote:
>> Hi all,
>> After merging the net-next tree, today's linux-next build (sparc
>> defconfig) produced this warning:
>> net/core/pktgen.c: In function 'pktgen_if_write':
>> net/core/pktgen.c:1710:1: warning: the frame size of 1048 bytes is
>> larger than 1024 bytes [-Wframe-larger-than=]
>>   }
>>   ^
>> Introduced by commit
>>    35951393bbff ("pktgen: Remove VLA usage")
>> 
> 
> Thanks for the report.
> 
> David:
> 
> If this code is not going to be executed very often [1], then I think
> it is safe to use dynamic memory allocation instead, as this is not
> going to impact the performance.
> 
> What do you think?
> 
> [1] https://lkml.org/lkml/2018/3/9/630

Sure, that works.

It is only invoked when pktgen configuration changes are made.
