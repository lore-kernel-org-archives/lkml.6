Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E081DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9572D2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Rghrq+4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9572D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbeGSQQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:16:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33007 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeGSQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:16:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so2060889wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=P29LRP7KrXJPIsJl6OhU4HvJVmXMzm6c/Wy++pqM2mE=;
        b=Rghrq+4a1ihDw2wppwXDLZUxgmlCQavXbtLV32GD4wBnCBccwZBOXNZrV3KcialZEE
         HKVdDlv+YDcclG5R205FznFpLWOXMViaYdEZcvnjjW+edoDdVVnn0rSiURoVAsuUvqVh
         s+LEf1PLlDTk58qbEYIAIUsXrgIsWytBRUXwHso6ECWNuac0W37XbpjtuGt/uxpG3q2p
         w2mwpF7pl801+3maEjPP5ckdrGCiMyf6/Dly9X2Rsp82SSuZGjj4P918c+uGgqztDyxe
         fFMcBRtfKvAjaovkzmdBVk2ATH/Ops8RrnbzJUGhDetLt3CtwsNJEyzx/5nKJL3nt2nA
         bhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P29LRP7KrXJPIsJl6OhU4HvJVmXMzm6c/Wy++pqM2mE=;
        b=Yt7KlRzg8ESwWR+iQXUPP1oFJxcTfsBUr0gnRkPW9d7CjwedNh1zLd7Y+c+mUla69K
         Lzf/09DK100cxqixnIpcEQkpaIOUwjcCb1JBpcmOiYNhtaDFsxro43eAxpSOu98ZPu19
         rL9PCENO+Ymg0xjj+1G2wQ8XGq3LITDuSdN/oDGg/aPSWmLTkanzDU584a5ZXNpXZQa4
         p3oiZnUPi8Fc75su6hhtmcoMWpIEcQZHHjVtONNVi6Ytg2t0zeFkI1yZrHdIZ9T5+yjx
         hcItjzMvBRtXR12uoUPXSqpwt95vXISe4nKqnMUL+L+bcoVRHHuIae7t6U5mHsFXbd8o
         zfpw==
X-Gm-Message-State: AOUpUlHXer2PW70iiL/MTIzBrcniPSvnYa8bjwCS0mezDbLFteHKtAOk
        GfyLghQYnvNLC4ovbwei1Az4NA==
X-Google-Smtp-Source: AAOMgpdb7tUY7OHciFrfyeXbiZM5MCONO6Z1XJWjsDxyu6HsWAMVGQjDA9bZxUgU+a8qfnb4ZAM59g==
X-Received: by 2002:a1c:1d2:: with SMTP id 201-v6mr4316225wmb.4.1532014366428;
        Thu, 19 Jul 2018 08:32:46 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-40-185.w90-86.abo.wanadoo.fr. [90.86.159.185])
        by smtp.gmail.com with ESMTPSA id w9-v6sm8914090wrr.77.2018.07.19.08.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:32:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
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
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 0/3] net: extend eth_platform_get_mac_address()
Date:   Thu, 19 Jul 2018 17:32:40 +0200
Message-Id: <20180719153243.20944-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to a series I posted a while ago the goal of which
was to replace the at24 platform data with device properties. To do so
we need to somehow remove reading the MAC address from relevant board
files.

In my patches I used nvmem and MTD to read the MAC address from within
the davinci emac driver. It was suggested that we generalize it further
but since MTD doesn't support nvmem yet, the best we can do is to move
this code over to net core code.

The following patches modify the eth_platform_get_mac_address()
function which seems to be the best candidate for this code.

The first patch splits the function into two subroutines.

The last two patches add nvmem and MTD support to the function. In
order to stay compatible with existing users, nvmem and MTD will be
tried last - after device tree and arch-specific callback.

If this series gets accepted I will modify my previous patches to
use it instead of handcoding the same operations in davinci_emac.

v1 -> v2:
- dropped patches 1 & 2
- improved the MAC address verification and fixed a potential buffer
  overflow in patch 2/3

v2 -> v3:
- in patch 1: split the function into subroutines in preparation
  for nvmem and MTD support
- modify patches 2 & 3 so that they have a separate function for
  each new MAC address source

Bartosz Golaszewski (3):
  net: split eth_platform_get_mac_address() into subroutines
  net: add support for nvmem to eth_platform_get_mac_address()
  net: add MTD support to eth_platform_get_mac_address()

 net/ethernet/eth.c | 117 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 11 deletions(-)

-- 
2.17.1

