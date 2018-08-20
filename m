Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E81C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BE52150F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BE52150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeHTGKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 02:10:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39786 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeHTGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 02:10:05 -0400
Received: from localhost (unknown [172.58.41.21])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8B5C4147494BE;
        Sun, 19 Aug 2018 19:56:18 -0700 (PDT)
Date:   Sun, 19 Aug 2018 19:56:17 -0700 (PDT)
Message-Id: <20180819.195617.287376807384738076.davem@davemloft.net>
To:     yanhaishuang@cmss.chinamobile.com
Cc:     steffen.klassert@secunet.com, kuznet@ms2.inr.ac.ru,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip6_vti: fix a null pointer deference when destroy
 vti6 tunnel
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1534733465-2493-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1534733465-2493-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Aug 2018 19:56:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Date: Mon, 20 Aug 2018 10:51:05 +0800

> If load ip6_vti module and create a network namespace when set
> fb_tunnels_only_for_init_net to 1, then exit the namespace will
> cause following crash:
 ...
> This because ip6n->tnls_wc[0] point to fallback device in default, but
> in non-default namespace, ip6n->tnls_wc[0] will be NULL, so add the NULL
> check comparatively.
> 
> Fixes: e2948e5af8ee ("ip6_vti: fix creating fallback tunnel device for vti6")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Ugh, applied, thanks.
