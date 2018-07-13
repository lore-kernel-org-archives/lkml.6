Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D4CECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A01320871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK8DCs0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A01320871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeGMLQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:16:21 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33775 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeGMLQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:16:21 -0400
Received: by mail-oi0-f66.google.com with SMTP id l10-v6so14779228oii.0;
        Fri, 13 Jul 2018 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zGpXrKa/LLp4QHwQXt/8sNyBP/4/M7Fjlu+XC5M5MmE=;
        b=kK8DCs0n9zx41zzYUIIEhL19bRd0iw+UAZDiRJILlH0Kns7KXhWHOmPErBYE1V12gB
         W+8CKn9B6t/Wt4rQNBkekCxkoVDCRX5scaEzM6vz4+1hWOEKpyFH7706N7d3jACgCS2J
         KYZuF13C0fqRo1sbz+N/GxPsVRbu9vipVKbxAS5qPwaTyfNqF0N3Hun0svtxPcgHVNLu
         V9gS7mld3zpbbS1l5RCmEc79G+EONJ60son8AVKPKBg5yqnaEnbF3EvIWGzxBnPHmo13
         rlSLvCmWZGbPSx2g2GLomKtyDU/Tp8rinZSQ/nYQm4E/OWVD+plZSrW/+oHc/wL8/iKw
         CH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zGpXrKa/LLp4QHwQXt/8sNyBP/4/M7Fjlu+XC5M5MmE=;
        b=m2EDHQf26spPk3jXHg2xWdHim7kzHonLETq5QJjLIYEzupCqD5NGt5JuTMrDW3x2FP
         TonOLKEyNYGRGhfPoQHJwo9OmhvxFbwb5ngIDVUQllhAca6tbW4lvBtFZPTPam6lG79/
         nEKZd8qKbjgWqf8ilvZ5Jmgz62iaHIQmCaA+WhRLtvFY3yx+EvXIfJW/iQbwni6DFB/g
         TfUZ76PnwWucs0FW5ZZTGV5R1u8KsAfbjPfAVuSKrOZZtBlokYo0XFm0ehBYbJaURpJK
         B1l8I6Y4Sz/FOCC9U02V+iOyJ/3xlLLMOXvQ0cwB5B3kOHb/Hn0/tFZ5HhkC2jP4G24w
         XNRA==
X-Gm-Message-State: AOUpUlFLeOpap6WWNYuS7TB+j9GQMqE1AFpRl1RNKFUtSa3493LzxMin
        O4mC1lvOmFrpizl72ouWA3E1FRx+LRTdq+kxRX8=
X-Google-Smtp-Source: AAOMgpes5MJru4ylV4ZLhmiTzSRaS44rWoaKIpEA7W/BvwZ5V/gOyrNts7hoeoRMxCOlwK00SNEYGdIJuYlZBjXbwMw=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr7064984oif.71.1531479730525;
 Fri, 13 Jul 2018 04:02:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 04:02:10
 -0700 (PDT)
In-Reply-To: <CAHQ1cqEXBfs1B6Jr1NvUY6WoyX9oG=0haJpiTLVH7t-37ht10Q@mail.gmail.com>
References: <20180712023337.30112-1-andrew.smirnov@gmail.com>
 <20180712023337.30112-2-andrew.smirnov@gmail.com> <CAOMZO5DfHqKjF6xykJtoC-aA-ATWM6mCZR0VzPVpSDOt-Fs6bQ@mail.gmail.com>
 <CAHQ1cqEXBfs1B6Jr1NvUY6WoyX9oG=0haJpiTLVH7t-37ht10Q@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Jul 2018 08:02:10 -0300
Message-ID: <CAOMZO5BGuu7VEHNn61W+33PfJ3eQqLTCy8PrAmCtXvLeC-DhLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line
 pinumx config
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 2:15 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> I wanted to avoid relying on defaults be it register reset values or
> settings that bootloader left us with. Default value of 0xa5 works,
> but, given how the pin is IRQ_TYPE_LEVEL_HIGH, I though it would be
> better to configure it to have a pulldown. Do you want me to add that
> to commit log?

Yes, that would be nice. Thanks
