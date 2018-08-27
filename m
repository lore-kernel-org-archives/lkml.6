Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764E7208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764E7208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeH0M3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:29:08 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:4068 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727159AbeH0M3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:29:07 -0400
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id 99/E5-25120-BA9B38B5; Mon, 27 Aug 2018 08:43:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRWlGSWpSXmKPExsUS3ulwWHf1zuZ
  og90rxSzmHznHanF40QtGi5ufvrFaXN41h81i6fWLTBate4+wO7B5rJm3htFj56y77B6bVnWy
  eXzeJBfAEsWamZeUX5HAmrHk1QGmgsccFY8vv2NqYNzD1sXIxSEksJZRYufCL0AOJ5BTIfF+6
  0d2EJtXwFTi7pHFrCA2m4COxKOZ65lAbBYBVYmuiVfA6oUFLCWOdLUygtgiAkESjx+dZQEZyi
  ywm1Hiw4UDzBCDBCVOznzCAmIzC0hIHHzxghlimZbEuTWrwJolBOwlpr+/ygxh60u8/LqRCcI
  2lPg+6xtQLweQbS5x5FMBRNha4vqHWWwTGAVmIdkwC8mGBYxMqxgtkooy0zNKchMzc3QNDQx0
  DQ2NdA0tLXUNzQ31Eqt0k/RSS3XLU4tLdIHc8mK94src5JwUvbzUkk2MwKBnAIIdjCe+JR9il
  ORgUhLlfWTVFC3El5SfUpmRWJwRX1Sak1p8iFGGg0NJgvfajuZoIcGi1PTUirTMHGD8waQlOH
  iURHhdQNK8xQWJucWZ6RCpU4y6HH/eT53ELMSSl5+XKiXOqw2MZiEBkKKM0jy4EbBUcIlRVkq
  YlxHoKCGegtSi3MwSVPlXjOIcjErCvBdAVvFk5pXAbXoFdAQT0BEzXjWAHFGSiJCSamDMnyDl
  IPcviutJ02WH7rfKzrYztJmvvwpf8shtf+KZb+4bGosV46PEZty5IhmzU+Z0MPuuwzMUtVPTt
  q/71vfz+HvPPV/zrawfF8baXv3+s0+Mb31dxpp9j26day9h13cOsmfZbh8Xet/29Kk1U54sX/
  7orgGHstwsy6j098tbf926/cc/Lc9eiaU4I9FQi7moOBEAOB09SAADAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-19.tower-282.messagelabs.com!1535359403!5991626!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28691 invoked from network); 27 Aug 2018 08:43:23 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-19.tower-282.messagelabs.com with AES128-SHA encrypted SMTP; 27 Aug 2018 08:43:23 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 27 Aug 2018 10:43:22 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 1F5E55F7FA; Mon, 27 Aug 2018 17:43:21 +0900 (KST)
Message-ID: <cover.1535358095.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Mon, 27 Aug 2018 17:21:35 +0900
Subject: [PATCH V5 0/3]  da7280: haptic driver submission
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
X-KSE-Antivirus-Info: Clean, bases: 27.08.2018 03:30:00
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

This patch applies against linux-next and v4.18

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
 drivers/input/misc/da7280.c                        | 1438 ++++++++++++++++++++
 drivers/input/misc/da7280.h                        |  412 ++++++
 6 files changed, 1971 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
 create mode 100644 drivers/input/misc/da7280.c
 create mode 100644 drivers/input/misc/da7280.h

-- 
end-of-patch for PATCH V5

