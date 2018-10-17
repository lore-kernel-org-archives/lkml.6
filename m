Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B802C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FA8214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FA8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJQJa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:30:26 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:9243 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbeJQJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:30:25 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id 9A/79-09191-64296CB5; Wed, 17 Oct 2018 01:37:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRWlGSWpSXmKPExsUS3ulwWNdt0rF
  ogzt3mCzmHznHanF40QtGi5ufvrFaXN41h81i6fWLTBate4+wO7B5rJm3htFj56y77B6bVnWy
  eXzeJBfAEsWamZeUX5HAmvHv3TnGgnccFRunpjYwHmPrYuTiEBJYyyjx98QJli5GDiCnQuL4C
  5suRk4OXgFTidabr5lAbDYBHYlHM9eD2SwCqhJNm04xgtjCAg4S+04+ZAWxRQSCJB4/OssCMp
  NZYDejxIcLB5ghBglKnJz5hAXEZhaQkDj44gVYXEhAS+LcmlVggyQE7CWmv7/KDGHrS7z8upE
  JwjaU+D7rGwuEbS6x6tNpNgjbWuL6h1lsExgFZiFZMQvJigWMTKsYLZKKMtMzSnITM3N0DQ0M
  dA0NjXQNLc10jQzN9BKrdJP0Ukt1y1OLS3QN9RLLi/WKK3OTc1L08lJLNjECQz6l4MiNHYxfl
  qcfYpTkYFIS5a1tOxYtxJeUn1KZkVicEV9UmpNafIhRhoNDSYJ3xkSgnGBRanpqRVpmDjD6YN
  ISHDxKIrwn+oHSvMUFibnFmekQqVOMuhxtT6/PYBZiycvPS5US500DmSEAUpRRmgc3ApYILjH
  KSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5i0HmcKTmVcCt+kV0BFMQEe42x4BOaIkESEl1cBo
  p7xqp6D13A1lk2+59/0IM0q/YTF73oOJrolix+dMNNOt4Vn0smrh/48n/LXuFHIuyVCJ3Dbj1
  HH27Tm76mtXH1+6qWcvh5HUWT4vK05NnguB6Wu4N/qUMMtsW7m2h+tveaHMKqnanXlfTnJMc1
  XUqmte8nXeU7sLsUfXcfU80Vn+UKju/txGJZbijERDLeai4kQAiKmL+P8CAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-20.tower-288.messagelabs.com!1539740229!556224!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17701 invoked from network); 17 Oct 2018 01:37:10 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-20.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 17 Oct 2018 01:37:10 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 17 Oct 2018 03:37:08 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 1964B5F7FD; Wed, 17 Oct 2018 10:37:07 +0900 (KST)
Message-ID: <cover.1539737877.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 17 Oct 2018 09:57:57 +0900
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
X-KSE-Antivirus-Info: Clean, bases: 16.10.2018 22:03:00
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

