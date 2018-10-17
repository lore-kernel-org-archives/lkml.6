Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C9ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F182020869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F182020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeJRBwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:52:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48914 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJRBwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:52:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 307BE260B56
Message-ID: <75b42b9f86b504bbd84dfab1e2c6fd0965216c67.camel@collabora.com>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Date:   Wed, 17 Oct 2018 14:55:18 -0300
In-Reply-To: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-10-14 at 20:04 +0300, Aaro Koskinen wrote:
> Hi,
> 
> There is something wrong with jz4740-mmc in current mainline kernel
> (tested v4.18 and 4.19-rc, the MMC support for CI20 does not exist
> prior those), as the DMA support does not work properly if I disable
> kernel pre-emption. The console gets flooded with:
> 
> [   16.461094] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 567 host->next_data.cookie 568
> [   16.473120] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 568 host->next_data.cookie 569
> [   16.485144] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 569 host->next_data.cookie 570
> [   16.497170] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 570 host->next_data.cookie 571
> [   16.509194] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 571 host->next_data.cookie 572
> [   16.532421] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 572 host->next_data.cookie 573
> [   16.544594] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 573 host->next_data.cookie 574
> [   16.556621] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 574 host->next_data.cookie 575
> [   16.568638] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 575 host->next_data.cookie 576
> [   16.601092] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 582 host->next_data.cookie 583
> 
> etc. ad inf.
> 
> This should be easily reproducible on CI20 board with ci20_defconfig
> and setting CONFIG_PREEMPT_NONE=y.
> 

Will take a look as soon as possible, most likely after ELCE.

Thanks,
Eze
