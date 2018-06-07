Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lLG4Ok5lGVvoBwAAmS7hNA
	; Thu, 07 Jun 2018 17:03:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E4026074D; Thu,  7 Jun 2018 17:03:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ft3i6o2l"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8260260590;
	Thu,  7 Jun 2018 17:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8260260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeFGRDU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:03:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33192 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbeFGRDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:03:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so3965785wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+zC+riEVWwJRMtaQdbVVtwYjNK4ONhMtZO9aoiw2mwg=;
        b=Ft3i6o2lrD7dHhsiyYiiv/htSE69noz5c/+fd/ieqff+8AR8ezjxEHU97D5fn0FxlJ
         7hu9MfZarfJnLE2Rt+bgdxXjZrgRhiUQFbUSKqHXMWf9MoSo3e8OwDVNGrI3xJjLa5y9
         3kI9aodNY8QdxBDTOIjpJ30xtP3eOHr2zVsMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+zC+riEVWwJRMtaQdbVVtwYjNK4ONhMtZO9aoiw2mwg=;
        b=Tl8o8luM1lDcc2YCpSccPm9XHWQurDTSBJyGvrXYtgbwYa2l0X5KC681Ui0TjnX+F+
         a3a6mhrSW37c149rutkURCp1Dsstkpz1w0nAsMoIJM1OXcvcm81XJZPnSstoVs2Zst14
         muGAOeI6Rm3TzHjYVM/EMluQcPx13uwQaOl3NokvSpYoE72ur1QNiaW9PXrj9jJeurTc
         Z4p1im4ROw5WSVjxFi8RbzYu8gmqUdeN2vBQVTbJwd5Gx0L3BMvtg2hdP0NPOZEk0bva
         A08OOvwtMqR2InFl5/Ckt5gBHkHyhh8CoA/TorhgvHo43dFGD4svHhfSfsd1/Nv5lyRi
         EO+g==
X-Gm-Message-State: APt69E3GWe262rSitFnuGncw4wejBjdpEXYjybXtkICMYtPi8Mv4ojho
        PctzIte1obj8rS2JP8uoGnedbA==
X-Google-Smtp-Source: ADUXVKIalXkuw+7oA2pFYeezvVfiS+4MA0LP6PtuZvz6z8QQCYXUbNfOBQ5+3a9t+ChUlWJ8EoKJ0g==
X-Received: by 2002:a1c:2856:: with SMTP id o83-v6mr2445617wmo.3.1528390997889;
        Thu, 07 Jun 2018 10:03:17 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id c201-v6sm4147332wmh.18.2018.06.07.10.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 10:03:17 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode for
 the cells list
To: Alban <albeu@free.fr>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
References: <1521933899-362-1-git-send-email-albeu@free.fr>
 <1521933899-362-2-git-send-email-albeu@free.fr>
 <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
 <20180417165420.423a691b@avionic-0020>
 <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
 <20180417180040.04f53495@avionic-0020> <20180418134119.2e587621@avionic-0020>
 <9f7d2987-b33e-79b5-ae58-2985fd7334e4@linaro.org>
 <20180418143243.3c23493c@avionic-0020>
 <e34619a4-e9b6-9945-a1cc-a3680aac6819@linaro.org>
 <20180418153440.187ed16e@avionic-0020>
 <d30656d6-f17e-6ed0-251f-2b59d02cd202@linaro.org>
 <20180607184155.6da38a01@tock>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0fb0e8e9-e7b8-10c3-fcdd-399c73a33878@linaro.org>
Date: Thu, 7 Jun 2018 18:03:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180607184155.6da38a01@tock>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/18 17:41, Alban wrote:
> AFAIU the only thing that we disagree on now is if the nodes
> representing the cells should be direct children of the provider
> or in a dedicated subnode. For the MTD case both solution would solve
> the binding clash. I would really appreciate if the DT people could
Am reluctant in changing the nvmem generic bindings for a special case.

Can you try this with your original subnode proposal:
just pass the subnode node pointer in np of nvmem_config:

------------------------->cut<------------------------------------
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b05aa8e81303..c9621632bbfb 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -472,7 +472,11 @@ struct nvmem_device *nvmem_register(const struct 
nvmem_config *config)
         nvmem->priv = config->priv;
         nvmem->reg_read = config->reg_read;
         nvmem->reg_write = config->reg_write;
-       nvmem->dev.of_node = config->dev->of_node;
+
+       if (config->np)
+               nvmem->dev.of_node = config->np;
+       else
+               nvmem->dev.of_node = config->dev->of_node;

         if (config->id == -1 && config->name) {
                 dev_set_name(&nvmem->dev, "%s", config->name);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index f89598bc4e1c..743345ffe2c8 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -49,6 +49,7 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned 
int offset,
   */
  struct nvmem_config {
         struct device           *dev;
+       struct device_node      *np;
         const char              *name;
         int                     id;
         struct module           *owner;

------------------------->cut<------------------------------------

thanks,
srini

> chip in so that we can settle this and get the MTD support merged.
