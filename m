Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D0EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486F820823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486F820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJ3Mfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 08:35:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45370 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3Mfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 08:35:39 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EC87713ADD5EF;
        Mon, 29 Oct 2018 20:43:56 -0700 (PDT)
Date:   Mon, 29 Oct 2018 20:43:56 -0700 (PDT)
Message-Id: <20181029.204356.2257052616319742165.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     aviad.krawczyk@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com
Subject: Re: [PATCH] hinic: Fix l4_type parameter in
 hinic_task_set_tunnel_l4
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181029105158.6340-1-natechancellor@gmail.com>
References: <20181029105158.6340-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 29 Oct 2018 20:43:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 29 Oct 2018 03:51:58 -0700

> Clang warns:
> 
> drivers/net/ethernet/huawei/hinic/hinic_tx.c:392:34: error: implicit
> conversion from enumeration type 'enum hinic_l4_tunnel_type' to
> different enumeration type 'enum hinic_l4_offload_type'
> [-Werror,-Wenum-conversion]
>                 hinic_task_set_tunnel_l4(task, TUNNEL_UDP_NO_CSUM,
>                 ~~~~~~~~~~~~~~~~~~~~~~~~       ^~~~~~~~~~~~~~~~~~
> 1 error generated.
> 
> It seems that hinic_task_set_tunnel_l4 was meant to take an enum of type
> hinic_l4_tunnel_type, not hinic_l4_offload_type, given both the name of
> the functions and the values used.
> 
> Fixes: cc18a7543d2f ("net-next/hinic: add checksum offload and TSO support")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
