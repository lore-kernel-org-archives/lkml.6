Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2613C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFBD21874
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546541169;
	bh=feEzb5DmN/tcbVN7HizVbAa2zKmf011KYyDHrWocAPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vi1+yu+AVksEM0NO/sFYVbv5hHrmxXgLeB2wVP9pw3qUIWN5egBjCRQ2M7YnBMQ8r
	 sXYpZ3K1wMQ4xfLzRfiPaJaQzg+uRiJB5aSiwZcN9j5Xgda9zMnMSBjJBsTbpAENxw
	 GmTU64VrcfFUf0PctIZ/ejA4htaFJNuAlsK3Wz7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfACSqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfACSqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:46:08 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 714AF2184B;
        Thu,  3 Jan 2019 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546541167;
        bh=feEzb5DmN/tcbVN7HizVbAa2zKmf011KYyDHrWocAPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DcKWQg92TvgrrnqKTYo9AlDequCxuKMlLuLItgL7ixQ/FLd62HxyfdTVOnW13nQwZ
         dgyL8VI0WdZSFLQcKoU8guNMxWaTzbavFI/RCTMbaI9WeQIJ7U4z5Y+nTDrQ4yyZXE
         5aQwtdpBdvAEqqOVRTtvrUPD2u2NFrMleyFbYcKs=
Received: by mail-qk1-f176.google.com with SMTP id d15so5738989qkj.0;
        Thu, 03 Jan 2019 10:46:07 -0800 (PST)
X-Gm-Message-State: AJcUuke2MG1ysOildv1nzoX0DZNbi5BZQfNOsZzEt2/g3tRfPbFc+MM9
        jQ/kIryq1lQx0abS4iApYbwbCrGfiknJWbF8mg==
X-Google-Smtp-Source: ALg8bN55c9+ff84kzOyNUJ4aDSEn/x7T5GqMB7sVKtPRLc//csJ/sfkg77+ctfOHiIjv0vOjYNUIy5dwIWvxbvA4uvA=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr45626127qkg.147.1546541166685;
 Thu, 03 Jan 2019 10:46:06 -0800 (PST)
MIME-Version: 1.0
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com> <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
In-Reply-To: <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Jan 2019 12:45:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXFAEdSaexA3p62u8f3RsVA1vfNsOLu4aetB-iLb9qFg@mail.gmail.com>
Message-ID: <CAL_JsqJXFAEdSaexA3p62u8f3RsVA1vfNsOLu4aetB-iLb9qFg@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH 2/7] dt-bindings: soc: Add opp table on scpsys bindings
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 8:10 AM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> Add opp table on scpsys dt-bindings for Mediatek SoC.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/opp/mtk-opp.txt  | 24 +++++++++++++
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt
>
> diff --git a/Documentation/devicetree/bindings/opp/mtk-opp.txt b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> new file mode 100644
> index 0000000..036be1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> @@ -0,0 +1,24 @@
> +Mediatek OPP bindings to descibe OPP nodes with level values
> +
> +OPP tables for devices on Mediatek platforms require an additional
> +platform specific level value to be specified.
> +This value is passed on to the mediatek Power Management Unit by the
> +CPU, which then takes the necessary actions to set a voltage rail
> +to an appropriate voltage based on the value passed.
> +
> +The bindings are based on top of the operating-points-v2 bindings
> +described in Documentation/devicetree/bindings/opp/opp.txt
> +Additional properties are described below.
> +
> +* OPP Table Node
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2-mtk-level"
> +
> +* OPP Node
> +
> +Required properties:
> +- mtk,level: On Mediatek platforms an OPP node can describe a positive value
> +representing a level that's communicated with a our power management hardware
> +which then translates it into a certain voltage on a voltage rail.

Work with the Qcom folks and create a common level property.

Rob
