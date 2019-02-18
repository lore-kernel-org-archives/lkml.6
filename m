Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99DEC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A35E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550519353;
	bh=5tGe11uimKPnWJghYOTSy8TXUq53/J3Z9G3EX+abXaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xsE73GXlSjsvGeHOCOsP4P8Fz4bPwslTa+eCkvPaJ+x4bzWy3e4tvTd6ZniMiU2Bl
	 tDWK1xjpjnY8UM90qBOROaSMm/XONO3O7C6zfKQb7qLPR0uwrBu4+b+0WHbkkvMjPE
	 WVoPiuNHJIl4Zdc7Ob/v9J//tzvaJ7xkrLxvI/KQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfBRTtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:49:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36139 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfBRTtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:49:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id v62so21431207otb.3;
        Mon, 18 Feb 2019 11:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vOK+4qtemVEZSOAnA8zIaao8MQOq+8sUNCoT3jozv2I=;
        b=SdvTm6cu5DM4AhvFiQBgH1a2M7v/1sjosduknvzC3KcnSZX7Oclu2v/oWgucW+ClFA
         HKm/CbC3x0p9DESrWTfRSVoKpyJrLEt3VzB4mqXIH2eP/XxocUFC5pKKszdv+sFBbNVa
         o2xUSUsOS2RpG2D0jF7UU0suyjRE/do98FjxPX4RfjHusSSadQ0vl5mG2bhLgYoHPnEM
         q6egy9AL2+HVWiJ1Hro8u7SzMbWpf52GfLbcq/T29LVMqIuaXleDgBx3pREVdtOhr2tY
         tfXGxBjmT3X+ulQdEaqnhoBt5XUuASiBYi4hzWwNuZsumHIVunSsZMKqlM/MDRDiU0Tz
         VZ9Q==
X-Gm-Message-State: AHQUAube5A/GtecmNAnkcHOWAn/E6NfTO4s44tUpHshy7ql+RJq5j6w9
        1jtZaif9Lfc0NDlKp0idmSqtKwY=
X-Google-Smtp-Source: AHgI3IbLJBtJMSXy6Td45k9NLFpSMoKE5Xz7D9T8jv/QYUf9cB/2luiAQUc04+2PeRthqP/tx48ALw==
X-Received: by 2002:a05:6830:104e:: with SMTP id b14mr1836646otp.250.1550519350685;
        Mon, 18 Feb 2019 11:49:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a12sm6322407otl.39.2019.02.18.11.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:49:10 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:49:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v2 01/15] dt-bindings: sram: milbeaut: Add binding for
 Milbeaut smp-sram
Message-ID: <20190218194909.GA9552@bogus>
References: <1549628733-30171-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549628733-30171-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Feb 2019 21:25:33 +0900, Sugaya Taichi wrote:
> The Milbeaut M10V SoC needs a part of sram for smp, so this adds the
> M10V sram compatible and binding.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/sram/milbeaut-smp-sram.txt | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
