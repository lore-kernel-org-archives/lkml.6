Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC86FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B00020BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3QFZKA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B00020BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeGKCTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:19:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43950 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732286AbeGKCTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:19:48 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so46412603oib.10;
        Tue, 10 Jul 2018 19:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GUAMuQjfaWtJLdDAYlxcmhRAwBeNj+Boxj619i1x7jo=;
        b=i3QFZKA5Ja41FvYbabCSybw65ie9XpFWayIlCeIPhZ7/Z8WMqBphmmC5JTGZXt/EWz
         0e7tcWzRjK7iFYOIFp2+nciEFY5WEBvpsgHHa1WAzBdkQs73dqqe65w6DED1GV/ZgmeJ
         wmnFHSZbLoACVvawnGaOrTp8PARp2FV4B8UeCQ4aaw/ot94BVbOj7SfLqKlcasxjUGRs
         GuQvGPJxICaSixbKguDBr+hRBiXxJg06G5i+bdt/7fiD8oHoeOOpXwAg3vINQ2Iu6i+e
         kDO9FMUxbTTaMzJtvwbUlGN6XNp0cV2a5JgREeA3m1WUAgyxmKyvEbOolvDcXuqobX8s
         kXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GUAMuQjfaWtJLdDAYlxcmhRAwBeNj+Boxj619i1x7jo=;
        b=ewUzwxNIQCKLgzRT37eEEb/sjnbJRRcmvgtdo09foKzbd9/iRUnHSSFd66xUCBJAMq
         wZ9WZxAo3nrXxEPgRq8+ug2dpDPpfF0D2UtfISIadjg/ndumjnnbyLsNPI4kn3jpM4OM
         OZG/SOZfFwJG/ltRI9FE4+3qJMzXcaKJR3A2/DzrjJlcJ6G8xAPko2+eWp1WMjyMAGfe
         npKSAE8FnnUWL1PYImRoX/Yupoh7CrVRYREVnEdII3PMQ8a1dPz/m7FHETySijzQ09o2
         uVv87yYqtzpU15yYIGTAhUgY3pYzFTm8+ETeSjd+r9F22RyZAOCV7ig+GxhoUFJd5QU7
         DA2Q==
X-Gm-Message-State: AOUpUlEkqpasqiF+v2c9lADQQtRN1aWHdPhi5Whaw/SZuXcqVg26e2rF
        WSW2ICJiTSSrRVeytjwNMFN2pEhqFt+VuxhkKrA=
X-Google-Smtp-Source: AAOMgpd6bQhU8P7OoQPV5fVD7MtaaZr81seSW/Lnp6DYe3eid6orFafrmixRzNOljrZbc8D5jxcZwHUDQiOgruTJuMs=
X-Received: by 2002:aca:3a57:: with SMTP id h84-v6mr12560534oia.336.1531275473593;
 Tue, 10 Jul 2018 19:17:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 19:17:52
 -0700 (PDT)
In-Reply-To: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
References: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 10 Jul 2018 23:17:52 -0300
Message-ID: <CAOMZO5BZsmY=_+H7vMomoY+pUx0fY2kh80rgx6UVMUYWct9ojQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] clk: imx: add ocram_s clock for i.mx6sx
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 9:58 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SX has a 16KB always-on ocram bank called
> ocram_s, and its clock gate in CCM CCGR1 CG14
> needs to be enabled before access, add it to
> clock tree.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
