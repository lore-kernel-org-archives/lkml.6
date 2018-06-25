Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B76C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDD4258FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8kpTZm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDD4258FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933579AbeFYM0T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:26:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46197 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933458AbeFYM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:26:17 -0400
Received: by mail-oi0-f66.google.com with SMTP id h79-v6so12251475oig.13;
        Mon, 25 Jun 2018 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B3SnObRj48p2AGOmJCMAAoR+bKpze2dRSS86FxN2ZdM=;
        b=G8kpTZm91pk/tlmEux97ICP7SmsTtFzzSLmpuwe4SLpWaVbZyGXvc3zWt6GmuoLfeS
         xJmtt2Dzq0xBkNa6mv4FlqOKr/b+1GHkx51y5i7FEit9T8Jdhk6RCxa6srWxUm3l4DAY
         lLEwld2Jfa52Q41oJfFfQ4BEf6UrMMZYwq3jW48jmoismv9IiMEH6gWConQHySNvqShX
         YRrFUND3s2yUXGtmQgP7D3Zw5NGgqOiShUb8HaGPC4sUxTIcpinfXyLZ2MTNoO7Ad/Cu
         BSDKIGasOHZ2P6rfDY64TkQmym0l5vEPg12CeWHhAI3RyqA1ePKLGRI1ERzBBPiPWJIy
         aDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B3SnObRj48p2AGOmJCMAAoR+bKpze2dRSS86FxN2ZdM=;
        b=sHBiMiUvjWQPw8/nBB4zCLEqCSWJ3CwZWMElpgOK/trs+bQoQSmS0qDnIZ1b24tm7+
         mI+POW4qRtqOV68qIUaXgnDKqW3dyzulTM5Uy/RsL1qRqFFj+466P5yLwBKU7V32dpX3
         UfXWpLe+cc059nLRBRKlPJrdImmeuheUihjI5VeE0huQd0Cjwe27T7zM/Hg7mPDGcoF3
         YkYhtIxEY4Xs7OEqQ3B+5NUQ7wt+FeSUEDQvObtV1swZNmazG4qZ3g/TMTv0CbpRSfcu
         Qby5PKOcfJk6rU0YXAKBSQGdDfA7z1SobF0FmXJ/dZGgRylKXoGxNYW8UnEJeUw93ksY
         wO/w==
X-Gm-Message-State: APt69E3w3mTPXMMr/VH9LFOBLA2J8sjwzAftEqTuMOE+LG3bYduowRgZ
        g/SKvHDZKNSUYD8EsP1907hB+zuJUpBLuu9xH34=
X-Google-Smtp-Source: AAOMgpeDRe1qey4f8k7tX5JB76ZFXbydieSBdlkJ6enn4xe9STxvG+lZOhRpqxwrmWZ5f56ZEJfW11u4Yo0JVSbgEPQ=
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr7067670oii.198.1529929577184;
 Mon, 25 Jun 2018 05:26:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 05:26:16
 -0700 (PDT)
In-Reply-To: <20180625121813.rzqgzdbk6ue73eq4@earth.universe>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
 <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
 <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
 <CAHQ1cqHpNvZGAfFKrp-OiZevsha5CBwJsw8GT+uhgNSfEUejkw@mail.gmail.com>
 <CAOMZO5DAbooRgA+sHJa5EmEGy-CHW3FPydcOFtK5AqpdJzD7MQ@mail.gmail.com> <20180625121813.rzqgzdbk6ue73eq4@earth.universe>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Jun 2018 09:26:16 -0300
Message-ID: <CAOMZO5B_tVj8niY10m2Q1vnr3Az74pwX+BgTo0DaN+PdM4xTYg@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Mon, Jun 25, 2018 at 9:18 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:

> I still have access to the imx53 based PPD from General Electric.
> But I don't understand what patch you want me to test. FWIW the
> images I use(d) for testing already had CONFIG_USB_CHIPIDEA_ULPI
> and CONFIG_USB_ULPI_BUS enabled.

I was referring to the patch that enables CONFIG_USB_CHIPIDEA_ULPI and
CONFIG_USB_ULPI_BUS.

Will submit this change as suggested by Andrey.

Regards,

Fabio Estevam
