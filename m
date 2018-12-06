Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15959C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB3A20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0pN0xFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB3A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeLFLJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:09:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39175 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFLJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:09:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so41023otl.6;
        Thu, 06 Dec 2018 03:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsbKvC3dsLuKuLrjIpJKbElmmt5kYOSNKeq+ipXgjJ8=;
        b=S0pN0xFg8GHIlmGU3OvDu3N+NbpgKQgh8EaRo8aX7NdAaNnWAFFhFC/vjT3mcROYxT
         CNIdMZl7uRezULj4aSsQwMTT6yO3BDTwvbDCs826Ju29zCgujPpWj1ou2C+G/pqpoevu
         dyo3Y8qzrfDyBZ9bJv6HYFc1qDq//jeknPYQEKgw+GuSnKdDrC8lquTPPHgBgF8aiXub
         eKADFPX1JmGbVLw3uSzIjTPwoxzvGsg+yQ75+IHGgDGMh/cGL2q6t6c+XtkOqnilJYgf
         IAZMIhJmCbP7aY7FKmd/8lZ1Z6eia1oyXP68wEkYCvCm4qJpDDetrU4sn4rG7TkzZUWg
         Kdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsbKvC3dsLuKuLrjIpJKbElmmt5kYOSNKeq+ipXgjJ8=;
        b=GkiNvun8lEXyElkZ2SscVWPgyDiV+jAC3ycw3TyPuZu5MDr0AI0sAJ7SYjZJCWD1i/
         uAL4H/0NvuPOiO6SzHTjSjqcRS4KKpvpby6mTpKSmYZJOQTKDubjtT1ftzUbQFQ4dQWO
         UTjRbpjfARAgtGJUNBgTQwJLGV7SA7eDX31gT6WubHC5icI9FR+5s7XBPm5itYgmrrdB
         3KW1fDsK9Ve5WWkVIKcZsFUgh/oRoRc7utiAZVOknrhfwSxPAEX8m1VcmwEpM1vCTsnb
         hbzNKnLsP+x+yFGrLBoxoVmeGY56rG5aAybK51oEYwQoXFdtxotYWpQzxLAvAdHLujUS
         QivQ==
X-Gm-Message-State: AA+aEWaR8BIJdfuanO/FVCAt/Kemx11MUGt0Vdp7/VXRVXbdvl5YwtuQ
        CP5DmKJH4ifOp2z5H2vuzr75KXgGpJeMOZn248M=
X-Google-Smtp-Source: AFSGD/UflYCDRVA+ZIqCYf/BomfclWY5d1SNKbE3gasuXQoc2CwlqryVo0s0RbzGs4pQaVG1hLOXF6q9eNo2iU/Xn+s=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr15951694otq.255.1544094593665;
 Thu, 06 Dec 2018 03:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20180921152726.31742-1-lukma@denx.de> <20181009105028.17971-1-lukma@denx.de>
 <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com> <20181206092255.2359f7e6@jawa>
In-Reply-To: <20181206092255.2359f7e6@jawa>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Dec 2018 09:09:58 -0200
Message-ID: <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device (vf610 based)
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 6:23 AM Lukasz Majewski <lukma@denx.de> wrote:

> At the time of development - I've checked my NXP related patches with
> W=1 passed to make. No warnings observed then.

In linux-next the warning happens without W=1.
