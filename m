Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90028C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5247921471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5247921471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeGLGER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:04:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54450 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeGLGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:04:17 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9EBA413FE910B;
        Wed, 11 Jul 2018 22:56:18 -0700 (PDT)
Date:   Wed, 11 Jul 2018 22:56:18 -0700 (PDT)
Message-Id: <20180711.225618.955135210897509961.davem@davemloft.net>
To:     jan.dakinevich@virtuozzo.com
Cc:     christophe.jaillet@wanadoo.fr, dan.carpenter@oracle.com,
        keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, den@virtuozzo.com,
        khorenko@virtuozzo.com
Subject: Re: [PATCH] cnic: use kvzalloc to allocate memory for csk_tbl
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1531144279-26687-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1531144279-26687-1-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Jul 2018 22:56:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Mon,  9 Jul 2018 16:51:19 +0300

> Size of csk_tbl is about 58K, which means 3rd order page allocation.
> kvzalloc provides a fallback if no high order memory is available.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>

Applied, thanks.
