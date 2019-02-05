Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40B6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E24207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgbRU++P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBELZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:25:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34891 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfBELZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:25:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so3250395wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 03:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lp4C64vaQeuPBNDxASUIsDnoG31EkUl0CanDE2WESiY=;
        b=tgbRU++P6WVvG8WrpVZX9BFuQ4QnjTsDMaM7kCUBAy3jJvIGn9ZHH4pD2UIW1VJkMT
         ayM6aRe9zznGyphHcQMlHZbYkaOnYaVD971FdSc0pU/GeVnFLCfmHjbXXs3ULsQNFCO/
         BhvXKt78SSbUFhcAksWoQDkPkQFectFCrFs9mCV4ZgwI8YBNcRlkmyhjHWmCP/ZrkNO4
         y04m/mujkpOzVR3W/zkkQisL8tNeL224GrKByuxUdelXKphBM9XUhv7po8UE/kQywdmj
         vTlQyLikLFBetYYUT6cuorv0QCpcoIFnKk4dsFa3oxAswqr4giImLeYJPxp4xle6cKJQ
         BzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lp4C64vaQeuPBNDxASUIsDnoG31EkUl0CanDE2WESiY=;
        b=RvPnaB4sX4vsKvZNQ1pzMmeq3+nGsk+ZMuBJtGG9KkRrheLwR1eN+5LtzdRX262I+8
         p1rKHMKoZUNmfMH1sFiTcKFi+Tiu9TMpE8+rIHsIE98aPnd2xl0ucvf8YlHTAFfnU+oD
         S/Tr+zuZllqCQTMoWA/QCNJOTkyAmUjmNL/PBwmt+Sz9XnzUHD7MNuyPI+RrO9Cfo+qL
         JFnLuQ2AEPa30Dbunfi5ZYoHNgNugruaZEqlX8wPxKAiRvfPRPvb/q2SQxLkwSIq9Z/q
         nzj/S5pNC9Dm1FNvg+H7uinLVRDxp252xBWuJa40xzwrn26yUeUjuuLbPnpLlTYudPud
         L7Nw==
X-Gm-Message-State: AHQUAuZ0A/u04PEkl9FjEoGqRalUqiwDR3JO3EN3KKaLbAq3lx0BtKNN
        79lYxLTI5+QgvtdIN2gTZBOBGA==
X-Google-Smtp-Source: AHgI3IaXLJcsciPEpFpNR8zdKi3pNMebIpqhCiqt4gHpqLeBZRN3ajVegbiORDjgnhiwi+YMzIcxyQ==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr3331944wma.24.1549365899304;
        Tue, 05 Feb 2019 03:24:59 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id c14sm14669526wme.13.2019.02.05.03.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 03:24:58 -0800 (PST)
Subject: Re: [PATCH v3 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, jollys@xilinx.com,
        rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
References: <20190206110721.27765-1-nava.manne@xilinx.com>
 <20190206110721.27765-4-nava.manne@xilinx.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <faa21f65-e5ab-52d4-a9be-bee1b2f931ad@linaro.org>
Date:   Tue, 5 Feb 2019 11:24:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206110721.27765-4-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2019 11:07, Nava kishore Manne wrote:
> This patch adds zynqmp nvmem firmware driver to access the
> SoC revision information from the hardware register.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>

Patch itself looks good to me!

Due to dependency on the "[PATCH v3 1/3] firmware: xilinx: Add 
zynqmp_pm_get_chipid() API" Its better to take this patch from the same 
tree!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks,
srini
