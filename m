Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C479C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA9C20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA9C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeKHP5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:57:30 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:59070 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbeKHP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:57:30 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 02/28-08707-666D3EB5; Thu, 08 Nov 2018 06:23:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRWlGSWpSXmKPExsUS3ulwWDf12uN
  og0UbrC3mHznHanF40QtGi5ufvrFaXN41h81i6fWLTBate4+wO7B5rJm3htFj56y77B6bVnWy
  eXzeJBfAEsWamZeUX5HAmvHv3TnGgnccFRunpjYwHmPrYuTiEBJYwyixaGkfexcjJ5BTITFty
  UNmEJtXwFTiR/MjVhCbTUBH4tHM9UwgNouAisTPv/fBaoQFHCT2nXwIViMiECTx+NFZFpChzA
  K7GSU+XDgANUhQ4uTMJywgNrOAhMTBFy+YIZZpSZxbs4oRxJYQsJeY/v4qM4StL/Hy60YmCNt
  Q4vusbywQtrnEwjfNbBC2tcT1D7PYJjAKzEKyYhaSFQsYmVYxWiYVZaZnlOQmZuboGhoY6Boa
  Gusa6xqZWOolVukm6qWW6ian5pUUJQJl9RLLi/WKK3OTc1L08lJLNjECwz6lkPnnDsbH7emHG
  CU5mJREefNmP44W4kvKT6nMSCzOiC8qzUktPsQow8GhJMErexUoJ1iUmp5akZaZA4xAmLQEB4
  +SCK8ySJq3uCAxtzgzHSJ1ilFRSpzXDyQhAJLIKM2Da4NF/SVGWSlhXkYGBgYhnoLUotzMElT
  5V4ziHIxKwry6IFN4MvNK4Ka/AlrMBLT4nuwDkMUliQgpqQbGlT/2mM+dLa5ncErslI3CF5/D
  d+59uq0aw7SVsTBs+6/09vBX36faCwpzviqfMH1Xj/+CmTavnc5dn3C14kXpy/R9anW3K+68V
  W69F776N3PbORGdWFO/vPwNdzofx55M4eO/IiO5yZIjWTE3aZ7w+c5FWpNmtyvGhC3f9kAtgO
  Hwn9rUmuyZSizFGYmGWsxFxYkAA1YIC/UCAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-11.tower-223.messagelabs.com!1541658213!1038966!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12073 invoked from network); 8 Nov 2018 06:23:33 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-11.tower-223.messagelabs.com with AES128-SHA256 encrypted SMTP; 8 Nov 2018 06:23:33 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 8 Nov 2018 07:23:33 +0100
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 4E5ED5F7FB; Thu,  8 Nov 2018 15:23:31 +0900 (KST)
Message-ID: <cover.1541656450.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 8 Nov 2018 14:54:10 +0900
Subject: [RESEND PATCH V7 0/3]  da7280: haptic driver submission
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
X-KSE-Antivirus-Info: Clean, bases: 08.11.2018 03:21:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Dialog DA7280 Haptic driver IC.

In this patch set the following is provided:

[PATCH V7 1/3] MAINTAINERS file update for DA7280
[PATCH V7 2/3] DA7280 DT Binding
[PATCH V7 3/3] DA7280 Driver

This patch applies against linux-next and v4.19-rc6

Thank you,
Roy Im, Dialog Semiconductor Ltd.

Roy Im (3):
  MAINTAINERS: da7280 updates to the Dialog Semiconductor search terms
  dt-bindings: input: Add document bindings for DA7280
  Input: new da7280 haptic driver

 .../devicetree/bindings/input/dlg,da7280.txt       |  105 ++
 MAINTAINERS                                        |    2 +
 drivers/input/misc/Kconfig                         |   13 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/da7280.c                        | 1409 ++++++++++++++++++++
 drivers/input/misc/da7280.h                        |  412 ++++++
 6 files changed, 1942 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
 create mode 100644 drivers/input/misc/da7280.c
 create mode 100644 drivers/input/misc/da7280.h

-- 
end-of-patch for RESEND PATCH V7

