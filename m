Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7E2ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B572420881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B572420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeIOCaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:30:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41172 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIOCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:30:21 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AD404142A3431;
        Fri, 14 Sep 2018 14:14:06 -0700 (PDT)
Date:   Fri, 14 Sep 2018 14:14:06 -0700 (PDT)
Message-Id: <20180914.141406.2211638662965115243.davem@davemloft.net>
To:     qing.huang@oracle.com
Cc:     andrew@lunn.ch, leon@kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        tariqt@mellanox.com
Subject: Re: [PATCH] net/mlx4_core: print firmware version during driver
 loading
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c332f10a-5ad0-53fd-5111-1964443b3092@oracle.com>
References: <c580ad9d-b63d-743b-2278-1c4cf3553186@oracle.com>
        <20180914181718.GD3811@lunn.ch>
        <c332f10a-5ad0-53fd-5111-1964443b3092@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Sep 2018 14:14:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qing Huang <qing.huang@oracle.com>
Date: Fri, 14 Sep 2018 11:33:40 -0700

> 
> 
> On 9/14/2018 11:17 AM, Andrew Lunn wrote:
>> On Fri, Sep 14, 2018 at 10:15:48AM -0700, Qing Huang wrote:
>>> The FW version is actually a very crucial piece of information and
>>> only
>>> printed once here
>>> when the driver is loaded. People tend to get confused when switching
>>> multiple FW files
>>> back and forth without running separate utility tools, especially at
>>> customer sites.
>>> IMHO, this information is very useful and only takes up very little
>>> log file
>>> space. :-)
>> Why not use ethtool -i ?
>>
>> $ sudo ethtool -i eth0
>> driver: r8169
>> version: 2.3LK-NAPI
>> firmware-version: rtl8168g-2_0.0.1 02/06/13
>>
>>      Andrew
> Sure. You can also use ibstat or ibv_devinfo tool if they are
> installed. But it's not very
> convenient in some cases.
> 
> E.g.
> A customer upgrades FW on HCAs and encounters issues. During triage,
> it's much easier
> to study customer uploaded log files when remotely testing different
> FW files.

Not a valid argument.  You can print the ethtool output from initramfs
if necessary for triage.

I still stand by the fact that ethtool is the only fully reliable way
to obtain this information, the kernel log is not.
