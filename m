Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783CEC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117E5240BC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117E5240BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeGFCHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:07:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44506 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbeGFCHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:07:35 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CF87110977DA2;
        Thu,  5 Jul 2018 19:07:33 -0700 (PDT)
Date:   Fri, 06 Jul 2018 11:07:30 +0900 (KST)
Message-Id: <20180706.110730.784787207378309674.davem@davemloft.net>
To:     hofrat@osadl.org
Cc:     derek.chickles@caviumnetworks.com,
        satananda.burla@caviumnetworks.com,
        felix.manlunas@caviumnetworks.com,
        raghu.vatsavayi@caviumnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] liquidio: make timeout HZ independent and readable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530555195-28129-1-git-send-email-hofrat@osadl.org>
References: <1530555195-28129-1-git-send-email-hofrat@osadl.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Jul 2018 19:07:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Mon,  2 Jul 2018 20:13:15 +0200

> schedule_timeout_* takes a timeout in jiffies but the code currently is
> passing in a constant which makes this timeout HZ dependent. So define
> a constant with (hopefully) meaningful name and pass it through
> msecs_to_jiffies() to fix the HZ dependency.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> commit f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")

Applied, thank you.
