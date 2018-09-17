Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD0ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EAA214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EAA214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeIQUnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:43:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46178 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeIQUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:43:19 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 02285144B43BF;
        Mon, 17 Sep 2018 08:15:31 -0700 (PDT)
Date:   Mon, 17 Sep 2018 08:15:31 -0700 (PDT)
Message-Id: <20180917.081531.1710106422276499589.davem@davemloft.net>
To:     vakul.garg@nxp.com
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org, davejwatson@fb.com,
        doronrk@fb.com
Subject: Re: [PATCH net-next] selftests/tls: Add MSG_WAITALL in recv()
 syscall
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180916043428.24329-1-vakul.garg@nxp.com>
References: <20180916043428.24329-1-vakul.garg@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 08:15:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vakul Garg <vakul.garg@nxp.com>
Date: Sun, 16 Sep 2018 10:04:28 +0530

> A number of tls selftests rely upon recv() to return an exact number of
> data bytes. When tls record crypto is done using an async accelerator,
> it is possible that recv() returns lesser than expected number bytes.
> This leads to failure of many test cases. To fix it, MSG_WAITALL has
> been used in flags passed to recv() syscall.
> 
> Signed-off-by: Vakul Garg <vakul.garg@nxp.com>

Applied.
