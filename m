Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85651C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D83425AC6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gfGloDXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D83425AC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932187AbeFZHoX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:44:23 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38571 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbeFZHoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:44:20 -0400
Received: by mail-io0-f194.google.com with SMTP id l19-v6so15043875ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dFOoq9ukdoIjNXP3Kck/Dqmkte+kn13Q/803Th6ijI8=;
        b=gfGloDXT2a571Nn2GPe9Ip4bsonGV6nb7vRFABv1ZlN91pvBVJtEs6+D7oOa2wMx1I
         kdTuRnOI254j2c5AMsqecFk5prbJI/6I8nrX2pdHosm87olVRD7LsRdaf8E1JxIDC3g5
         9vFKqpZl/R2xsrCErrg1mZaS3EP6Ru8PPxIhASTKBe7xRK+jkUZw98RxPZ+nOpPZDGe7
         tWyTG/hje1u/cLHK+vjKrKyvVUeuQPb/rF2gH8Nr1MegViJ68j3FJuNf1/p5olz55A4H
         Uxxtk0+lLN0aNd+HUmZJm/OeBnGFC8qFEzXnSt3AQNBS9Ttz4cz0GZEmuVjscwKouHGy
         gdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dFOoq9ukdoIjNXP3Kck/Dqmkte+kn13Q/803Th6ijI8=;
        b=ZTzWfm/ddD3RIKYg6MAT5KUOs4TSzzq2c2+sF09j4tQwBHpIMJt5WM90MxggLxfpyT
         zXQZqbJa4A2N0ZeDWtX3M4QgUaTg03iTL08sItWCbFquGJO/Z8Q2ye6sLBVFNKYnQMAi
         xABu4UyD274b9srJZ6hK+J7apIqNx7CJxTGKGn6Naynxh+ki/rTIzgAxIy9BQLnU5e7j
         gjy5loYeMzc4opjb6UUN3yIAXsrzmaompX0XY0e1tGIbxTmsiYYoyqO9svHLWkbeH9aP
         g6+LwHfq3FpmRDgv9Vsnq62G+NwHJTjX0tLLcaSvqFlJxCjsLmgA2qpXb1DUt4YqGVOt
         4jmw==
X-Gm-Message-State: APt69E0dfAN9teivMUizEyrccti0R6CS7JneaT9jrNXrtmaNaVjp1kT9
        tS9Dq5lMzq+oFGVvNW1gw+WODX/ax8smLxi3R4OtpQ==
X-Google-Smtp-Source: AAOMgpdeCb2eZ9/oOfaQ5y8kwc9lWd883NoOmwOgWbFPdmZRoBVyktbUMdHrqa2FukkfCewvqJyA2SPSd5abhZBBxbs=
X-Received: by 2002:a6b:6515:: with SMTP id z21-v6mr323050iob.258.1529999060083;
 Tue, 26 Jun 2018 00:44:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 00:44:19
 -0700 (PDT)
In-Reply-To: <20180625180237.GC17417@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl> <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com> <20180625180237.GC17417@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Jun 2018 09:44:19 +0200
Message-ID: <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing at24_platform_data
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-25 20:02 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> With my patch 1/14 you'll get -EPROBE_DEFER from nvmem_cell_get() if
>> the nvmem provider is not yet registered. Will that help in your case?
>
> I don't think so. My driver instantiates the AT24 device. So if i get
> -EPROBE_DEFER, i need to cleanup the probe, and return -EPROBDE_DEFER
> to the code. Which means i need to remove the AT24 device...
>
>        Andrew

Are you sure this is the correct approach? I understand that you want
to use something like board files for your machine? Wouldn't it be
better to register a platform device for at24, register a cell lookup
and then depend on that cell from your driver?

Would you mind describing your platform in detail a bit more?

Best regards,
Bartosz
