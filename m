Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A6FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101FD2403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101FD2403D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753726AbeGEK66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:58:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56016 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbeGEK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:58:56 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5D79B10977DA7;
        Thu,  5 Jul 2018 03:58:55 -0700 (PDT)
Date:   Thu, 05 Jul 2018 19:58:53 +0900 (KST)
Message-Id: <20180705.195853.580143925396995107.davem@davemloft.net>
To:     moshe@mellanox.com
Cc:     vasundhara-v.volam@broadcom.com, jiri@mellanox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] Add configuration parameters support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Jul 2018 03:58:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moshe Shemesh <moshe@mellanox.com>
Date: Wed,  4 Jul 2018 14:30:27 +0300

> Add configuration parameters setting through devlink.
> Each device registers supported configuration parameters table.
> Each parameter can be either generic or driver specific.
> The user can retrieve data on these parameters by "devlink param show"
> command and can set new value to a parameter by "devlink param set"
> command.
> The parameters can be set in different configuration modes:
>   runtime - set while driver is running, no reset required.
>   driverinit - applied while driver initializes, requires restart
>                driver by devlink reload command.
>   permanent - written to device's non-volatile memory, hard reset required.
> 
> The patches at the end of the patchset introduce few params that are using
> the introduced infrastructure on mlx4 and bnxt.
> 
> Command examples and output:
 ...

Looks great, series applied, thanks!
