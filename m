Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5694C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC3320873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC3320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeG2VsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:48:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44464 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeG2VsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:48:02 -0400
Received: from localhost (c-73-37-107-99.hsd1.or.comcast.net [73.37.107.99])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9233113E47D63;
        Sun, 29 Jul 2018 13:16:21 -0700 (PDT)
Date:   Sun, 29 Jul 2018 13:16:21 -0700 (PDT)
Message-Id: <20180729.131621.773833672945325604.davem@davemloft.net>
To:     sean.wang@mediatek.com
Cc:     john@phrozen.org, nbd@openwrt.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net-next: mediatek: cleanup unnecessary
 get chip id and its user
From:   David Miller <davem@davemloft.net>
In-Reply-To: <d4fa77f13190aefa5cf3f609a3ae555aeef38259.1532755541.git.sean.wang@mediatek.com>
References: <658dfd485c035cdae5452bc5d572125076b47a48.1532755541.git.sean.wang@mediatek.com>
        <d4fa77f13190aefa5cf3f609a3ae555aeef38259.1532755541.git.sean.wang@mediatek.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Jul 2018 13:16:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <sean.wang@mediatek.com>
Date: Sat, 28 Jul 2018 13:35:56 +0800

> From: Sean Wang <sean.wang@mediatek.com>
> 
> Since driver is devicetree-based, all device type and charateristic can be
> determined by the compatible string and its data. It's unnecessary to
> create another dependent function to check chip ID and then decide whether
> the specific funciton is being supported on a certain device. It can be
> totally replaced by the existing flag, so a cleanup is made by removing
> the function and the only user, HWLRO.
> 
> MT2701 also have a missing HWLRO support in old code, so add it the same
> patch.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Applied.
