Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4B4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E073320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E073320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbeGWTJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:09:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45992 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbeGWTJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:09:52 -0400
Received: from localhost (unknown [172.58.43.169])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2E05D108CEDD7;
        Mon, 23 Jul 2018 11:07:27 -0700 (PDT)
Date:   Mon, 23 Jul 2018 11:07:26 -0700 (PDT)
Message-Id: <20180723.110726.835170464043859135.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     qiang.zhao@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to check
 return value of qe_muram_alloc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180723141233.19948-1-yuehaibing@huawei.com>
References: <20180723141233.19948-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Jul 2018 11:07:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 23 Jul 2018 22:12:33 +0800

> qe_muram_alloc return a unsigned long integer,which should not
> compared with zero. check it using IS_ERR_VALUE() to fix this.
> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
