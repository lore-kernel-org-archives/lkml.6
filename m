Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4852229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550183187;
	bh=YL85AWpsB8yHn4HE/LjbG0iark5x6TEwUeV1Li2H6xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=09LmkS2908ZaewONjZU+KyjNooAMQPbHef2NBWiSQ1Di8RvSrSxHJfBVolzK/bjvK
	 ZXRdILUYkxrDyWCkIiOUXhP+bRFYuH7b50zx+ekQY8R8u+7RR71jxi0mBR1ahfmXWB
	 mCkQl8tmaXM8hHTMSSw1/P/euvI0kckFxwRok57s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392804AbfBNW0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730623AbfBNWZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:25:47 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62F2F222A1;
        Thu, 14 Feb 2019 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550183146;
        bh=YL85AWpsB8yHn4HE/LjbG0iark5x6TEwUeV1Li2H6xs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HFXrNl2UCqG6EWD9zJ80rHR+SLzhZ0z2p7m8BwVsFKI4qSDLdNCsNjtFUYniNbHIy
         SdnShVPgMlPjYo28+mK7brkQJzlSRJC/O0m8cnrVLHQMbR4G7EjKGzVVw3uGuSLK9/
         rVneQ4FjVLLThNLiykpEJFjds/ugbLvDOV5kFpzQ=
Received: by mail-qk1-f170.google.com with SMTP id r21so4584885qkl.11;
        Thu, 14 Feb 2019 14:25:46 -0800 (PST)
X-Gm-Message-State: AHQUAuZTU03LKyyIKwv1Mazd1txf/vFOY+fhAXbu53YOHJnqkeTtJFlz
        S9RYujRkX1DjgEuX5vML0PFqNnWo3I/nx7toAA==
X-Google-Smtp-Source: AHgI3IbPbeaayaCLOakH1MmZKpETwRvANLH2Gb0Yo4wRcfifnKOKS4VCZp9wkiin1kvNuuOVeEESHA2tgHEUMWB0eiU=
X-Received: by 2002:a37:94d:: with SMTP id 74mr4734584qkj.79.1550183145609;
 Thu, 14 Feb 2019 14:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20190214175725.60462-1-ray.jui@broadcom.com> <20190214175725.60462-4-ray.jui@broadcom.com>
In-Reply-To: <20190214175725.60462-4-ray.jui@broadcom.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Feb 2019 16:25:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+W=+1=Sj8zQu_ECW9UzEiS8Oya8W_0ZQYPGemXC38qfg@mail.gmail.com>
Message-ID: <CAL_Jsq+W=+1=Sj8zQu_ECW9UzEiS8Oya8W_0ZQYPGemXC38qfg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:57 AM Ray Jui <ray.jui@broadcom.com> wrote:
>
> Update the binding document to make the 'interrupts' property optional.
> For certain revisions of the I2C controller (e.g., iProc NIC I2C), I2C
> interrupt is unwired to the interrupt controller. In such case, this
> 'interrupts' property should be left unspecified, and driver will fall
> back to polling mode
>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt        | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
