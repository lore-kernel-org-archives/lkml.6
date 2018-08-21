Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD73C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F217620851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F217620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbeHWMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:43:59 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:8791 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730157AbeHWMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:43:55 -0400
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id E7/B0-19263-91B7E7B5; Thu, 23 Aug 2018 09:15:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRWlGSWpSXmKPExsUS3ulwWFeyui7
  a4PVaRYv5R86xWhxe9ILR4uanb6wWl3fNYbNYev0ik0Xr3iPsDmwea+atYfTYOesuu8emVZ1s
  Hp83yQWwRLFm5iXlVySwZqz5dISpYCJnxaq13awNjE/Zuhi5OIQE1jJKrHm5g7WLkRPIqZD4d
  WsGcxcjBwevgKnE9ANcIGE2AR2JRzPXM4HYLAKqEjf/HGUDsYUFLCU23/kOZosIBEk8fnSWBW
  Qms8BuRokPFw4wgyR4BQQlTs58wgJiMwtISBx88YIZYpeWxLk1qxhBbAkBe4np768yQ9j6Ei+
  /bmSCsA0lvs/6xgJhm0v0Ht/EBmFbS1z/MIttAqPALCQrZiFZsYCRaRWjeVJRZnpGSW5iZo6u
  oYGBrqGhka6hpYmumbleYpVuol5qqW55anGJrqFeYnmxXnFlbnJOil5easkmRmDIMwDBDsZj3
  5IPMUpyMCmJ8n72r40W4kvKT6nMSCzOiC8qzUktPsQow8GhJMHrU1UXLSRYlJqeWpGWmQOMPp
  i0BAePkgjvw0qgNG9xQWJucWY6ROoUoy7Hn/dTJzELseTl56VKifNagcwQACnKKM2DGwFLBJc
  YZaWEeRmBjhLiKUgtys0sQZV/xSjOwagkzBsFMoUnM68EbtMroCOYgI5gZa4FOaIkESEl1cBY
  uKbbMX1fWecLhaUHOw8JSQg9vlYsvHXxW0HJCqGiRxVsFzL1GKvXfb3T4HZyw/ySn1XSAjavZ
  E9tTkksnX8hSk7KMa2L4yuf3xWZVVu+eIu//peueGHJ3WOT/uyo/SHC3n9e/N2sGu/5CpFLum
  rXSqVN6Vqnt+vaK5+ypY1dksFRcdKMPLOUWIozEg21mIuKEwGaEhFw/wIAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-17.tower-262.messagelabs.com!1535015705!5782324!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7618 invoked from network); 23 Aug 2018 09:15:05 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-17.tower-262.messagelabs.com with AES128-SHA encrypted SMTP; 23 Aug 2018 09:15:05 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 23 Aug 2018 11:15:04 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 E931D5F7F9; Thu, 23 Aug 2018 18:15:02 +0900 (KST)
Message-ID: <cover.1534830272.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 21 Aug 2018 14:44:32 +0900
Subject: [PATCH V4 0/3]  da7280: haptic driver submission
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>,
        <devicetree@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: NB-EX-CASHUB01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23.08.2018 07:55:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Im <roy.im.opensource@diasemi.com>

This patch adds support for the Dialog DA7280 Haptic driver IC.

In this patch set the following is provided:

[PATCH V2 1/3] MAINTAINERS file update for DA7280
[PATCH V2 2/3] DA7280 DT Binding
[PATCH V2 3/3] DA7280 Driver

This patch applies against linux-next and v4.18

Thank you,
Roy Im, Dialog Semiconductor Ltd.

Roy Im (3):
  MAINTAINERS: da7280 updates to the Dialog Semiconductor search terms
  dt-bindings: input: Add document bindings for DA7280
  Input: new da7280 haptic driver

 .../devicetree/bindings/input/dlg,da7280.txt       |  101 ++
 MAINTAINERS                                        |    2 +
 drivers/input/misc/Kconfig                         |   12 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/da7280.c                        | 1438 ++++++++++++++++++++
 drivers/input/misc/da7280.h                        |  412 ++++++
 6 files changed, 1966 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
 create mode 100644 drivers/input/misc/da7280.c
 create mode 100644 drivers/input/misc/da7280.h

-- 
end-of-patch for PATCH V4

