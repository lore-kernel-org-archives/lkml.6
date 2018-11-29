Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9765C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A8E2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A8E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeK2MZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:25:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42876 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeK2MZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:25:50 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7AB9114E8EDD9;
        Wed, 28 Nov 2018 17:22:15 -0800 (PST)
Date:   Wed, 28 Nov 2018 17:22:12 -0800 (PST)
Message-Id: <20181128.172212.1033397162837638079.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     grygorii.strashko@ti.com, netdev@vger.kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181129002835.GB5037@lunn.ch>
References: <20181128220211.GA5037@lunn.ch>
        <0b70091e-3747-ee8f-15d6-4532e210278e@ti.com>
        <20181129002835.GB5037@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Nov 2018 17:22:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 29 Nov 2018 01:28:35 +0100

> On Wed, Nov 28, 2018 at 04:43:40PM -0600, Grygorii Strashko wrote:
>> Hi Andrew,
>> 
>> On 11/28/18 4:02 PM, Andrew Lunn wrote:
>> >> This is dynamic configuration related to ALE VLAN entries and
>> >> I do not see the way to support its auto-detection with current driver,
>> >> unfortunately.
>> > 
>> > I think you can subscribe to switchdev events which will tell you.
>> 
>> Thanks a lot for your review and comments.
>> 
>> Unfortunately, we still do not have switchdev in place, but i need to resolve
>> existing issue somehow. This patch is small, local to CPSW fix which can be
>> backported to stable. So, if possible, and no strong objection, could we proceed with it?
> 
> Hi Grygorii
> 
> David is the person who generally says no to kernel module
> parameters. You should ask him.

No module options.

You'll be stuck with it forever.

Sorry.
