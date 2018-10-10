Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155C0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD942098A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5T9Daey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD942098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJKCu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbeJKCu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:50:27 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE13E2087D;
        Wed, 10 Oct 2018 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539199611;
        bh=BeunW+luSLFlh7v64LDUIYiU9n07HdJzv1/ZJ8Rk5tQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D5T9Daey1AxrqgGr33JTsMbSnF5Cha4L+un/rWyzzDbi3zMcM29QY+DE3Ho+BVhxR
         1av5q4vE8VXsFfLKse12GUdbDcs1YCiXb8LkYLFdAgspDN/XfqNRKaKw6tnel5/IwK
         +/GsodMfNW8BI209g4dyokDP6U8fr3JisjKRFVp8=
Received: by mail-qt1-f182.google.com with SMTP id q40-v6so7090543qte.0;
        Wed, 10 Oct 2018 12:26:51 -0700 (PDT)
X-Gm-Message-State: ABuFfoiVtU5yXmwggik/OkUOxPPVHH6lbrXsL7TH6ehniKv5hEafqXef
        qU81wtFhgxjvl1y2yywNZGa0YV5+BCyYIXFD8g==
X-Google-Smtp-Source: ACcGV61fuagdd4Se/vHzrEauytDSwV72w9ZVThEEsodnarC0ADPaBukTQt+ePZOwQ8A/tEBJxAoSMSPupWTo3S5AIdw=
X-Received: by 2002:a0c:d4e5:: with SMTP id y34mr14375721qvh.106.1539199611060;
 Wed, 10 Oct 2018 12:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Oct 2018 14:26:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+MYBrkZ=OEv3avxC_NZ+q3+stOF8CsHeXUsomKZD9+AA@mail.gmail.com>
Message-ID: <CAL_Jsq+MYBrkZ=OEv3avxC_NZ+q3+stOF8CsHeXUsomKZD9+AA@mail.gmail.com>
Subject: Re: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 12:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hi.
>
> This patchset adds support for the Embedded Controller on an OLPC XO
> 1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
> the existing OLPC platform infrastructure, currently used by the x86
> based models.
>
> The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
> uses extra handshake signal to signal readiness of SOC to accept data
> from EC and to initiate a transaction if SOC wishes to submit data.
>
> The SPI slave support for MMP2 was submitted separately:
> https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t
>
> THe "power: supply: olpc_battery: correct the temperature" patch was
> already sent out separately, but I'm including it because the last
> commit of the set depends on it.
>
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.

I asked this on the OLPC devel list recently, but I don't think my
message ever got past the moderator. Could you generate a DT dump from
/proc/device-tree of an XO 1 and send to me? I have some DT changes
planned and need to see if they'd be okay for x86 OLPC.

Rob
