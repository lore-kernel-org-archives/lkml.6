Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2D7C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7D524AA3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7D524AA3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934579AbeFWBvI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:51:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34462 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933864AbeFWBvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:51:06 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A7E2D128F4E81;
        Fri, 22 Jun 2018 18:50:57 -0700 (PDT)
Date:   Sat, 23 Jun 2018 10:50:55 +0900 (KST)
Message-Id: <20180623.105055.470247977870986966.davem@davemloft.net>
To:     joe@perches.com
Cc:     derek.chickles@caviumnetworks.com,
        satananda.burla@caviumnetworks.com,
        felix.manlunas@caviumnetworks.com,
        raghu.vatsavayi@caviumnetworks.com, ulli.kroll@googlemail.com,
        linus.walleij@linaro.org, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, jeffrey.t.kirsher@intel.com,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        harish.patil@cavium.com, manish.chopra@cavium.com,
        Dept-GELinuxNICDev@cavium.com, linux-net-drivers@solarflare.com,
        ecree@solarflare.com, bkenward@solarflare.com,
        grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        woojung.huh@microchip.com, ath9k-devel@qca.qualcomm.com,
        mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        kvalo@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        intel-wired-lan@lists.osuosl.org, linux-omap@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] net: drivers/net: Convert random_ether_addr to
 eth_random_addr
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
References: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Jun 2018 18:51:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Fri, 22 Jun 2018 10:51:00 -0700

> random_ether_addr is a #define for eth_random_addr which is
> generally preferred in kernel code by ~3:1
> 
> Convert the uses of random_ether_addr to enable removing the #define
> 
> Miscellanea:
> 
> o Convert &vfmac[0] to equivalent vfmac and avoid unnecessary line wrap
> 
> Signed-off-by: Joe Perches <joe@perches.com>

I'll apply this to net-next, thanks Joe.
