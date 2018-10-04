Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46750C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E0E21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E0E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeJDO3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:29:06 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:23245 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727353AbeJDO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:29:05 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 2C/41-09077-623C5BB5; Thu, 04 Oct 2018 07:37:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRWlGSWpSXmKPExsUS3ulwWFft8NZ
  og/5ki/lHzrFaHF70gtHi5qdvrBaXd81hs1h6/SKTReveI+wObB5r5q1h9Ng56y67x6ZVnWwe
  nzfJBbBEsWbmJeVXJLBmXD3ziqXgOUfFqssz2BsYD7B1MXJxCAmsYZR41nuSpYuRE8ipkFj4f
  z57FyMHB6+AqcTRq8IgYTYBHYlHM9czgYRZBFQkvk2SBwkLC1hKXO2/wAZiiwgESTx+dJYFZC
  SzwG5GiQ8XDjCDJHgFBCVOznwCNp5ZQELi4IsXzBCrtCTOrVnFCGJLCNhLTH9/lRnC1pd4+XU
  jE4RtKPF91jcWCNtc4uT7t1C2tcT1D7PYJjAKzEKyYhaSFQsYmVYxWiQVZaZnlOQmZuboGhoY
  6BoaGukaWloAsZleYpVukl5qqW55anGJrqFeYnmxXnFlbnJOil5easkmRmDApxQcO7KD8XRX+
  iFGSQ4mJVHemZO3RgvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4P1+ECgnWJSanlqRlpkDjD2YtA
  QHj5IIrxhImre4IDG3ODMdInWKUZej7en1GcxCLHn5ealS4rz7QIoEQIoySvPgRsDSwCVGWSl
  hXkYGBgYhnoLUotzMElT5V4ziHIxKwrzBIFN4MvNK4Da9AjqCCegI+ZwtIEeUJCKkpBoYa7Ju
  fvm6gOV0hYrxCfnjiududV+UED6eGPqjheVFYEcrp+TJ6sbzHUkfp+TN2jjtTN/DevN46at+R
  ZN+tK0/e5ah2+T83tbDAaH8F0UTrUzjT3CZ20u2xuVL7Q1rmP55f2h4RGLZpA/fuy+KXl27+E
  KhWN96eacK1QUSUxUf8FaVFNat3LtQiaU4I9FQi7moOBEAOFQcO/4CAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-8.tower-288.messagelabs.com!1538638629!227578!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4987 invoked from network); 4 Oct 2018 07:37:09 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-8.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 4 Oct 2018 07:37:09 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 4 Oct 2018 09:37:09 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 0611E5F7FA; Thu,  4 Oct 2018 16:37:08 +0900 (KST)
Message-ID: <cover.1538635541.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 4 Oct 2018 15:45:41 +0900
Subject: [PATCH V7 0/3]  da7280: haptic driver submission
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
X-KSE-Antivirus-Info: Clean, bases: 04.10.2018 05:19:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Dialog DA7280 Haptic driver IC.

In this patch set the following is provided:

[PATCH V2 1/3] MAINTAINERS file update for DA7280
[PATCH V2 2/3] DA7280 DT Binding
[PATCH V2 3/3] DA7280 Driver

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
 drivers/input/misc/da7280.c                        | 1393 ++++++++++++++++++++
 drivers/input/misc/da7280.h                        |  412 ++++++
 6 files changed, 1926 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
 create mode 100644 drivers/input/misc/da7280.c
 create mode 100644 drivers/input/misc/da7280.h

-- 
end-of-patch for PATCH V7

