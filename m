Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235CBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7430214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ovd5U/3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7430214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeKONRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:17:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33575 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKONRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 08:17:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id c206so10033688oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 19:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bi9ij3ZwB57bFu8hQyHO9qEKpBj6Um/nzyk7+97cq3U=;
        b=Ovd5U/3yEo1wMFs73SKO8aR24E/+5Y3oQtPUFC4mYWJIOPWMfH1eU6lcnysFOyIX8s
         gr+A4OjMIVTpVz3E+K/d40vazzQ9G8kO6RZN+wJoXMC5kzwYYdUKXZxPM5r5iHzxR/Rd
         Eq7a57WXq5x8K4c1v1NYJIXK3NiGLwpO6uzAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bi9ij3ZwB57bFu8hQyHO9qEKpBj6Um/nzyk7+97cq3U=;
        b=YIdidxbgrXc2YPnayAh4mI8PUtGkjhERWA8igpzWEnQaWnYDTFiHTGYVTZLsQIACvA
         QQ1+y78OXP/4I05f+AC1CX7Sw69eva2DyY3upPmXuU7UWVbmjkAWAl37sSyXDkRnSm1d
         CKNAn/JrpufirbmbjZMi6DIhKRaBsQw9OfYAyupBGIihyh26F58aqhv9woq+p6NjZuyV
         Uryc+fF3xFhSFBQP3OgLqLyyYGPX8RQhO6NLCF95p0zcmWqYXshVypwKwsw0dzkHfXPa
         dhkJAdcg+OKAA9ELxL1xJJdJlyTLdX1ge1ccwe6ceJbcw7JSIgF698AfJpBatypQwLHy
         cIGw==
X-Gm-Message-State: AGRZ1gInLm1PQspFfQPqPjdr7eO4t+98n9Ov48zkLMhY6YUQnhOAC7P7
        WERQZ42ISXAD26w3CxzDA//33g==
X-Google-Smtp-Source: AJdET5drYtTadjXMa2mTVL+83d71jVHQa/3lCIPJjm/XUjK9NmjnhKnoUGXEFfTrMQsswl73O07rag==
X-Received: by 2002:aca:1b0e:: with SMTP id b14mr2538733oib.215.1542251500713;
        Wed, 14 Nov 2018 19:11:40 -0800 (PST)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id n6sm15244073ote.56.2018.11.14.19.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 19:11:39 -0800 (PST)
Subject: Re: [RFC PATCH 09/12] soc: qcom: ipa: main IPA source file
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-10-elder@linaro.org>
 <CAK8P3a0RH4wbigKR0zsbxPzqWDjrLEkYfQk4GNxhGuxs=HJHHw@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <4cc029b5-590d-fcba-6c29-b8dac6d03133@linaro.org>
Date:   Wed, 14 Nov 2018 21:11:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0RH4wbigKR0zsbxPzqWDjrLEkYfQk4GNxhGuxs=HJHHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 8:08 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> 
>> +static void ipa_client_remove_deferred(struct work_struct *work);
> 
> Try to avoid forward declarations by reordering the code in call order,
> it will also make it easier to read.
> 
>> +static DECLARE_WORK(ipa_client_remove_work, ipa_client_remove_deferred);

Done.  I've actually reworked this a lot, and pulled all the
clock (and interconnect) related code into a separate source file.
No more forward declarations (there anyway), and the work structure
is now embedded in the top-level IPA structure so I can derive
it again in the work function (rather than using the global).

>> +static struct ipa_context ipa_ctx_struct;
>> +struct ipa_context *ipa_ctx = &ipa_ctx_struct;
> 
> Global state variables should generally be removed as well, and
> passed around as function arguments.

Working on this.

>> +static int hdr_init_local_cmd(u32 offset, u32 size)
>> +{
>> +       struct ipa_desc desc = { };
>> +       struct ipa_dma_mem mem;
>> +       void *payload;
>> +       int ret;
>> +
>> +       if (ipa_dma_alloc(&mem, size, GFP_KERNEL))
>> +               return -ENOMEM;
>> +
>> +       offset += ipa_ctx->smem_offset;
>> +
>> +       payload = ipahal_hdr_init_local_pyld(&mem, offset);
>> +       if (!payload) {
>> +               ret = -ENOMEM;
>> +               goto err_dma_free;
>> +       }
>> +
>> +       desc.type = IPA_IMM_CMD_DESC;
>> +       desc.len_opcode = IPA_IMM_CMD_HDR_INIT_LOCAL;
>> +       desc.payload = payload;
>> +
>> +       ret = ipa_send_cmd(&desc);
> 
> You have a bunch of dynamic allocations in here, which you
> then immediately tear down again after the command is complete.
> I can't see at all what you do with the DMA address, since you
> seem to not use the virtual address at all but only store
> the physical address in some kind of descriptor without ever
> writing to it.

I should probably have added at least a comment here.  The
DMA memory was zeroed at the time of allocation.  That zero
buffer is then referred to in the payload to the HDR_INIT_LOCAL
immediate command.  So that command, when executing in the IPA
hardware, uses the contents of the buffer whose physical address
it's supplied, which in this case is full of zeroes.  We don't
use the virtual address because the buffer came pre-zeroed.

Based on your comment elsewhere I will be putting the command
payload in a structure on the stack rather than allocating it
dynamically.

> Am I missing something here?
> 
>> +/* Remoteproc callbacks for SSR events: prepare, start, stop, unprepare */
>> +int ipa_ssr_prepare(struct rproc_subdev *subdev)
>> +{
>> +       printk("======== SSR prepare received ========\n");
> 
> I think you mean dev_dbg() here. A plain printk() without a level
> is not correct and we probably don't want those messages to arrive
> on the console for normal users.

Yes, this was obviously a debug message in some code I should
have removed before sending...

>> +static int ipa_firmware_load(struct de
>> +
>> +err_clear_dev:
>> +       ipa_ctx->lan_cons_ep_id = 0;
>> +       ipa_ctx->cmd_prod_ep_id = 0;
>> +       ipahal_exit();
>> +err_dma_exit:
>> +       ipa_dma_exit();
>> +err_clear_gsi:
>> +       ipa_ctx->gsi = NULL;
>> +       ipa_ctx->ipa_phys = 0;
>> +       ipa_reg_exit();
>> +err_clear_ipa_irq:
>> +       ipa_ctx->ipa_irq = 0;
>> +err_clear_filter_bitmap:
>> +       ipa_ctx->filter_bitmap = 0;
>> +err_interconnect_exit:
>> +       ipa_interconnect_exit();
>> +err_clock_exit:
>> +       ipa_clock_exit();
>> +       ipa_ctx->dev = NULL;
>> +out_smp2p_exit:
>> +       ipa_smp2p_exit(dev);
>> +
> 
> No need to initialize members to zero when you are about
> to free the structure.

The IPA context is in fact a global, static structure at
the moment.  All of this bookkeeping (zeroing out things)
is a habitual practice, basically.  Regardless your point
is good and I'll remove these kinds of things as part of
converting to not using globals.

>> +static struct platform_driver ipa_plat_drv = {
>> +       .probe = ipa_plat_drv_probe,
>> +       .remove = ipa_plat_drv_remove,
>> +       .driver = {
>> +               .name = "ipa",
>> +               .owner = THIS_MODULE,
>> +               .pm = &ipa_pm_ops,
>> +               .of_match_table = ipa_plat_drv_match,
>> +       },
>> +};
>> +
>> +builtin_platform_driver(ipa_plat_drv);
> 
> This should be module_platform_driver(), and allow unloading
> the driver.

Yes.  I've done this for my own use, but the code is not
currently able to shut down cleanly.  I've been fixing a
*lot* of the things that don't clean up after themselves
today but there's more work before I can say this can be
safely built as a module.  But it's a requirement.

					-Alex



> 
>         Arnd
> 

