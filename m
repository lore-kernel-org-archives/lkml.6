Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B35C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4C721852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeLSFc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:32:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49160 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSFc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:32:59 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4FDD01475EE3F;
        Tue, 18 Dec 2018 21:32:58 -0800 (PST)
Date:   Tue, 18 Dec 2018 21:32:57 -0800 (PST)
Message-Id: <20181218.213257.1251094090416839024.davem@davemloft.net>
To:     bvanassche@acm.org
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/rhashtable: Fix work initialization in
 rhashtable_init()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181217214058.76811-1-bvanassche@acm.org>
References: <20181217214058.76811-1-bvanassche@acm.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 21:32:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>
Date: Mon, 17 Dec 2018 13:40:58 -0800

> The test_insert_dup() function from lib/test_rhashtable.c passes a
> pointer to a stack object to rhltable_init(). Avoid that the following
> is reported with object debugging enabled while running the selftest
> from lib/test_rhashtable.c:
 ...
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Please just fix the test to use the global object created for this purpose
instead of an unnecessary on-stack instance.

Thanks.
