Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A827C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517612075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TlaIIU9M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xt/xmpSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfBVNmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:42:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33516 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:42:22 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91B71607EF; Fri, 22 Feb 2019 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550842941;
        bh=FDamOiR0lLQwAnjHnGnM7lBxK044vNz50zAG6u5LAO0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TlaIIU9MPp16jbe5tlMI/GeL4wTlXIf+o4RtGuT60loziL8heBqCQQlW8ByILr7mA
         uXQRoF8Z4j24H4X32ux6W3QDAwYfbo2L0Qi5mRHrl1uLTT8Wo+JJtKYpZpA5+I6fiS
         WA0Wsizf1mFOXbkIxMR2k9qFEzryVf7T+LUknsUM=
Received: from [10.206.24.232] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: riteshh@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99BAD604A6;
        Fri, 22 Feb 2019 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550842940;
        bh=FDamOiR0lLQwAnjHnGnM7lBxK044vNz50zAG6u5LAO0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xt/xmpSri2OHQoSDMW/htj8qCAUNAKVXfZQam+a2Vt5CmlnYOvAAH9YXI4+/Yfaq5
         yV93JNOXB2g3aFJXadUz1rKLJ/3zVIcVAF2DklS9V1o9zc2J5EpXAjpACCV7oF4fCI
         sIrDLI+Jt3xu/kwAh6Iicsr34VHC60Re3U8S8+4w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99BAD604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=riteshh@codeaurora.org
Subject: Re: panic with CONFIG_FAIL_MMC_REQUEST and cqhci
To:     Laura Abbott <labbott@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>
References: <d220878f-2981-5e5e-22b0-5534cc037e8d@redhat.com>
From:   Ritesh Harjani <riteshh@codeaurora.org>
Message-ID: <5e81d594-15bb-81f5-75a0-a147fd5cfc18@codeaurora.org>
Date:   Fri, 22 Feb 2019 19:12:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d220878f-2981-5e5e-22b0-5534cc037e8d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On 2/19/2019 12:59 AM, Laura Abbott wrote:
> Hi,
>
> Fedora got report of a panic when I accidentally left debugging enabled
> on a build https://bugzilla.redhat.com/show_bug.cgi?id=1677438
>
> It looks like a panic from code in CONFIG_FAIL_MMC_REQUEST from the
> cqhci driver because there isn't a command (high level overview)

With CQHCI, in case of non-DCMD (data) requests, mrq->cmd can be NULL.
Is this crash happening always (100% on bootup) with CQHCI & 
CONFIG_FAIL_MMC_REQUEST enabled?

Sure, I will role out a patch to handle this case.
It will be great, if you could also confirm it from your side.

Regards
Ritesh


>
> (gdb) list *(mmc_should_fail_request+0xa)
> 0x149a is in mmc_should_fail_request (drivers/mmc/core/core.c:98).
> 93        };
> 94
> 95        if (!data)
> 96            return;
> 97
> 98        if (cmd->error || data->error ||
> 99            !should_fail(&host->fail_mmc_request, data->blksz * 
> data->blocks))
> 100            return;
> 101
> 102        data->error = data_errors[prandom_u32() % 
> ARRAY_SIZE(data_errors)];
> (gdb)
>
> (gdb) list *(mmc_cqe_request_done+0x1c)
> 0x2a6c is in mmc_cqe_request_done (drivers/mmc/core/core.c:505).
> 500    void mmc_cqe_request_done(struct mmc_host *host, struct 
> mmc_request *mrq)
> 501    {
> 502        mmc_should_fail_request(host, mrq);
> 503
> 504        /* Flag re-tuning needed on CRC errors */
> 505        if ((mrq->cmd && mrq->cmd->error == -EILSEQ) ||
> 506            (mrq->data && mrq->data->error == -EILSEQ))
> 507            mmc_retune_needed(host);
> 508
> 509        trace_mmc_request_done(host, mrq);
>
>
> (gdb) list *(cqhci_irq+0x1d2)
> 0x1172 is in cqhci_irq (drivers/mmc/host/cqhci.c:747).
> 742                data->bytes_xfered = 0;
> 743            else
> 744                data->bytes_xfered = data->blksz * data->blocks;
> 745        }
> 746
> 747        mmc_cqe_request_done(mmc, mrq);
> 748    }
> 749
> 750    irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int 
> cmd_error,
> 751                  int data_error)
>
> This can be worked around by turning off the option but it
> seems like something to fix up.
>
> Thanks,
> Laura
