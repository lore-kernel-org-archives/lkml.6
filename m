Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F4AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5702075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5702075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeGRXGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:06:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44888 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeGRXGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:06:08 -0400
Received: from localhost (50-234-71-226-static.hfc.comcastbusiness.net [50.234.71.226])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CF2211479DED0;
        Wed, 18 Jul 2018 15:26:08 -0700 (PDT)
Date:   Thu, 19 Jul 2018 07:26:08 +0900 (KST)
Message-Id: <20180719.072608.944784986385146557.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     stefan.sorensen@spectralink.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: fix missing break in switch
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718011733.GA27872@embeddedor.com>
References: <20180718011733.GA27872@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 15:26:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 17 Jul 2018 20:17:33 -0500

> It seems that a *break* is missing in order to avoid falling through
> to the default case. Otherwise, checking *chan* makes no sense.
> 
> Fixes: 72df7a7244c0 ("ptp: Allow reassigning calibration pin function")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied and queued up for -stable, thank you.
