Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03CDC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBFF21E1E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eln/CjFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBFF21E1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932310AbeGBBFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:05:12 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38908 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbeGBBFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:05:11 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so13360612oie.5;
        Sun, 01 Jul 2018 18:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K0H7aUzNRXA4fh8Q1AU1RxdLOYbaQ7xBT9GGQpr6r1E=;
        b=Eln/CjFZR7niU7G6xoj3nQjRy6UtdrKgJG8/3iVgvaO52IkiHL5yCrsaiPAnP8ZI13
         MOjZpNzojQeEb6YG07BFiIKF3YKKFJYQ17GVZi4pTpBZN+pHvdUV4hmoqaBlE7NUTuAH
         50PoZ152Mwj67RJOZSkqp1LtTnGpFfP4i8hS5cbaEcMhn1t4uYpFOE1ksmlB0Gh7bt4E
         zrluxuzsmY2yskoKwZFZI5a5Z8NJMN3IfdEHTTALUhrp1t0t3170uHG+eIOdSV+GVVAh
         LsKLZLSasl0uijuewPYCOxXh5NY3T16BL2Ia9LmSejfAOe86bm+e251V87ONUl8UEC1f
         bJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K0H7aUzNRXA4fh8Q1AU1RxdLOYbaQ7xBT9GGQpr6r1E=;
        b=roA633PaM5zwthTHol6xQN7zLkrwOvL7KuPsnb8KtbvbsGxGKtQ0/eoRak0zWQNCR6
         DZ94KJPB9NxjUDCT5kX/xuqVy9M82TWtPwYidY45aWYiZgVcuF5L1tN0goyz2/DAcHo7
         ZcsrC64AduOFBd+F2QbtB6WUES2NOSC2+yaFNUsY+56U/70T5fhVdkHa1BbgMdKignhK
         E7ZPAsd1f/UVx+S2Y5viz2gHJnw7/csMTgiTMMFXJBgG0536vp7XlzU6u6Cf+pXhEwag
         EGaJ3F4vqagbZxPRaISTLC9Z5mhHOAv/3q1phK9c9SEW3MFGX68gfPpqgaoJXLskkKzA
         tV0A==
X-Gm-Message-State: APt69E1vyAz94sZWHzvHAzld4sPYRWjYMudo+jWGHXxqh5zkZCGQiM1k
        PSAeZRIvZ9ungVTrlZiCTB+DsWeG5931tk/tzno=
X-Google-Smtp-Source: AAOMgpcY88sqFkResK9e01hv+DhYN33cWhNursYkZL0nMo/d3arQ1QPohYb58hfyGAhtN3lcDUxe9vjBlTTWQcRfdds=
X-Received: by 2002:aca:d4d7:: with SMTP id l206-v6mr1415433oig.52.1530493510568;
 Sun, 01 Jul 2018 18:05:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 18:05:10 -0700 (PDT)
In-Reply-To: <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon> <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com> <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 1 Jul 2018 22:05:10 -0300
Message-ID: <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
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

On Sun, Jul 1, 2018 at 10:03 PM, Anson Huang <anson.huang@nxp.com> wrote:

> So that mean such kind of kernel patch will never be into kernel? Even if it is a
> necessary patch for fixing some other issues? I just wonder how this case being
> handled.

What is the issue that 5fe156f1cab4f fixes? It is not clear by looking
at the commit log.
