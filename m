Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDC0C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB5E2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB5E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJMDtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:49:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39136 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeJMDtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:49:17 -0400
Received: by mail-oi1-f195.google.com with SMTP id y81-v6so10798669oia.6;
        Fri, 12 Oct 2018 13:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iBZ7jCAtzPfYr+mQBWV6NZ+CVjza3RJgUPpy7ZDZzHs=;
        b=aAJaCjqMKyWqBJAmBJ4MiCDSkKbzQ928qnHYuGoYeoBOL3hzJ7ONVb6h+oSKuhbbSd
         Y9HDqlBbbVo2cFwlyYr4Tm3jqzpdH5fcMUlfqoEtiWA6dJ0T6nEmRE4/koMwwe5osXXX
         kEiEc/gNHgSEppwMizwJVG0eZ1321G7TP3ejPk16+faO64c4IR/EvCS84eRNtvn/SNuV
         EilVrx+Hlmsu029p2nJOogzBedukZ3qsFMKDbHgj47dAEVRFQ2ZB3l3E8yqBO1PL4R5P
         df6K0VLho3lskHeey+4qmkCT7RBui1V4h8HGMWnbu/RFQdpuMVo+3IMjf5xukAbyYk+Y
         6b0A==
X-Gm-Message-State: ABuFfoiA0Dv8fws1rCOMBcnA5q92DT11LBgO3zA/Zq0v5XdPO0z2Vttz
        suPUn5pPKbe2FFYia32Jeg==
X-Google-Smtp-Source: ACcGV611ZeCjuMsKrnmBRPGSoT+AUq2BkV+vQD9dfjfl36AV5SxGQtlbGbHzneeWGsHcBveXmxlIBg==
X-Received: by 2002:aca:3f43:: with SMTP id m64-v6mr1145435oia.46.1539375307489;
        Fri, 12 Oct 2018 13:15:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y63-v6sm665393oia.39.2018.10.12.13.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:15:06 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:15:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org,
        Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 6/7] dt-binding: mips: Document Realtek SoC DT bindings
Message-ID: <20181012201506.GA22059@bogus>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
 <20181001102952.7913-7-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001102952.7913-7-yasha.che3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 13:29:51 +0300, Yasha Cherikovsky wrote:
> This patch adds device tree binding doc for Realtek MIPS SoCs.
> 
> It includes a compatible string for the Realtek RTL8186 SoC.
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/mips/realtek.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/realtek.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
