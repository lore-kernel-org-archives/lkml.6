Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D6EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF1520896
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF1520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeHUPsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:48:23 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:31289 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbeHUPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:48:23 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 68/5B-19240-7650C7B5; Tue, 21 Aug 2018 12:28:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleJIrShJLcpLzFFi42KJ27nUWDedtSb
  a4Eudxfwj51gtmhevZ7N4c3w6k0XX6p0sFteO9TJZXN41h81i0bJWZosnC88wWSy9fpHJonXv
  EXYHLo8189Ywemxa1cnmMe9koMf+uWvYPTa+28Hk8X7fVTaPnd8b2D0+b5IL4IhizcxLyq9IY
  M1oWTeRteADW8W1zbeYGxj3snYxcnEICaxnlGjbMo2ti5ETyKmQ2DX7DSOIzSvgJrHg5kdmEJ
  tNwEJi8okHYDUsAqoS91p7WEBsYQEPidcvd7OBDBIRmMQkcePeU1aQBLNAA6PE0h1uEIMEJU7
  OfMICEZeQOPjiBTPEMgOJ0wsaweISAvYS099fBYpzANn6Eo3HYiHChhLfZ32DKjGXOLLtPtsE
  Rv5ZSKbOQjJ1ASPTKkbzpKLM9IyS3MTMHF1DAwNdQ0MjXUNLI10TI73EKt1EvdRS3fLU4hJdQ
  73E8mK94src5JwUvbzUkk2MwDhhAIIdjFsvJB9ilORgUhLlPZdWHS3El5SfUpmRWJwRX1Sak1
  p8iFGGg0NJglecpSZaSLAoNT21Ii0zBxixMGkJDh4lEd5kZqA0b3FBYm5xZjpE6hSjMcef91M
  nMXPs6542iVmIJS8/L1VKHGKSAEhpRmke3CBYIrnEKCslzMsIdJoQT0FqUW5mCar8K0ZxDkYl
  YV5pkCk8mXklcPteAZ3CBHQKO1slyCkliQgpqQZGJZtnl/fkME1Kv//tk+1ip1hbxb9Tp8yxf
  LDwtKpmmur3pkuda53Pfes/vmiVrfcBxy35Kd4FPAznL0h9Wsl053xNUoy5nr1HTvDUJtnUvO
  fdd6fqMDEoJ8s2H7x7wetWmuJJObtT3+MEl6eJZVktXGNyOOq23p8cL7fJLGqzAneWdD2dsy9
  XiaU4I9FQi7moOBEAstZB3B8DAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-24.tower-268.messagelabs.com!1534854502!5799296!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12385 invoked from network); 21 Aug 2018 12:28:22 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-24.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 21 Aug 2018 12:28:22 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Tue, 21 Aug 2018 13:28:20 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 387833FAEE; Tue, 21 Aug 2018 13:28:20 +0100 (BST)
Message-ID: <cover.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 21 Aug 2018 13:28:20 +0100
Subject: [PATCH 0/3] dt-bindings: connector: Add USB-PD PPS APDO support
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 21/08/2018 10:54:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds DT bindings support for PPS APDOs, and updates the FUSB302
to use the generic connector bindings allowing for PPS support in this Type-C
port controller. Existing FUSB302 device specific bindings still work, but
are now deprecated in favour of the generic connector approach.

Adam Thomson (3):
  dt-bindings: connector: Add support for USB-PD PPS APDOs to bindings
  dt-bindings: usb: fusb302: Use usb-connector bindings for
    configuration
  usb: typec: fusb302: Populate tcpc fwnode for TCPM property handling

 .../bindings/connector/usb-connector.txt           |  8 +++---
 .../devicetree/bindings/usb/fcs,fusb302.txt        | 32 +++++++++++++++++-----
 drivers/usb/typec/fusb302/fusb302.c                |  3 ++
 include/dt-bindings/usb/pd.h                       | 26 ++++++++++++++++++
 4 files changed, 58 insertions(+), 11 deletions(-)

-- 
1.9.1

