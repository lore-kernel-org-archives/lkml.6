Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4831FC04E83
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F9420C0E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F9420C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeHSVkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 17:40:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33774 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeHSVkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 17:40:21 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7B2161473D02A;
        Sun, 19 Aug 2018 11:27:59 -0700 (PDT)
Date:   Sun, 19 Aug 2018 11:27:59 -0700 (PDT)
Message-Id: <20180819.112759.972635376824399679.davem@davemloft.net>
To:     yanhaishuang@cmss.chinamobile.com
Cc:     steffen.klassert@secunet.com, kuznet@ms2.inr.ac.ru,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ip6_vti: fix creating fallback tunnel device for
 vti6
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1534662305-16734-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1534662305-16734-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
        <1534662305-16734-2-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Aug 2018 11:27:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Date: Sun, 19 Aug 2018 15:05:05 +0800

> When set fb_tunnels_only_for_init_net to 1, don't create fallback tunnel
> device for vti6 when a new namespace is created.
> 
> Tested:
> [root@builder2 ~]# modprobe ip6_tunnel
> [root@builder2 ~]# modprobe ip6_vti
> [root@builder2 ~]# echo 1 > /proc/sys/net/core/fb_tunnels_only_for_init_net
> [root@builder2 ~]# unshare -n
> [root@builder2 ~]# ip link
> 1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group
> default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Applied.
