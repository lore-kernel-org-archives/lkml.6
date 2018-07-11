Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95BEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F4E20846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr0hrvmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F4E20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbeGKOKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:10:33 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40327 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeGKOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:10:33 -0400
Received: by mail-lf0-f66.google.com with SMTP id y200-v6so21392403lfd.7;
        Wed, 11 Jul 2018 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zL30GF0MXWI4OS4bhiSmZ8/z1tJ369mfDNdjNOFt7gs=;
        b=nr0hrvmxh9dzamCde4WvjOUXShtUcxN9/mg7QhBjP8SPcthGdQA1JdDTanguvzyLXa
         oM5hGKe3lMvafjp4dk8uKWtWfHg4jdwG/5d+RMsc/ZCXApcat/zw7/DMAfdvbKL73JMq
         E1x7F2VPTjcDiBCcSlsr5K4J+7RA7j9dctQkLY43pRfHmAy4CRTlXMtEMNbyL3yhytSS
         WOLSV8yOiyC9qCOq2pJwI6cXM6Sirr+oUGENYphzhiP0rKXx4ZAKpWvfjulCPg85fyjC
         koFO8j4vkCHjcllHKT1elOXG0G+Uop29fyJMfaSeLwyam7UzaduQ6CCfCUtm30mY5xXe
         2rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zL30GF0MXWI4OS4bhiSmZ8/z1tJ369mfDNdjNOFt7gs=;
        b=sZil9HGyRCV7ZvE1waIP70gv6tVWjIFV6fwRR3zmRtmYsiSY5/sPjy8dvOfyMfRlYo
         c3/WBSVG3HnVm6x+rub0KVJYLAIQq96pfH1YEXcOYgSaqH4F+nksz+2JLDf3Zr2/WHlT
         08LOuJaIg+seG3DYZpAJulUg0Af24rCXMqCN41DlIJWl4NMRTOtOzu3sbhH+as00UlUZ
         4ka2i8618XH5v96mIZuJYdu08rmOjoC8OcygIb7NsWRpZuWN2h6LGLGlDiMuaPUOCkRv
         BtUXtoy4NWaAfoYIKyf+sS0fJJ0jPsnEvMxuf4hjTTedIeo8RwgdcumYvm9Sp6CwQu+d
         hzsw==
X-Gm-Message-State: APt69E2MVG5iGxWOHWN207/8wreBnYVFbmkeya2TWhQP+26seqyE8K4K
        U9kSRsrsrA5NhuJLCDJbfEIRuaudkk9zB8vfmNQ=
X-Google-Smtp-Source: AAOMgpdQIYl14PbDTqubRnZnrKWep6GeEtK18zAX+zhiP85OtcKqkKbDYAHYjt0wS6vyVbG7EbwFHwAR5975YxJDrhg=
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr5879954lfk.132.1531317959530;
 Wed, 11 Jul 2018 07:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 07:05:58
 -0700 (PDT)
In-Reply-To: <20180622104930.32050-2-boris.brezillon@bootlin.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com> <20180622104930.32050-2-boris.brezillon@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 16:05:58 +0200
X-Google-Sender-Auth: VTbqAMoLTzDtDV3Sx63rNBElqqo
Message-ID: <CAK8P3a2Z_oiAKDsawZn_R=V-HPy1pPYsd6Jquh6bVUEfuQ+Eug@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:49 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Add core infrastructure to support I3C in Linux and document it.
>
> This infrastructure is not complete yet and will be extended over
> time.
>
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices..

I just realized I replied to the wrong version when I reviewed v4 of this
patch. I think most of my comments still apply, so please see

https://lore.kernel.org/lkml/CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com/T/#u

and ignore anything that has changed in the meantime.

     Arnd
