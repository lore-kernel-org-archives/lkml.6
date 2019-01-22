Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74BAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A2121726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1ihnbeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfAVXjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:39:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33655 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAVXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:39:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so248387lfc.0;
        Tue, 22 Jan 2019 15:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5VYBgL9jX0969Xk+NDIlqX03ARn4bupWy69/ku4CBw=;
        b=K1ihnbeC28J27CVlPTA7MAf3H0eRq8hEH1d0gML1kYum7jZfC1uK0PGHKgYHMO6yFE
         HFyORfqvasFdAcGOTuEMhpBsFkA1rYJv8zcx8iaaEuHJF6y3F9MF+5btAmwljVE5360C
         FPyr+aB6WOD4H7Z3GqSyD5aNCQA5AlwhbKvAj09YMTxI7CKRLtljyuX9/oUgZh5lrbuQ
         qLqw2Sqw+SjVMfwmCnAuRc3IlLj+W8ofvu8GaPDFKtRdVt3UfX6v0NaDM/ZqN5s6dO/+
         nBmURTsp1QY/8htyeVgHt/yMoYdGCvEBKmrXL0yntbSE13jN61P6sCtWCgCKCBTJ+ciz
         MRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5VYBgL9jX0969Xk+NDIlqX03ARn4bupWy69/ku4CBw=;
        b=lqsZetfa08zXHoQ6SWWHunk6NEy/A687yzugH5Z3xZ0hVkPBXjevBxYdzK6mAEcvIG
         y2SvJLHwCI/oZutQovY0nn6nwiClkLtQI14U8leH9Rghg3A24aj0Nbs25SJwEU2zQQuQ
         Y0OgHc/uvEPDaOCx1JG1UIQltqyAGj356+MR/Ejv3W6uOBCSTkXq+mTYjW0ueM1H8KCz
         yuIK9ZEIuh4QGOb60F8pgRal0Cyg9BsMAOY3+XLmHLqIdF+8E2nDana7c20nMB6a0W3P
         n1G33+FMHqANSmK87GVBTiC1UpNsmDkFfJUrckC9yGjw22Cgwsk+Ty5tQg3JTFd7iyRT
         DTHg==
X-Gm-Message-State: AJcUukfZSJHOokbO1/MjXYVFp9ycL4xJAifcwBU1rAeEL5EoV30SL/Bg
        BOBXdcKtw+gxysCptnPwZPs=
X-Google-Smtp-Source: ALg8bN5sEo+iMMwPKRyOVkx4yA1qPad5sylseTdj8se9Y5LniZfOJ53L0ZjtqZdg8RUXiqwOnj4abQ==
X-Received: by 2002:a19:6514:: with SMTP id z20mr21325115lfb.31.1548200346083;
        Tue, 22 Jan 2019 15:39:06 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e14-v6sm214913ljl.43.2019.01.22.15.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 15:39:05 -0800 (PST)
Date:   Wed, 23 Jan 2019 02:39:02 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V3] i2c: tegra: Add Bus Clear Master Support
Message-ID: <20190123023902.4bbf5c5c@dimatab>
In-Reply-To: <BYAPR12MB33986390C45475180381713FC2980@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548187338-6807-1-git-send-email-skomatineni@nvidia.com>
        <5405e9aa-d974-ca9d-dec1-32f8631a045d@gmail.com>
        <BYAPR12MB33984356AE1E279C7E0E880CC2980@BYAPR12MB3398.namprd12.prod.outlook.com>
        <20190123014042.6d64ee29@dimatab>
        <BYAPR12MB33986390C45475180381713FC2980@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Tue, 22 Jan 2019 23:26:08 +0000
Sowjanya Komatineni <skomatineni@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> >> >> +	if (i2c_dev->msg_err =3D=3D I2C_ERR_ARBITRATION_LOST) {
> >> >> +		if (!i2c_dev->is_multimaster_mode)
> >> >> +			return
> >> >> tegra_i2c_issue_bus_clear(i2c_dev);
> >> >> +		return -EAGAIN; =20
> >> >
> >> >This changes the returned errno from -EIO to -EAGAIN for the=20
> >> >supports_bus_clear=3Dfalse case, is it okay and intentional?
> >> >   =20
> >>=20
> >> Yes EAGAIN is intentional to allow for transfer retry.
> >> During single master mode, ARBITRATION LOST notification happens
> >> when 1. I2C Master sees the bus is occupied by some other device
> >> when a transfer is initiated 2. I2C Master lost the bus during
> >> arbitration incase if slave device pulls SDA line low continuously
> >> for some unknown reason If arbitration lost is due to cause 1,
> >> retry helps to continue with transfer once bus is released by the
> >> slave and it just added delay in communication due to bus release
> >> delay by slave. In case of 2nd cause, retry never succeeds in
> >> cases where bus clear is not supported. =20
> >
> >It's unclear whether the "never succeeds retry" may fail with the
> >EAGAIN, causing an endless retry-loop. Could you please clarify this
> >moment? =20
>=20
> during master transmit mode, on arbitration lost and if master
> doesn=E2=80=99t support bus clear to recover then transfer will return
> EAGAIN. I2c core base driver performs retries if return code from
> i2c_transfer is EAGAIN up to specified retries in i2c adapter and
> returns the ret code from the last retry. Retry is not endless as i2c
> core base performs retry only up to specified adapter retries.
> Following return code from documentation
> https://www.kernel.org/doc/Documentation/i2c/fault-codes
>=20
>=20

Good, thanks for the clarification.
