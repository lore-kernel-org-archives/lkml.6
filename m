Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A854C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D047620645
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ec4fMoCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D047620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbeJAPmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:42:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34134 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:42:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id z4-v6so11605233wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+41b4xfuLROPjXmXAV/GBRmIFeToWI55jGiWeOP4P0g=;
        b=Ec4fMoCQr4TEkEqR03xJi43xOmtDfP5EpWqhP76m/Bi4nM18ufUcfdWMG9eaYA6DAS
         KOWAvxT92TwiCT+4yal7u2EWCDSau5y8xJQ+JZEWCnJUXwlEuSge3wM90MSgHfqeH3eJ
         5xhp1BX4xNbwvEO/AYFfjwtGSYwc2N+fui0J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+41b4xfuLROPjXmXAV/GBRmIFeToWI55jGiWeOP4P0g=;
        b=Mm9kflpIcavfR9lK5+JT+XoFyd21awxGsH1Pusn2AwHaAr4nCQ+7NPztmjOVWz+IV3
         P8py1ytOC7HbeuedBX5b73MxuObQVjkc2pPgvqMnvBnG3BXoxBArxEPuEdW83xYU1FMP
         tWSDl+OKQkzgk74SHz/3K86GVCLuN1jBAEXUfBDPVpTw44GQDz1c4WQ+HNF6Ml+nWG2c
         EYGPGfCoJ0Rna8A3+uzLo7B4680NaBRyPjZzh9fJdgfh1h5fMLb4z3g0z8qO6pshTK5/
         pK6dHLRTxtClTgH/NbZHkG9gzUv3uENhfJer6xFmCSjd4OTYeY5SD3M7LXXpLH9VOGep
         gsmA==
X-Gm-Message-State: ABuFfoj8I9htdNGIqVrr3BPSIAvmqEwO8b2G0xoybJTNZwzwXt8ZW7mk
        jpnl9PNdkaGAV3XlAlqYYOXU7KGaDk8=
X-Google-Smtp-Source: ACcGV61dF3OIQcjM9ShjwdxN98ETnC3sshmlTQU9PszwN6OQDjhajQo+AIR4G30zTJrXipja81HKYA==
X-Received: by 2002:adf:e792:: with SMTP id n18-v6mr6046041wrm.136.1538384717980;
        Mon, 01 Oct 2018 02:05:17 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id a18sm10515797wrx.55.2018.10.01.02.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 02:05:17 -0700 (PDT)
Subject: Re: [PATCH] nvmem: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-37-robh@kernel.org>
 <CAL_JsqLDacDPo8VsqTS8otF5WOZgFXvGUNuzAZVEyDG-52zyhw@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a8af38b8-37c9-fc54-df2d-cf2403ac7644@linaro.org>
Date:   Mon, 1 Oct 2018 10:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLDacDPo8VsqTS8otF5WOZgFXvGUNuzAZVEyDG-52zyhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/18 23:06, Rob Herring wrote:
> On Mon, Aug 27, 2018 at 8:55 PM Rob Herring <robh@kernel.org> wrote:
>>
>> In preparation to remove the node name pointer from struct device_node,
>> convert printf users to use the %pOFn format specifier.
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>   drivers/nvmem/core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Ping. This has no dependencies, so please apply.

Sorry, Looks like I missed this one!
I already re-based it. I will send it with other fixes to Greg KH soon!

thanks,
--srini
> 
> Rob
> 
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index aa1657831b70..6988ee9f11ba 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -304,6 +304,7 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
>>          mutex_lock(&nvmem_cells_mutex);
>>          list_del(&cell->node);
>>          mutex_unlock(&nvmem_cells_mutex);
>> +       kfree(cell->name);
>>          kfree(cell);
>>   }
>>
>> @@ -879,7 +880,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
>>          cell->nvmem = nvmem;
>>          cell->offset = be32_to_cpup(addr++);
>>          cell->bytes = be32_to_cpup(addr);
>> -       cell->name = cell_np->name;
>> +       cell->name = kasprintf(GFP_KERNEL, "%pOFn", cell_np);
>>
>>          addr = of_get_property(cell_np, "bits", &len);
>>          if (addr && len == (2 * sizeof(u32))) {
>> @@ -904,6 +905,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
>>          return cell;
>>
>>   err_sanity:
>> +       kfree(cell->name);
>>          kfree(cell);
>>
>>   err_mem:
>> --
>> 2.17.1
>>
