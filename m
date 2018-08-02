Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CD42157F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CD42157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeHBXfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:35:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47662 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeHBXfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:35:06 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A501913AEDDCC;
        Thu,  2 Aug 2018 14:42:05 -0700 (PDT)
Date:   Thu, 02 Aug 2018 14:42:05 -0700 (PDT)
Message-Id: <20180802.144205.1530942065351147301.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     gomonovych@gmail.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: lmc: fix case value for target abort
 error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180801172241.1974-1-colin.king@canonical.com>
References: <20180801172241.1974-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 02 Aug 2018 14:42:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed,  1 Aug 2018 18:22:41 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Current value for a target abort error is 0x010, however, this value
> should in fact be 0x002.  As it stands, the range of error is 0..7 so
> it is currently never being detected.  This bug has been in the driver
> since the early 2.6.12 days (or before).
> 
> Detected by CoverityScan, CID#744290 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks Colin.
