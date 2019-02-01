Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5EFC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46DB20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuMewRnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfBAAxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:53:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33648 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfBAAxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:53:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so4375842ljd.0;
        Thu, 31 Jan 2019 16:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSQwEIH++ZxsN+L+eoV/Z3MO7hvsQRf3FV2fxKuX3u0=;
        b=KuMewRnEq7Ee3pTqLXChvW5pLh2PquSAi8PGaBO+rDTJsS9TgWbbszt+l0V8e0Dd7R
         jyV/f79vQL6kMXYqtWSXDCZ9AVFjSIVD+NI2f4NQto6dyozx3pJQ37QQB5ufetp8pg72
         FZ3GfuJRIe7EGrvMDSjzkS83rcyXWahYw7PznMtyugvNTdvZjqTYLcH7YwB1MYvjLNXt
         rae5OPzMAsvjr+Xt0HQmeI/yaP1+IV33gyKHlNXfqQKGJOqN42r7KcooEOoo6ay0wiVi
         nkqllVr2/RlDC1IE9oDxzdhfJpsFAWM0uR89WwEBzlvObqOi8uulmD0lkHs29o59+3PX
         mM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSQwEIH++ZxsN+L+eoV/Z3MO7hvsQRf3FV2fxKuX3u0=;
        b=A8uqDu7UkzssG2F5LRjjelh+Yxz53dvicKw+aTsJ+d7EZ77tCVee4NqUUyqWeIojYG
         R5s25zuNXI4Ae1v7vlr5YKRBa1p6eslyp9vxGzSsgq/nqAEEDekdVJZCWoAZd2bNVkR9
         HVq4QG0JzYNDOzGwW2CNpCNpADZ0H0O1sJYxr4GvilLNgX8Idgl79TqVaymsA1t8V0vA
         dGGyby+ntNDYo04HBP41FOYCtwMPCZCCbQDHgHShX8gUTNmPVXSvOW2A0BOO41fccn/d
         9VEPemgI/uWSGDTU9Bq9DDvjBsQ5XscLQxkN2revfMJygt3ScQwHvbhi7Cj8owsKrgXY
         pYlQ==
X-Gm-Message-State: AJcUukcMtwId+f8tvQI1rnI2BvANWu3bnkMcOVANPnCqxN9lPcpxPCHG
        KT6esG3657DHF2IbCqYZy6+NaMcN
X-Google-Smtp-Source: ALg8bN5UZ9XpOar26tJX2WV1ybB1iRamD5G+/7kL/JNUWFpryGEopTXD3kV/WZ6m1xlNbsnYqdbmJw==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr27240067ljk.80.1548982433051;
        Thu, 31 Jan 2019 16:53:53 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id w16-v6sm1047660ljw.11.2019.01.31.16.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 16:53:52 -0800 (PST)
Date:   Fri, 1 Feb 2019 03:54:17 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190201035417.737ff65f@dimatab>
In-Reply-To: <BYAPR12MB3398D3DCD0DEACD67A58C75FC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
        <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
        <4663c7b9-d306-1cd4-1bdc-f7be84af0667@gmail.com>
        <8a88f8ee-24d3-00ac-f1fa-c43b576ed82c@gmail.com>
        <BYAPR12MB3398CFEE7E912513AE48DD2FC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
        <e50a353c-94c4-1a47-92a4-5f41f4f64aa7@gmail.com>
        <c2676c08-83d7-2ac9-ce34-c7c7f86d798e@gmail.com>
        <BYAPR12MB3398D3DCD0DEACD67A58C75FC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Thu, 31 Jan 2019 21:46:48 +0000
Sowjanya Komatineni <skomatineni@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > It works with this change:
> >
> > diff --git a/drivers/i2c/busses/i2c-tegra.c
> > b/drivers/i2c/busses/i2c-tegra.c index fe5b89abc576..8e059e94b94e
> > 100644 --- a/drivers/i2c/busses/i2c-tegra.c +++
> > b/drivers/i2c/busses/i2c-tegra.c @@ -1170,10 +1170,11 @@ static int
> > tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev, time_left,
> > completion_done(&i2c_dev->msg_complete), i2c_dev->msg_err);
> >
> > +       tegra_i2c_init(i2c_dev, true);
> > +
> >         if (likely(i2c_dev->msg_err =3D=3D I2C_ERR_NONE))
> >                 return 0;
> > =20
> > -       tegra_i2c_init(i2c_dev, true);
> >         /* start recovery upon arbitration loss in single master
> > mode */ if (i2c_dev->msg_err =3D=3D I2C_ERR_ARBITRATION_LOST) {
> >                 if (!i2c_dev->is_multimaster_mode)
> >
> >
> > Which means that HW state is kept dirty after DMA transfer. Please
> > check everything carefully. =20
>=20
> Identified issue, When I moved logic around for diff changes, INT
> enable isn=E2=80=99t correct for FIFO DATA REQ. Will have proper fix in n=
ext
> version.=20
>=20

Awesome :)
