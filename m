Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CABCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218E9208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC17rHMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218E9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeLFNLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:11:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45071 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeLFNLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:11:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so299053ota.12;
        Thu, 06 Dec 2018 05:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYAP0FDf9YNBMWgdORmXDMVVswMNNb05wRSae/tf3Nw=;
        b=IC17rHMQEVLCEVVTTDSzu+FUITmT7NEzuxxM7SC5V2CPaXRIFAjZf38gAc5WPopOAp
         QkK5b5HwPsewOIpMZ+BAkL9+DInqfbNistu9DP5s6v1E8ueVV4hF3nZSk+ZZ7gbe+4Ol
         HzfY/v7nlD08H/+mrckcPtNTN1ClP8pDLJNWfDtcySFGyJ9aJxs0GxECFTOslICpxlyM
         CxUaeLxcSDJc6QZxayjuMx+Gbj4mrKU+FsDXyiSsztLBE7vAoRvPbNrdYdMc1ITxGxsb
         vfwAMvC8cMR8vleILmnLdvoAO4IOsPg1RqfWIC9vu2CDEC/+EtB3+lLEJ6CyJeYgaiqh
         fn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYAP0FDf9YNBMWgdORmXDMVVswMNNb05wRSae/tf3Nw=;
        b=clNrsPItdbvz/HF6JZRLtjq3V+YCFwBoCC8HCuvYqoy6SGAf4ObefMZYnXyQZpkfnb
         RY0HxYI5mzs1V8fWXEkozbbpIkZ3WSVjIXokLO4xQbgZojDn/wQ+tKR236p0ahqrxFge
         5pNeJUoMluLU2R0z7ZZsPFjGStaIp9QFgM6lzTZ12Dp0/Q6TKSjUP9/ozpPTEJRVZ1Hz
         dmDILIhnDMNCPUzSdBtirRwUaodu+MzJn/KFAtRCr66LWI6aMAY0TZwKdmy+2DYXONj3
         2kDz0bqwnHQIUs9EXHOJ+AN0ITjCqguJ3aFuOTzz59pfP3wq5o83t+ePVrMnVXRB2jSB
         FrPg==
X-Gm-Message-State: AA+aEWZ8Gheu1K4HpW89ZcfaaCdtgHo/6qIzlRU6nrJzMk9KCouZArjk
        owKRNVWS7603lmdT4cFeYsiEiaYLlnumm1otCB0=
X-Google-Smtp-Source: AFSGD/VC104wpPGlWUD6WBJPfNqXxgq8NYycDkUGHv3QStJQA1mDiAw8+87WEC2RTo04a52san2E6+f+xPSD0vOduEA=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr18659071oty.203.1544101872568;
 Thu, 06 Dec 2018 05:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20180921152726.31742-1-lukma@denx.de> <20181009105028.17971-1-lukma@denx.de>
 <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
 <20181206092255.2359f7e6@jawa> <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
 <20181206140840.53d49cd6@jawa>
In-Reply-To: <20181206140840.53d49cd6@jawa>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Dec 2018 11:11:02 -0200
Message-ID: <CAOMZO5CUfN7uLf7bsw6Xg4+TNrRYodw11Ekg5ypqyXU6q-UFtg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device (vf610 based)
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Thu, Dec 6, 2018 at 11:08 AM Lukasz Majewski <lukma@denx.de> wrote:

> I will check this latter this week...

Reading the spi dt-binding it states that the spi slave node is optional.

If I remove it like this, then the warning is gone:

--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -109,12 +109,6 @@
        bus-num = <3>;
        status = "okay";
        spi-slave;
-
-       slave@0 {
-               compatible = "lwn,bk4";
-               spi-max-frequency = <30000000>;
-               reg = <0>;
-       };
 };

 &edma0 {

Does spi slave still work without it?
