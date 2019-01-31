Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9102FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6064720870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJHnErV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfAaEBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:01:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37401 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaEBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:01:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id y11so1262920lfj.4;
        Wed, 30 Jan 2019 20:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0RqIU9Eq95C4tey2sbvRlLsrpRApYrAJ46rBJmN1FE=;
        b=HJHnErV+jYPhhT1AhiV8mdTtXIRS2qI5NUscyWMPEXARnDdJF0eY2XaJCwjj+RuPQJ
         ElzO4IUq62zdB5a3igmWrgJH9nwcPkBH2WEn9lKEjOmygf8q8lnM7KEbhALav7Vr9rgB
         W4xe07hw0ZWBLsPxBGmHaBZQ/smuJFgRHM9VmoMizxkvJmyQlCcfV8BNdC2shcbTgyYK
         t1abPnbPh02i2kVWWAgPeYIAigYxMinH8ouz5M4Xl4q+BdsFfItiWankYZdW/RMmyn8i
         /A2Im2Wyblr/Qk4yjmvhVP/1H6IVhfRE8mInnDHkKlj0wBpd/K6fyzClcUts7ueYr0eI
         qtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0RqIU9Eq95C4tey2sbvRlLsrpRApYrAJ46rBJmN1FE=;
        b=ge4rQoWmcYVbrUkROkJiDhjHSFn9cUV5UW5O0XPf+mtpUu4qsLypXXi0AHJciHI3Vd
         TJlqS02sm/c0FLlp6A/6Bnl71A3u27SlcYvQ1KkTpLLJr/BMkg7oDEcdfPWxq6DgMrxE
         3UD5cHJWeg7zP5aeX9+aBhFG8GDuvaBpA0aCWiWZnf4UBCEECxRnml23vMzs5UBJNxvh
         BNHngeqfoXs9zozlHpJN2f7hSJbrq9eB8Qw5tGDmcNySZ5B59UQgxUzLTYW6QBJ8pCux
         zoW45oN/7S/ax+wCvrPGPOxTVfqA6JEudeoMHp6UIro4vptzlLsITe3jaeg1y6DrpJHH
         xVLw==
X-Gm-Message-State: AJcUukfF7HbjijlOW/Bi4njTy5ZoiuSPYtWJp2dJYzZizY9RoDtJeuhH
        tkKQ0Fc9Q6o1Endqsh7dpF0=
X-Google-Smtp-Source: ALg8bN5tZb68ZnyBtW2I8jt5rh04CiSaW6vzYEYeahXZv+sZCB14XSKsIekeM7yiFCY6PQ0QVqJBww==
X-Received: by 2002:a19:c014:: with SMTP id q20mr27720704lff.16.1548907259216;
        Wed, 30 Jan 2019 20:00:59 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id s20sm592218lfb.51.2019.01.30.20.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 20:00:58 -0800 (PST)
Date:   Thu, 31 Jan 2019 07:01:20 +0300
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
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190131070120.33127cd8@dimatab>
In-Reply-To: <BYAPR12MB3398C3E7C5842C698B5CA1CCC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
        <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
        <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
        <BYAPR12MB3398B845E97674BE93CCD7D9C2910@BYAPR12MB3398.namprd12.prod.outlook.com>
        <f3282ada-56a8-b5c7-c400-38483eab2d06@gmail.com>
        <BYAPR12MB3398CE89D24AC71BF7DAF43CC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
        <725aece7-d3f2-c26f-4af4-200d8b507123@gmail.com>
        <BYAPR12MB3398C3E7C5842C698B5CA1CCC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Thu, 31 Jan 2019 03:34:59 +0000
Sowjanya Komatineni <skomatineni@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > I2C_INT_ALL_PACKETS_XFER_COMPLETE shall be masked for the PIO mode
> > I2C_INT_PACKET_XFER_COMPLETE shall be masked for the DMA mode, if
> > I'm not missing something.=20
> for packets with repeated start or continue xfer,
> PACKET_XFER_COMPLETE will be triggers for packets with stop bit, both
> PACKET_XFER_COMPLETE and ALL_PACKET_XFER_COMPLETE will be triggered.
> To be align with what PIO mode is doing, will not use
> ALL_PACKETS_XFER_COMPLETE for DMA in next version.=20

Sounds good.

> >
> > Handle the error-case here:
> >
> >	if (i2c_dev->msg_err !=3D I2C_ERR_NONE) {
> >		dev_err(i2c_dev->dev, "i2c dma transfer failed\n");
> >		goto i2c_recover;
> >	}
> >
> >...
> >	<--- end of tegra_i2c_xfer_msg() -->
> >
> >	if (likely(i2c_dev->msg_err =3D=3D I2C_ERR_NONE))
> >		return 0;
> >
> > i2c_recover:
> >	tegra_i2c_init(i2c_dev);
> >	/* start recovery upon arbitration loss in single master
> >	mode */ if (i2c_dev->msg_err =3D=3D I2C_ERR_ARBITRATION_LOST) {
> >		if (!i2c_dev->is_multimaster_mode)
> >			return tegra_i2c_issue_bus_clear(i2c_dev);
> >		return -EAGAIN;
> >	}
> >	if (i2c_dev->msg_err =3D=3D I2C_ERR_NO_ACK) {
> >		if (msg->flags & I2C_M_IGNORE_NAK)
> >			return 0;
> >		return -EREMOTEIO;
> >	}
> >
> >	return -EIO; =20
>=20
> When DMA transfer timeout, no need to check for ARB LOST or NO_ACK as
> if any of those interrupts trigger interrupt handler will terminate
> dmaengine and completes so DMA timeout will not be seen in those
> cases and falls thru msg_err check
>=20

Okay.
