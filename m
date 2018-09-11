Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D43C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30FE20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30FE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIKRno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:43:44 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:26303 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727063AbeIKRno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:43:44 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 38/40-31069-0B8B79B5; Tue, 11 Sep 2018 12:44:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRWlGSWpSXmKPExsUS3ulwWHf9jun
  RBjvemVnMP3KO1eLwoheMFjc/fWO1uLxrDpvF0usXmSxa9x5hd2DzWDNvDaPHzll32T02repk
  8/i8SS6AJYo1My8pvyKBNWPGgwcsBc85Kk4vfcDYwHiArYuRi0NIYC2jxNWV89m7GDmBnAqJx
  7NOsoLYvAKmElveHmUCsdkEdCQezVwPZrMIqErsuvIKrEZYwFKibeYGZhBbRCBI4vGjsywgQ5
  kFdjNKfLhwgBlikKDEyZlPWEBsZgEJiYMvXjBDLNOSOLdmFSOILSFgLzH9/VVmCFtf4uXXjUw
  QtqHE91nfWCBsc4mtt1ezQdjWEtc/zGKbwCgwC8mKWUhWLGBkWsVokVSUmZ5RkpuYmaNraGCg
  a2hopGtoaaxraGail1ilm6iXWqpbnlpcomuol1herFdcmZuck6KXl1qyiREY9ikFB5fsYHy0P
  P0QoyQHk5Io7+bc6dFCfEn5KZUZicUZ8UWlOanFhxhlODiUJHgDtwPlBItS01Mr0jJzgBEIk5
  bg4FES4RUBRqEQb3FBYm5xZjpE6hSjLsef91MnMQux5OXnpUqJ85aDzBAAKcoozYMbAUsGlxh
  lpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ8y4DmcKTmVcCt+kV0BFMQEesOz8F5IiSRISUVAPj
  tOgLes4TGw5+3Rr+paqxNUBs8WquNf8n1X1buMx6/v36hIiMipPtNy4ya3/X/5bPtDz916lmn
  SdipuvmS/0JPOr+jsue373j0pt0nukXm6IiDwdrC275bfF2ttXTOeW3du7RntSq8eZTSPAnqb
  7IHdnc9x5+Z2DqYfMP3Hv6leZX50NXwrcvUGIpzkg01GIuKk4EAOSZz1gBAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-3.tower-268.messagelabs.com!1536669871!7001141!3
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5105 invoked from network); 11 Sep 2018 12:44:31 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-3.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 11 Sep 2018 12:44:31 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Tue, 11 Sep 2018 14:44:31 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 2DA825F7FB; Tue, 11 Sep 2018 21:44:29 +0900 (KST)
Message-ID: <cover.1536668286.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 11 Sep 2018 21:18:06 +0900
Subject: [PATCH V6 0/3]  da7280: haptic driver submission
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
X-KSE-Antivirus-Info: Clean, bases: 11.09.2018 11:03:00
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
end-of-patch for PATCH V6

