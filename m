Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EEFC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A072189A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFNAw6Fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A072189A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeHMS1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:27:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39793 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:27:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so8502971edi.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P/H2JP+qb8VVvDhe6Ak6wYetfbRveKXjdPevQ/+pf7E=;
        b=kFNAw6FkYTOZBAaPnop6ir2hys30N7nU0BS6hOTwZI5kxqUOYnnHaaTmtdAGNet5jN
         vmoVltdZ/MZtmbRJ4/DpAADWQPDZGhDjRkf2GZoglcF8w0wpb3IgQ4AjhT7OU7PsojcF
         NPpikG2p7KIWrH9q9wMvAX8060x5JiCLnmVs8YtEQiHxGtvspQaeQLmtnH/oiYuo7Bl9
         UBcS1eQKlXsgAPXKJqhNPAC80IOefmQ6HTLSCZ94OAN7250j9wxCSEo74X1U2UdfjR+E
         B+hJiqsjNJkt2kmb+K73qqDpX6DHhdoFEOi8xFNGBSdYptiBGT3vWePXsT8A9CmE3TLn
         vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P/H2JP+qb8VVvDhe6Ak6wYetfbRveKXjdPevQ/+pf7E=;
        b=R/j9KPj7bh8obixxAVr2+3imSHfDu0ONx024LO+CdtjTmKS0Q6tYU2a5bnG223AdgX
         os5X0BYeQ2dwNRTTv76FBMwPFWjUj2+QAjt3tr73C01aKvc+rCGRCnIfzoUGlWRup6J+
         4mxw5wn7Kdn56G+Z92v8HD8O0LBM65T641kMcmVyUjnogig9deCg/qEPl4+jlwvbvthT
         Gq/fq0ShyPmvmaSZ4rSVOZwC/WsiJii99zzCCrmULRPqckWOAsIIj/XvOdH5tc7jlczT
         Vyn2rSGmoZzR2lFwbREwofCrG1O5OJ08F+0Jwg0Uvjg0iu79CuSqGtz2ZbVGCksoXNvg
         G9jg==
X-Gm-Message-State: AOUpUlFBpqyzRP5i9Lv3P4KoecwHzHj642NwRBAMZL0VPqLypiPmuzV7
        eSS8NC9y/QvBN4N/kXXy2H6v+5aEvtEJT7GVAkfAx/3S
X-Google-Smtp-Source: AA+uWPwC3YoElDm8k0OSE2PuTZhpgorvGtjPaCj7fRIm4qFNGy8lcC0PwwyD7TpEa8rWX6CiffDqavlV4lD/jp9PLis=
X-Received: by 2002:a50:af03:: with SMTP id g3-v6mr22474900edd.220.1534175060700;
 Mon, 13 Aug 2018 08:44:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 08:44:20
 -0700 (PDT)
In-Reply-To: <1527540154-25179-1-git-send-email-samarth.parikh@arm.com>
References: <1527540154-25179-1-git-send-email-samarth.parikh@arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 13 Aug 2018 21:14:20 +0530
Message-ID: <CABb+yY1rGEkfHNgFt2ATY-EoqJnopqZq7fRXRReKPpZ75T+gLA@mail.gmail.com>
Subject: Re: [PATCH v3] mailbox: arm_mhu: add support for mhuv2
To:     Samarth Parikh <samarth.parikh@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Arvind Chauhan <Arvind.Chauhan@arm.com>,
        Deepak Pandey <Deepak.Pandey@arm.com>, samarthp@ymail.com,
        Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 2:12 AM, Samarth Parikh <samarth.parikh@arm.com> wrote:


> diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> index 4971f03..1633535 100644
> --- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>
From the documentation you shared, MHUv2 is quite a different
controller. Please create separate bindings document.


> +
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/amba/bus.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +
Can we trim the list ?


> +#define MHU_V2_REG_STAT_OFS            0x0
> +#define MHU_V2_REG_CLR_OFS             0x8
> +#define MHU_V2_REG_SET_OFS             0xC
> +#define MHU_V2_REG_MSG_NO_CAP_OFS      0xF80
> +#define MHU_V2_REG_ACC_REQ_OFS         0xF88
> +#define MHU_V2_REG_ACC_RDY_OFS         0xF8C
> +
> +#define MHU_V2_LP_OFFSET               0x20
> +#define MHU_V2_HP_OFFSET               0x0
> +#define MHU_V2_CHANS                   2
> +
The documentation says there can be upto 124 channels, actual value
reflected in MHU_V2_REG_MSG_NO_CAP_OFS.
And there is no priority of any channel really.


> +#define mbox_to_arm_mhuv2(c) container_of(c, struct arm_mhuv2, mbox)
> +
> +struct mhuv2_link {
> +       unsigned int irq;
> +       void __iomem *tx_reg;
> +       void __iomem *rx_reg;
> +};
> +
TX and RX are independent channels, and may be different in number. So
maybe have only 'reg' and a 'direction' flag. Accordingly, update the
bindings.


> +
> +static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
> +{
> +       int i, err;
> +       struct arm_mhuv2 *mhuv2;
> +       struct device *dev = &adev->dev;
> +       void __iomem *rx_base, *tx_base;
> +       const struct device_node *np = dev->of_node;
> +       unsigned int pchans;
> +       int mhuv2_reg[MHU_V2_CHANS] = {MHU_V2_LP_OFFSET, MHU_V2_HP_OFFSET};
> +
> +       /* Allocate memory for device */
> +       mhuv2 = devm_kzalloc(dev, sizeof(*mhuv2), GFP_KERNEL);
> +       if (!mhuv2)
> +               return -ENOMEM;
> +
> +       rx_base = of_iomap((struct device_node *)np, 0);
> +       if (!rx_base) {
> +               dev_err(dev, "failed to map rx registers\n");
> +               return -ENOMEM;
> +       }
> +
> +       tx_base = of_iomap((struct device_node *)np, 1);
> +       if (!tx_base) {
> +               dev_err(dev, "failed to map tx registers\n");
> +               iounmap(rx_base);
> +               return -ENOMEM;
> +       }
> +
We don't have to fix the order of TX and RX offsets.
The PID[2] is 0x4 for TX and 0xb for RX. Which is more reliable and flexible.


> +       pchans = readl_relaxed(tx_base + MHU_V2_REG_MSG_NO_CAP_OFS);
>
There should be also
            rxpchans = readl_relaxed(rx_base + MHU_V2_REG_MSG_NO_CAP_OFS);

because the spec has a separate MHU_V2_REG_MSG_NO_CAP_OFS for tx and rx regions.

Cheers!
