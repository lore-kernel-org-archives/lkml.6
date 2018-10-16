Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE5EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2C2205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2C2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJQApf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:45:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeJQApf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:45:35 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C6C512DE580D;
        Tue, 16 Oct 2018 09:54:17 -0700 (PDT)
Date:   Tue, 16 Oct 2018 09:54:14 -0700 (PDT)
Message-Id: <20181016.095414.697502448536323380.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     quentin.schulz@bootlin.com, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com
Subject: Re: [PATCH net-next v2 2/2] net: phy: mscc: fix memory leak in
 vsc8574_config_pre_init
From:   David Miller <davem@davemloft.net>
In-Reply-To: <e64b93c2-4f25-ee68-ef23-e947f1e84d55@embeddedor.com>
References: <6161326e265a99f8ec8e0f7028790a0131c5404e.1539159556.git.gustavo@embeddedor.com>
        <20181010083422.phokcciqdkzm6u7w@qschulz>
        <e64b93c2-4f25-ee68-ef23-e947f1e84d55@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Oct 2018 09:54:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 16 Oct 2018 10:49:36 +0200

> Hi,
> 
> On 10/10/18 10:34 AM, Quentin Schulz wrote:
>> Hi Gustavo,
>> 
>> On Wed, Oct 10, 2018 at 10:31:39AM +0200, Gustavo A. R. Silva wrote:
>>> In case memory resources for *fw* were successfully allocated,
>>> release them before return.
>>>
>>> Addresses-Coverity-ID: 1473968 ("Resource leak")
>>> Fixes: 00d70d8e0e78 ("net: phy: mscc: add support for VSC8574 PHY")
>> 
>> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
>> 
> 
> Friendly ping. Dave, can you take this?

It needs to be posted properly to netdev, just like all networking
patches do.
