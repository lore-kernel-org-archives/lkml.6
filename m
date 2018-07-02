Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081C1C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E1A24255
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+MeAsao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E1A24255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932281AbeGBBRU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:17:20 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35979 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752834AbeGBBRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:17:17 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so12891304oie.3;
        Sun, 01 Jul 2018 18:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UZYPax8qY2F19ZYQTdg6MTMRg4eSFsZfEBSro1RASGY=;
        b=m+MeAsaoeBHQPfjxTPZXGC1cuUmjzuIw3rJsh/q6j3xUca0TRIH4+nRUVvinmL5Xkp
         qvtY/NgH3KmfGkqrJtqDjsjKwu11yzHzMfEWTUuaB2Ytnb0Kks1q7qzc916NcUftepLI
         Ka//T+YUHkSHm3rgF+sTD7Dx+5HRJC2TnEJU1FqGiQhLUks+7AFvEPBQ+IWP788a2b98
         202um2xVTqSgEwVBxHHz63ZML/44mbaq9WSk1deaxLe0pPUMyZ7+Z0sxPfrzPm9WXaRG
         eIUFIDZQJQoL2eUrDLqlJju6FxM0i7/bWumvgdpQA7uh7U3R368Kjofqc8ZzkLdV6etA
         7ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UZYPax8qY2F19ZYQTdg6MTMRg4eSFsZfEBSro1RASGY=;
        b=XhgV9FnlfKiwxnYESNBBE64Ms5teyMy+rS6f6qsb55ZRKB7I0uNWh6ryIVx+9ES+Or
         yWk9/8YDPDdVh+ygG8OIX7TQouqF4W8nO9nWB0Lf4s+la3DKH8fwPH3bnel4Ql85SqsN
         vJrxOPemmCsbEprKhVRiIiQCSt23h325UQa9ja0WpNg8uKEH+5b5uFk7fX/6SCM2cOzA
         qwSbcfX++fU4WalJRvseQ6pe7pIMSkQF1MMydUdyPq7cM6I+2IdwS53gGultmIPMRTAs
         Y3ZfKywAsjWFe+Pin9ZUMhcOTTekcOYIx19IYdLkaJMcdBfTqNfW5tuat3zErbtPCb0G
         YLIA==
X-Gm-Message-State: APt69E258WZu+WbkSzrK2HCQN0b4Std/G+F076cAhSA07x7WCMu4SdQI
        Y5OAFg2MWHbloWiom+1hu6L8iT6OQHEaEyUVn7A=
X-Google-Smtp-Source: AAOMgpccGgepNsskmxzX14eFjuRVTl6c0DzGv6iadAPwIeqs0A+8NxQuG0ONDlhnoZu8pC018pLRhDi7B39FrC/9vaY=
X-Received: by 2002:aca:808:: with SMTP id 8-v6mr13922150oii.198.1530494236342;
 Sun, 01 Jul 2018 18:17:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 18:17:15 -0700 (PDT)
In-Reply-To: <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon> <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
 <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com> <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 1 Jul 2018 22:17:15 -0300
Message-ID: <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 10:09 PM, Anson Huang <anson.huang@nxp.com> wrote:

> On some new i.MX platforms, PFuze switches are used for supplying GPU/VPU
> or other non-critical modules only, these switches need to be turned off by
> runtime PM to avoid very high power leakage, like on mScale850D.

Ok, in this case I suggest adding a new property so that the switches
can be turned off only when the new property is present.

When this new property is absent, then we keep the current behavior
and avoid dtb breakage.

Since MX8M support is not in place yet, this is not urgent, so I will
send a revert and then you can re-work the patch so that it does not
affect the old dtbs.

Do you agree with such approach?
