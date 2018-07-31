Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749DAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CA020870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CA020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbeGaVWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:22:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57482 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732094AbeGaVWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:22:46 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DF99F12DE6617;
        Tue, 31 Jul 2018 12:40:56 -0700 (PDT)
Date:   Tue, 31 Jul 2018 12:40:53 -0700 (PDT)
Message-Id: <20180731.124053.2701966560858042.davem@davemloft.net>
To:     hch@lst.de
Cc:     edumazet@google.com, paulmck@linux.vnet.ibm.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: remove bogus RCU annotations on socket.wq
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180730074507.17037-2-hch@lst.de>
References: <20180730074507.17037-1-hch@lst.de>
        <20180730074507.17037-2-hch@lst.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 31 Jul 2018 12:40:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 30 Jul 2018 09:45:07 +0200

> We never use RCU protection for it, just a lot of cargo-cult
> rcu_deference_protects calls.
> 
> Note that we do keep the kfree_rcu call for it, as the references through
> struct sock are RCU protected and thus might require a grace period before
> freeing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to net-next, thanks.
