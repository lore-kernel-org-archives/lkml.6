Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C64FCC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C88120891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JobCUoud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C88120891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933204AbeFLSuB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:50:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46220 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754083AbeFLSt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:49:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id v13-v6so25234865wrp.13;
        Tue, 12 Jun 2018 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=8rlsoXxT9q+6pPK2tpzX+yqssP8rjp/z6xS+iP+IgbM=;
        b=JobCUoudlfhmv55hMnD/XB4V/QI7ZVitYyj13mjaQPtLpubI+YkBEBSa2eG7B3TJtR
         mVlvEvXdws0HXEPKTVVTR7PTjI6gLMDQAqeyE74vVrFVHZDZD9pvDt81SwaPds3sJOjj
         AmAJD7a6uHilsktuWVDAKMH4iu+WYfnobiBA0EyiJ1+SFhsDu77xzF/SyQL0uH3g6t1+
         RHco9DRsYYU7yKhvRqgQNHADHfpy4Z1P5JJaEThUwkCgK2EMy1pByidczAl/dAQt5Z6U
         3CA86Sol1d8wciIe2Mgv4QXs3JI+0e9hwBvH7kNs1bG68cQeJwThDwpTTmYdAlPNnmfT
         eR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:references:content-transfer-encoding;
        bh=8rlsoXxT9q+6pPK2tpzX+yqssP8rjp/z6xS+iP+IgbM=;
        b=OqlRfz3VwUZr+eJO7eKFRWVhn/n2sC9xRKJMAVPVZr41aS/Sui9qvxFCGaX5HZJReH
         L/2/p1x/l5tSzz7oYNea608gn0KyoXuqX9UZiz8prHH7rLr+liSiGkxHQS8mPBriHPyJ
         1FmtNV1aLpzX6lSAy75fp003AINiodIx1/zjTzS8a0/EAEnB7etebOj7aEQuUwRqeuQz
         wUA+GUQzH3pNMnPbI2y8wBc/0pwXGK0YIThcBvYFG8XrfSBPG2l/VX2dz8C+LhYdIE/f
         lnPjHPC2kL1trmnfPd8ldumoyoXhBOQG/9PlnKS+XId5+KkPNkoE9ZMjg6A0sXkJTEAs
         Fn3g==
X-Gm-Message-State: APt69E3wWqD/VOHoHbZB9btyZEpQJowo8WmCSAr1sb3DVAjLWfFCiz0r
        /igzzdkidYTZt3d1EnxoQTk=
X-Google-Smtp-Source: ADUXVKInzsXz0leFvJFs0IQvji1i3BScCCd47jpYEcDzfW8AFyghlOvbFcb5her6c99UzKZJXHhK9A==
X-Received: by 2002:adf:e852:: with SMTP id d18-v6mr1493382wrn.146.1528829395046;
        Tue, 12 Jun 2018 11:49:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j43-v6sm594007eda.26.2018.06.12.11.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 11:49:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Vivek Unune <npcomplete13@gmail.com>,
        florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        jonmason@broadcom.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: BCM5301X: Make usb3 phy use mdio phy driver
Date:   Tue, 12 Jun 2018 11:49:39 -0700
Message-Id: <20180612184939.9095-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
In-Reply-To: <20180409223153.41893-1-npcomplete13@gmail.com>
References: <20180315135647.48456-1-npcomplete13@gmail.com> <20180409223153.41893-1-npcomplete13@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Apr 2018 18:31:53 -0400, Vivek Unune <npcomplete13@gmail.com> wrote:
> Currently, usb3 phy in bcm5301x.dtsi uses platform driver which
> requires register range "ccb-mii" <0x18003000 0x1000>. This range
> overlaps with mdio cmd and param registers (<0x18003000 0x8>).
> Essentially, the platform driver partly acts like a mdio bus
> driver, hence to use of this register range.
> 
> In some Northstar devices like Linksys EA9500, secondary switch
> is connected via external mdio. The only way to access and
> configure the external switch is via mdio bus. When we enable the
> mdio bus in it's current state, the mdio bus and any child buses
> fail to register because of the register range overlap.
> 
> On Northstar, the usb3 phy is connected at address 0x10 on the
> internal mdio bus. This change moves the usb3_phy node and makes
> it a child node of internal mdio bus.
> 
> Thanks to Rafał Miłecki's commit af850e14a7ae
> ("phy: bcm-ns-usb3: add MDIO driver using proper bus layer") the
> same usb3 platform driver can now act as usb3 phy mdio driver.
> 
> Tested on Linksys Panamera (EA9500)
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
