Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910EDC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5661A207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVtLQpYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfBELZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:25:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34910 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfBELZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:25:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so3251014wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 03:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=H81CsTKITV3FWmJzwgJ/ocfDDsIlt6Hj5sCGX2qZsdQ=;
        b=FVtLQpYiKhhtGgbVmKdAWTNylIBNZDP5uAQJVop9FwT0856pJ9q/mp/ebaiGnP5aFi
         LNULZdwShLjh5yLcJc0VO0qpjxcCrYjXno3+Vv2aCfBC8l2F4EcdFeNEbjTPrjLMT5G+
         yiXpsLB0tNsIcl3ytFD0wKgVT24Gej7+cQpF2zH3TrE0iY2kQ+VS/eKPdjUSYNeUx28E
         eHmU8PgtQ48HGQ4521wOPmFvDygmNJDx6W260N+2XLlqMol2ml5FdmasiKD3iBnWlCZj
         blZM4F/wBLrS5V0LCAspdY8Kye7Nz6zskitL494dZVlwuaKcEhJaSziRB/GVnnF9n+a1
         NVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H81CsTKITV3FWmJzwgJ/ocfDDsIlt6Hj5sCGX2qZsdQ=;
        b=JWWloH1qOptRdTVLJb2rXPX53ymWhSOAiVagplIsAc0maHiktSWyH+M6eqcfzMEbLJ
         jE2wVB+xvoPOauaI+i5S3Q9ZFg7fKfqMgbr+PmNViN+FhBsrBZtB6/KUYRjO58sKuUUY
         u0dMANCF9n4uHg/c1oyR9UAKIlCfSM+YBKUYlNaDxOO346Ys6F/RWg4ACghhnCRuZ/k3
         GeCecoMMVno7bqObUmfpB/X1GS8CMeX9J0S48Xq8+K1kiejdpXiv/N9Fj+g6s0QvsLYj
         SRl8O9xDfW5FqLsVJvkv7JlF2M/ogX2ADJxkcdQ3xJkRAWflLgceCckjBUq3OkEpV0Ob
         jApw==
X-Gm-Message-State: AHQUAuZlKKiGZ0+6E/9rl63SRmCEASEeWpVgeIdaMufshBcLBJM2514L
        NrrSZqEhtmZ8WptOb4uMPZT7xQ==
X-Google-Smtp-Source: AHgI3IZXL9szj2pFBhr/gC5EwYldeMfF46/MYbL4LqoUaqtlfz3kJ4DvU+c9Rry9XjubUXFtgzX13Q==
X-Received: by 2002:a1c:c7:: with SMTP id 190mr3501108wma.74.1549365908643;
        Tue, 05 Feb 2019 03:25:08 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a62sm16056424wmf.47.2019.02.05.03.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 03:25:08 -0800 (PST)
Subject: Re: [PATCH v3 2/3] dt-bindings: nvmem: Add bindings for ZynqMP nvmem
 driver
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, jollys@xilinx.com,
        rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
References: <20190206110721.27765-1-nava.manne@xilinx.com>
 <20190206110721.27765-3-nava.manne@xilinx.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3fdea48b-a3dc-a4d2-2fa6-b1128576ffcd@linaro.org>
Date:   Tue, 5 Feb 2019 11:25:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206110721.27765-3-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2019 11:07, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP nvmem driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
