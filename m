Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C5D0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6B3208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htXItzar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6B3208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933734AbeFLIGy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:06:54 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33859 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeFLIGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:06:50 -0400
Received: by mail-yb0-f193.google.com with SMTP id n23-v6so6358356ybg.1;
        Tue, 12 Jun 2018 01:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e5PB52vtW70OgSHdtQvWA/NTvXoh/ObxdYwq9can+O0=;
        b=htXItzarpD8KEW++pYXQI+NU6OxDBMOmjAkAkJeX/cmWYvdV1ZmWHgnDLq5Po4WhR0
         31PnE/RLiO8nDZPQPijfxaTYr+qrTbzSKFRFpz9isqj14B0K/tXhX26d+0yOTMp1+oWH
         U96E8KS/NZs5Xa3Gxu6BRhdXsplEcKMIYl02sZ8RH9rghVQFis1HH5ONhYEtV5vGdqpf
         mpzkN89S8+5+NOuvpA5GHm1Pk4G/sZESxWJUygLarFgTx6xYhkuFudFURaAwnsBhNsKR
         01VLEuzgFkZfiBI7PMhD4NEiVceQnga3VmU2wCXs0c4ysy/DTUnuikWT7CJAxdGwtUa+
         PpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e5PB52vtW70OgSHdtQvWA/NTvXoh/ObxdYwq9can+O0=;
        b=emV3S+MdRjOlSqZP9dFw9yA4hhMjyqr+BbUKmB2QV2F8DIFC8oVBqXlLIJRxH5wtZv
         chOlUrTWDpG5ddCdwsaFxNDD2LuCdl2iCp5BVkOcOdZHyzKcSeoVq0bfdc9R2+al+pMg
         33L6lIU3cmG9nhJ8VBLrPH33ad3taPZpaAnKP6nSCBbhr8kxDAz9SOG9HZqKv3s61ro0
         b5RGlFsIFzK7ehyeqcNMv9YzuH+CfHHX27FF6kw4qiIqkXh8GFoh1R5Cjvhabj5nbqPq
         CkW1cuWdLYWw+0PRUCEtLLb9ag/VTyT12PKg9AL2A8mX8k7355dAaNqS9dzy0THhcxLB
         iBOw==
X-Gm-Message-State: APt69E0KcsRFE+/Vk4z+/vhVjYWBUJs29ed1Ca1NieJBTiu3W000O9Zh
        eqmMmbSea0Bq2Nwapq++YDAglZ1R9C6PQmNS6ew=
X-Google-Smtp-Source: ADUXVKJcik+Q7/Xt+tTy34KZJq+7eEdvsfhPxZcOOof1aSSUZ9nCla2aY9sqrm2HBFieZTqmLnHqiwjUqtjFTZLamqo=
X-Received: by 2002:a25:6e07:: with SMTP id j7-v6mr943923ybc.225.1528790809568;
 Tue, 12 Jun 2018 01:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140544.22268-1-peron.clem@gmail.com> <20180607140544.22268-4-peron.clem@gmail.com>
 <20180611181042.GA30888@rob-hp-laptop>
In-Reply-To: <20180611181042.GA30888@rob-hp-laptop>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 12 Jun 2018 10:06:38 +0200
Message-ID: <CAJiuCce46jEnCy0z8=uqZMV=pgJZBd9vX0hjrTBuejMBJ5hxhg@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] dt-bindings: timer: add i.MX EPIT timer binding
To:     Rob Herring <robh@kernel.org>
Cc:     Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 11 Jun 2018 at 20:10, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 07, 2018 at 04:05:42PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Cl=C3=A9ment Peron <clement.peron@devialet.com>
> >
> > Add devicetree binding document for NXP's i.MX SoC specific
> > EPIT timer driver.
> >
> > Signed-off-by: Cl=C3=A9ment Peron <clement.peron@devialet.com>
> > ---
> >  .../devicetree/bindings/timer/fsl,imxepit.txt | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit=
.txt
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, I posted the v7 yesterday, could you add your tag to the new releas=
e ?

Regards,
Clement
