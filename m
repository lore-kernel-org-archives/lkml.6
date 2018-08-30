Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD90C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FAC20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FAC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeH3VIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:08:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44536 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeH3VIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:08:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id l82-v6so16692000oih.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn3qfs8tE0KMtbxf5moHR771ElxtKNmjOPp0m7rrEMc=;
        b=tcoXxDJxEtKURwNMRjRII124TX72mPxqZaUAT90J0XL3Je/940qs2g9b8AW0xGWIYG
         vxRNFRPZKvDaj6VYi9nxl/FhKWabrqfe9DaNjZGP0nPKVhfTWM1Mb4mgKzUp4qXMAiBa
         vcWH1Rw0AqkJxX4Jg1JCj/Yv1T5FWtaHaE9FoLskUl2nsdQhstFid4W9e1vTbNQ1u3IY
         98PGNmqnSOci8Czp6lmBO9+f29ZvFbbpoCKEAbiXmfnmBgyslZaaL75Cso5GLZcOSoEv
         w1BV/Y1PUwG3bA0KnChG2hqPgjs0AnQXokX28U1YTlc1WwLN7rM2mqkVLg+a74c/L40Z
         OxXw==
X-Gm-Message-State: APzg51BRRlctTGej/38p9zDfh/vIT60nYi3vMjqu3vNEYLv6bQ+rdZRU
        /F0o0I3jmfDiUXpTig2xz6SfPazm
X-Google-Smtp-Source: ANB0VdbyRknDWQt7RrJOTwz1ZjA6PsV8tLw6S9xG0WWy6UsfMXajiepQrhQ+2mdpqoEzRaNt120Xpw==
X-Received: by 2002:aca:b3d6:: with SMTP id c205-v6mr3430490oif.133.1535648700616;
        Thu, 30 Aug 2018 10:05:00 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id h186-v6sm14537675oib.55.2018.08.30.10.05.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 10:05:00 -0700 (PDT)
Received: by mail-oi0-f43.google.com with SMTP id 13-v6so16759995ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:05:00 -0700 (PDT)
X-Received: by 2002:aca:e2d3:: with SMTP id z202-v6mr3039453oig.121.1535648700022;
 Thu, 30 Aug 2018 10:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180829200425.16435-1-robh@kernel.org> <VI1PR04MB32475E7E36BA8467FC07B01D91080@VI1PR04MB3247.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB32475E7E36BA8467FC07B01D91080@VI1PR04MB3247.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 30 Aug 2018 12:04:48 -0500
X-Gmail-Original-Message-ID: <CADRPPNTWQP7kgB8O4LJ67H237z=o8KEscT0i7nveNVFvodb+AA@mail.gmail.com>
Message-ID: <CADRPPNTWQP7kgB8O4LJ67H237z=o8KEscT0i7nveNVFvodb+AA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
To:     Zhao Qiang <qiang.zhao@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 9:49 PM Qiang Zhao <qiang.zhao@nxp.com> wrote:
>
> From: Rob Herring <robh@kernel.org>
> date: 2018/8/30 4:04
>
> > To: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; Leo Li <leoyang.li@nxp.com>;
> > linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org
> > Subject: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
> >
> > Use the of_get_child_by_name() helper instead of open coding searching for the
> > 'firmware' child node. This removes directly accessing the name pointer as well.
> >
> > Cc: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: Li Yang <leoyang.li@nxp.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>

Merged for next.  Thanks.

Regards,
Leo
