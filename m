Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68EDC46469
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79336206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79336206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeIMU1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:27:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49844 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeIMU1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:27:40 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F308213FCB0E3;
        Thu, 13 Sep 2018 08:17:42 -0700 (PDT)
Date:   Thu, 13 Sep 2018 08:17:42 -0700 (PDT)
Message-Id: <20180913.081742.846333906880381162.davem@davemloft.net>
To:     nautsch2@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        gregkh@linuxfoundation.org, ek@google.com, tglx@linutronix.de,
        maze@google.com, shli@fb.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com
Subject: Re: [PATCH 1/1] ipv6: Add sockopt IPV6_MULTICAST_ALL analogue to
 IP_MULTICAST_ALL
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180910082715.11506-2-nautsch2@gmail.com>
References: <20180910082715.11506-1-nautsch2@gmail.com>
        <20180910082715.11506-2-nautsch2@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 08:17:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Naujoks <nautsch2@gmail.com>
Date: Mon, 10 Sep 2018 10:27:15 +0200

> The socket option will be enabled by default to ensure current behaviour
> is not changed. This is the same for the IPv4 version.
> 
> A socket bound to in6addr_any and a specific port will receive all traffic
> on that port. Analogue to IP_MULTICAST_ALL, disable this behaviour, if
> one or more multicast groups were joined (using said socket) and only
> pass on multicast traffic from groups, which were explicitly joined via
> this socket.
> 
> Without this option disabled a socket (system even) joined to multiple
> multicast groups is very hard to get right. Filtering by destination
> address has to take place in user space to avoid receiving multicast
> traffic from other multicast groups, which might have traffic on the same
> port.
> 
> The extension of the IP_MULTICAST_ALL socketoption to just apply to ipv6,
> too, is not done to avoid changing the behaviour of current applications.
> 
> Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
> Acked-By: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

Applied to net-next, thank you.
