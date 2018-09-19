Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A1BECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB7F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB7F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbeISQ4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:56:09 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:10363 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730892AbeISQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:56:08 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 22/C1-18431-E8032AB5; Wed, 19 Sep 2018 11:18:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRWlGSWpSXmKPExsUS3ulwWLfPYFG
  0watlehbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzVjU8ZK14B1Hxc5389kaGI+xdTFycQgJrGWUODGpmamLkRPIqZBYO
  mciC4jNK2Aqsf7mY3YQm01AR+LRzPVgNSwCqhLHGz6B1QgLOEgsOniFGcQWEQiSePzoLAvIUG
  aB3YwSHy4cYIYYJChxcuYTsAZmAQmJgy9eMEMs05I4t2YVI4gtIWAvMf39VWYIW1/i5deNTBC
  2ocT3Wd9YIGxzid3Tj0HVWEtc/zCLbQKjwCwkK2YhWbGAkWkVo0VSUWZ6RkluYmaOrqGBga6h
  oZGuoaWJrpGRqV5ilW6iXmqpbnlqcYmuoV5iebFecWVuck6KXl5qySZGYNinFBx6uIPx3PL0Q
  4ySHExKorxMsxZGC/El5adUZiQWZ8QXleakFh9ilOHgUJLgFdFfFC0kWJSanlqRlpkDjECYtA
  QHj5II72yQNG9xQWJucWY6ROoUoy7Hn/dTJzELseTl56VKifPyghQJgBRllObBjYAlg0uMslL
  CvIwMDAxCPAWpRbmZJajyrxjFORiVhHmTQKbwZOaVwG16BXQEE9ARn5cuADmiJBEhJdXAuJTn
  wdQKyXipc7nJxsVs92yqFJax/dU4nbFK1ORglPfu1x8XvjvFIlXSERGu4TxrVu63Dw2r7uxkt
  m6dPulf2/Os+liJheFlmZsstHwkBMTnmJkwy93s2vQvsT/+lr3F3KQc7c9vTbhVXbbESE74VP
  BNhPMN75pnCcfjGpTe+z91kjZyTTVTYinOSDTUYi4qTgQA5Dqn3gEDAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-19.tower-268.messagelabs.com!1537355918!4205199!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22838 invoked from network); 19 Sep 2018 11:18:38 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-19.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 19 Sep 2018 11:18:38 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 19 Sep 2018 13:18:38 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 9A2695F7F9; Wed, 19 Sep 2018 20:18:36 +0900 (KST)
Message-ID: <cover.1537353304.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 19 Sep 2018 19:35:04 +0900
Subject: [RESEND PATCH V6 0/3]  da7280: haptic driver submission
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
X-KSE-Antivirus-Info: Clean, bases: 19.09.2018 10:15:00
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

This patch applies against linux-next and v4.19-rc3

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
end-of-patch for RESEND PATCH V6

