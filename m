Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91235C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5639720834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F9tXbxBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5639720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeK2RlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:41:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39992 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeK2RlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:41:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so635062wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 22:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YV9hfzTpUgAyUx8Nm7ThXxiskRUw8Zxkk0mellNLqOk=;
        b=F9tXbxBkn92Q4HFrUMZtBEb6/fIHm/Il0Waxh/sl/Bn9hQzfQOW5wc4Tq3e4d0mA04
         7PqcP0879t0Fb/glJXNLPAQ0JL3FHMO1fwcTbGAmv6Y+WAZ6khnwfrh3KIs/rOLwBr2Q
         yOrKuxwTe+UKK6o2AMo2U3sKFjyvRyEJRS0gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YV9hfzTpUgAyUx8Nm7ThXxiskRUw8Zxkk0mellNLqOk=;
        b=A77A5Z0TxJzSj2qfBqRtrvOe63h4KI/Mgewzz/KzS2JIP96YbQmBpKr1dV8zPk2OA0
         /XPqW+O9hnLux0eD1noTebkUnQ1jdcueq9SVAOIVivbY/LAUXs7ZGJMbsQWc4NLsPQGu
         EJBMFl3hdr4QWl9oQFopBDQG9zdZ8Q417nTKj3gQa7uk5YrFvHvOpb26sJsaUsoXlpH6
         WpJV7VbU/0tCbyts7K82u2IUDJ4pMpfCZHrl4dYtsX/GQ5Tq+JQnOetTWV9FuemXY+P9
         KHLtczC//RbSGS9Xm3LTMO6KxN2wsEV39T+MXm8Ydlj7MtHxCI1JV98S15Q0BwLrsw+B
         6juw==
X-Gm-Message-State: AA+aEWauqfR5/LvOD7qbmftCj9RH5TEBY3zFBrS6THsnjUwMIb/ADA04
        R0Z5pr+mNks/VVBviUPc7DKFbG9nIx3lIY4HCy9bxg==
X-Google-Smtp-Source: AFSGD/UXdx2B12PMklgbK1k80jRCW8ghJDawzP365y9jZxQn2shyj+chDU0odFmQYiMmmo2f1TWrm9muWmqDrCeSjYs=
X-Received: by 2002:adf:ee4e:: with SMTP id w14mr252780wro.112.1543473408278;
 Wed, 28 Nov 2018 22:36:48 -0800 (PST)
MIME-Version: 1.0
References: <1542082418-16675-1-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1542082418-16675-1-git-send-email-srinath.mannam@broadcom.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 29 Nov 2018 12:06:37 +0530
Message-ID: <CABe79T7zfW5vz2S8hKWD4t8DW=uH_UkAXq1r2AyuZ+t=QZ-fQQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Stingray usb phy driver support
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

Could you please help to review and provide your comments to this
patch series when you have time?

Thank you,
Regards,
Srinath.

On Tue, Nov 13, 2018 at 9:43 AM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> These patches add stingray usb phy driver and its
> corresponding DT nodes with documentation.
>
> All patches are based on Linux-4.19.
>
> Srinath Mannam (3):
>   dt-bindings: phy: Add binding document for stingray usb phy
>   phy: sr-usb: Add stingray usb phy driver
>   arm64: dts: Add USB DT nodes for Stingray SoC
>
>  .../bindings/phy/brcm,stingray-usb-phy.txt         |  62 ++++
>  .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  95 ++++++
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
>  drivers/phy/broadcom/Kconfig                       |  11 +
>  drivers/phy/broadcom/Makefile                      |   1 +
>  drivers/phy/broadcom/phy-bcm-sr-usb.c              | 367 +++++++++++++++++++++
>  6 files changed, 537 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
>  create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
>
> --
> 2.7.4
>
