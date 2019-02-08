Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B6220844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfyr+dAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfBHQPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:15:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45726 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:15:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so2909518lfa.12;
        Fri, 08 Feb 2019 08:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bLXvZvUJiHt8osK66qwWWSmj4MuGS30szSGLqg7p7O4=;
        b=Wfyr+dAZAb3WwpQ0Y3GtMe/tjcMfcEL12Hd9IoDe6AeJmnBjO44Bm0H+Us5CMqGyuf
         irHu+13oCQREBShCEwzrV1KyfPqS7rpEpG9poooqsGljBMjNcI+Zgg9rZtXQoMWjEh7r
         1J9kHjlP01geXqzSU0dljk0oMRJB1v1vr/hQ5Nz380e/9lvhFldQRFsol9bcyzs6S/lP
         zLXYzjdmXL3wLmCT8pjwLiqHM+0YpbhhWqQd0vIvEErbst0K3N0t5KvAU4GDe1h6ow6i
         UH6y5/b1tgGSJrQdaHTB6HX0xC8qeb2Vxp349M0292PMBPICiK+S4knwLyv8tI8tjC3h
         figA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLXvZvUJiHt8osK66qwWWSmj4MuGS30szSGLqg7p7O4=;
        b=flxZr9adYzVXYCrHVgka+YuuHFfWGro8m4D4DxOJa6tQHyXVCLZ90g7w8gVpQveLfx
         pOn0xk4wiPeHWq6VayGzyITmN2AFTe8qbk3dJr+uW5JC7P69vyMu8oaG8YCdaYN3r+4b
         JoalBOGSF8fi1gTxDPL2pWnrsgKUqicMz+QpMKbfGxKeVLz8e7kpLUEynu+/EAo+FXqq
         Zwh1NJRgslTi9tB5Au/8jGOPDxNYX1gMt/MPGTvYPEo2ahZeMwWzsrEzR4m1PlpJ5R2E
         /iR5Sv+SYD78o+EB/2ZrRcPVNTbT5YoPQ8AuzfaODE1oWu0sgru6cYZM4V4g6E0Zm1eo
         W+cQ==
X-Gm-Message-State: AHQUAuZ5zvZJ91miI4Wuj/fkaExgWZssBd/klYdnSJP55ISjioOosQNO
        3Naw/gRuY0ntxQT+e6vYq3henREZ
X-Google-Smtp-Source: AHgI3IYIJkxHeOnL+47gmSWpAQNyyjc4rA9GtKLMAUPIZbMeglX5ijMtudZUSpnYSW1H3hYmT+poPg==
X-Received: by 2002:a19:4dd0:: with SMTP id a199mr14789692lfb.42.1549642521876;
        Fri, 08 Feb 2019 08:15:21 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id v24-v6sm289881ljj.65.2019.02.08.08.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 08:15:21 -0800 (PST)
Subject: Re: [PATCH V15 4/6] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-4-git-send-email-skomatineni@nvidia.com>
 <7806f2cd-72b4-6ae3-b75f-0fc74fb62b95@gmail.com>
 <BYAPR12MB3398BE6DA6F1E82E5F2525C2C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB3398382FF9052AE466CE29ECC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB339863A43F030013DCA7F548C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <21901823-2ec1-6bd5-d0df-2360858f2b7e@gmail.com>
Date:   Fri, 8 Feb 2019 19:15:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339863A43F030013DCA7F548C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 18:58, Sowjanya Komatineni пишет:
> 
> 
>>> Please use "release_dma:" variant that I suggested in the comment to v14 because:
>>>>
>>> 1) It's just a good (and common-style in kernel) tone to unwind errors handling in the opposite order, it makes code more straight forward and helps to avoid silly mistakes.
>>>
>>> 2) It keeps the current code consistent in regards to probe error-handling.
>>>
>>
>> Can move tegra_i2c_release_dma under the same disable_div_clk label before clk_disable
>>
>> Order in probe is
> 	clk_prepare
> 	i2c_runtime_resume
> 	clk_enable in case of multimaster mode
> 	i2c_init_dma
>>
>> unwinding should be order is
> 	release_dma
> 	disable_div_clk
> 	disable_rpm
> 	unprepared
>>
>> Probe failure from tegra_i2c_init_dma, tegra_i2c_init, devm_request_irq, i2c_add_numbered_adapter all of them perform goto disable_div_clk
>>
>> I can add tegra_i2c_release_dma before performing clock disable under same disable_div_clk so all existing disable_div_clk labels remain same.
>> Otherwise adding new label release_dma causes all goto disable_div_clk statement also to be changed but its same as adding release_dma under disable_div_clk above the clk_disable.
>>
> 
> OK, please ignore above. will add release_dma to show explicitly for readability.
> With release_dma all error handlers performing disable_clk_div need to go thru release dma and disable_clk_div label is not needed.

tegra_i2c_init_dma() releases dma itself in a case of error, hence it should jump to the disable_clk_div.

> So having release dma under disable_clk before clk_disable function is also same. 
> Please confirm if this is ok to use same disable_div_clk or do you prefer release_dma label removing disable_div_clk

In general goto-label naming should reflect the actual jump-action. If goto jumps to dma-releasing, then the action is release-dma and not disable-clk.

Hence the correct variant is:

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 7104213d813b..62e81096fb55 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1604,14 +1604,14 @@ static int tegra_i2c_probe(struct platform_device *pdev)
        ret = tegra_i2c_init(i2c_dev, false);
        if (ret) {
                dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
-               goto disable_div_clk;
+               goto release_dma;
        }
 
        ret = devm_request_irq(&pdev->dev, i2c_dev->irq,
                        tegra_i2c_isr, 0, dev_name(&pdev->dev), i2c_dev);
        if (ret) {
                dev_err(&pdev->dev, "Failed to request irq %i\n", i2c_dev->irq);
-               goto disable_div_clk;
+               goto release_dma;
        }
 
        i2c_set_adapdata(&i2c_dev->adapter, i2c_dev);
@@ -1625,14 +1625,16 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 
        ret = i2c_add_numbered_adapter(&i2c_dev->adapter);
        if (ret)
-               goto disable_div_clk;
+               goto release_dma;
 
        return 0;
 
+release_dma:
+       tegra_i2c_release_dma(i2c_dev);
+
 disable_div_clk:
        if (i2c_dev->is_multimaster_mode)
                clk_disable(i2c_dev->div_clk);
-       tegra_i2c_release_dma(i2c_dev);
 
 disable_rpm:
        pm_runtime_disable(&pdev->dev);
