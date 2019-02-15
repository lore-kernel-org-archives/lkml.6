Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73E6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D292192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TZj2IyRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfBOEaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:30:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44249 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfBOEae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:30:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id v16so8834376wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 20:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yo+f6Yrz0/xsF4MJzC8I5QKJVsdTgOn+Do/We2mzmPg=;
        b=TZj2IyRWpH431oroAUhJ/ktk/yJl5kc8OnyK04w2rsNY7kJXb0JtJZ4A5PFN1Ovpya
         TUuifEDutSxOAiwH5MaQ/pXU8U62b8kcon9aLGliIn6F4RepdaiCccJmAAGr2I8VJ0PG
         YHxtiNYSf2E6HTxFLPL8Y3IHPI8+ZcOsUuIbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yo+f6Yrz0/xsF4MJzC8I5QKJVsdTgOn+Do/We2mzmPg=;
        b=tbeTp9MQf6CBqghVhKNoK11ag7sXElZRVHDz43/hsHs0A//xKHomb0BZdr9/dD6QAJ
         90azjBG9vC+szBNO9wBgnv+Vp9YZtyp1iakrG/A0YhEIxWDDR2fxy+bjiHcXDQOPp7aF
         eTVurrvmuh8xcN2CoAmgtZtFBidbPKxwidb9XSsQy+Fxt+cONQi50PzAWqPGqku4pd4i
         Y/zC2qAh2R3v64pgt6bFg1k+GdAXeuKinaDItrkn4YaXnTG9+66ZTjrIw9/vA7zqVpRc
         4GLvqhisJ6Iut3BNkLOXaUxbfYQ73ebmSqaliD6jl2ZW/vP0ojKgc9CVOLZoCLvuAKbl
         AJEQ==
X-Gm-Message-State: AHQUAuaPuuefXjPrNsDAqPKZGnHcpykqdDNvTIZ1kockC/U7rZXCMYoC
        FRhZj/UPKshe/Qha8c14Kc/xqdCew7kcLg/+J8LlZw==
X-Google-Smtp-Source: AHgI3IZUPHgVdNrUHF92TQ67pJ+RVO8KeshItatMDs9GOpo7XYjTRXAMPmBVg0Xgk7HRkSLYTt1cNozg1ml4qDDcRqU=
X-Received: by 2002:adf:f70c:: with SMTP id r12mr4267219wrp.54.1550205033111;
 Thu, 14 Feb 2019 20:30:33 -0800 (PST)
MIME-Version: 1.0
References: <1549474347-7224-1-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1549474347-7224-1-git-send-email-srinath.mannam@broadcom.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 15 Feb 2019 10:00:22 +0530
Message-ID: <CABe79T6BpN1FN5Q=f1TYkFDO-yitR_Zjd1vf669POho-wDQRKw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Stingray USB PHY driver support
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Could you please help to review and provide your comments to this
patch series when you have time?

Regards,
Srinath.

On Wed, Feb 6, 2019 at 11:03 PM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> These patches add Stingray USB PHY driver and its corresponding
> DT nodes with documentation.
>
> This patch set is based on Linux-5.0-rc2.
>
> Changes from v2:
>   - Addressed Kishon review comments
>   - Updated patchset to Linux-5.0-rc2
>
> Changes from v1:
>   - Addressed Kishon review comments
>   - phy init call return value handle
>
> Srinath Mannam (3):
>   dt-bindings: phy: Add Stingray USB PHY binding document
>   phy: sr-usb: Add Stingray USB PHY driver
>   arm64: dts: Add USB DT nodes for Stingray SoC
>
>  .../bindings/phy/brcm,stingray-usb-phy.txt         |  62 ++++
>  .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  95 ++++++
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
>  drivers/phy/broadcom/Kconfig                       |  11 +
>  drivers/phy/broadcom/Makefile                      |   1 +
>  drivers/phy/broadcom/phy-bcm-sr-usb.c              | 371 +++++++++++++++++++++
>  6 files changed, 541 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
>  create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
>
> --
> 2.7.4
>
