Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84DA2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PlMJmX62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfBVU22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:28:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32803 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfBVU22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:28:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id h11so1635489pgl.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:message-id
         :user-agent:references:from:in-reply-to:to:cc:date;
        bh=JGrmt3K/7C9d4lSIXEU8F7kSqd+ILecKJ2eiGA/K+dg=;
        b=PlMJmX62oaqBjeQvBF4tuOXleGUxjouBehmvZqRREBhPp/vAVNK31M9Vy/TTGO8Nz+
         44AIvTYvlSmaGSw24p21GR7eIimwk8NhcE7ZKL09lwxeVhOe8T7vjworxijnxYcSGXPN
         N/vzobJbr1ne0GoL3KJc8SdXAg9B+5mA46/ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :message-id:user-agent:references:from:in-reply-to:to:cc:date;
        bh=JGrmt3K/7C9d4lSIXEU8F7kSqd+ILecKJ2eiGA/K+dg=;
        b=Asr9W3Tb2p9aTB4uxI2u0icnRXgQ03+L45HgDYR4l8WpE9uN5ga7lJkWBm9hCkfeEN
         sy6nBy9Scu4Ou9uX8bWTivAcz55uG1tub05wwiFd33Oip9/KQlDJnHMPrGiBGOTTPjkv
         dqsRxpaos+PK35oijkaVoAuC5gR2M9gl3h2qljFw7hg0unfqOtWQoHCzvL4hY8owvxNY
         QzRfiaTEMZeEfWVAPhqM0UJYoSo3tKlrvJznc0VhkHdphdtFm89YefLztJM3D48iJ5oa
         EAKWgPZKXko5gauNxgN82vmqeUBEZo3MCo7pLLW9VGQTemHMLISLSXllH9Hel8vwJ5Z9
         Kcgg==
X-Gm-Message-State: AHQUAua/9ix3FuoeJYNGMs8FrfSqhzuRYX9WT4hRpnfYvMUBBpD1vM/q
        7tXQkYGoImjZ2e+iC7t9RFcsvw==
X-Google-Smtp-Source: AHgI3IbTleRVAWyTwMD/A0QYeUiBAT5ppQdkb9ug5wwvki5wpZtt0S0koF4APVcuqkpzuLBr8s2bvQ==
X-Received: by 2002:a63:94:: with SMTP id 142mr5633941pga.74.1550867307515;
        Fri, 22 Feb 2019 12:28:27 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u127sm3154621pfu.165.2019.02.22.12.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:28:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 8/8] phy: ufs-qcom: Refactor all init steps into phy_poweron
Message-ID: <155086730616.77512.8822375378896358546@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190213232526.26995-1-evgreen@chromium.org> <20190213232526.26995-9-evgreen@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20190213232526.26995-9-evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>
Date:   Fri, 22 Feb 2019 12:28:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-02-13 15:25:26)
> The phy code was using implicit sequencing between the PHY driver
> and the UFS driver to implement certain hardware requirements.
> Specifically, the PHY reset register in the UFS controller needs
> to be deasserted before serdes start occurs in the PHY.
>=20
> Before this change, the code was doing this by utilizing the two
> phy callbacks, phy_init() and phy_poweron(), as "init step 1" and
> "init step 2", where the UFS driver would deassert reset between
> these two steps.
>=20
> This makes it challenging to power off the regulators in suspend,
> as regulators are initialized in init, not in poweron(), but only
> poweroff() is called during suspend, not exit().
>=20
> For UFS, move the actual firing up of the PHY to phy_poweron() and
> phy_poweroff() callbacks, rather than init()/exit(). UFS calls
> phy_poweroff() during suspend, so now all clocks and regulators for
> the phy can be powered down during suspend.
>=20
> QMP is a little tricky because the PHY is also shared with PCIe and
> USB3, which have their own definitions for init() and poweron(). Rename
> the meaty functions to _enable() and _disable() to disentangle from the
> PHY core names, and then create two different ops structures: one for
> UFS and one for the other PHY types.
>=20
> In phy-qcom-ufs, remove the 'is_powered_on' and 'is_started' guards,
> as the generic PHY code does the reference counting. The
> 14/20nm-specific init functions get collapsed into the generic power_on()
> function, with the addition of a calibrate() callback specific to 14/20nm.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

