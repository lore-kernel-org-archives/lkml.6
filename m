Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4827AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0200B208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lahi/zPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0200B208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbeGMSGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:06:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34949 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbeGMSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:06:32 -0400
Received: by mail-oi0-f68.google.com with SMTP id i12-v6so63745450oik.2;
        Fri, 13 Jul 2018 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dYcU/0GMzwHskzM2qy8wkKwZonMeTkuxCnoa7WQFaUk=;
        b=lahi/zPczIcFbiX2XoEd+5CY/q4Sduk7UcpeZoik3vvvxqzj+qWfdaHr4mMiOADCxs
         +EVUktv8fbZxU9CkHaGGeBHx+O8LPRT+scFZXADVmnzEyzJMTdaXTFSSfyHVJg4Nfyts
         O2Hi1PzqBkCU6RWUzgXrkZXxekCyo2I4whkeqkwXsJYZ5hukexmuC5HQYCu5kkPh4aO1
         k1oDLbf6ML+a+7PNzJSC7NJWkIzF9mB/NQlklYkqaIJizEeZmsjasEFP7Bg+EY8rKjd5
         5F8yq3wshEKhgz+lkfFGLWkz7sZ6L7sdT9Hu0uOG7SoAHMRX2Fk7INhmMzUmFNxIFoGB
         GePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dYcU/0GMzwHskzM2qy8wkKwZonMeTkuxCnoa7WQFaUk=;
        b=pDGtgQIdEkDjsAJQ2OPOErQLT+CMWSf9zCCZdemkdFpukDgfQKdIdtySVUYTkoScCW
         tXvilDB9WMdOKcnNi4jv0aB7pKuRajzb51Y36p73v97pOjvVN9RVDnjwykVVwunK0HYF
         f8OTlG169owR14jR4iDe3WPDay0PW+QCG10egdM5sDZgAmtW+sTRyMc8guK5x7G13DES
         rX6MYTOHGYSHjfAQsoHEt5/39u+orrMwzpx+Su15qXSfhgpCgA5fzi+5bfqqcOcv+9Yk
         AtZhcLauQXExA+CrnlRKXaDUXzhW3RhmqSTh79aiYNizHG2Zdg4EPg4TzWuGO3WwCEbP
         7tKQ==
X-Gm-Message-State: AOUpUlERhvEilJWHSgx3d7+aH1Tscw0rAlhIHQjCmGDKFiOeM82V3evf
        37hS0h0PCIs58SHDqfn9dkT3GHhEgFbivzflnPk=
X-Google-Smtp-Source: AAOMgpd65BuMILXnY/lywnkSk9Iedn26A8MPT7/DdcTDwY6ZkU5xNKAp7YyibSoZpWyBnJogsUzxWEPFQbDkCsyOXyk=
X-Received: by 2002:aca:4b0d:: with SMTP id y13-v6mr8160563oia.198.1531504254732;
 Fri, 13 Jul 2018 10:50:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:50:54
 -0700 (PDT)
In-Reply-To: <20180713173005.19552-3-andrew.smirnov@gmail.com>
References: <20180713173005.19552-1-andrew.smirnov@gmail.com> <20180713173005.19552-3-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Jul 2018 14:50:54 -0300
Message-ID: <CAOMZO5ADn2FdZ+4uOV-K_vD+cLxd3a25Dbttbe7XLkB=u=6Dpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog
 compatible string
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 2:30 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> It looks like I made a nasty typo in the original patch which resulted
> in missing watchdog device. Fix it.
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: cphealy@gmail.com
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
