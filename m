Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C146C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C15020894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C15020894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbeGaXMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:12:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59442 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeGaXMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:12:37 -0400
Received: from localhost (unknown [172.58.43.50])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 50586100A811F;
        Tue, 31 Jul 2018 14:30:17 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:30:15 -0700 (PDT)
Message-Id: <20180731.143015.1326547191404152411.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     axboe@kernel.dk, hch@infradead.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, tj@kernel.org, bp@alien8.de,
        manoj@linux.vnet.ibm.com, mrochs@linux.vnet.ibm.com,
        ukrishn@linux.vnet.ibm.com, nab@linux-iscsi.org,
        tglx@linutronix.de, pombredanne@nexb.com, sboyd@codeaurora.org,
        cyrille.pitchen@free-electrons.com, jgross@suse.com,
        viresh.kumar@linaro.org, u.kleine-koenig@pengutronix.de,
        sdharia@codeaurora.org, rdunlap@infradead.org,
        vinod.koul@intel.com, david.kershner@unisys.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] ide-cd: Remove redundant sense buffer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180731195155.46664-7-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
        <20180731195155.46664-7-keescook@chromium.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 31 Jul 2018 14:30:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Tue, 31 Jul 2018 12:51:51 -0700

> This is already able to process the sense buffer, so remove the redundant
> parsing during the failure path. This also fixes any possible stale values
> since the prior code did not check the sense length.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: David S. Miller <davem@davemloft.net>
