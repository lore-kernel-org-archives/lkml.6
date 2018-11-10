Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4A9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ED120854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+qIrMv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ED120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeKKDex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:34:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42912 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeKKDex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:34:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id n46so4511721otb.9;
        Sat, 10 Nov 2018 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHLOE62z0OY7BBVihq+Ry8CF8+OZ5ZHzEIw25xj/yXI=;
        b=a+qIrMv9QI+QptxAlA1N8N3bZP+CU53axiGsMSCuys7WoiNYobKc2c0uO07f3wmLpB
         41rzmnu9iYvKoCgIOWW+xNEH98SSTtnegovae5DC6i500wwpLTNCp+pGz+oZCvxaSU5N
         I/Xqtiwt9TOOR77LFVKaUInOE6xRdtP+sn4xukCIIO4rFOt3jAdYIobBfh4QJjQ6X9Y7
         1/t56VOCDm9AC4nYrR3dxBlqIU3I32o7ketANahrYXsL9b+3eOLe4tLJUABxiDx1bDwh
         P1y22nyF0Gx1uNCcjAZeozi6PKfXEtOoBs0t/yPGtY3SLtgEAjp5u//vd322V+0BTzpw
         BG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHLOE62z0OY7BBVihq+Ry8CF8+OZ5ZHzEIw25xj/yXI=;
        b=SKZu7JchRvmJazQ1f0jM/maV+uAxYtug6xzlUd3eh797F2vpY3xU3Fg13RS+AIk9qZ
         Za8X7FlUDiqoCNRqidnEnKBBbJAkD+kuTmESghW1fFpOc+LJNATkjl3rrdLgSnJrKhZO
         waRaSVKcqMSHlMcXg9EZkMS/yjFJXjqWVRMvqM03rT3xmLx99mGr1O6HFjii4DsqqtTH
         g2QVeQE72jg42N2th4wNOEjm8DqzDf/fNugJeOIsAAzJ0kUNo8IKSs7J4dg2D9YwpP75
         8yFv8zdgPehvSkbkB0O5Oq1yymr/X1TTA6zqUkbHgKGgaXgd97it7bhS/9QjjfPrnyPI
         uGIA==
X-Gm-Message-State: AGRZ1gIRfc/Me+GEIDT0FSZ6hnC62Gkj0I6AwtgIdYf7icxhSOGcFbV5
        w46AWuwrrtddCoWQHjHNfEYDrGRZp+1KrNJ21e8=
X-Google-Smtp-Source: AJdET5dK9vvylBRPizTn1cqQmVk1pBXW31d5JO4RU3enEpXSLc2agKbEfIfHDQQ/5zVk9j6T5qDxmgpPbDK2TSYVQfg=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr7812130otl.196.1541872144349;
 Sat, 10 Nov 2018 09:49:04 -0800 (PST)
MIME-Version: 1.0
References: <1541871439-4882-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1541871439-4882-1-git-send-email-martin@kaiser.cx>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 10 Nov 2018 15:49:00 -0200
Message-ID: <CAOMZO5CF0KoAckvJ++FuQcaj2d1bNBCvZMzThuezUCQ95+od_g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: imx: make sure that maps are fully initialized
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Sat, Nov 10, 2018 at 3:39 PM Martin Kaiser <martin@kaiser.cx> wrote:
>
> The commit that added scu based pinctrl support introduced a regression
> for the mmio case. In the for-loop where the maps are initialized, we
> end up creating a partially initialized map in some cases. This causes a
> kernel panic when such a map is used at a later stage.
>
> When scu is not used and and a pin uses the default pad configuration,
> the current code sets the map's type and data.configs.group_or_pin but
> no configs or num_configs are set. The previous code without scu
> support did not create a new map at all in this case and did not
> increment the counter.
>
> Fix this by setting the map type and data.configs.group_or_pin only when
> a configuration was set before, either by scu or by mmio using a
> non-default pad config. Increment the counter only if a new map was
> created.
>
> Fixes: b96eea718bf6 ("pinctrl: fsl: add scu based pinctrl support")
> Cc: A.s. Dong <aisheng.dong@nxp.com>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
