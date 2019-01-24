Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B1FC282C4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D7D2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmioJtdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfAXDOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:14:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43245 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfAXDOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:14:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so2240435pfk.10;
        Wed, 23 Jan 2019 19:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwI3E7q4DyXyUZqSE47EMgNwFn6pB/gRH3/afCHNjQw=;
        b=KmioJtdZB51euERwWmQQ2wSzvA4/neC1DSfIlSoknejoj6dzMPZaFJDuEgCOTZ4goC
         7hSpJQPcQRuBfqlRuMGLqDwx0z7mmeMHuu0Hb5nEqJUFsoKQJjesRPvl5RPZ1O6TSQCN
         LsrJecDP9PKw3vYpjbRKFHhJSeRtzD5KAxfvON57SjcjGPfiuUXDM3a/3xFMkM9k9eyQ
         xNlAUwElaBuqq+XGCH/65OQc9hVTXyPEOYNOcqFW6QEwWUqVn1gRFwDIFAx56LbSlGXr
         iaOoGTFodpAgNmFMO6gQj10a6EhnhyVgT1x0I291ULsoGBHNbNKXr/1ezmN6j1bRzs88
         h2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwI3E7q4DyXyUZqSE47EMgNwFn6pB/gRH3/afCHNjQw=;
        b=PE8Q/getOh6PyCqDr7oX6+FWoTCKAIX78krylfmaVAzc4wv5ur9bOO6IaaJoarzBv8
         gcgHD2ngRtVCzBr5iHLq8Ry9w0wIr1Bww5ny1J/afDeDfPVlJlncbvcyUUlHjigN6L19
         xhG2YkUeHqG3B/TPeFMeVDubPfpQmPOKmq/nrt55tVck9karkVz94OYqlrUOKySM/j+Q
         d0ppN6PfZsOXoUhGvDU7JfsCtFv04gPF1qxy2FUXtO6+onEEx0k5URyPVAGWuIges2Bq
         Elcqs9nP/nYfn9SJiCzyQdd37JF8JxgGEnRXIpQTE1ocLVXj0t3Y4HiT2AhDiSDSagkF
         vMvg==
X-Gm-Message-State: AJcUukeCMFf7fH+KrST5/gKrkq8uyw6Kl84731vahcZ5ZH1B4rEtQxYq
        y8RMkfYXPLo1kqoedKbkYeXtG72M
X-Google-Smtp-Source: ALg8bN6HBPEc/pX8+TzzOECa+0LvSndR3LbjARU2yZ+PduN21eHsIaom6H+oMcwF7w9sd0Bsd2BqAw==
X-Received: by 2002:a63:160d:: with SMTP id w13mr4475603pgl.43.1548299640617;
        Wed, 23 Jan 2019 19:14:00 -0800 (PST)
Received: from [192.168.43.97] ([121.90.236.7])
        by smtp.gmail.com with ESMTPSA id p24sm31217894pfk.155.2019.01.23.19.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 19:13:59 -0800 (PST)
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
 <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <67fa5f94-886b-f09c-c93d-832e427ffec8@gmail.com>
Date:   Thu, 24 Jan 2019 04:13:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 3:23 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/01/24 上午 09:54
>>
>>
>> > +#define RPC_CMNCR      0x0000   // R/W
>>
>> Is there any reason for using those horrible C++ comments ?
> 
> By Mark's comments for the SPDX header needs to be C++ style and
> I patch the whole RPC driver comments using C++ style otherwise it looks
> messy.

I think the C++ comments should only be applied to the SPDX identifier,
maybe the header, but not the entire file.

>> [...]
>>
>> > +module_platform_driver(rpc_spi_driver);
>>
>> RPC is not a SPI controller, it's a SPI and HF controller.
>>
>> Also, how difficult will it be to add the HF support ?
> 
> One of my customers needs RPC SPI driver for our company's
> Octal-Flash,MX25UW51245G.
> We don't have HF product and hope you could understanding.

I am worried that when we need to add RPC HF support (which is what all
boards but the D3 Draak use), we will have to rewrite the entire driver
and/or convert it to MFD and that would be a tremendous undertaking. I'd
prefer to have the driver ready for the HF addition before it's accepted
upstream.

-- 
Best regards,
Marek Vasut
