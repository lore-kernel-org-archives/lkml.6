Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A9B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfBNAdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:33:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46652 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfBNAdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:33:12 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8B25314CEC644;
        Wed, 13 Feb 2019 16:33:11 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:33:09 -0800 (PST)
Message-Id: <20190213.163309.1448482672803486233.davem@davemloft.net>
To:     lucien.xin@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com
Subject: Re: [PATCH net] sctp: call gso_reset_checksum when computing
 checksum in sctp_gso_segment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5b8187d1eabd52e4db7d3e4506d98c33571c1c83.1549968450.git.lucien.xin@gmail.com>
References: <5b8187d1eabd52e4db7d3e4506d98c33571c1c83.1549968450.git.lucien.xin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 Feb 2019 16:33:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 12 Feb 2019 18:47:30 +0800

> Jianlin reported a panic when running sctp gso over gre over vlan device:
 ...
> It was caused by SKB_GSO_CB(skb)->csum_start not set in sctp_gso_segment.
> sctp_gso_segment() calls skb_segment() with 'feature | NETIF_F_HW_CSUM',
> which causes SKB_GSO_CB(skb)->csum_start not to be set in skb_segment().
> 
> For TCP/UDP, when feature supports HW_CSUM, CHECKSUM_PARTIAL will be set
> and gso_reset_checksum will be called to set SKB_GSO_CB(skb)->csum_start.
> 
> So SCTP should do the same as TCP/UDP, to call gso_reset_checksum() when
> computing checksum in sctp_gso_segment.
> 
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Applied and queued up for -stable, thanks.
