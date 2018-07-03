Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B21C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B038D24B9A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8X25lMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B038D24B9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeGCLKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:10:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42966 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeGCLKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:10:33 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so2931632oib.9;
        Tue, 03 Jul 2018 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mDo9lOe4yPZSb4oQpVn++fZxPqwwJvBsQbKgY5Mwidw=;
        b=k8X25lMUMsTrCCZZEXe5C7tfyXv3Td4WY5PLxIGUTjn/GCI638aKSWTm+d3ehqslTg
         x+ZhCkoZ0D6DlciX7ZY5Yvqz4Exg3YLSDSKG7D4pKKuPL5LxgVAkVlyz8MHItlEGQcvp
         5CM/7JGZLxv6QR8+Ip4dsORH336trIdHa0BoESb15AAs4T5dxdJpqeZQ/SSg/D+CqguQ
         xkpG0Lw4DvJwQs2LuVwIXPtClO9ZMba/a/O7OWEhsIITfyl5BY2vhrAMZ5QkwAS/YYVq
         FzRhz0Jnxyt2OOZMD0dIIHAIUSQMMMonKzARD2zoeqUKBhnwPpsyqmB2eCl/fNa1zDIj
         MdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mDo9lOe4yPZSb4oQpVn++fZxPqwwJvBsQbKgY5Mwidw=;
        b=sRYavtZWOb4xMTxt1FQu5e684BtjdIlWplaCwmV9EoTTgc9z28zUNwoBTFyxHo7qJu
         i8ykZkk6RYtA4ok6yaQvjPPBJHnr4wQNXc1ocN6sAq1SP/KKQ4V0Qq3jMH6zu+t89y68
         uU+6k48+sXFcsat62BUhUwFGtZDtDOUj0POEnPuvddaXOWJwU6UULeCcR6KAu5qUz4OW
         s5+tseOsYV7qGxIG+RNNPOaSw53y4S88CfW6uH1YSYaHp6yKYxUKuIl5yhlHMMIpoaz2
         lCNWPeq3V5W/hFoZi0rhhkBhLoalWXONLnlhUgXzx5XRBAuk/ulSdKiQq3ih2VGlQfUE
         fUKg==
X-Gm-Message-State: APt69E1B/xdEm/G1pzcLJu6iS4WjWpnIX4ogrcnoZFE4N74xOaWDvFuc
        VsiJspehMTN2+F+8aTHz9Qn06zRFSeK2UG5qBoU=
X-Google-Smtp-Source: AAOMgpdhj43erK4jgewpwUZX/xzq4sBYTeWB3OClj1l7wsu6k9FrPl3bFFoyTE2F7j5UF2TUlNLxX4I4YRl2K8NZBcg=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr9420674oif.71.1530616232614;
 Tue, 03 Jul 2018 04:10:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 04:10:32 -0700 (PDT)
In-Reply-To: <AM3PR04MB131542D42FCD798FDBBA54BFF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
 <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
 <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
 <1530526335.15665.13.camel@nxp.com> <20180703053843.GC4348@dragon> <AM3PR04MB131542D42FCD798FDBBA54BFF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 08:10:32 -0300
Message-ID: <CAOMZO5BY99f5jjU+73=8WjqwBKr_q2S1mvx90URZUBkgOVn9YA@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Tue, Jul 3, 2018 at 4:44 AM, Anson Huang <anson.huang@nxp.com> wrote:

> It is NOT easy to identify which switch is critical or NOT, and different platforms
> have different board design, it will introduce many platform specified code, so I think
> just revert the pfuze100 switch enable/disable patch should be OK for now.

I have sent the pfuze100 regulator patch revert and it is linux-next
now. Should probably reach 4.18-rc4.

> After a couple of release cycles, add the pfuze100 switch enable/disable patch
> back to support this feature, I believe users should switch to new dtb with "regulator-always-on"
> existing already.

That will still break old dtb compatibility.

You cannot force users to use "regulator-always-on" and the old dtbs
need to always work.

So whatever new feature you need to introduce it needs to be done in
such a way that the existing dtb's will continue working.
