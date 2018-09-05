Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7320CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B87720867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kzfq/gQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B87720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIEV2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:28:53 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36749 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIEV2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:28:53 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so14983844oie.3;
        Wed, 05 Sep 2018 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oYyTcVh+KjKc2zAZAYkx3h6FH3OE9Y8ej9EHkNfGzp8=;
        b=Kzfq/gQ2nqBef5GMzf5Q+obIJPEtMDGdxLkznU4hYWmgK3yeMezy9JgDV10KsoV4s4
         exf/HqEuXOUvMQwTjwgnB1d/CESFQEwti3MENjqNdQV6loYUNokVdOFIQ+ci5gf6Ppop
         POSOpsE63piCcjSNI8IV/HFKYzufOYggKk4GKCECp/5b9iiqk7uAYJSDZYNANMkU+0JL
         2EqAqlTz7z3G2JNj5tk+R5IMSrVO2YJUrGVhoyKV4sScM9JUpF5v2bEkQ+iN0JeIQoOS
         B1WMML50QQmMIMzBBIhq7SlwLKrhPyJL/8r1EpxDF9gW/acdjl49fnUAFHU4RWEi0BNT
         0DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oYyTcVh+KjKc2zAZAYkx3h6FH3OE9Y8ej9EHkNfGzp8=;
        b=NhINuXLVLjduZMbmGsVAtGaw4jQ4jP2tmWLfvHbf1daPKLMHOi6G9ihlmgv5PoOlck
         HhxCzilyfUC/B1flyKIE7RKwf9+D0g0g7olV/G2oFSaMXBneyLsXOBR2KXRfe59n4Jpp
         Pz93qqUjLIReOWoQ7ALmpfTRL0irJTwg1kosA72pKeoGkkPhah2TyHLpH4R0Ml62vA97
         CgZfmF4AuhoWlRhPlIo9y6VVP/e+CmGRZIN/J2HPQt1i9yP+oNYdigtuRWwzy1Bkq21S
         9or+WThqLbY0Kg0iGZVRI4G537YgANsoHGnV3p4tWPdn2J3OZ/L16nAS9hcM9sGJywTB
         GYvg==
X-Gm-Message-State: APzg51A0RfL8sAJ0eD+BupJFzXUg9PY7yqlWb3hKIQCim4U/qfLQlo5r
        rmt/t25bu1Ta0JSGPRkzDozi7gTqEIgGeSNtRl2twg==
X-Google-Smtp-Source: ANB0VdYuuFYeqQ8oFl0RhllniV1tMoLeaRyf1jd1PvPRt4ZwEnEB9GuFplSpM+i8RwrinYk6o8tU/G8uL/I56Qq+pZE=
X-Received: by 2002:aca:bdc4:: with SMTP id n187-v6mr29702539oif.3.1536166670456;
 Wed, 05 Sep 2018 09:57:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:cca:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 09:57:50 -0700 (PDT)
In-Reply-To: <20180905102536.GC15467@agonzal-linux>
References: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com>
 <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com> <CAOMZO5B26iFCY2DeBHa6_=uRT3zgdP5J+HBqzpPY-=7HHgP9EA@mail.gmail.com>
 <20180905102536.GC15467@agonzal-linux>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Sep 2018 13:57:50 -0300
Message-ID: <CAOMZO5BsyfFwvQygRgiKqoKiBCBMkVWmY5Zj_hvjLOk-_Tri2w@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
To:     "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Wed, Sep 5, 2018 at 7:25 AM, Gonzalez, Alex <Alex.Gonzalez@digi.com> wrote:

> My intention was to add the board support first, and then one or more panels
> as independent patches.

Sounds like a good approach.
