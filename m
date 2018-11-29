Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45464C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DE62146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DE62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeK3JdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:33:18 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36266 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeK3JdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:33:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A77D314F4528F;
        Thu, 29 Nov 2018 14:26:15 -0800 (PST)
Date:   Thu, 29 Nov 2018 14:26:15 -0800 (PST)
Message-Id: <20181129.142615.2049253532690656553.davem@davemloft.net>
To:     ms@dev.tdt.de
Cc:     andrew.hendry@gmail.com, stephen@networkplumber.org,
        joe@perches.com, anto.cardace@gmail.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net/x25: handle call collisions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181127085029.9589-3-ms@dev.tdt.de>
References: <20181127085029.9589-1-ms@dev.tdt.de>
        <20181127085029.9589-3-ms@dev.tdt.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 29 Nov 2018 14:26:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 27 Nov 2018 09:50:29 +0100

> If a session in X25_STATE_1 (Awaiting Call Accept) receives a call
> request, the session will be closed (x25_disconnect), cause=0x01
> (Number Busy) and diag=0x48 (Call Collision) will be set and a clear
> request will be send.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Applied.
