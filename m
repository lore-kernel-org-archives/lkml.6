Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A23C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E78020851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E78020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeLCKPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:15:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43381 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeLCKPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:15:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so3750448eds.10;
        Mon, 03 Dec 2018 02:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEEfeb2bhDBv6eCurl9mR7hSIVGyipoTCFXHjvSDN2M=;
        b=PLnLRQqzo2HrnkPK4wKF27R2TGLjOgfl0h2hFgXpSwIoOrJJ4hl39Ck9Ka3dMkPMZh
         RdwlUwbnC5lG2fq+Td6VjO8BvPDTbWGfrmYh8LJhgfvHV3jmEL/UzMuj+0OQL3rc0LIT
         NfYkJkYgHrBfsYmaqsLahAuXXl2y1t41C4zN4EA3X6XTttRzsHU9pBrUrtuIhakRGsz8
         S/hPY6f37mGoc8GWdZCXU3rsyJQ+zTy62uoC2TAR1FP/KL7cm0f6VUFDUSpdxxtm27Dw
         9LKEYh95iJ/VKFU3IawRmSZEoNKLlK8qhS+RD6zSPKDe4p8jxJZvs/6Z5kuWTE+5VVeH
         Pptg==
X-Gm-Message-State: AA+aEWbBYTU/11NDWFSyPymKu626H83VHxNvKtWh+BFGe9/fjYV0Nz0O
        PZjRb+bX1oNP5/ym58vqc59lO/enXWs=
X-Google-Smtp-Source: AFSGD/WGl8xObSqoDK0LZmhyY1wh7gDDLNotm7bo4Z31BbdCMmK1G1SBY7mFkNnwujJ6Q3XYPZxy0A==
X-Received: by 2002:a17:906:860a:: with SMTP id o10-v6mr12264909ejx.1.1543832094461;
        Mon, 03 Dec 2018 02:14:54 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id b11-v6sm2099510eje.38.2018.12.03.02.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:14:54 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id l9so11476239wrt.13;
        Mon, 03 Dec 2018 02:14:54 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr12800470wrv.87.1543832093766;
 Mon, 03 Dec 2018 02:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 3 Dec 2018 18:14:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v64B-afrJ=n1td4HsJgtyrr=oxjF3M=pqjuKtp2AU2V0Gw@mail.gmail.com>
Message-ID: <CAGb2v64B-afrJ=n1td4HsJgtyrr=oxjF3M=pqjuKtp2AU2V0Gw@mail.gmail.com>
Subject: Re: [PATCH 0/5] media/sun6i: Allwinner A64 CSI support
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:07 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> This series support CSI on Allwinner A64.
>
> The CSI controller seems similar to that of in H3, so fallback
> compatible is used to load the driver.
>
> Unlike other SoC's A64 has set of GPIO Pin gropus SDA, SCK intead
> of dedicated I2C controller, so this series used i2c-gpio bitbanging.
>
> Right now the camera is able to detect, but capture images shows
> sequence of red, blue line. any suggestion please help.

The CSI controller doesn't seem to work properly at the default
clock rate of 600 MHz. Dropping it down to 300 MHz, the default
rate used by the BSP, fixes things.

The BSP also tries to use different clock rates (multiples of 108 MHz)
according to the captured image size. I've not tried this since the
driver no longer exports sub-device controls, and I currently don't
know how to handle that to change the resolution.

Regards
ChenYu
