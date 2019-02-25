Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0460C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6F520842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfBYRfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:35:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42760 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:35:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D38E014EE12A7;
        Mon, 25 Feb 2019 09:35:22 -0800 (PST)
Date:   Mon, 25 Feb 2019 09:35:20 -0800 (PST)
Message-Id: <20190225.093520.1888476051243130091.davem@davemloft.net>
To:     wen.yang99@zte.com.cn
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn
Subject: Re: [PATCH v2] net: dsa: fix a leaked reference by adding missing
 of_node_put
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1551079339-30270-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551079339-30270-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Feb 2019 09:35:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>
Date: Mon, 25 Feb 2019 15:22:19 +0800

> The call to of_parse_phandle returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./net/dsa/port.c:294:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 284, but without a corresponding object release within this function.
> ./net/dsa/dsa2.c:627:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
> ./net/dsa/dsa2.c:630:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
> ./net/dsa/dsa2.c:636:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
> ./net/dsa/dsa2.c:639:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
> Reviewed-by: "David S. Miller" <davem@davemloft.net>

Applied.
