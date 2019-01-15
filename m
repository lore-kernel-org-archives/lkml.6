Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080EF2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547587923;
	bh=88VJeO6jo2Kjn5ZG6TlHcwm9guwqKoIrqosPywIEhOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wYe70L8IkaiC3n3oOfvxRnqAOn0IJsXeV1HHqfxZQPdoSJT2RMsDfp6dJz8rqliwo
	 TiOr++a67FvMvriGdYNfC/3vqFOFCQjJwsLz4sRYMAGhIKZBRIv5H8ny0J5dmzYmDx
	 3Xr4MOStTLhK4EChFTHpPrd+TOiHZLnU5XvtevDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbfAOVcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:32:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34898 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732817AbfAOVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:32:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so3373675oif.2;
        Tue, 15 Jan 2019 13:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z9gEuT+YNXtCWVAFBTcu1FTumM4T92y7to9PgZX0coQ=;
        b=jNP43C9ojiKqUI+uVO0Z3sA+knK/gJMPtzTJ7N/nucdtD68a61HfONtuvo3NntlD8j
         Ef4JRLR5KJKOLX08oqP3Fky9TW69vTEuVevC4Oc5xQcCBAlHn35NdXe2WrGuRp4prUvW
         cXxlf8OYtALRWdRonGTGNPUkjNaGQdDvkPH4x0eysmwT72nCQAOV7+Eva3AXT8K+Uhuq
         KvfYK6k4Es282fGGskX4Jp3lV6WcLsVcYSUz+b4xdu6HVtYHhd6f8j45gZT8nzoAKf7t
         WbrW+WnnZmjJazyjuhita1sDLizkyHBUqW0UZJrpybNPgXEBLGww+vDlCyOgMYkDBAhK
         My3Q==
X-Gm-Message-State: AJcUukcYdYlyWIi7LsfxfUhHuk0R9QLbxHTJtsAZswScr23wBczgPC0h
        B4K8to7BUWfEmdciEgub/Q==
X-Google-Smtp-Source: ALg8bN46tdJkXSr9UlbEAiQScxzL4Sh2niknXE4jMQPxp0hHi2TBQnCAmqsaPBl7jSHP+unwEvy0Xg==
X-Received: by 2002:aca:4d3:: with SMTP id 202mr488889oie.345.1547587920354;
        Tue, 15 Jan 2019 13:32:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z18sm1862540otp.41.2019.01.15.13.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 13:31:59 -0800 (PST)
Date:   Tue, 15 Jan 2019 15:31:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-binding: iio: add NPCM ADC documentation
Message-ID: <20190115213158.GA7016@bogus>
References: <20190109164343.164205-1-tmaimon77@gmail.com>
 <20190109164343.164205-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109164343.164205-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jan 2019 18:43:42 +0200, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM Analog-to-Digital Converter(ADC).
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/iio/adc/nuvoton,npcm-adc.txt          | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
