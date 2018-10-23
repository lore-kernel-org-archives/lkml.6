Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CADC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F466207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F466207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeJWKur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:50:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39812 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:50:47 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3C60E146BF274;
        Mon, 22 Oct 2018 19:29:33 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:29:32 -0700 (PDT)
Message-Id: <20181022.192932.357987873245726983.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] octeontx2-af: Remove set but not used
 variables 'devnum, is_pf'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1539954186-193695-1-git-send-email-yuehaibing@huawei.com>
References: <1539954186-193695-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Oct 2018 19:29:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 19 Oct 2018 13:03:06 +0000

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/marvell/octeontx2/af/rvu.c: In function 'rvu_detach_rsrcs':
> drivers/net/ethernet/marvell/octeontx2/af/rvu.c:855:6: warning:
>  variable 'devnum' set but not used [-Wunused-but-set-variable]
>  
> drivers/net/ethernet/marvell/octeontx2/af/rvu.c:853:7: warning:
>  variable 'is_pf' set but not used [-Wunused-but-set-variable]
> 
> drivers/net/ethernet/marvell/octeontx2/af/rvu.c: In function 'rvu_mbox_handler_ATTACH_RESOURCES':
> drivers/net/ethernet/marvell/octeontx2/af/rvu.c:1054:7: warning:
>  variable 'is_pf' set but not used [-Wunused-but-set-variable]
> 
> drivers/net/ethernet/marvell/octeontx2/af/rvu.c:1053:6: warning:
>  variable 'devnum' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit
> 746ea74241fa ("octeontx2-af: Add RVU block LF provisioning support")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
