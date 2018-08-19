Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B34BC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AD220B6F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AD220B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeHSVkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 17:40:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33760 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeHSVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 17:40:17 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 617C91473D024;
        Sun, 19 Aug 2018 11:27:54 -0700 (PDT)
Date:   Sun, 19 Aug 2018 11:27:53 -0700 (PDT)
Message-Id: <20180819.112753.320024709787799108.davem@davemloft.net>
To:     yanhaishuang@cmss.chinamobile.com
Cc:     steffen.klassert@secunet.com, kuznet@ms2.inr.ac.ru,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com
Subject: Re: [PATCH 1/2] ip_vti: fix a null pointer deferrence when create
 vti fallback tunnel
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1534662305-16734-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1534662305-16734-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Aug 2018 11:27:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Date: Sun, 19 Aug 2018 15:05:04 +0800

> After set fb_tunnels_only_for_init_net to 1, the itn->fb_tunnel_dev will
> be NULL and will cause following crash:
 ...
> Reproduce:
> echo 1 > /proc/sys/net/core/fb_tunnels_only_for_init_net
> modprobe ip_vti
> unshare -n
> 
> Fixes: 79134e6ce2c9 (net: do not create fallback tunnels for non-default
> namespaces)
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Applied, but please format your Fixes: tag properly next time.

Do not split up a Fixes tag into multiple lines, no matter how long it
is.  And enclose the commit header text in both parenthesis and double
quotes, not just parenthesis.  Like ("blah blah blah"), thank you.
