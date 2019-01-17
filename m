Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD156C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72F820855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfAQQkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:40:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:44857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbfAQQkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:40:13 -0500
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M1n4s-1h4RLh0Q1a-00to4X; Thu, 17 Jan 2019 17:39:51 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id 31DA16E85603; Thu, 17 Jan 2019 08:39:43 -0800 (PST)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org
Cc:     Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH v2 0/2] Add support for the Aspeed AST2500 SoC EDAC driver
Date:   Thu, 17 Jan 2019 08:38:15 -0800
Message-Id: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
X-Mailer: git-send-email 2.4.5
X-Provags-ID: V03:K1:GKo1VKn9KyeZV/UCPikGLJBxMv/BIpGyn9BpU807KE2eSsNdoQu
 xg8U5TgIwPoGsZkxB6r7aBgjNNUH/moY42AYjlJ2Zp7VaBbMxbAsgINBqjA1to9qmPs8hco
 TD57GxlxlDkKuEpn5eQuz/lJMlLB2edaNZNzBTFMX2w4grJEmU58SwBrAg/4Caa7EJjwTrE
 26RyJjqj/xDxcxqxd6JMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U8wHh0ywuwI=:x/3zO11iYv/ECKfdIlri+c
 0Okjn/KGgE+Zui6N80ea7ScUFvPx+b0kLHVBu+OxDhy/wgsdHcQ0P1cqyT2J/7R3S7evcwplC
 9GT0tzRTFVn2k3CGnQMpjg1ohWhLCRgR5vwLYUIk2mNVa6WNDjG2wIyN71gNLvFnNNzefLLGR
 0GO3026Mq9ddJngzCLBYtdG70/wir6xOhcIRV/vCTDMrrvldXyVmGGS/Mg0CYNCdK+OlD0ZjM
 PxvgKdb96IMBw+LTYMczAJcJPuJx/xgJLH9dL8PxWPPns+7Cz9c4BqqQHQQx5LFx9C7Nx4vN9
 o6+vLuWBItFnhLpxgVJmRLLRfp+iBK8vu2diKrjbBNJsVq25EacFd3XOHG6a9lc6kXpaY6vdF
 LS2CZf6YcCpTkndIx4fKXVyv7pT1BW0is3akd8rTsr39mwGseNwPBdmiVkPmjP2KX04Y1bC0U
 Q1Gkz3g7/Ml3C+b146dlNaeJAPqu0VBxharbdFLiPYjgE33dKrTbY9TA7lU8ewx72bS33VpY5
 m8yq+WmZCUiVghF75ghaZZCQ7owxxagxlbnzg8WSyDq/M7gIh2PE0CjQ6kQ1eeHcEFgYpPh6I
 C70QZbkfDD35XcGE8NX5SgvOtxK/u/8i9J+aT4yeCYPVNbsx3bBMsmuAPHTm21l1LqXk4uenH
 siCCzhss+USPjkhWuPHbZvuA3yaGfwQHfiSQZxSWEwidyvK6rjypb5ma1TuRfitfjd5Kl8VFC
 rBulFMYHuQwk7jqfEOE4CBu5CEI1QuKQ7hICHdWy5rUrM6R0WC06ELXpUu+Ikoai2+qkY0EOh
 hzx2/KhpHDD6FwU54UJQkuUX33lKbyd42h6HqS31xs54ck/vxY6O45ju3vdlu1I3PSbWA8c5g
 CgF7nGeH+3atthGkqsvzszFnz1I8ec1fqxY21y36pCy5UU2y1yc2qXjemrbcw/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan M Schaeckeler <sschaeck@cisco.com>

Add support for the Aspeed AST2500 SoC EDAC driver.

Changes since v1:
- Addressed all cosmetic issues
- Fixed (un-)recoverable address calculation in reg58 and reg5c
- Removed status field from the example device tree binding
- Added little more text to Kconfig


Stefan M Schaeckeler (2):
  EDAC: Add Aspeed AST2500 EDAC driver
  dt-bindings: edac: Aspeed AST2500

 .../bindings/edac/aspeed-sdram-edac.txt       |  25 ++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   7 +
 drivers/edac/Kconfig                          |   8 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/aspeed_edac.c                    | 421 ++++++++++++++++++
 6 files changed, 468 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 create mode 100644 drivers/edac/aspeed_edac.c

-- 
2.19.1

