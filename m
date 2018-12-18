Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DEE21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545144886;
	bh=AC2VOCoH+I1mPcO+voramcyQN6RJluyXpsNBdvzXQ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A5R3INVVnz1Q5pnadDY22exYTEuxocD1lfZ4hzu7V4m2PZMF2ZtY0bGliGLGhTJ/d
	 tx0M0ZEnOrDL4i0MFf4yzOlgkIFR1l0PmDFm1LIwTgHeVftP3i2n0Y5bYU5JOgTz8r
	 MyndlM18CLZ9q/4IYXih8ElyHwXhORvrUaLB35TM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeLROyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:54:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33458 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLROyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:54:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so15934776otl.0;
        Tue, 18 Dec 2018 06:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4k5kZxIdDFfoQz0/tRnJEj6f5m3tJzXJ5ZlNyDMUVzU=;
        b=ncJtd25tuL3IpWsDuXXUXXmzK76yi/qpBgFuqZtRx0VCfnX6v6ENWtvOjLYnM6EQOR
         auAyHstQY/WEiiY0FfmLC2C8gjQEaVby9/jHJkF1JOev03sZrqmOG77RPRb3qEGUyMLV
         k/b0nJVBdHdwuzAVWPi16n7b59Ol1ci8vFRzIai9JpqkCeV/xkTPBYfLaNxFqC1gPGZJ
         fQe4JCkAo4gQKSGlhXVAhj/Y9nCCNVlfYz9pTUyOb6d0V3IKwn3g8AKCvaQhFR8M4kMM
         Q7gUzMQeCrS8Im/Hg8VHFpDYu+7kc60+cCrNrynvG6cvk+/vwx9vIDkhEJDAG8CSyYuM
         t3PA==
X-Gm-Message-State: AA+aEWbMFlVmJuFAxzt0NUCtlQafm6sFK2bh/qapAsVF5ZqQizVcuvaT
        HNNsVStszg45kxcJ5NMEQIRRSFg=
X-Google-Smtp-Source: AFSGD/Uoogt6H9PwWIl7a41DSxWnEZV6v8OLqxpb77pArrv1WhL4PajgKZjBCewzsiuf75V7S7OePw==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr13253162otl.343.1545144884729;
        Tue, 18 Dec 2018 06:54:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q128sm7846876oia.4.2018.12.18.06.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:54:44 -0800 (PST)
Date:   Tue, 18 Dec 2018 08:54:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     olof@lixom.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-unisoc@lists.infradead.org,
        afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net
Subject: Re: [PATCH v6 08/11] dt-bindings: serial: Document RDA Micro UART
Message-ID: <20181218145443.GA5150@bogus>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
 <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:35:24PM +0530, Manivannan Sadhasivam wrote:
> From: Andreas Färber <afaerber@suse.de>
> 
> Add an initial binding for the UART in RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt

Please add acks/reviewed-bys when posting new versions.

Rob
