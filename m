Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D8FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3888B20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3888B20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeG3VUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:20:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36286 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbeG3VUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:20:02 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E77E513FC7C5C;
        Mon, 30 Jul 2018 12:43:30 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:43:30 -0700 (PDT)
Message-Id: <20180730.124330.538236571439983894.davem@davemloft.net>
To:     dima@arista.com
Cc:     linux-kernel@vger.kernel.org, rong.a.chen@intel.com,
        0x7f454c46@gmail.com, herbert@gondor.apana.org.au,
        steffen.klassert@secunet.com, netdev@vger.kernel.org
Subject: Re: [PATCH] netlink: Don't shift with UB on nlk->ngroups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180730173236.20968-1-dima@arista.com>
References: <20180730173236.20968-1-dima@arista.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Jul 2018 12:43:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>
Date: Mon, 30 Jul 2018 18:32:36 +0100

> On i386 nlk->ngroups might be 32 or 0. Which leads to UB, resulting in
> hang during boot.
> Check for 0 ngroups and use (unsigned long long) as a type to shift.
> 
> Fixes: commit 7acf9d4237c46894e0fa0492dd96314a41742e84 ("netlink: Do not
> subscribe to non-existent groups").

Please, in the future, format your Fixes: tag correctly.  No need
to say the work "commit", please do not chop up the line no matter
how long it is, and please provide 12 digits of SHA1_ID value, rather
than the whole thing.

> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Applied, thank you.
