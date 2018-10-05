Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9799DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CE42084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CE42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeJELuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:50:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeJELuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:50:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BB5C7147F1FAC;
        Thu,  4 Oct 2018 21:53:06 -0700 (PDT)
Date:   Thu, 04 Oct 2018 21:53:06 -0700 (PDT)
Message-Id: <20181004.215306.257567278871187581.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, lists@wiesinger.com, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: Keep CPU port as tagged in all VLANs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181005032413.8866-1-f.fainelli@gmail.com>
References: <20181005032413.8866-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Oct 2018 21:53:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu,  4 Oct 2018 20:24:13 -0700

> Commit c499696e7901 ("net: dsa: b53: Stop using dev->cpu_port
> incorrectly") was a bit too trigger happy in removing the CPU port from
> the VLAN membership because we rely on DSA to program the CPU port VLAN,
> which it does, except it does not bother itself with tagged/untagged and
> just usese untagged.
> 
> Having the CPU port "follow" the user ports tagged/untagged is not great
> and does not allow for properly differentiating, so keep the CPU port
> tagged in all VLANs.
> 
> Reported-by: Gerhard Wiesinger <lists@wiesinger.com>
> Fixes: c499696e7901 ("net: dsa: b53: Stop using dev->cpu_port incorrectly")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.
