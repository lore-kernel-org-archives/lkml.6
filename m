Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAAAECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D40B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D40B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbeGRVSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:18:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43076 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbeGRVSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:18:39 -0400
Received: from localhost (179-64-212-66.spl.org [66.212.64.179])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7F30C1479C608;
        Wed, 18 Jul 2018 13:39:03 -0700 (PDT)
Date:   Thu, 19 Jul 2018 05:39:03 +0900 (KST)
Message-Id: <20180719.053903.2078135194846496238.davem@davemloft.net>
To:     saeedm@dev.mellanox.co.il
Cc:     arnd@arndb.de, saeedm@mellanox.com, leon@kernel.org,
        ilyal@mellanox.com, borisp@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: fix an unused-function warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CALzJLG_r5pkBWGvyE+e7PVtPOnLnXS8oee_ka+=UEAkbqDP-Kg@mail.gmail.com>
References: <20180717135009.3584984-1-arnd@arndb.de>
        <CALzJLG_r5pkBWGvyE+e7PVtPOnLnXS8oee_ka+=UEAkbqDP-Kg@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 13:39:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date: Tue, 17 Jul 2018 17:42:25 -0700

> On Tue, Jul 17, 2018 at 6:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> These dummy helpers are all intended to be inline functions,
>> but one of them by accident came without the 'inline' keyword,
>> causing a harmless warning:
>>
>> In file included from drivers/net/ethernet/mellanox/mlx5/core/main.c:63:
>> drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h:79:1: error: 'mlx5_accel_tls_add_flow' defined but not used [-Werror=unused-function]
>>  mlx5_accel_tls_add_flow(struct mlx5_core_dev *mdev, void *flow,
>>
>> Fixes: ab412e1dd7db ("net/mlx5: Accel, add TLS rx offload routines")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Saeed Mahameed <saeedm@mellanox.com>
> 
> Dave, you can take this one to net-next.

Sure, done.
