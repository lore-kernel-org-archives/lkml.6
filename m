Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5644620894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5644620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbeGaAry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:47:54 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51285 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeGaAry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:47:54 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so1716835itf.1;
        Mon, 30 Jul 2018 16:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BNQvc+wgQBlp2ChoQOPBFbsRwCizSlc/L8aGtfRIXr0=;
        b=U5BKARjw9E6JKYlimQtog4lcAovNfm0n2J2CoKkxUKibaGeX2ZBC0DVz25XHncMVYv
         T7Ru1u4jVM8RM/eU1I2EX7LvnP5R1iC1t1knKJrNPMXyd5woEigTrop7DC9LVX1VXpjC
         BeYMTMSyK7iQhXE7j5fh2zwB2mbnRu8f8UcQZrKIrHrfD4qe+enwoYwU+LFmaQmX7MJF
         vrXPZCfO39H9JTr/Qcrs1W+w3ns7mbVE/kj/Y6D2F0RDvZPzyPb741Qn0E8YmDKBJJZd
         pg8ItQE6AjpnqY4LCWYEV7LlqbKrYHeL9ybb78xaL0c6OuBBRAzEfcYOWE7yoq/UdPaT
         C7YA==
X-Gm-Message-State: AOUpUlHfzlE8mbVEt5edX3Olbrpk2FHzMlXy7xQI5vJlsN2nmFMwKFdv
        URMgcvxV8JCbP9q8ZmYh9w==
X-Google-Smtp-Source: AAOMgpf22fZ0zuYs6eX9QT5WWkG0FLWN3S6vexS5eajwsdTxF4A5yk+oLEpnNW3vaTyld51/fptakQ==
X-Received: by 2002:a02:4dda:: with SMTP id t87-v6mr18312755jad.51.1532992238402;
        Mon, 30 Jul 2018 16:10:38 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 137-v6sm717722itl.39.2018.07.30.16.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:10:37 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:10:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br
Subject: Re: [PATCH v3 1/4] dt-bindings: dmaengine: Add binding for Actions
 Semi Owl SoCs
Message-ID: <20180730231037.GA2265@rob-hp-laptop>
References: <20180726050658.1399-1-manivannan.sadhasivam@linaro.org>
 <20180726050658.1399-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726050658.1399-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:36:55AM +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Actions Semi Owl SoCs DMA controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/dma/owl-dma.txt       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt

Reviewed-by: Rob Herring <robh@kernel.org>
