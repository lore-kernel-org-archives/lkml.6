Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E36C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF76A20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF76A20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeGXEYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:24:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52688 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGXEYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:24:35 -0400
Received: from localhost (unknown [172.58.43.75])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 59CF612DE6614;
        Mon, 23 Jul 2018 20:20:17 -0700 (PDT)
Date:   Mon, 23 Jul 2018 20:20:14 -0700 (PDT)
Message-Id: <20180723.202014.998386909125276647.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     ast@kernel.org, daniel@iogearbox.net, quentin.monnet@netronome.com,
        jakub.kicinski@netronome.com, bhole_prashant_q7@lab.ntt.co.jp,
        osk@fb.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: btf: fix inconsistent IS_ERR and PTR_ERR
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180724025524.22012-1-yuehaibing@huawei.com>
References: <20180724025524.22012-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Jul 2018 20:20:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 24 Jul 2018 10:55:24 +0800

> Fix inconsistent IS_ERR and PTR_ERR in get_btf,
> the proper pointer to be passed as argument is '*btf'
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 2d3feca8c44f ("bpf: btf: print map dump and lookup with btf info")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
