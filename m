Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2333BC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F4F2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F4F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLCXNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:13:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49342 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeLCXM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:12:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C3ECB12F7A9EF;
        Mon,  3 Dec 2018 15:12:57 -0800 (PST)
Date:   Mon, 03 Dec 2018 15:12:53 -0800 (PST)
Message-Id: <20181203.151253.1348214769326219632.davem@davemloft.net>
To:     jakub.kicinski@netronome.com
Cc:     salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        lipeng321@huawei.com, mehta.salil@opnsrc.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, liuzhongzhu@huawei.com, jiri@resnulli.us,
        f.fainelli@gmail.com
Subject: Re: [RFC net-next 3/9] net: hns3: Add "port vlan table"
 information query function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181203151222.6e56efcd@cakuba.netronome.com>
References: <20181202230933.15560-1-salil.mehta@huawei.com>
        <20181202230933.15560-4-salil.mehta@huawei.com>
        <20181203151222.6e56efcd@cakuba.netronome.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Dec 2018 15:12:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Mon, 3 Dec 2018 15:12:22 -0800

> On Sun, 2 Dec 2018 23:09:27 +0000, Salil Mehta wrote:
>> From: liuzhongzhu <liuzhongzhu@huawei.com>
>> 
>> This patch prints port vlan table information.
>> 
>> debugfs command:
>> echo dump port vlan tbl > cmd
>> 
>> Sample Command:
>> root@(none)# echo dump port vlan tbl > cmd
>>  vlan | port filter bitMap:
>>  0000 | 00000000:00000000:00000000:00000000:00000000:00000001
>> root@(none)#
>> 
>> Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> 
> Adding debugfs files for basic switch concepts like MAC and VLAN tables
> seems like a bit of a stretch to me.  I wonder what others think.

Agreed.
