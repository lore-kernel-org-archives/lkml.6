Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFAEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF960208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF960208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeHWIIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:08:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41586 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbeHWIIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:08:37 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0A040100A2013;
        Wed, 22 Aug 2018 21:40:50 -0700 (PDT)
Date:   Wed, 22 Aug 2018 21:40:50 -0700 (PDT)
Message-Id: <20180822.214050.1461943848445235396.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        jakub.kicinski@netronome.com, simon.horman@netronome.com,
        nogahf@mellanox.com, aring@mojatatu.com, john.hurley@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net_sched: fix unused variable warning in stmmac
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180822152608.4173947-1-arnd@arndb.de>
References: <20180822152608.4173947-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 Aug 2018 21:40:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Aug 2018 17:25:44 +0200

> The new tcf_exts_for_each_action() macro doesn't reference its
> arguments when CONFIG_NET_CLS_ACT is disabled, which leads to
> a harmless warning in at least one driver:
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: In function 'tc_fill_actions':
> drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:64:6: error: unused variable 'i' [-Werror=unused-variable]
> 
> Adding a cast to void lets us avoid this kind of warning.
> To be on the safe side, do it for all three arguments, not
> just the one that caused the warning.
> 
> Fixes: 244cd96adb5f ("net_sched: remove list_head from tc_action")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
