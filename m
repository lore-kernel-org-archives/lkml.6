Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28462C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E772087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E772087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeIJRNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:13:14 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.5]:35706 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728087AbeIJRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:13:14 -0400
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-central-1.aws.symcld.net id BC/09-24284-A41669B5; Mon, 10 Sep 2018 12:19:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRWlGSWpSXmKPExsUSt3Opsa5X4rR
  og3UzdSzmHznHatG8eD2bxZvj05ksulbvZLG4dqyXyeLyrjlsFouWtTJbPFl4hsli6fWLTBat
  e4+wO3B5rJm3htFj06pONo95JwM99s9dw+6x8d0OJo/3+66yeez83sDu8XmTXABHFGtmXlJ+R
  QJrxuVnO5kL7rNX7PzynqmBcQZbFyMXh5DAekaJ3ldzGbsYOYGcCol7Z06C2bwCbhLHlj1gB7
  HZBCwkJp94wAZiswioSuzf94ipi5GDQ1hAU+LBRGGQOSICk5gkbtx7ygpSwyzQwCixdIcbxBx
  BiZMzn7BAxCUkDr54wQyxy0Di9IJGsLiEgL3E9PdXmUFmSgjoSzQei4UIG0p8n/UNqsRcYubq
  eSwTGPlnIZk6C8nUBYxMqxgtk4oy0zNKchMzc3QNDQx0DQ2NdY10jYwM9RKrdBP1Ukt1k1PzS
  ooSgbJ6ieXFesWVuck5KXp5qSWbGIGxklLIdHcH44eF6YcYJTmYlER5JRSnRQvxJeWnVGYkFm
  fEF5XmpBYfYpTh4FCS4F2bAJQTLEpNT61Iy8wBRi1MWoKDR0mEdyVImre4IDG3ODMdInWK0ZK
  jZfLkScwcf95PBZL7uqdNYhZiycvPS5US570L0iAA0pBRmgc3DpZYLjHKSgnzMjIwMAjxFKQW
  5WaWoMq/YhTnYFQS5v0TDzSFJzOvBG7rK6CDmIAOWnd+CshBJYkIKakGxv3nBMpSmVnMPk2Zo
  LBS96aEQ2i7LsvOqdOvecftupHfbP3x9qkCfa8jJ7d1PAq3bliyWE20X+PirW2NittqWP9vE3
  n/9MuZGztehrpfjl9k9KNK/aH5yy1ZEz8Vnfdvy3+X8GXB2ZhP9z/vtCmf/M9s55zvlT/SfAR
  iYljK3zLrXLrFnG4ut0CJpTgj0VCLuag4EQDNKGZWJwMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-32.tower-223.messagelabs.com!1536581962!4409455!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15039 invoked from network); 10 Sep 2018 12:19:22 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-32.tower-223.messagelabs.com with AES128-SHA encrypted SMTP; 10 Sep 2018 12:19:22 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 10 Sep 2018 13:19:22 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 17D293FA99; Mon, 10 Sep 2018 13:19:22 +0100 (BST)
Message-ID: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 10 Sep 2018 13:19:22 +0100
Subject: [PATCH 0/3] *** SUBJECT HERE ***
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

