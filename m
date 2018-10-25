Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9FDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2979D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2979D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJZDIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:08:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56220 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeJZDIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:08:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B92751478ADB8;
        Thu, 25 Oct 2018 11:34:41 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:34:41 -0700 (PDT)
Message-Id: <20181025.113441.567599603045046210.davem@davemloft.net>
To:     ivan.khoronzhuk@linaro.org
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@intel.com, bjorn@mork.no
Subject: Re: [PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
References: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Oct 2018 11:34:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Thu, 25 Oct 2018 01:10:55 +0300

> The cpsw holds separate mcast entires for vlan entries. At this moment
> driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
> As result mcast for vlans doesn't work. It can be fixed by adding same
> mcast entries for every created vlan, but this patchseries uses more
> sophisticated way and allows to create mcast entries only for vlans
> that really require it. Generic functions from this series can be
> reused for fixing vlan and macvlan unicast.

This is a bug fix but targetted at net-next, and indeed it is quite
invasive as it adds new core infrastructure and converts the generic
vlan code over to using it.

Unfortunately net-next is closed.

So if you want this bug fixed in mainline you will have to come up
with a less invasive fix, and resubmit this net-next approach when the
net-next tree opens back up.

Thank you.
