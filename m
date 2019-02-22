Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92295C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69874206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfBVVQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:16:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33895 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:16:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id w4so4209210qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M2s0it5LxYHJ5+ZSUqoBK5dkuzpKg1LsXuZLt4U2+Jw=;
        b=ugct1w+wrFZpaV2Bxgd29HkYPSV0V4rYOW2p6ttMRqh0rnc1qht1wzUSzMlPXbIcZu
         E8A25UvMkt4tKYkvHPCzmlc5e+fCgxHYZwLT6Jfa2rkET0BNb1tNz7HhOw9lyaIt8orJ
         05ekIs4Ilv6hbcO03tjo453N+s41BYI26JRrMz5qwZCXlGUP9kk5Cu52NDnVA2nsAtCw
         NVaL7YiUm6VZzL7B4jka/U/qsGsB2LgSUV4DwwfCf/oj3L+TsM4CBIq1Qxqz1NIfbGQt
         mvB+Db8xXXFj+GcojVT5V1pjlvVfA/GSjGrhAVxjtraFhW6g3xfPPDiVTaPP80/axVsv
         v24g==
X-Gm-Message-State: AHQUAuZBq37zY4qMdP3gSvXVXq1CGLSDxLb2pabdgc24eTCcV9PvnV2d
        GF5pzhXOOwBn8txJoHoXXYWZKX4JWAg=
X-Google-Smtp-Source: AHgI3IZ8yeMd6x0FSyvPfxOTWYdZW5wqnJh+K98YcadLBvE3Wk2/6vpeXBnXUx8SXR4hfBBc3RfDBA==
X-Received: by 2002:ac8:2eda:: with SMTP id i26mr4698190qta.260.1550870177046;
        Fri, 22 Feb 2019 13:16:17 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
        by smtp.gmail.com with ESMTPSA id c10sm1279868qkk.91.2019.02.22.13.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:16:16 -0800 (PST)
Subject: Re: panic with CONFIG_FAIL_MMC_REQUEST and cqhci
To:     Ritesh Harjani <riteshh@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>
References: <d220878f-2981-5e5e-22b0-5534cc037e8d@redhat.com>
 <5e81d594-15bb-81f5-75a0-a147fd5cfc18@codeaurora.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <248f4e5f-f204-b998-bd14-a08dfb774932@redhat.com>
Date:   Fri, 22 Feb 2019 13:16:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5e81d594-15bb-81f5-75a0-a147fd5cfc18@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 5:42 AM, Ritesh Harjani wrote:
> Hi Laura,
> 
> On 2/19/2019 12:59 AM, Laura Abbott wrote:
>> Hi,
>>
>> Fedora got report of a panic when I accidentally left debugging enabled
>> on a build https://bugzilla.redhat.com/show_bug.cgi?id=1677438
>>
>> It looks like a panic from code in CONFIG_FAIL_MMC_REQUEST from the
>> cqhci driver because there isn't a command (high level overview)
> 
> With CQHCI, in case of non-DCMD (data) requests, mrq->cmd can be NULL.
> Is this crash happening always (100% on bootup) with CQHCI & CONFIG_FAIL_MMC_REQUEST enabled?
> 
> Sure, I will role out a patch to handle this case.
> It will be great, if you could also confirm it from your side.
> 

Thanks, I'll have to follow up with the reporter and see if he
gets back to me.

> Regards
> Ritesh
> 
> 
>>
>> (gdb) list *(mmc_should_fail_request+0xa)
>> 0x149a is in mmc_should_fail_request (drivers/mmc/core/core.c:98).
>> 93        };
>> 94
>> 95        if (!data)
>> 96            return;
>> 97
>> 98        if (cmd->error || data->error ||
>> 99            !should_fail(&host->fail_mmc_request, data->blksz * data->blocks))
>> 100            return;
>> 101
>> 102        data->error = data_errors[prandom_u32() % ARRAY_SIZE(data_errors)];
>> (gdb)
>>
>> (gdb) list *(mmc_cqe_request_done+0x1c)
>> 0x2a6c is in mmc_cqe_request_done (drivers/mmc/core/core.c:505).
>> 500    void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq)
>> 501    {
>> 502        mmc_should_fail_request(host, mrq);
>> 503
>> 504        /* Flag re-tuning needed on CRC errors */
>> 505        if ((mrq->cmd && mrq->cmd->error == -EILSEQ) ||
>> 506            (mrq->data && mrq->data->error == -EILSEQ))
>> 507            mmc_retune_needed(host);
>> 508
>> 509        trace_mmc_request_done(host, mrq);
>>
>>
>> (gdb) list *(cqhci_irq+0x1d2)
>> 0x1172 is in cqhci_irq (drivers/mmc/host/cqhci.c:747).
>> 742                data->bytes_xfered = 0;
>> 743            else
>> 744                data->bytes_xfered = data->blksz * data->blocks;
>> 745        }
>> 746
>> 747        mmc_cqe_request_done(mmc, mrq);
>> 748    }
>> 749
>> 750    irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>> 751                  int data_error)
>>
>> This can be worked around by turning off the option but it
>> seems like something to fix up.
>>
>> Thanks,
>> Laura

