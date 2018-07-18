Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CC020652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WHc7en4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CC020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbeGRQtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:49:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50626 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731361AbeGRQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so3371252wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QP2WPmDtY6wTfmL4nBDJ1iHeMuOKJmvPoI3id9/o7tA=;
        b=WHc7en4HQHiC5xT4H2BfLn39yEsVeZq8SIO2Fgq+i9TzytJdLWfRFSlhsSvWkE0BkY
         zAryg4VAidW13C8fv9eDfnSQL13zbcDnDTHiERobfh98zKpUES/PJuSIKQ7j4UXtSdGE
         IHf9DptI7Wf2oVMdPqAKarp6sYK2th4B7jTYgwgY6qYxH0RVeC4Flht0JjmqV4Vh+gG+
         FOOUuiA1mXpGhrIgqQBEAjG7EoLcSgpec/L+FjFpvIk2ghyNv9fu1jogqxzzPYn1WuV/
         lAC9KMMsOOTTwXBJ2tPvXyn9cjslWEypxh27BX+hNQe3QBtHii4Q2aLSZB6fajkpGqHO
         r+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QP2WPmDtY6wTfmL4nBDJ1iHeMuOKJmvPoI3id9/o7tA=;
        b=EzgdVPQJ7LiE5Sa5FGm1MRHb0j7N95oUEOX1C4WeScO5P/5R5gLJpQvbFzNNkCiGoM
         SaWfG6j0qHvPSw1AAi0/yEc4uXI7BovHq8hDl4ylq+QQdbtPma16DUEmhw6hgq54wU0F
         w1fnjI+V0pr+kCDNrzQ5Rm5DNjgJuYOV8H9RgVCd+QJxCuk0nn2zpqYUk/1DUeXY05nW
         CA6Oq7jttarqq9+d+RgM90td24/vawh+tkP7ZJQxQS8v/xsXY8H+TULOYxLZadzIgjk/
         LOMH1vkGlnYilg5CMoptNDkjQ6UJSBbqH7ElzdEtCHPDcxcNtd3uw6v4zpc2OwtpGrO1
         9Mlg==
X-Gm-Message-State: AOUpUlFzgrvuDH6WyUurK91O8L6CLNUByu0W3jro/BkNpFQ0dU/iBI9j
        No9V0QrjxRBAEfPvEsStpztGqQ==
X-Google-Smtp-Source: AAOMgpfiV9Xny1ZAfOOolJuDgF3rZr+jl4VpeE5e5Xet03R+sQ0oHPtZs9/eaZqTrun8BlGkNVIhKA==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr2039020wma.72.1531930241965;
        Wed, 18 Jul 2018 09:10:41 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v185-v6sm2847803wme.30.2018.07.18.09.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:10:41 -0700 (PDT)
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
Subject: [PATCH 0/5] net: extend eth_platform_get_mac_address()
Date:   Wed, 18 Jul 2018 18:10:30 +0200
Message-Id: <20180718161035.7005-1-brgl@bgdev.pl>
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

The first patch only visually shrinks the code because this routine
will grow significantly in the next patches.

The second patch adds an info message on success so that we keep
getting notifications from users who already are verbose.

The third patch calls is_valid_ether_addr() on the read address so
that we're sure it's correct.

The last two patches add nvmem and MTD support to the function. In
order to stay compatible with existing users, nvmem and MTD will be
tried last - after device tree and arch-specific callback.

If this series gets accepted I will modify my previous patches to
use it instead of handcoding the same operations in davinci_emac.

Bartosz Golaszewski (5):
  net: visually shrink eth_platform_get_mac_address()
  net: add an info message to eth_platform_get_mac_address()
  net: fortify eth_platform_get_mac_address()
  net: add support for nvmem to eth_platform_get_mac_address()
  net: add MTD support to eth_platform_get_mac_address()

 net/ethernet/eth.c | 77 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 12 deletions(-)

-- 
2.17.1

