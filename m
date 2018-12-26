Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9C8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E05F21900
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F1VZ9JvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeLZQwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:52:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42480 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeLZQwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:52:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so17740561qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 08:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KwMLCwUPmTyjB5Pj1lp5mz4Va0BflBJ0qIj28Vl0AYs=;
        b=F1VZ9JvABZHl0spaxH2eIKcRy2rGKk48H4bG+bpEEY8FbuHPaFkODM9Q4dOoi/eYi9
         6dPfETCJ7pNBpZSMCofZIGKP8I8Mahx3jf/HDWUp2m0UlpBp6+PCWrQQyngSPiA/P8GO
         1gYeVvFFg6TFfNEdrBC2NMm3wdT2BGVCBHvNVtt7Fp6HX4iReVMyrAyqC5wVvJorq180
         foE6YeRZA51+vND9CEy8xgtW8pwVkRHwmiBokeGDUKJvnMcF1Nhf5ZXMpKWnJ6IaEyPW
         cCRXiQeCGxJ0Y0CN0i5s9hP15DX0dYl/ntquyGGUN1xxG4OznOk+YToKSWoBNNtTzCzR
         lX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KwMLCwUPmTyjB5Pj1lp5mz4Va0BflBJ0qIj28Vl0AYs=;
        b=Zq+eDME29HddYAPCPTl25frABUzgq1LgS+D5EbyKrEP7WXvhw8jjiYI1DpM5iLycdr
         RRW1HdmXdj7vlnRPL6+ouQezIGrpHUGPxkGXfbf0qOtRO9Hi3dpWhHrAXdqzQ/8ZvNHC
         9WGk0qBIvNM2OYlqUyfZVotfgix/2Lg0VNLfQ7mnamLiBNTE9TP5Wg3BCylelvLrC2jo
         3oOr28X2Oh7xaIVgOTFSUe2sG7GeGiS5n6Ag8okBOx6L0GfPnofaTmRD/YF2JuhPcRQg
         ANVILY/4npI4EYFxNm3Cg2gyG102YpdjejDJyL5Tp15pTqjzrXP31EKSNjRT88IOo0+s
         A9VA==
X-Gm-Message-State: AJcUukepfyKZ30zWf6jj/LO2vZrEayCIf5FqgQjET5VbMwQZx3NiSTTy
        mSGgK2SDwer7eolDwGmjd7ceZw==
X-Google-Smtp-Source: ALg8bN67X9W5Wk0k3HufO7fWRbaVLwDavt0wOU/+w4ECRENWrtR3oRBfqYTX/5CnUad1duSCmNXPGA==
X-Received: by 2002:a0c:b0db:: with SMTP id p27mr19603568qvc.73.1545843169671;
        Wed, 26 Dec 2018 08:52:49 -0800 (PST)
Received: from localhost ([2601:182:c980:96c:8dd:4488:90b1:59d1])
        by smtp.gmail.com with ESMTPSA id v22sm13500839qkl.27.2018.12.26.08.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 08:52:48 -0800 (PST)
Date:   Wed, 26 Dec 2018 08:52:48 -0800 (PST)
X-Google-Original-Date: Wed, 26 Dec 2018 08:31:47 PST (-0800)
Subject:     Re: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
In-Reply-To: <alpine.DEB.2.21.9999.1812211124180.777@viisi.sifive.com>
CC:     Alistair Francis <Alistair.Francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-ceba7c1a-7334-4869-a7d4-2326b59f82b5@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 11:27:39 PST (-0800), Paul Walmsley wrote:
>
> On Fri, 21 Dec 2018, Alistair Francis wrote:
>
>> When the MicroSemi driver does eventually go upstream this will
>> probably have to be discussed though as either the config or device
>> tree will need to be edited to ensure only one PCIe device is present.
>
> The right way to do that is to have two separate DT files: one for the
> HiFive-U board alone; the other for the HiFive-U plus the expansion board
> combo.  There shouldn't be any problems with keeping both drivers enabled
> in the defconfig.

We actually need at least three:

* One for the HiFive Unleashed
* One for the HiFive Unleashed, when attached to the Micro Semi expansion 
  board.
* One for the HiFive Unleashed, when attached to a VC707.

We may end up needing additional device trees for the newer Xilinx boards, 
depending on if it's possible to probe for that 32-bit DMA limit on the VC707 
or not.  Then, of course, we'll need an image-specific device tree whenever we 
put an accelerator on the FPGA.

Ideally we'd have a discoverable bus, but that's going to be a bit of a way 
out.  For now we'll have to get by with different device trees, but that should 
get significantly easier when we get a proper bootloader working.
