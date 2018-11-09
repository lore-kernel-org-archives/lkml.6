Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B84C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 04:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E6120855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 04:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E6120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeKIOLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 09:11:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42950 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeKIOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 09:11:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 642DD14B3DBD6;
        Thu,  8 Nov 2018 20:33:00 -0800 (PST)
Date:   Thu, 08 Nov 2018 20:32:57 -0800 (PST)
Message-Id: <20181108.203257.130600128161514091.davem@davemloft.net>
To:     ivan.khoronzhuk@linaro.org
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@intel.com, bjorn@mork.no
Subject: Re: [PATCH v2 net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
References: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Nov 2018 20:33:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Thu,  8 Nov 2018 22:27:53 +0200

> The cpsw holds separate mcast entires for vlan entries. At this moment
> driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
> As result mcast for vlans doesn't work. It can be fixed by adding same
> mcast entries for every created vlan, but this patchseries uses more
> sophisticated way and allows to create mcast entries only for vlans
> that really require it. Generic functions from this series can be
> reused for fixing vlan and macvlan unicast.
> 
> Simple example of ALE table before and after this series, having same
> mcast entries as for vlan 100 as for real device (reserved vlan 2),
> and one mcast address only for vlan 100 - 01:1b:19:00:00:00.
 ...
> Based on net-next/master
> 
> v2..v1:
>   net: ethernet: ti: cpsw: fix vlan mcast
> 	- removed limit for legacy switch cpsw mode

Series applied.
