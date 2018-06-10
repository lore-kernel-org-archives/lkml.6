Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9vQBM1L+HFuFAgAAmS7hNA
	; Sun, 10 Jun 2018 10:32:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A707E60850; Sun, 10 Jun 2018 10:32:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjJR4ZFS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D80CE6070A;
	Sun, 10 Jun 2018 10:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D80CE6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeFJKcn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 06:32:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45303 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753865AbeFJKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 06:32:39 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so17386883wrm.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eKObGpcMzXuzqQApEz6WE0kVA68JdMvl/wu0poaAl3Y=;
        b=XjJR4ZFSq4geU7LNx0t0jUBlJmLn/GK5Hyzp4Z3aZR0+74E2wYtaFWsQAX4dsXieGk
         c6OhadD0E3JzHaMwT2M8qdAkv9D8tBJyvm3TXKHGvkVcgroSqhgJgVUJQ0YW04sTDXEC
         PFZFK58wtXzhgjFdfNNTX3MLn3gFBAAZFyhqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eKObGpcMzXuzqQApEz6WE0kVA68JdMvl/wu0poaAl3Y=;
        b=Y/O4fJaHkKNzxuYeOhZkfof0ENNwwJaooIezYfayI/UPl2GL0pyjTNeDHp/pW0G+4B
         BFW4XdKrQpqgx6EuGOXTyWwl2jhw5RnjMs4MluoTx3SproC88Te0zRbcmRws6+ElCYkg
         Two3HwcYlZaSOK46fxNv3NSGJND2vkQOq7WwOqpdBtxzEGjjuAW9sSspKqrq3FYHRKxM
         30BVZpUA6btPvseOPsczJXmKuuZM5V/w2tlak9uZsHfam4sMt3qjzjYz2M8/sRCEdm/3
         rq/BwDsv/EhVpyvuQeIJq0oD/3gdYkaSaG9tYSdNRj0/Efqgf2PEVQ+p5FltDLsEcFRq
         J3gA==
X-Gm-Message-State: APt69E3VBRL+VIP6ufTh+ThS0pkj8LNz9p8CC+2AX6fsfZ8rjoR+Lp71
        h0Niui+EiJ99hmbc+A0TO+3FOg==
X-Google-Smtp-Source: ADUXVKILN1LnofjByb/Wwk8L8EmuNbI443GchMBtJd/M4TjF0oLNyVLsTTzKhkVOHalYtatN0+TGjw==
X-Received: by 2002:adf:eb0c:: with SMTP id s12-v6mr7573592wrn.174.1528626758347;
        Sun, 10 Jun 2018 03:32:38 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id k36-v6sm55877021wrc.20.2018.06.10.03.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 03:32:37 -0700 (PDT)
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
 <0fb0e8e9-e7b8-10c3-fcdd-399c73a33878@linaro.org>
 <20180608125938.4fd457a0@tock>
 <cd7a0085-66cd-308e-a950-cd0eb96db945@linaro.org>
 <20180608190717.55cb185c@tock>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <02d3cba5-01a3-4d8f-55fc-9c7b7fd5e5c1@linaro.org>
Date: Sun, 10 Jun 2018 11:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180608190717.55cb185c@tock>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/18 18:07, Alban wrote:
> On Fri, 8 Jun 2018 12:34:12 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> 
...
> 
> I looked into this. It would work fine for the cells but not so nicely
> for the nvmem device API. The phandle for the nvmem device would have
> to reference the node passed here and not the real device. We would end
> up with a DT like this:
> 
> flash@0 {
> 	compatible = "mtd";
> 	...
> 	nvmem_dev: nvmem-cells {
> 		compatible = "nvmem-cells";
> 		...
>          };
> };
> 
> other-device@10 {
> 	...
> 	nvmem = <&nvmem_dev>;
> };
> 
> Now if there is no cell defined we have this empty child node that make
> very little sense, it is just there to accommodate the nvmem API.
> 
NO. This just looks fine!
nvmem-cells is the nvmem provider node without which you would not have 
any provider instance.
All this looks as expected!
Am not sure what is the problem here!


> What I would suggest now is to just change the wording. We don't
> deprecate the current binding, but we extend it to allow grouping the
> cells in a child node if required. The code to support this is trivial,
> (4 lines including error handling) so even if we expect very few
> bindings to make use of it it is not going to be maintenance drag.
> That would look like this:

> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.txt b/Documentation/devicetree/bindings/nvmem/nvmem.txt
> index fd06c09..085d042 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.txt
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.txt
> @@ -19,7 +19,10 @@ Optional properties:
>   
>   = Data cells =
>   These are the child nodes of the provider which contain data cell
> -information like offset and size in nvmem provider.
> +information like offset and size in nvmem provider. Alternatively the data
> +cells can be grouped in a node that has a compatible property set to
> +"nvmem-cells".
> +
>   
>   Required properties:
>   reg:   specifies the offset in byte within the storage device.
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 4e94a78..3e1369c 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -859,6 +859,14 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
>          if (!nvmem_np)
>                  return ERR_PTR(-EINVAL);
>   
> +       /* bindings that already have anonymous child nodes can instead put
> +        * their cells in a child node with an nvmem-cells compatible. */
> +       if (of_device_is_compatible(nvmem_np, "nvmem-cells")) {
> +               nvmem_np = of_get_next_parent(nvmem_np);
> +               if (!nvmem_np)
> +                       return ERR_PTR(-EINVAL);
> +       }
> +
>          nvmem = __nvmem_device_get(nvmem_np, NULL, NULL);
>          of_node_put(nvmem_np);
>          if (IS_ERR(nvmem))
> 
> What about it?
Let me repeat what I have said in my previous emails:

Having a subnode still sounds very fragile to me,
and this could be much specific case of MTD provider. We might have
instances where this could be sub-sub node of the the original provider
for other providers. Also I do not want to bring in Provider specifics 
layout into nvmem bindings.

I can not make myself any clearer than this, Its going to be a NAK from 
my side for the above reasons!

Also, patch I shared should give enough flexibility to various range of 
providers which have different child node layouts without touching the 
nvmem bindings. If it works please use it.


thanks,
srini
> 
> Alban
> 
