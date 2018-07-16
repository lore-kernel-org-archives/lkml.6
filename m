Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DBAECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999BA208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999BA208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeGPVh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:37:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60238 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbeGPVh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:37:58 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0CCC01400A888;
        Mon, 16 Jul 2018 14:08:47 -0700 (PDT)
Date:   Mon, 16 Jul 2018 14:08:46 -0700 (PDT)
Message-Id: <20180716.140846.1194638558934032830.davem@davemloft.net>
To:     sbaranoff@gmail.com
Cc:     avagin@virtuozzo.com, xemul@virtuozzo.com, edumazet@google.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net,v2] tcp: Fix broken repair socket window probe patch
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1531668997-1439-1-git-send-email-sbaranoff@gmail.com>
References: <1531668997-1439-1-git-send-email-sbaranoff@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Jul 2018 14:08:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Baranoff <sbaranoff@gmail.com>
Date: Sun, 15 Jul 2018 11:36:37 -0400

> Correct previous bad attempt at allowing sockets to come out of TCP
> repair without sending window probes. To avoid changing size of
> the repair variable in struct tcp_sock, this lets the decision for
> sending probes or not to be made when coming out of repair by
> introducing two ways to turn it off.
> 
> v2:
> * Remove erroneous comment; defines now make behavior clear
> 
> Fixes: 70b7ff130224 ("tcp: allow user to create repair socket without window probes")
> Signed-off-by: Stefan Baranoff <sbaranoff@gmail.com>

Applied and queued up for -stable.
