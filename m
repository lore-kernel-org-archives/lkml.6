Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A49C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347C52085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347C52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeKGXjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:39:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41482 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKGXjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:39:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so20925524qkj.8;
        Wed, 07 Nov 2018 06:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7x9qXIYwWxC9M3xpC7Cw7kQGSB9dv0q2CdIBvxneeLw=;
        b=gcbicAfiY4VheY+YylSyGKFuMwnUdqbSKMlN2LjANz6qmMMhlDn0lyj+SwYq8uVJSx
         f6zviYp3JMOSiUVYRb/z/5ZV9s2+xhY+AfQtjmElf3XAHSPOBUdlMJDVjkIJlSavhj7M
         /hBTEbvvCtRkG+/XNrN2c6ZhpJ+zTqB7pgnmywIzOrUG/2XplNiP5UaKieNi97Yp6rPX
         xwf2etG2QQKhs7lD5386WifF8lJmbTJRbK5gmpWRCTnOsS4ZCCvwBuD3Vr3qioJX4l9V
         v7UzowN7mXxZW0FzfH1ygq4Vs3P2Tu4HlTTVU1wzAgiiTGWOz+mUz6EiA2jP0HJRnczy
         Bqkw==
X-Gm-Message-State: AGRZ1gL6iuaeP7vggZgMaQKNhCY8ytPoXjndOwuB6qk7s2vecL0zU5c8
        ce5B8oqN9/4bCd5V45/4XchJjcHu/w0ghOpePqYLqQ==
X-Google-Smtp-Source: AJdET5cxfl5tsAYioh22504uO++m1M+N1e6H7eYyG1mqsVRww6VDrdCC5ngr197mQvWOuZAdbZRNmExtvZPjAFQNVo8=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr353635qvj.161.1541599745845;
 Wed, 07 Nov 2018 06:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-10-elder@linaro.org>
In-Reply-To: <20181107003250.5832-10-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 15:08:46 +0100
Message-ID: <CAK8P3a0RH4wbigKR0zsbxPzqWDjrLEkYfQk4GNxhGuxs=HJHHw@mail.gmail.com>
Subject: Re: [RFC PATCH 09/12] soc: qcom: ipa: main IPA source file
To:     Alex Elder <elder@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:

> +static void ipa_client_remove_deferred(struct work_struct *work);

Try to avoid forward declarations by reordering the code in call order,
it will also make it easier to read.

> +static DECLARE_WORK(ipa_client_remove_work, ipa_client_remove_deferred);
> +
> +static struct ipa_context ipa_ctx_struct;
> +struct ipa_context *ipa_ctx = &ipa_ctx_struct;

Global state variables should generally be removed as well, and
passed around as function arguments.

> +static int hdr_init_local_cmd(u32 offset, u32 size)
> +{
> +       struct ipa_desc desc = { };
> +       struct ipa_dma_mem mem;
> +       void *payload;
> +       int ret;
> +
> +       if (ipa_dma_alloc(&mem, size, GFP_KERNEL))
> +               return -ENOMEM;
> +
> +       offset += ipa_ctx->smem_offset;
> +
> +       payload = ipahal_hdr_init_local_pyld(&mem, offset);
> +       if (!payload) {
> +               ret = -ENOMEM;
> +               goto err_dma_free;
> +       }
> +
> +       desc.type = IPA_IMM_CMD_DESC;
> +       desc.len_opcode = IPA_IMM_CMD_HDR_INIT_LOCAL;
> +       desc.payload = payload;
> +
> +       ret = ipa_send_cmd(&desc);

You have a bunch of dynamic allocations in here, which you
then immediately tear down again after the command is complete.
I can't see at all what you do with the DMA address, since you
seem to not use the virtual address at all but only store
the physical address in some kind of descriptor without ever
writing to it.

Am I missing something here?

> +/* Remoteproc callbacks for SSR events: prepare, start, stop, unprepare */
> +int ipa_ssr_prepare(struct rproc_subdev *subdev)
> +{
> +       printk("======== SSR prepare received ========\n");

I think you mean dev_dbg() here. A plain printk() without a level
is not correct and we probably don't want those messages to arrive
on the console for normal users.

> +static int ipa_firmware_load(struct de
> +
> +err_clear_dev:
> +       ipa_ctx->lan_cons_ep_id = 0;
> +       ipa_ctx->cmd_prod_ep_id = 0;
> +       ipahal_exit();
> +err_dma_exit:
> +       ipa_dma_exit();
> +err_clear_gsi:
> +       ipa_ctx->gsi = NULL;
> +       ipa_ctx->ipa_phys = 0;
> +       ipa_reg_exit();
> +err_clear_ipa_irq:
> +       ipa_ctx->ipa_irq = 0;
> +err_clear_filter_bitmap:
> +       ipa_ctx->filter_bitmap = 0;
> +err_interconnect_exit:
> +       ipa_interconnect_exit();
> +err_clock_exit:
> +       ipa_clock_exit();
> +       ipa_ctx->dev = NULL;
> +out_smp2p_exit:
> +       ipa_smp2p_exit(dev);
> +

No need to initialize members to zero when you are about
to free the structure.

> +static struct platform_driver ipa_plat_drv = {
> +       .probe = ipa_plat_drv_probe,
> +       .remove = ipa_plat_drv_remove,
> +       .driver = {
> +               .name = "ipa",
> +               .owner = THIS_MODULE,
> +               .pm = &ipa_pm_ops,
> +               .of_match_table = ipa_plat_drv_match,
> +       },
> +};
> +
> +builtin_platform_driver(ipa_plat_drv);

This should be module_platform_driver(), and allow unloading
the driver.

        Arnd
