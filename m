Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7353C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9D120661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9D120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeH3GI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:08:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39672 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3GI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:08:28 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3AF2F108F43BB;
        Wed, 29 Aug 2018 19:08:43 -0700 (PDT)
Date:   Wed, 29 Aug 2018 19:08:39 -0700 (PDT)
Message-Id: <20180829.190839.1082082323658260994.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        netdev@vger.kernel.org, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, vkuznets@redhat.com,
        marcelo.cerri@canonical.com, jopoulso@microsoft.com
Subject: Re: [PATCH] hv_netvsc: Fix a deadlock by getting rtnl_lock earlier
 in netvsc_probe()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <PU1P153MB016903725D5E8EF56C07FF69BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01692432D92B3A726FBDDC68BF300@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
        <20180829.174841.833303774555397982.davem@davemloft.net>
        <PU1P153MB016903725D5E8EF56C07FF69BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Aug 2018 19:08:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Thu, 30 Aug 2018 00:58:48 +0000

>> From: David Miller <davem@davemloft.net>
>> Sent: Wednesday, August 29, 2018 17:49
>> 
>> From: Dexuan Cui <decui@microsoft.com>
>> Date: Wed, 22 Aug 2018 21:20:03 +0000
>> 
>> > ---
>> >  drivers/net/hyperv/netvsc_drv.c | 11 ++++++++++-
>> >  1 file changed, 10 insertions(+), 1 deletion(-)
>> >
>> >
>> > FYI: these are the related 3 paths which show the deadlock:
>> 
>> This incredibly useful information belongs in the commit log
>> message, and therefore before the --- and signoffs.
> 
> Hi David,
> I was afraid the call-traces are too detailed. :-)
> 
> Can you please move the info to before the --- line?
> 
> Or, should I resend the patch with the commit log updated?

Please resend.
