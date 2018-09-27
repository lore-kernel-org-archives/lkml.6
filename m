Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94010C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B01216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B01216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeI1CWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:22:50 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40859 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeI1CWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:22:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id j68-v6so3297590oib.7;
        Thu, 27 Sep 2018 13:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9ZTIqwHTp1Z/5i9EkPs17r9W8KQ/GROFb82dM8SLrA=;
        b=mgNbiLmO0XHsb8Jlzhas7jhOEedxAJjRmGkVIsOaeeufOzkuZhAhqRTiAk03aAK8Uu
         SZwbqO92wSR+XkTeKXKribP6sqPTss+MdPNYNEFPXGzW6fJWQckWo8lV3EzVcjrLgp+y
         tcQ4Wz99k8k4FghzG+/oUJAYmFWR7f4fLqYLW0rS/w0ywDHceMtWJreNPuTW94xVHYl9
         K0y3yELnLAXe0pQe638qbrC5Aea2QgD0MdTEa9vJmXciUn+jcOYWjhH3awRcAGHhk8ql
         Xp3P5bRnixwprVdz+yf7Y71+FXI1kaIHDU9k4KbPLEQ+YAZwkN0Q/1Mc+EJQtSkETczJ
         Xoiw==
X-Gm-Message-State: ABuFfojmjnGbp6elngi1SB745QMRCdakG0a94tTBuS5ew7U30PyEyHTH
        tsWZb1SHo8Xte12954magQ==
X-Google-Smtp-Source: ACcGV63e/pUyMYhXxUNL+6/QPqOeu2Zrqb5QgFFIqX9l9ARAffnC5WBAgXmuoudtvrWr6OLFJTlU8Q==
X-Received: by 2002:aca:4792:: with SMTP id u140-v6mr4240258oia.215.1538078572722;
        Thu, 27 Sep 2018 13:02:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 89-v6sm1124187otr.62.2018.09.27.13.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:02:51 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:02:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Akash Gajjar <Akash_Gajjar@mentor.com>
Cc:     heiko@sntech.de, Deepak_das@mentor.com, Pragnesh_patel@mentor.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Levin Du <djw@t-chip.com.cn>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: add initial dts support for
 Rockpro64
Message-ID: <20180927200251.GA4060@bogus>
References: <Akash_Gajjar@mentor.com>
 <1537943105-21247-1-git-send-email-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537943105-21247-1-git-send-email-Akash_Gajjar@mentor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 11:54:57 +0530, Akash Gajjar wrote:
> Rockpro64 is a rockchip RK3399 based board from pine64.org.
> This patch adds basic device node support for Rockpro64 board and make it able
> to bring up.
> 
> Peripheral Works
> - Sdcard
> - USB 2.0, 3.0
> - Leds
> - Ethernet
> - Debug console
> 
> Not working:
> - USB Type-C
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> ---
> changes for v2
> - Added support for usb 2.0, 3.0
> - Added fusb302 node and its regulator support
> - Cleanup pinctrl node
> - Remove backlight, pcie, sound codec node inherited from firefly-rk3399 dts
> changes for v3
> - Added copyright properly
> - Typo correction in commit message
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts  | 692 +++++++++++++++++++++
>  3 files changed, 697 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
