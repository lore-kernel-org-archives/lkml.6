Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB44C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7415220A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7415220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbeHPFv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:51:26 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:8185 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727634AbeHPFvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:51:25 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 9B/11-09223-9C7E47B5; Thu, 16 Aug 2018 02:56:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRWlGSWpSXmKPExsUS3ulwWPfk85J
  og/1nJS3mHznHanF40QtGi5ufvrFaXN41h81i6fWLTBate4+wO7B5rJm3htFj56y77B6bVnWy
  eXzeJBfAEsWamZeUX5HAmjFn4VvmgqmcFYu+vmVqYHzB1sXIxSEksJZR4sj2bSxdjJxAToXEs
  ZYt7CA2r4CpxIpzP8HibAI6Eo9mrmcCsVkEVCUmr3vJDGILC1hKnFlwjxHEFhEIknj86CwLyF
  Bmgd2MEh8uHGCGGCQocXLmE7BBzAISEgdfvGCGWKYlcW7NKrBmCQF7ienvrzJD2PoSL79uZIK
  wDSW+z/rGAmGbSyy+MwPKtpa4/mEW2wRGgVlIVsxCsmIBI9MqRoukosz0jJLcxMwcXUMDA11D
  QyNdQ0tjXUNjS73EKt1EvdRS3fLU4hJdQ73E8mK94src5JwUvbzUkk2MwLBnAIIdjJe+JR9il
  ORgUhLl1a8ujhbiS8pPqcxILM6ILyrNSS0+xCjDwaEkwXvlWUm0kGBRanpqRVpmDjACYdISHD
  xKIrwZIGne4oLE3OLMdIjUKUZdjj/vp05iFmLJy89LlRLnPQhSJABSlFGaBzcClgwuMcpKCfM
  yAh0lxFOQWpSbWYIq/4pRnINRSZj3GcgUnsy8ErhNr4COYAI6IlmkEOSIkkSElFQD48TME88m
  buWfnMvpxi3P7LDLdUsT7/SrM1Lu8QRbbzZbq9KcsSd+qQb7HeuCah+Hk0IORuFrE3v+nmhsb
  5xbWiqb/eHFwdLru0yXKN1K2Cyil7i3u/vCip8GDJ/X23SEx67j/mM5kfHq/+Yj1g+ko37dtr
  2Tbl6xxX2RzLbDj7M/FTsmmHw7rcRSnJFoqMVcVJwIAI0u1m0BAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-8.tower-268.messagelabs.com!1534388168!5525239!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4206 invoked from network); 16 Aug 2018 02:56:09 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-8.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 16 Aug 2018 02:56:09 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 16 Aug 2018 04:56:08 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 6BC345F7F9; Thu, 16 Aug 2018 11:56:07 +0900 (KST)
Message-ID: <cover.1534384964.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 16 Aug 2018 11:02:44 +0900
Subject: [PATCH V1 0/3]  da7280: haptic driver submission
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
X-KSE-Antivirus-Info: Clean, bases: 16.08.2018 00:48:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Im <roy.im.opensource@diasemi.com>

This patch adds support for the Dialog DA7280 Haptic driver IC.

In this patch set the following is provided:

[PATCH V1 1/3] MAINTAINERS file update for DA7280
[PATCH V1 2/3] DA7280 DT Binding
[PATCH V1 3/3] DA7280 Driver

This patch applies against linux-next and v4.18

Thank you,
Roy Im, Dialog Semiconductor Ltd.

Roy Im (3):
  MAINTAINERS: da7280 updates to the Dialog Semiconductor search terms
  Documentation: devicetree: input: new binding for da7280
  Input: new da7280 haptic driver

 .../devicetree/bindings/input/dlg,da7280.txt       |   91 ++
 MAINTAINERS                                        |    2 +
 drivers/input/misc/Kconfig                         |   12 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/da7280.c                        | 1452 ++++++++++++++++++++
 drivers/input/misc/da7280.h                        |  412 ++++++
 6 files changed, 1970 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
 create mode 100644 drivers/input/misc/da7280.c
 create mode 100644 drivers/input/misc/da7280.h

-- 
end-of-patch for PATCH V1

