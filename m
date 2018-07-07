Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A1C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467252198F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467252198F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeGGLaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:30:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51734 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeGGLaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:30:19 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3CCE612107106;
        Sat,  7 Jul 2018 04:30:18 -0700 (PDT)
Date:   Sat, 07 Jul 2018 20:30:16 +0900 (KST)
Message-Id: <20180707.203016.623173685153821356.davem@davemloft.net>
To:     sfr@canb.auug.org.au
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, moshe@mellanox.com, jiri@mellanox.com
Subject: Re: linux-next: build warning after merge of the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180706095633.676b0229@canb.auug.org.au>
References: <20180706095633.676b0229@canb.auug.org.au>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Jul 2018 04:30:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 6 Jul 2018 09:56:33 +1000

> Hi all,
> 
> After merging the net-next tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> In file included from include/net/dsa.h:24:0,
>                  from include/linux/platform_data/b53.h:23,
>                  from drivers/net/dsa/b53/b53_spi.c:25:
> include/net/devlink.h: In function 'devlink_param_value_changed':
> include/net/devlink.h:771:9: warning: 'return' with a value, in function returning void
>   return -EOPNOTSUPP;
>          ^
> include/net/devlink.h:769:1: note: declared here
>  devlink_param_value_changed(struct devlink *devlink, u32 param_id)
 ...
> Introduced by commit
> 
>   ea601e170988 ("devlink: Add devlink notifications support for params")

Thanks Stephen, this should be fixes now.
