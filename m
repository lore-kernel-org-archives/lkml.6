Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4C1C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DF220873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DF220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbeG2Dgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 23:36:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59862 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbeG2Dgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 23:36:49 -0400
Received: from localhost (unknown [172.56.41.34])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D691D13AED0A0;
        Sat, 28 Jul 2018 19:08:10 -0700 (PDT)
Date:   Sat, 28 Jul 2018 19:08:09 -0700 (PDT)
Message-Id: <20180728.190809.1376213313357548269.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     vasilyev@ispras.ru, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, jonmason@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] net: mdio-mux: bcm-iproc: fix wrong getter and setter
 pair
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180727161707.GP10686@lunn.ch>
References: <20180727155747.24978-1-vasilyev@ispras.ru>
        <20180727161707.GP10686@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 28 Jul 2018 19:08:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 27 Jul 2018 18:17:07 +0200

> On Fri, Jul 27, 2018 at 06:57:47PM +0300, Anton Vasilyev wrote:
>> mdio_mux_iproc_probe() uses platform_set_drvdata() to store md pointer
>> in device, whereas mdio_mux_iproc_remove() restores md pointer by
>> dev_get_platdata(&pdev->dev). This leads to wrong resources release.
>> 
>> The patch replaces getter to platform_get_drvdata.
>> 
>> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> 
> Fixes: 98bc865a1ec8 ("net: mdio-mux: Add MDIO mux driver for iProc SoCs")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied and queued up for -stable, thanks.
