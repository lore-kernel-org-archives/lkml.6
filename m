Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DDC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B609520820
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548532129;
	bh=PcoAyqe8C7lwvuUK3oesFYWuqImdTTjmphhncXKOnfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HdbsQQ4yHoGR3pUJQda5IJRrOMIADbuJGxNDfiZUjuiCBenXpAWAN1BH9KQtqWKeT
	 NEd+563JdO27ymqvaWUj97CDRYsO4kDMKMQ6mNSlLSKsS9XXVeZx1kRaPtdz6le/1c
	 +Jk2w7OKvVWrVy712JXUOWkCDFRd8th89bvycUVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfAZTr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 14:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfAZTr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 14:47:27 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E04F21906;
        Sat, 26 Jan 2019 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548532046;
        bh=PcoAyqe8C7lwvuUK3oesFYWuqImdTTjmphhncXKOnfk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VlBlfJcI0Mwv2/Jz3tiuHSEhHZ3a5jKLw/mKA6cdXa+DssQsOGVqaaYn2SqEp+JdP
         TxQiAUr4YPnPRcVRdfZTwAKEe8GU78AK/QAj/O8xVL7iZf9hE3STRDdq+EMqlkrUj2
         Gy5CsdN/7AMRrsjKPOmcJMZWdFvAKw4PHsdjXyG0=
Received: by mail-qt1-f175.google.com with SMTP id d19so14347949qtq.9;
        Sat, 26 Jan 2019 11:47:26 -0800 (PST)
X-Gm-Message-State: AJcUukdKKAGLsv0+TWIfm/qEZa2AvkvILsSVftpjlfTwe52TFy63zuyF
        7VVN0xQ/yu6udcV/kO/Xr2oPJtWBkNmCNRSmvw==
X-Google-Smtp-Source: ALg8bN6tXfihtdpQ6K2viCeKMaL35awOQJFThS5Y6tk4YuShiuHqz2RIu1hAoV30ihUU1P80AB4K/ndJ5zjXvyS7PcY=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr14851739qve.246.1548532045415;
 Sat, 26 Jan 2019 11:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org> <20190126041041.13173-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190126041041.13173-2-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sat, 26 Jan 2019 13:47:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0zhp8X-K8PobfBmXgpvp6+EsqJL7ixHHu9b84ZoAmWA@mail.gmail.com>
Message-ID: <CAL_JsqJ0zhp8X-K8PobfBmXgpvp6+EsqJL7ixHHu9b84ZoAmWA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: arm: Document Bitmain BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:11 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Document Bitmain BM1880 SoC from Bitmain Technologies Ltd along with the
> Sophon Edge board.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/arm/bitmain.yaml       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bitmain.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
