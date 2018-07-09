Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B2AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD23F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaQ+tld5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD23F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeGINDb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:03:31 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54942 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeGIND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:03:29 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so25215542itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpVKS9/rnBtx+rygkN50Al2lGQXGexrCV8QREQCgkuw=;
        b=aaQ+tld55wVSVkmWEr5lnbbC24jIH9QL6e1GNRjoY4GLUjVBOJ5rXKqf26WdAeDXfD
         9RUd4pQHRyM8J5yaRddlcD3SM3YEEX14uPQzwuKIGln1m8LNXWMLsqeNSRjQ616wHQ0v
         pQfBzde6iPf9iVrxIVSwdnYcWbiQhQEAWs6y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpVKS9/rnBtx+rygkN50Al2lGQXGexrCV8QREQCgkuw=;
        b=f+GrhXcWgRw/jXkhiak5EZ1QUbi5R8mCKNIVE+p0AkF4inspy7ou+1DKnIOox6IHJQ
         +uco+wOLkU+4h1eQSpMwFolKVs4Gff8QnkhwqGIekUHfnxvTzV1PYg739yo4yoLwMkBq
         ZDOelMemrIKP4nZh8hmxA+IwdsbhkdNfH4Wwo17yCNX8y1PUMkDyLx163YzrX9bpi2tD
         AmAs62VcJZX2Hb/cEr4mbRDyHzupcmoEyeBUAJ+Y9CP2aSEq+2OocxS9ie8SjYkTCFxD
         F7y0w8j+lYxjGIctTR/iAxqRrbDYTH5ABTA34A9a4huxHgdX0Jp4VVym7/xUxIcx55Ps
         eaUQ==
X-Gm-Message-State: APt69E39yGixOPXwg6WEp7QPLnP3AeX/tBhDIwvnEgi5v3TJHfuzIklV
        RRTIdItkphb9RKdl7d+xKjTON5VQXqm++mJ6gLZD0Ysx
X-Google-Smtp-Source: AAOMgpfkvSlMSvi1td0IDizz23Mm6PXQVmNIdRMkO0+V1nD6z/onI1EONa/yOTw2xDcVpe7JCUsMgEZ2cr0yxWCK59Q=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr15655849itb.38.1531141408917;
 Mon, 09 Jul 2018 06:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <1530580694-8649-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1530580694-8649-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 15:03:17 +0200
Message-ID: <CACRpkdbE25NeZ_GuJOxSsC90Wog2LGmYuACydEUB7qx-CO2orw@mail.gmail.com>
Subject: Re: [PATCH V2] bindings: add clocks optional binding for imx gpio
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 3:22 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> Some i.MX SoCs have GPIO clock gate in CCM, accessing
> GPIO registers needs to enable GPIO clock gate first,
> i.MX GPIO driver will enable clock gate if there is
> clock property in GPIO node of dtb, add optional property
> to i.MX GPIO binding doc.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Patch applied as pretty uncontroversial.

Yours,
Linus Walleij
