Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F71DC04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041D32084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEhxzTDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041D32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeKZHWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:22:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42166 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKZHWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:22:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so9338658otk.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AlbfShw5i3IlIAHidpBrFayjrMSk0cQqU1djN/umuJ8=;
        b=gEhxzTDK6+fRLiG9o2/aTpIEDZ8d/JfeldJ9Xu5S5JgopBK5tbpkUiNDeb7sWspZsO
         TEaIW+Z1DzZqWUsgnie/hJ9denZw4NTd5g4VlcbXoh1to/kROwFpVmoLPX+ha0ReY+et
         uR+Zx1R30SeffzNW8CCSVBb5hzdIbePL20mjGY4QoCgREId8ZPXx53G5idCe0RBStT3I
         zQGRnlTDVajUGdZtK2siMyVHlrVV8hVarhwRHYJ0BPcnA+fqfiiDFKGFqFO7NR3ZITG/
         gM6rJ4rKSkXFQFGZOkvvKFUy780WWFndvzPNc9NSIOjQqjUlaNHxcgA0F2cRHvn+ufwE
         49Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AlbfShw5i3IlIAHidpBrFayjrMSk0cQqU1djN/umuJ8=;
        b=TaCaypg+nxP8MdsJEKm80pfESFvh8YBMCZ/AplnLjf8pX1L0cE9qYlIxCsOtNuhbi0
         YBv5qakxyc5t/9UnkLx6cICpfX5UkM/l1W+u4LCq8zw/k/l9HNIu7C9c4wqA/ybNE9R/
         FbYLiti/jG+JG7pFvd76gRn/BpPXvNmd9SKz0kyr8SsnYAF5Ir1NaIRsNGWvO0axtgta
         RruQYKfmpqonx/6GjWtQh/Rqy3hAj94SpEKofUMYP7tm2fLzmo9CB7eQI7f/SxU2nzYS
         FVTHfjXzqLDvcbeEDMvCD5M35kqQZqdeuQLYLsWm3wh0pBVtjZEBOuoWl+Aw0GWt7sEY
         Uhlw==
X-Gm-Message-State: AA+aEWZNpoXBzqc1PBeh9IxF+CbXfgUz53Mnexhv8ZAuM5uv7+aYpZXr
        nycTrUBe8Lk1/YU3uHUVFzYzkLozLiwNxLrEU14=
X-Google-Smtp-Source: AFSGD/XN1uDfz4wvKaPKFzNl/cSW054wlxoEcizhIyidIuubbtt7/1R/BbSKXsmNItdrux8E+5B+FMeYNVcV4aKriY4=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr13249075otl.196.1543177813540;
 Sun, 25 Nov 2018 12:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20181125201729.19836-1-otavio@ossystems.com.br> <20181125201729.19836-3-otavio@ossystems.com.br>
In-Reply-To: <20181125201729.19836-3-otavio@ossystems.com.br>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 25 Nov 2018 18:30:10 -0200
Message-ID: <CAOMZO5BMSp9wbSVPqzmw85MPFWVVT_-SOgMXnPg5RUFkBAB9zw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable USB_ANNOUNCE_NEW_DEVICES
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 6:18 PM Otavio Salvador <otavio@ossystems.com.br> w=
rote:
>
> From: Andreas M=C3=BCller <schnitzeltony@gmail.com>
>
> This is very helpful debugging USB issues.
>
> Signed-off-by: Andreas M=C3=BCller <schnitzeltony@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
