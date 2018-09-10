Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1495C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6085620866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6085620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeIJRSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:18:18 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:12765 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727727AbeIJRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:18:18 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 7B/F0-28243-A72669B5; Mon, 10 Sep 2018 12:24:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleJIrShJLcpLzFFi42KJ27nUWLcyaVq
  0QctUc4v5R86xWjQvXs9m8eb4dCaLrtU7WSyuHetlsri8aw6bxaJlrcwWTxaeYbJYev0ik0Xr
  3iPsDlwea+atYfTYtKqTzWPeyUCP/XPXsHtsfLeDyeP9vqtsHju/N7B7fN4kF8ARxZqZl5Rfk
  cCacfnZTuaC++wVO7+8Z2pgnMHWxcjFISSwnlFi9bNW1i5GDiCnQmLLMoEuRk4OXgE3iWPLHr
  CD2GwCFhKTTzxgA7FZBFQlzmx8ywRiCwt4S1w4fpkRZI6IwCQmiRv3nrKCJJgFGhgllu5wgxg
  kKHFy5hMWiLiExMEXL5hBbCEBA4nTCxrB4hIC9hLT319lBrlBQkBfovFYLETYUOL7rG9QJeYS
  M1fPY5nAyD8LydRZSKYuYGRaxWiRVJSZnlGSm5iZo2toYKBraGika2hprmtkaqiXWKWbpJdaq
  lueWlyiC+SWF+sVV+Ym56To5aWWbGIERkpKwdHfOxgnLEo/xCjJwaQkyiuhOC1aiC8pP6UyI7
  E4I76oNCe1+BCjDAeHkgSvXCJQTrAoNT21Ii0zBxizMGkJDh4lEV4lkDRvcUFibnFmOkTqFKM
  xx5/3Uycxc+zrnjaJWYglLz8vVUqc924CUKkASGlGaR7cIFgqucQoKyXMy8jAwCDEU5BalJtZ
  gir/ilGcg1FJmFcVZCFPZl4J3L5XQKcwAZ2y7vwUkFNKEhFSUg2MVTrxsjYh/7wbpNdNmHHIn
  uHJP+lHl+80H42a7RdnmNSev+6G/dbYvPOuwj7Lz124yKyy9k3dv6l3t7Acb5hbbsHIrK251/
  Ydc/8WzQATp74Zb5Umch9zChGZM1/qlP/OGdZKr+6eKm+RkU7iMWQ+OStN3f16/8TpJxQepXA
  tyak9pXspRipMiaU4I9FQi7moOBEAXbJYwiADAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-12.tower-288.messagelabs.com!1536582265!7720496!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31042 invoked from network); 10 Sep 2018 12:24:25 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-12.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 10 Sep 2018 12:24:25 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 10 Sep 2018 13:24:24 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 051023FA99; Mon, 10 Sep 2018 13:24:25 +0100 (BST)
Message-ID: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 10 Sep 2018 13:24:25 +0100
Subject: [PATCH v2 0/3] dt-bindings: connector: Add USB-PD PPS APDO support
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
X-KSE-Antivirus-Info: Clean, bases: 10/09/2018 11:14:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180910122425.RDEZbsypI3lxdhmkX1UtU7HUKi9qs6wZ4cA_6PXSOOY@z>

This patch set adds DT bindings support for PPS APDOs, and updates the FUSB302
to use the generic connector bindings allowing for PPS support in this Type-C
port controller. Existing FUSB302 device specific bindings still work, but
are now deprecated in favour of the generic connector approach.

Changes in v2:
	- Added Reviewed-by tags to patches
	- Rebase code against latest usb-next branch (v4.19-rc2)

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

