Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DECC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843202084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJU2XXlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843202084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeKZHVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:21:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46443 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKZHVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:21:31 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so13959027oif.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XmOwpX8gGQzLwgMIqXJr8WBdLMOvW3MGK3jRqhu8AY=;
        b=qJU2XXlrLc352vjfMRi8FE3gEdenjDx8r0WWopVHjhhWaIqsLOYSfUIA+n32RcbZAe
         6rlLNtuY8pIgvMJLxsX6OCWLtDa6PWzSD8pbNGtvOKOTqfABhWiNkIHXv6N1DTiSJAh6
         uDal4NAoYpDT1sFBsn6mMX8joUN5cJ6Al+O4IiPVgjonF1c+UuTGgRLBbXAeucEBS+iy
         wdZytA16vxgW1oF8K8WA7Iyf/klXUldITdWv3YPLja+JhqBECb2qDn/Pfpft2MOguG30
         x3XqbCARpULiegegLzNNEPJVBVL510+vgVEgaC+o9DClp00KpMbW0KCvLx5T6DgGYhU+
         maVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XmOwpX8gGQzLwgMIqXJr8WBdLMOvW3MGK3jRqhu8AY=;
        b=eoghCtEGQ+e1neMyfbZHUqkE3ij1+6YfndwD+uW4S160oTJ2igr1RzkmvDfjqXH4Kp
         zwvkFgqQmC629hd51iSo28XXZES2OjIt33J+g+AmyA9wEvHcB1k6gHtjuTiSkIpRSK+S
         IGT+X7toJhV7lpZQjJkWvZJ5ZhsL80mVTAjVMgyggtu3d8SuryZ1ZKCXbl0IkuGQCuRz
         wiFQ7tQq73ARbD30z7GOjOVXdCjOkHa/x4pmEw4Uq8QB6hlfVgIsLPSl7GkijaKMY4pZ
         kq9+NHlyBXpJMZQntbiceo0LgT+8kJX96kUTC8FrxeLQZ/dS97glxc2mYVZRusn+H+a3
         VAzQ==
X-Gm-Message-State: AGRZ1gLXFvIrs7UoIY1wRmcexpkOkEypCP9NbJR0W4pGPHBjT7tONZCn
        j8Fze4NUMDFu3OsJw4eJ4cM2+paHq/f6J6SeUGc=
X-Google-Smtp-Source: AJdET5eHOgSZTriLqGCeYNXd2MzcJyXQLj/BxeA9UQxe2r783/udcxJMfgWS5St17NfRA94/nBjm/bXlJXUzD9u7kLM=
X-Received: by 2002:aca:3092:: with SMTP id w140mr14013921oiw.237.1543177778183;
 Sun, 25 Nov 2018 12:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20181125201729.19836-1-otavio@ossystems.com.br>
In-Reply-To: <20181125201729.19836-1-otavio@ossystems.com.br>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 25 Nov 2018 18:29:34 -0200
Message-ID: <CAOMZO5AVWbk_gdtDvXQfYqmENr8d3z5oxQVtzFtex0WrfY6tZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: imx_v6_v7_defconfig: Remove CONFIG_ARM_UNWIND
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Otavio,

On Sun, Nov 25, 2018 at 6:18 PM Otavio Salvador <otavio@ossystems.com.br> wrote:
>
> The setting is removed when running a `savedefconfig` using the
> current setting set. It is being applied in preparation to some

"setting set" is a bit confusing.

> patches making changes to this defconfig.

It would be good to mention that CONFIG_ARM_UNWIND is still selected
automatically.

Otherwise it may give the impression that such functionality is being removed.

You could reword the commit log to something like this:

CONFIG_ARM_UNWIND is removed when running  'savedefconfig', but it is
still selected by the Kconfig logic.
This is done in preparation to making further changes to this defconfig cleaner.

With the reworded commit log:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
