Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E427C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1669F20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b23icjKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1669F20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeKJIbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:31:49 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57475 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeKJIbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=rTm/ubjZVgl/IfKr6r0uXqKUW6U8mJS7KA59uHHxbBI=;
        b=b23icjKCcJ1qtrSXr3WCk+UYobNZutegBAMlSTovdlBT5kW0EI7DbRv92W2/iTjqBnjSFsQ1qtf5HT7nNsYPzFQdZJoOCLdbPCc9QNtzUS6s8DjU38llTzrJZbxH9xDD18RdaKTWtYiHCbTMjbmh3MTyksiZL+MUmpJFTP7VIeQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gLFaJ-0003z0-IK; Fri, 09 Nov 2018 23:49:03 +0100
Date:   Fri, 9 Nov 2018 23:49:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     davem@davemloft.net, yuvalm@mellanox.com, leon@kernel.org,
        yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: Re: [RFC PATCH 04/10] net: hns3: Add "promisc mode" config info
 query function
Message-ID: <20181109224903.GE5259@lunn.ch>
References: <20181109220743.10264-1-salil.mehta@huawei.com>
 <20181109220743.10264-5-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109220743.10264-5-salil.mehta@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:07:37PM +0000, Salil Mehta wrote:
> From: liuzhongzhu <liuzhongzhu@huawei.com>
> 
> This patch prints promiscuous mode status.

netstat -i

Iface      MTU    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
lo       65536   871698      0      0 0        871698      0      0      0 LRU
tun0      1500  1052639      0      0 0       1013998      0      0      0 MOPRU

The flag P means promisc.

    Andrew
