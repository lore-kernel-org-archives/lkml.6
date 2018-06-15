Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACA2208E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyGvcMUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACA2208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966386AbeFOTrw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:47:52 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44894 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966149AbeFOTru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:47:50 -0400
Received: by mail-oi0-f67.google.com with SMTP id c128-v6so9795802oig.11;
        Fri, 15 Jun 2018 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e2N/hLeFw62BVvvsJ0aZkaKs9JwSVeEsDqWGXeK79jI=;
        b=DyGvcMUnLjzxPDZf60BIbfTWs8KXvar5hvdrb6sxbr0SNX/LnCTml/YCy6T+ahOqnI
         nrNvCSQNNZFIMprDkv5tqBa4kCuuB9+YvQRXJdf478cU/cmH55S/vLWxxLH3HBGjTsrx
         oJE45h2VuMbBR+wr3jcWxGIP+wnvVvIFx1OXrswrrmEGUbyF9W/hYA+QSabFLRPvh6ZB
         0sHZlr/mA0y0QRX8esRdD5svT4/j4VM4CaSpvcAVCtr9l5hIQGImGImvxASBUntuAbmr
         8ZZ6Mp7c20HCmMnRiFRUnnRA6fyuFQcAtw8u2Yy7CGe2N7iRceC7tShY0vjPnfxaWeku
         YNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e2N/hLeFw62BVvvsJ0aZkaKs9JwSVeEsDqWGXeK79jI=;
        b=n8j1bK3wM3aIWP2gzE1TqzxaHwN4p7oDKWfEENQG2fRlPVyYl1pMU3UYKH/ZDXngp8
         6v65e15tEpnGZUH56Jwmu9eUhFDfOcHNj8dWp2yxDAVfDRTPIRdPSzK16l9H3CP6jAvV
         sH/VvJJls6CbvVA12OmoExMIBOLnuFeJjtqLEV4nrL227ohMcIhqRG7ZlE+CfJsCnBWg
         vrRWvdWqUlOPqSKzsIQkb7A7uu50jCXhkOCOZ4XvcPKDIB3mmt1YGv4LGHuy37aVD2MC
         bDg0FPw60V8aiTnI++t/0PDVmf14bKvtsRJgLiqfq4OdrDr4Q3wARbWnOugl01cr6lmf
         RVsQ==
X-Gm-Message-State: APt69E1yLyNYskP44Fr6kUMTPJOcLfp6s2dE0eBkfbgnqUrB+QDJyRhS
        byelMrM8oerxsKzSCS5gc/FfTc7+oIg0R1Gyboo=
X-Google-Smtp-Source: ADUXVKJBc/vuKQQQDm1FuI89ThVJdaV89nfX0PHm9fztl/BPtipLKlAvtJvhMCYFzkqU9mb93/Oc9m0vtHs2yzn/dXw=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr1814620oia.44.1529092069377;
 Fri, 15 Jun 2018 12:47:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 12:47:48
 -0700 (PDT)
In-Reply-To: <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com> <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 15 Jun 2018 16:47:48 -0300
Message-ID: <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Franchi <marcofrk@gmail.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

On Fri, Jun 15, 2018 at 4:43 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> The FBDEV driver uses the same name and both can't be registered at the
> same time. Fix this by renaming the drm driver to mxsfb-drm
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Stefan sent the same patch a few days ago:
https://www.spinics.net/lists/dri-devel/msg179489.html
