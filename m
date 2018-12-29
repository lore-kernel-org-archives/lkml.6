Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1143FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF52C20665
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeL2FtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:49:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40500 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeL2FtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:49:07 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5F86D14515150;
        Fri, 28 Dec 2018 21:49:06 -0800 (PST)
Date:   Fri, 28 Dec 2018 21:49:05 -0800 (PST)
Message-Id: <20181228.214905.2208487974538707696.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH 1/1] net-next/hinic:add shutdown callback
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181228002040.1256-1-xuechaojing@huawei.com>
References: <20181228002040.1256-1-xuechaojing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Dec 2018 21:49:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Fri, 28 Dec 2018 00:20:40 +0000

> @@ -1106,6 +1106,13 @@ static void hinic_remove(struct pci_dev *pdev)
>  	dev_info(&pdev->dev, "HiNIC driver - removed\n");
>  }
>  
> +static void hinic_shutdown(struct pci_dev *pdev)
> +{
> +	pci_disable_device(pdev);
> +
> +	dev_info(&pdev->dev, "HiNIC driver - shutdown\n");
> +}

I do not think these messages are appropriate.  I didn't catch
them before, but I'm not going to let new ones get added.
