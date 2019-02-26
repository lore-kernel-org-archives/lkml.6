Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E18FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CD720651
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwiAmyOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfBZNHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:07:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36713 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBZNHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:07:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id g9so10668942eds.3;
        Tue, 26 Feb 2019 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BasbKuVfT3BNQiGcELRXYcPC3x2rxGGt3gjri0wpcJ4=;
        b=QwiAmyOJG1oaZ1fWJi3JQmcmzR78PnjFK97gMHLgpK5CzKcK24fWbislxBHFyRNNyb
         CY4md0dr5LVEB+RnHcmAljrf0lINN2mjZPFSHlSesWnoJRcHdruHJGCfwoyDOD8BC3d9
         bOpPLqRd7I9iFDHDjH+ZlxjGAL2Mg811Uw3dzd3rFKEOeVGfU0OVZqjJeXpayNMO6YRA
         0zvnudlquxHlqbnk08a2lWC/KCF/qMyUZUNgL9YT6P3HSejnCxoYuqdRiJFBXxS3pPeR
         9LF2HSo/YegNwVTA4JnT2gbZBQ2MptQyzTCVn/c+Q/5MQ0CgbdEGFgPJOu7t0t4RmEvM
         3KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BasbKuVfT3BNQiGcELRXYcPC3x2rxGGt3gjri0wpcJ4=;
        b=jkdeRFtKUHsoyIgTBWrDOlJyz9QT/Fl+P5XbjKk6XmY2lzZGmr3e+q7+Q4bIyBF02H
         PBdgayV8dRfhw6Ohl5HPQZmEynAICo/E5wwLuowJbBR3DSgXXoSrwzy2YBx5staPlLL/
         kbrrbDGjwjKynNkPpLqbm/GIkViTHjxdVXcAxspppqTw9IvZE66fs0CVs8eVKvkxlJdc
         lMQY/S3dFmNf4dWmj6i4SQw7XjNRLoJ5H3faLTBayJyB/iWEDwCoCqFTp2MIXeXDhrvp
         g4vlgc7TnYUtE+fiDh+hmdqEGUujO0143/SsM4vdDI636zIdvKQqGBzp7b98YQXZtLvJ
         kbpQ==
X-Gm-Message-State: AHQUAubsFYPhppXgN+/UJhRw5v9JP21ow+5+CuOxl5rIsAr/P/RV5z4n
        laJOn0KCY2m+RVQhuUL4peizZW78l1aTCUBnQPc=
X-Google-Smtp-Source: AHgI3IbjemB0Dt5wV2cyLR2XoDPL+/HeSYBhReESz4IPDzOXVkJEoIdzqI04zdBt9ayy82EiV4zzDz0pAel1y8tx2t0=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr6044338edc.67.1551186428529;
 Tue, 26 Feb 2019 05:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com> <20190226070742.30551-3-daniel.baluta@nxp.com>
 <CAOMZO5AzUzyr_xixDcntoNt1KNSRih_2ZRFnzQHcg6pZmHsYig@mail.gmail.com>
In-Reply-To: <CAOMZO5AzUzyr_xixDcntoNt1KNSRih_2ZRFnzQHcg6pZmHsYig@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 26 Feb 2019 15:06:56 +0200
Message-ID: <CAEnQRZBhR__V_J8LnwNCkhai_8WrSHtsKHtA07wDkScuqhacKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: imx8mq: Add SAI2 node
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 2:55 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 4:08 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > SAI2 is part of AIPS-3 memory region and it's the DAI through
> > which the wm8524 codec gets its data.
>
> Please do not mention wm8524 in a SoC dtsi file commit message.
>
> It is the imx8mq-evk board that uses this codec and this information
> is not SoC related.

Got it. Thanks for the comment. Will fix in next version.
