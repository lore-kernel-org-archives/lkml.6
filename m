Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2400FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FF0222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7k/lFrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404711AbfBOJ36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:29:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40954 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392822AbfBOJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:29:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15so826047wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OEnwGAiuFy8bBpFq9pPytLIcw+y/tAtIcUvB8liOjts=;
        b=T7k/lFrPu08ytbc7nMtd+y3ezVlYviXSgH/GjkGUn8ZbRquqaQdjmFm0yKqLK1HJso
         SdHvl/ycFZQAfJ5XN9bbax9QmR8yYjcdiG88aV9AgIiLhk97I54ZtTo80vWURWpylmEv
         +TVQxf6PfR6ThGQ0f8Z4b6cDgvMRbm+qT6obC2Vu2DVyWVZvaYGDBrpu1Jrui00KWj/M
         jdvmy6jDhfcHKsTncdJ+lEyEahpUfEHOxdGxVSK4LpuLRaoOHyIN62WOBqLwV7dGWziI
         iVmnfYQze6Z0cKqQud7HWGtGwqrLp0zcfMq7O1VB+3gAGPqc35ly4nJwJy6w/Gd9DdB8
         bF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OEnwGAiuFy8bBpFq9pPytLIcw+y/tAtIcUvB8liOjts=;
        b=AuSba51Mpru1nHnzBMqRx7OoXWZu9xZshFgNmoPfTmseovySuetIzkfnzmQ+0st3j+
         nyE3kDxjt0QMAXFVcyn7rqjdf/MahFopyeUOFtI4r9uf+j2rWSZzXBY9VcYH4hV3Q3KJ
         UzASWkDlc1iiSztV6faHjeDWptT+VtOa4ZFA//USn4iDaJdkPOd5mEh54TcwPkmo8o9t
         pITvTh8218A9xI2WrcaOnrouf665FkeYTAOkXnZaI6cn2RrbIp7BD/M6eo2vdzNVuPba
         u1ol8cCTOaMHCHnMf0fdn61nzQVSZDSnPWpv5lArUh6Fy2AQdiP6n/OWX6LabVJ8wVTR
         GFPA==
X-Gm-Message-State: AHQUAua3nZ+vN6mxQVMtcddPHs8RkLJT/uRaURazupnZOHx21hCPB+/i
        WFd8BXPxHABRJIquU9ZfPc9LlA==
X-Google-Smtp-Source: AHgI3IbOZP5dvaRZOj/GZU5acXwgT9dklZld6SBAYIpwzRq2os3Cuxm05yYg4C/Ia/IlOYDrdYCqyA==
X-Received: by 2002:a1c:c003:: with SMTP id q3mr2425904wmf.84.1550222996296;
        Fri, 15 Feb 2019 01:29:56 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q8sm9089993wrr.9.2019.02.15.01.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 01:29:54 -0800 (PST)
Subject: Re: mmotm 2019-02-14-15-22 uploaded (drivers/misc/fastrpc.c)
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Cc:     robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190214232307.rIB08%akpm@linux-foundation.org>
 <44c1e917-bd56-cc51-8b65-0bcedfcd5f4a@infradead.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <619bd894-5849-1eab-b12b-da76d8d52c4c@linaro.org>
Date:   Fri, 15 Feb 2019 09:29:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <44c1e917-bd56-cc51-8b65-0bcedfcd5f4a@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for Reporting this Randy,
I will send a patch to fix this!

On 15/02/2019 03:20, Randy Dunlap wrote:
> On 2/14/19 3:23 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2019-02-14-15-22 has been uploaded to
>>
>>     http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> http://ozlabs.org/~akpm/mmotm/series
> 
> on x86_64:
> 
> when CONFIG_DMA_SHARED_BUFFER is not set:
> 
> ld: drivers/misc/fastrpc.o: in function `fastrpc_free_map':
> fastrpc.c:(.text+0xbe): undefined reference to `dma_buf_unmap_attachment'
> ld: fastrpc.c:(.text+0xcb): undefined reference to `dma_buf_detach'
> ld: fastrpc.c:(.text+0xd4): undefined reference to `dma_buf_put'
> ld: drivers/misc/fastrpc.o: in function `fastrpc_map_create':
> fastrpc.c:(.text+0xb2b): undefined reference to `dma_buf_get'
> ld: fastrpc.c:(.text+0xb47): undefined reference to `dma_buf_attach'
> ld: fastrpc.c:(.text+0xb61): undefined reference to `dma_buf_map_attachment'
> ld: fastrpc.c:(.text+0xc36): undefined reference to `dma_buf_put'
> ld: fastrpc.c:(.text+0xc48): undefined reference to `dma_buf_detach'
> ld: drivers/misc/fastrpc.o: in function `fastrpc_device_ioctl':
> fastrpc.c:(.text+0x1756): undefined reference to `dma_buf_get'
> ld: fastrpc.c:(.text+0x1776): undefined reference to `dma_buf_put'
> ld: fastrpc.c:(.text+0x1780): undefined reference to `dma_buf_put'
> ld: fastrpc.c:(.text+0x1abf): undefined reference to `dma_buf_export'
> ld: fastrpc.c:(.text+0x1ae7): undefined reference to `dma_buf_fd'
> ld: fastrpc.c:(.text+0x1cb5): undefined reference to `dma_buf_put'
> ld: fastrpc.c:(.text+0x1cca): undefined reference to `dma_buf_put'
> 
> 
> 
--srini
