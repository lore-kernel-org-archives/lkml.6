Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43DEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9848E20C10
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9848E20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeHPWkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:40:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32902 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbeHPWkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:40:21 -0400
Received: from localhost (unknown [205.153.50.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 357B6145D1806;
        Thu, 16 Aug 2018 12:39:59 -0700 (PDT)
Date:   Thu, 16 Aug 2018 12:39:58 -0700 (PDT)
Message-Id: <20180816.123958.750435252621963789.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     jian-hong@endlessm.com, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
From:   David Miller <davem@davemloft.net>
In-Reply-To: <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
References: <20180815062110.16155-1-jian-hong@endlessm.com>
        <20180816.122131.604270853620318143.davem@davemloft.net>
        <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Aug 2018 12:39:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Thu, 16 Aug 2018 21:37:31 +0200

> On 16.08.2018 21:21, David Miller wrote:
>> From: <jian-hong@endlessm.com>
>> Date: Wed, 15 Aug 2018 14:21:10 +0800
>> 
>>> Found the ethernet network on ASUS X441UAR doesn't come back on resume
>>> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
>> 
>> Heiner, please take a look at this.
>> 
>> You recently disabled MSI-X on RTL8168g for similar reasons.
>> 
>> Now that we've seen two chips like this, maybe there is some other
>> problem afoot.
>> 
> Thanks for the hint. I saw it already and just contacted Realtek
> whether they are aware of any MSI-X issues with particular chip
> versions. With the chip versions I have access to MSI-X works fine.
> 
> There's also the theoretical option that the issues are caused by
> broken BIOS's. But so far only chip versions have been reported
> which are very similar, at least with regard to version number
> (2x VER_40, 1x VER_39). So they may share some buggy component.
> 
> Let's see whether Realtek can provide some hint.
> If more chip versions are reported having problems with MSI-X,
> then we could switch to a whitelist or disable MSI-X in general.

It could be that we need to reprogram some register(s) on resume,
which normally might not be needed, and that is what is causing the
problem with some chips.
