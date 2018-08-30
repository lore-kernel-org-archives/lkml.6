Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CFEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB46420644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB46420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeH3FIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:08:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39256 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeH3FIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:08:13 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 010F7108F4390;
        Wed, 29 Aug 2018 18:08:39 -0700 (PDT)
Date:   Wed, 29 Aug 2018 18:08:39 -0700 (PDT)
Message-Id: <20180829.180839.1488343012807365399.davem@davemloft.net>
To:     lipeng321@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com
Subject: Re: [PATCH V2 net 0/2] net: hns: fix some bugs about speed and
 duplex change
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1535335170-111030-1-git-send-email-lipeng321@huawei.com>
References: <1535335170-111030-1-git-send-email-lipeng321@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Aug 2018 18:08:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>
Date: Mon, 27 Aug 2018 09:59:28 +0800

> If there are packets in hardware when changing the spped
> or duplex, it may cause hardware hang up.
> 
> This patchset adds the code for waiting chip to clean the all
> pkts(TX & RX) in chip when the driver uses the function named
> "adjust link".
> 
> This patchset cleans the pkts as follows:
> 1) close rx of chip, close tx of protocol stack.
> 2) wait rcb, ppe, mac to clean.
> 3) adjust link
> 4) open rx of chip, open tx of protocol stack.

Series applied, thank you.
