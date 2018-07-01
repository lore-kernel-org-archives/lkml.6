Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E06C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 12:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52ADA23ECE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 12:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThJwYN+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52ADA23ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeGAMMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 08:12:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40908 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeGAMMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 08:12:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so6066992wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a5bsHJ+zZudz6APLxvSLcmgbhgsfKTjBnx7PP75UAIM=;
        b=ThJwYN+veT1sBRXTUxuLRAbDh8uoNOpR7lgFZFpm+rN4T4GTKSezbZ88jZyNaVQJr2
         PhGB5dxhfOjw1BTUu6QSX4FM4qrEK//pxtmZTS/rfpigAya57A3t70k/xwODPoNZLpDl
         aaT+kHCjw4nMSpheGgdg8rVcKtXtLbafbiudo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a5bsHJ+zZudz6APLxvSLcmgbhgsfKTjBnx7PP75UAIM=;
        b=t2MeIjFxLQmg1aV3GhtmpkIpuzxCuBPhcGabqPvyU+EHAPdfkKGC/idcdcRPuRKgnd
         2JVUH1ZPGI062VSYWRGd2Uu7/U6veyoXzvCyk9YWZWe05jML0ApLOsRP3aLIFnGGdfG9
         ZltvWh2Zw6DxNQg8hSOqq1nntgzxBFe86xhpA/tsxKl01MnwkHtT3LHBgAdaiz+zkDDK
         CunXcW1MBU6TgvntLfQdS7KrWgaUc7WB+cfvEdG/0AWP5SsaoP8Nz0KHlK2zb0SM8LUM
         X2/fbnLKmMPs6JqrS86h3nrawVCm8LSPVAkgFU3L0hAsv5jT1BxElUEH6PtYbFsflpiJ
         XGJg==
X-Gm-Message-State: APt69E3AJ/vNafIrkU7DGZLvTzo/Fy87k4MOcsnCvDB3QKAkZnZVSf94
        QydcAnjBtjdyEfmO04v25Gr4MQTH1v8=
X-Google-Smtp-Source: AAOMgpcOExrD3Giqmjbb4G5OnBiIyimCUDphpoIUnyzybx+zCAeuQx0Smv7nkWRadlBqHhpxCoTDFA==
X-Received: by 2002:a1c:647:: with SMTP id 68-v6mr6297750wmg.82.1530447169534;
        Sun, 01 Jul 2018 05:12:49 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e3-v6sm10258554wmd.2.2018.07.01.05.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 05:12:48 -0700 (PDT)
Subject: Re: [PATCH v5 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-7-georgi.djakov@linaro.org>
 <CAE=gft6pbLzeLLtpWd-jHbvYuURi=SpODOVqgY7mdHhmz=ZP9A@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <8e2218b4-a193-3bb4-b732-3608a4019977@linaro.org>
Date:   Sun, 1 Jul 2018 15:12:47 +0300
MIME-Version: 1.0
In-Reply-To: <CAE=gft6pbLzeLLtpWd-jHbvYuURi=SpODOVqgY7mdHhmz=ZP9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 06/26/2018 11:48 PM, Evan Green wrote:
> On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
>>

[..]

>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/msm8916.c
>> @@ -0,0 +1,495 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Linaro Ltd
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#include <dt-bindings/interconnect/qcom.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/interconnect-provider.h>
> 
> Nit: the previous two should be swapped for alphabetization.

Ok.

>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#include "smd-rpm.h"
>> +
>> +#define RPM_MASTER_FIELD_BW    0x00007762
> 
> This is unused, since it moved into that other file.

Ok.

[..]

>> +/**
>> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
>> + * @name: the node name used in debugfs
>> + * @links: an array of nodes where we can go next while traversing
>> + * @id: a unique node identifier
>> + * @num_links: the total number of @links
>> + * @port: the offset index into the masters QoS register space
>> + * @buswidth: width of the interconnect between a node and the bus (bytes)
>> + * @ap_owned: the AP CPU does the writing to QoS registers
>> + * @rpm: reference to the RPM SMD driver
>> + * @qos_mode: QoS mode for ap_owned resources
>> + * @mas_rpm_id:        RPM id for devices that are bus masters
>> + * @slv_rpm_id:        RPM id for devices that are bus slaves
>> + * @rate: current bus clock rate in Hz
>> + */
>> +struct qcom_icc_node {
>> +       unsigned char *name;
>> +       u16 links[MSM8916_MAX_LINKS];
>> +       u16 id;
>> +       u16 num_links;
>> +       u16 port;
>> +       u16 buswidth;
>> +       bool ap_owned;
>> +       struct qcom_smd_rpm *rpm;
> 
> This is unused.

Ok, will remove.

>> +       enum qcom_qos_mode qos_mode;
>> +       int mas_rpm_id;
>> +       int slv_rpm_id;
>> +       u64 rate;
>> +};
>> +

[..]

>> +static int qcom_icc_init(struct icc_node *node)
>> +{
>> +       struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
>> +       int ret;
>> +
>> +       /* TODO: init qos and priority */
>> +
>> +       clk_set_rate(qp->bus_clk, INT_MAX);
> 
> Vroom! What's the rationale here? I wonder if it might be better to
> avoid touching the clocks initially, and expect that the boot loader
> sets up a decent initial set of bus frequencies for consumers that
> never enable bus scaling? Otherwise, I worry that this driver becomes
> basically an essential driver for the platform solely because of this
> line and the one below, when really it might not be.

The idea is to run the interconnects at max rate until consumers start
sending requests, but i understand your worry and we can live without
this for now. The better solution would be to set maximum bandwidth and
remove it at late_init (after consumers are registered) or use this
patchset: https://lkml.org/lkml/2018/3/21/897
Actually I have some patches which add support for interconnects to keep
the bandwidth constraints active until consumers are registered. The
whole boot constraint thing adds complexity and introduces some
overhead, but hopefully can be optimized.

>> +       ret = clk_prepare_enable(qp->bus_clk);
>> +       if (ret)
>> +               pr_info("%s: error enabling bus clk (%d)\n", __func__, ret);
>> +       clk_set_rate(qp->bus_a_clk, INT_MAX);
>> +       ret = clk_prepare_enable(qp->bus_a_clk);
>> +       if (ret)
>> +               pr_info("%s: error enabling bus_a clk (%d)\n", __func__, ret);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw, u32 peak_bw,
>> +                             u32 *agg_avg, u32 *agg_peak)
>> +{
>> +       *agg_avg += avg_bw;
>> +       *agg_peak = max(*agg_peak, peak_bw);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
>> +                       u32 avg, u32 peak)
>> +{
>> +       struct qcom_icc_provider *qp;
>> +       struct qcom_icc_node *qn;
>> +       struct icc_node *node;
>> +       struct icc_provider *provider;
>> +       u64 avg_bw = icc_units_to_bps(avg);
>> +       u64 peak_bw = icc_units_to_bps(peak);
>> +       u64 rate = 0;
>> +       int ret = 0;
>> +
>> +       if (!src)
>> +               node = dst;
>> +       else
>> +               node = src;
>> +
>> +       qn = node->data;
>> +       provider = node->provider;
>> +       qp = to_qcom_provider(node->provider);
>> +
>> +       /* set bandwidth */
>> +       if (qn->ap_owned) {
>> +               /* TODO: set QoS */
>> +       } else {
>> +               /* send message to the RPM processor */
>> +               if (qn->mas_rpm_id != -1) {
>> +                       ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>> +                                                   RPM_BUS_MASTER_REQ,
>> +                                                   qn->mas_rpm_id,
>> +                                                   avg_bw);
> 
> You don't check for failure here, and potentially clobber failure with
> success. Unless only one of mas_rpm_id and slv_rpm_id is ever set. But
> no, I see SNOC_INT_0/1 set both. Same for below.

Ok, will add error checking.

>> +               }
>> +
>> +               if (qn->slv_rpm_id != -1) {
>> +                       ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>> +                                                   RPM_BUS_SLAVE_REQ,
>> +                                                   qn->slv_rpm_id,
>> +                                                   avg_bw);
>> +               }
>> +       }
>> +
>> +       rate = max(avg_bw, peak_bw);
>> +
>> +       do_div(rate, qn->buswidth);
>> +
>> +       if (qn->rate != rate) {
>> +               ret = clk_set_rate(qp->bus_clk, rate);
>> +               if (ret) {
>> +                       pr_err("set clk rate %lld error %d\n", rate, ret);
>> +                       return ret;
>> +               }
>> +
>> +               ret = clk_set_rate(qp->bus_a_clk, rate);
>> +               if (ret) {
>> +                       pr_err("set clk rate %lld error %d\n", rate, ret);
>> +                       return ret;
>> +               }
>> +
>> +               qn->rate = rate;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static int qnoc_probe(struct platform_device *pdev)
>> +{
>> +       const struct qcom_icc_desc *desc;
>> +       struct qcom_icc_node **qnodes;
>> +       struct qcom_icc_provider *qp;
>> +       struct resource *res;
>> +       struct icc_provider *provider;
>> +       size_t num_nodes, i;
>> +       int ret;
>> +
>> +       /* wait for RPM */
>> +       if (!qcom_icc_rpm_smd_available())
>> +               return -EPROBE_DEFER;
>> +
>> +       desc = of_device_get_match_data(&pdev->dev);
>> +       if (!desc)
>> +               return -EINVAL;
>> +
>> +       qnodes = desc->nodes;
>> +       num_nodes = desc->num_nodes;
>> +
>> +       qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
>> +       if (!qp)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       qp->base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(qp->base))
>> +               return PTR_ERR(qp->base);
>> +
>> +       qp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
>> +       if (IS_ERR(qp->bus_clk))
>> +               return PTR_ERR(qp->bus_clk);
>> +
>> +       qp->bus_a_clk = devm_clk_get(&pdev->dev, "bus_a_clk");
>> +       if (IS_ERR(qp->bus_a_clk))
>> +               return PTR_ERR(qp->bus_a_clk);
>> +
>> +       provider = &qp->provider;
>> +       provider->dev = &pdev->dev;
>> +       provider->set = &qcom_icc_set;
>> +       provider->aggregate = &qcom_icc_aggregate;
>> +       INIT_LIST_HEAD(&provider->nodes);
>> +       provider->data = qp;
>> +
>> +       ret = icc_provider_add(provider);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "error adding interconnect provider\n");
>> +               return ret;
>> +       }
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               struct icc_node *node;
>> +               int ret;
>> +               size_t j;
>> +
>> +               node = icc_node_create(qnodes[i]->id);
>> +               if (IS_ERR(node)) {
>> +                       ret = PTR_ERR(node);
>> +                       goto err;
>> +               }
>> +
>> +               node->name = qnodes[i]->name;
>> +               node->data = qnodes[i];
>> +               icc_node_add(node, provider);
>> +
>> +               dev_dbg(&pdev->dev, "registered node %s\n", node->name);
>> +
>> +               ret = qcom_icc_init(node);
>> +               if (ret)
>> +                       dev_err(&pdev->dev, "%s init error (%d)\n", node->name,
>> +                               ret);
>> +
>> +               /* populate links */
>> +               for (j = 0; j < qnodes[i]->num_links; j++)
>> +                       if (qnodes[i]->links[j])
>> +                               icc_link_create(node, qnodes[i]->links[j]);
>> +       }
>> +
>> +       platform_set_drvdata(pdev, provider);
>> +
>> +       return ret;
>> +err:
>> +       icc_provider_del(provider);
>> +       return ret;
>> +}
>> +
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +       struct icc_provider *provider = platform_get_drvdata(pdev);
>> +
>> +       icc_provider_del(provider);
> 
> This function can fail, so you should probably pass the failure along.
> 

Ok! Thank you!

BR,
Georgi
