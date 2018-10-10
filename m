Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB958C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD7420645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD7420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeJKAtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:49:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40254 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeJKAtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:49:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6655914766F0B;
        Wed, 10 Oct 2018 10:26:06 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:26:05 -0700 (PDT)
Message-Id: <20181010.102605.1416485422281413445.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     antoine.tenart@bootlin.com, andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: Re: [PATCH net-next] net: mscc: allow extracting the FCS into the
 skb
From:   David Miller <davem@davemloft.net>
In-Reply-To: <28179B83-2C71-47FA-9D9C-49237E4A07AE@gmail.com>
References: <20181002124323.GC9155@lunn.ch>
        <20181010144631.GE3368@kwain>
        <28179B83-2C71-47FA-9D9C-49237E4A07AE@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Oct 2018 10:26:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 10 Oct 2018 09:25:01 -0700

> 
> 
> On October 10, 2018 7:46:31 AM PDT, Antoine Tenart <antoine.tenart@bootlin.com> wrote:
>>Hi all,
>>
>>On Tue, Oct 02, 2018 at 02:43:23PM +0200, Andrew Lunn wrote:
>>> > The question could be "do we need len += ETH_FCS_LEN" to account
>>for the
>>> > FCS when NETIF_F_RXFCS is used", but I looked at other drivers and
>>it
>>> > seemed to me the FCS is not accounted in the stats. Should it be?
>>> 
>>> There does not appear to be a good answer to that. I submitted a
>>patch
>>> to a driver i'm using to not count it, so that the stats counters we
>>> consistent with another driver. The patch was rejected.
>>> 
>>> I think the best you can do is flip a coin, and then document it
>>using
>>> a comment about if it is/is not included.
>>
>>I'll leave it as-is then :)
>>
>>@Dave, Florian: it seems to me no modification was requested after
>>discussing those changes. Where do we stand regarding the patch?
> 
> Silence means agreement, thanks for your explanation, no more questions or concerns on my side.

You'll probably need to resubmit the patch anew though.
