Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F171ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF182089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1mTesCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF182089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeGNQ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:29:32 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45168 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeGNQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:29:31 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so41959600oic.12;
        Sat, 14 Jul 2018 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sebHGSr+V22im5roY/iopBlR/W+5Rkl0MOlPT1fdi0A=;
        b=N1mTesCjuHC8hO97YJAYMPgD78TVzfdrW7XjKDq6g6PI1mDDoCidSzEKUjfz5PiWls
         tgXI3vpvaIr9XaK9HVsCpFf83nwMbPEWHClZY9yaptbFFTjg+tbeHbiRv5q1HKJBrj91
         mvVTnlqKYhjUhbPcvdyBElGAH+VBE+DUe+lKlXp8nO06Z/pmbnswOYFuEtENe8ooUEdN
         NdxpgJzxSB8oW1S471S4nmXU59J9/U1eDvOvpdHVNKAIcQ4V4nXWzLm8fQAYkEAHm7d5
         Wo2HxRt+q/IR3OkGVrIMMkPuJfNqXi9xPau9wvSkPwsmGmZ6K9WVTiPpKL6Pj0qV1t/n
         B72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sebHGSr+V22im5roY/iopBlR/W+5Rkl0MOlPT1fdi0A=;
        b=WXCBTVKLLftaKSNxPxHXk4iTOZkx2mhsB4zWJ3pqmRFeKRPbtKETCNPlqnD31EWucg
         UoQYPFr5fwAdcWoYaT/1bI1vj4x+nRtePqHZwGPbrKlcYq2xJIFmjg0VrTpzwlkt+HuU
         ZxFTIt9yqepYP/DeCySGvQAjeq89GCE5O4YJB1nalF4WY94txKJutku5BdjgfXCkqmsK
         rotxsAAZY43b/Yq8C6OfYUaY1qFGlL8Z2qZbYevZVd6M9Nh3oDNG+ZW9O8W5sMopnkpr
         EN2BrlSEHFllKucx8kfiEDOt9ZBXFnD1Owja257G4GXNR79vTnQCHP5ewG2FoTxyFsu5
         cedQ==
X-Gm-Message-State: AOUpUlEa6WYPoNcR6UKcCIa9MCHvTc7l9g4dwJPEa4DF0qAYKFjvjiT/
        axMJ8PPrRZnC4B3TRNQomCB6fceLZ28aZNz+WAg=
X-Google-Smtp-Source: AAOMgpfKj91Er71qpjGzVybLeLOnBnKRyQ6m8Pm/p3PTqFp41ZIp+6usHhnlJ5bNFfpVsUj8k1jR1CMxp7FXrBcuV58=
X-Received: by 2002:aca:b355:: with SMTP id c82-v6mr2590103oif.9.1531584599847;
 Sat, 14 Jul 2018 09:09:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 09:09:59
 -0700 (PDT)
In-Reply-To: <1531533238-8816-1-git-send-email-Anson.Huang@nxp.com>
References: <1531533238-8816-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 14 Jul 2018 13:09:59 -0300
Message-ID: <CAOMZO5AcJSMyh3Y51K+4P2Ha-aX9kbeZCT6gFN9tV90p-6F2hg@mail.gmail.com>
Subject: Re: [PATCH V2] ARM: dts: imx6sl-evk: add missing GPIO iomux setting
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Fri, Jul 13, 2018 at 10:53 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SL EVK board, the MX6SL_PAD_KEY_ROW5 pin is
> used as lcd 3v3 regulator control pin, need to make
> sure MX6SL_PAD_KEY_ROW5 is muxed as GPIO function
> for controlling lcd 3v3 regulator.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Looks good now, thanks:

Reviewed-by; Fabio Estevam <fabio.estevam@nxp.com>
