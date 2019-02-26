Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A9121841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTg5BBmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfBZNaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:30:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36730 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfBZNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:30:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so10732782eds.3;
        Tue, 26 Feb 2019 05:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9OYMB9rvVsnbcid+V0NjauMAvdeRdz8F6EV7K+P+NQ=;
        b=tTg5BBmJVM0om9Jdg9y62DNwqQR3Ad0w/npEcYgf10ImcluMyPr9Zr4ZtShQpi5Q6U
         cWfFGPv7REDozad352+yl92KblUy4mY6ZTMfhXgkpcZcIKC14eXF159PtE5eb8tX7L+x
         oULTRhlXoEReSCth9E0PgBZWwgmwBDqgWAYQ8+4d5GHjzaWldQjnh5lXcnBoiNWD/DAB
         CJkrVT21zTbtC8uhcjC9zbFPlmW/Q2Mgs87Xki4xvdJ1X0AAHo9q47wWDg8aW4/hZ5ZA
         GuAzhyR4mnkxKODSmA1gqpLfRRasVwDhoJq/mbFQ3p9Lkx6sxRBVbXq/zH4LzI0xYGVb
         0EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9OYMB9rvVsnbcid+V0NjauMAvdeRdz8F6EV7K+P+NQ=;
        b=JtOVhhTv+0JxiHCLubaTkWzXaEjbl1rbmJqJbzzhEb3FmXOxoZvcal0hq00HZE4e3s
         awgITCq9OHJ6zjWC4+8Rs0ipwQs7p+Z29IvlNmYGXSvGTzRkFP+EdimigvfoUunBQRej
         CMqXX4mxpOicF4sTi8XgCrtJltLsYtcMeQZ+7k9I7SgMfzDbDN3JQzdIUJ8J0fV6WyIx
         YMObVyMvXAs41V2kWaEc9gREFVYebSlYFuzKcH6JJYRKJajW6uPOOKSxpB67v43oKkB+
         xDuRCkkpE3cKEVWYbaxQeb/Fv5oUDOh37Xf3GSzK2jM4bKMHX+ZxL/SfAKrvj3yMQ4mm
         Srhw==
X-Gm-Message-State: AHQUAuYMyFWaujvGqMmuLgWelBQiY1QzDMOM4/Rd453IDgEQTr/sX2vG
        gyL6NddzmKFsFzWyuAn+UPSaxBY4fKsB2fSpdQM=
X-Google-Smtp-Source: AHgI3IYUhMu6rvuFknbRLRY9YL5YXeczfwmmUVCUpAL/qrPiaSckmU/2x9pW2p2scEZiSnPUBUG0vlUMEjWSgxYy+Gw=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr6120033edc.67.1551187804388;
 Tue, 26 Feb 2019 05:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com> <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
 <CAEnQRZBRG4d59y3kteMaZMjfHWZ=FYL4dP+uRcthvXxqtmH7cw@mail.gmail.com> <CAOMZO5DTR8aLphJBCqR=oLOz5aZXuNfPVEgUk6K_YOdVD0UK+A@mail.gmail.com>
In-Reply-To: <CAOMZO5DTR8aLphJBCqR=oLOz5aZXuNfPVEgUk6K_YOdVD0UK+A@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 26 Feb 2019 15:29:52 +0200
Message-ID: <CAEnQRZDk=eTOmaAK8YoHy63PomrpfUDJ59mL5ipqeJx8v5bRDQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
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

On Tue, Feb 26, 2019 at 3:10 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 10:05 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> > I get your point here. But for the moment it is identical with
> > "fsl,imx7d-sdma" so there is no need to add it now!
> >
> > See the discussion here, and comment from Lucas:
> >
> > https://lkml.org/lkml/2019/1/28/194
>
> Lucas' suggestion was not change the sdma driver code and I also agree with it.
>
> The SoC dts should still use:
>
> compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";

Ok, makes sense. Will fix in next version.
