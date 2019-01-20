Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3BAC61CE8
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D4C2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTPd2uuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfATAlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 19:41:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35166 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfATAlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 19:41:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so19420452qtc.2;
        Sat, 19 Jan 2019 16:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouV8HGufHMeV5nBaCL2TxK6JYdBVyrFL2AW2wH5N98M=;
        b=HTPd2uuu0e7AFozef+RjvTw5dQv/aeS9Ai1Om9BDpbmabKCJBg+ss5SPMz4Pn8sWq0
         eHL7YlRCLUTWkLkwy3JamIEFlWW4Zh3bYClVY/dCBf09FummjtgMI0TenSWvyZk0JYM7
         mD3G12z6xJ8uOzweDz7P3xf3AcbTMArOmal0G4jriObLe2xbn8kEmb1XTLA9TnwiFK+Y
         70dOyR2Y1DWtuLArpFbnGHzbpkDkzcaTj86VglObzqJ9/Qz570CPDO82ivHsfJav/beT
         khZzD/7xJfrS+DLED4d3GJveVYI+fbDKze5MoAPoTEAz/skCM6b5yrwIVmmAo6H1FHqm
         Xnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouV8HGufHMeV5nBaCL2TxK6JYdBVyrFL2AW2wH5N98M=;
        b=j+si90j3mNLXIO8uNkK/1DjAwdkO68mQPBifEIh+fgpS94HUclZLRgqbUf4yJeWhmb
         mynbuSYj2CHpSrMKA64lDyAwtXI1OywnkyofYegZi3NALSlyh5TxV0E6J1d4WGalV4Cp
         PEWb7I+asrz6DBLj1/d1sAMgRxhr3oTDBvIgnaBTNLfK2yvXLGtDPEk/lz/usqusbUrv
         xVf6rip46qjcxla/l/r8XJdhWEk/WsPJD17hgX2qzPfyspe2OvyyQY69TUN0TgjbW+7r
         /vCD0WzipYqcGaArcVnP5ozGNO/h204QZMmxMUVtuN0fo3KASHpVP1lRJGgdz7fAI/gz
         dRog==
X-Gm-Message-State: AJcUukfwHfjZRCPZ3cFJfbzchSuTKusKHsBGJBxU4wRzCIgZZ8+CrGgG
        BHYJF5jvrqwN6Rpg1ZYP+cUv/2xUREvjARBTPIQ=
X-Google-Smtp-Source: ALg8bN5B9AH001fW04hvk9/LAqVdCb0czuZOJRqVnwpjySQIXdyohJYRnmwdm/oNssaRKexSdKOZdVNEI179YPcONPI=
X-Received: by 2002:aed:22ba:: with SMTP id p55mr21169003qtc.137.1547944859712;
 Sat, 19 Jan 2019 16:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20190116020100.4813-1-atull@kernel.org>
In-Reply-To: <20190116020100.4813-1-atull@kernel.org>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Sat, 19 Jan 2019 16:40:48 -0800
Message-ID: <CAJYdmeMfH-2aY09_rA0JavL4=WoRy+jWe+ZwgGgefDq-CbpCaA@mail.gmail.com>
Subject: Re: [PATCH v3] fpga: altera_freeze_bridge: remove restriction to socfpga
To:     Alan Tull <atull@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 6:01 PM Alan Tull <atull@kernel.org> wrote:
>
> The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> since it can be used on other platforms such as Stratix10.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: add depends on HAS_IOMEM
> v3: put both dependencies on one line
> ---
>  drivers/fpga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0bb7b5c..c20445b 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
>
>  config ALTERA_FREEZE_BRIDGE
>         tristate "Altera FPGA Freeze Bridge"
> -       depends on ARCH_SOCFPGA && FPGA_BRIDGE
> +       depends on FPGA_BRIDGE && HAS_IOMEM
>         help
>           Say Y to enable drivers for Altera FPGA Freeze bridges.  A
>           freeze bridge is a bridge that exists in the FPGA fabric to
> --
> 2.7.4
>

Thanks,
Moritz
