Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A6AC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF216204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF216204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeFSWpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:45:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49156 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeFSWp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:45:29 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 18:45:29 EDT
Received: from localhost (unknown [61.102.160.116])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0F413145230EA;
        Tue, 19 Jun 2018 15:37:51 -0700 (PDT)
Date:   Wed, 20 Jun 2018 07:37:50 +0900 (KST)
Message-Id: <20180620.073750.642289685695664600.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     mdf@kernel.org, keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: nixge: Add __packed attribute to DMA descriptor
 struct
From:   David Miller <davem@davemloft.net>
In-Reply-To: <832bebb8-300d-e911-2946-5edfe82dc30a@gmail.com>
References: <20180619165453.31894-1-mdf@kernel.org>
        <832bebb8-300d-e911-2946-5edfe82dc30a@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Jun 2018 15:37:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 19 Jun 2018 10:13:55 -0700

> How could padding be inserted given than all of the structure members
> are naturally aligned (all u32 type). Compiler bug?

Agreed, this looks completely unnecessary.

__packed should only be used when absolutely necessary because using
it generates less efficient code on some architectures.
