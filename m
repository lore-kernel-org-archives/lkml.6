Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28305C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49F221756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49F221756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeHMSZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:25:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52714 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbeHMSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:25:35 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F2CCD14580445;
        Mon, 13 Aug 2018 08:42:49 -0700 (PDT)
Date:   Mon, 13 Aug 2018 08:42:49 -0700 (PDT)
Message-Id: <20180813.084249.2086802236653374160.davem@davemloft.net>
To:     virgile@acceis.fr
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add icmp_echo_ignore_all support for ICMPv6
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180810154815.GA18171@_>
References: <20180810154815.GA18171@_>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 08:42:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Virgile Jarry <virgile@acceis.fr>
Date: Fri, 10 Aug 2018 17:48:15 +0200

> Preventing the kernel from responding to ICMP Echo Requests messages
> can be useful in several ways. The sysctl parameter
> 'icmp_echo_ignore_all' can be used to prevent the kernel from
> responding to IPv4 ICMP echo requests. For IPv6 pings, such
> a sysctl kernel parameter did not exist.
> 
> Add the ability to prevent the kernel from responding to IPv6
> ICMP echo requests through the use of the following sysctl
> parameter : /proc/sys/net/ipv6/icmp/echo_ignore_all.
> Update the documentation to reflect this change.
> 
> Signed-off-by: Virgile Jarry <virgile@acceis.fr>
> ---
> Changes in v2:
> 	- Added support for sysctl interface (and not just /proc filesystem)

Applied.
