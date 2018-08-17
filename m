Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7185BC04AB9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36136208DE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36136208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeHQEvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:51:13 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:32862 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbeHQEvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:51:12 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id EB/23-09760-AB9267B5; Fri, 17 Aug 2018 01:49:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRWlGSWpSXmKPExsUS3ulwWHeXZlm
  0waHnUhbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzTizqoupYCpnRePxyUwNjC/Yuhi5OIQE1jJKPH4+m6WLkQPIqZD48
  imni5GTg1fAVOJmz3tWEJtNQEfi0cz1TCA2i4CqRHv/VjYQW1jAUmLh369gtohAkMTjR2dZQG
  YyC+xmlPhw4QAzxCBBiZMzn7CA2MwCEhIHX7wAiwsJaEmcW7OKEcSWELCXmP7+KjOErS/x8ut
  GJgjbUOL7rG9gt0kImEvsX5UCEbaWuP5hFtsERoFZSDbMQrJhASPTKkbLpKLM9IyS3MTMHF1D
  AwNdQ0NjXVNdIxMjvcQq3SS91FLd5NS8kqJEoKxeYnmxXnFlbnJOil5easkmRmDQMwDBDsalf
  1IOMUpyMCmJ8rL/Lo0W4kvKT6nMSCzOiC8qzUktPsQow8GhJMHrqFEWLSRYlJqeWpGWmQOMP5
  i0BAePkghvCEiat7ggMbc4Mx0idYpRl+PP+6mTmIVY8vLzUqXEed1BigRAijJK8+BGwFLBJUZ
  ZKWFeRqCjhHgKUotyM0tQ5V8xinMwKgnzRoBM4cnMK4Hb9AroCCagI6YJlIIcUZKIkJJqYJSy
  YvRqT99TEOXrvD5ZT+ieuvqVGyuYBINf3lYzfDHtXuv65VINmuV1gocPXSveZy30gHty0uvE6
  o3+fm8rWt6G88Zuzu6eZHFesO974E7b68LB+l77JAou8l9g9n9V7J8cezdi36Q87pSMLdLNpw
  K2eE24ndUS3Gdmzm50ScNbeoqAe98eJZbijERDLeai4kQAAEyGkgADAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-3.tower-246.messagelabs.com!1534470584!4140884!3
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6475 invoked from network); 17 Aug 2018 01:49:46 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-3.tower-246.messagelabs.com with AES128-SHA encrypted SMTP; 17 Aug 2018 01:49:46 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Fri, 17 Aug 2018 03:49:43 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 E749C5F7F9; Fri, 17 Aug 2018 10:49:42 +0900 (KST)
Message-ID: <cover.1534468025.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Fri, 17 Aug 2018 10:07:05 +0900
Subject: [PATCH V2 0/3]  da7280: haptic driver submission
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
X-KSE-Antivirus-Info: Clean, bases: 16.08.2018 21:39:00
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
  Documentation: devicetree: input: new binding for da7280
  Input: new da7280 haptic driver

 .../devicetree/bindings/input/dlg,da7280.txt       |   91 ++
 MAINTAINERS                                        |    2 +
 drivers/input/misc/Kconfig                         |   12 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/da7280.c                        | 1451 ++++++++++++++++++++
 drivers/input/misc/da7280.h                        |  412 ++++++
 6 files changed, 1969 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
 create mode 100644 drivers/input/misc/da7280.c
 create mode 100644 drivers/input/misc/da7280.h

-- 
end-of-patch for PATCH V2

