Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79A2C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FA0206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FA0206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeJFEdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:33:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46692 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJFEdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:33:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0E3DD13ADF961;
        Fri,  5 Oct 2018 14:32:37 -0700 (PDT)
Date:   Fri, 05 Oct 2018 14:32:36 -0700 (PDT)
Message-Id: <20181005.143236.511366748709139149.davem@davemloft.net>
To:     ldr709@gmail.com
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH] atm: nicstar: Replace spin_is_locked() with
 spin_trylock()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181004074657.17597-1-ldr709@gmail.com>
References: <20181004074657.17597-1-ldr709@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Oct 2018 14:32:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lance Roy <ldr709@gmail.com>
Date: Thu,  4 Oct 2018 00:46:57 -0700

> ns_poll() used spin_is_locked() + spin_lock() to get achieve the same
> thing as a spin_trylock(), so simplify it by using that instead. This is
> also a step towards possibly removing spin_is_locked().
> 
> Signed-off-by: Lance Roy <ldr709@gmail.com>

Applied to net-next.
