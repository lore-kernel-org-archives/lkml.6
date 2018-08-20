Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BDBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D37F21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D37F21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeHTJWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:22:09 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:22457 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbeHTJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:22:08 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 95/46-10350-3BA5A7B5; Mon, 20 Aug 2018 06:07:47 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRWlGSWpSXmKPExsUS3ulwWHdzVFW
  0wZNl+hbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzdi18ypLwUTOinVzpRoYn7B1MXJxCAmsZZSY8f8vcxcjB5BTIfGtW
  beLkZODV8BUYubsk0wgNpuAjsSjmevBbBYBVYlpP/6zgNjCApYSC5o3gsVFBIIkHj86ywIyk1
  lgN6PEhwsHmCEGCUqcnPkErIFZQELi4IsXYHEhAS2Jc2tWMYLYEgL2EtPfX2WGsPUlXn6FGCo
  hYCjxfdY3FgjbXGLKtI3sELa1xPUPs9gmMArMQrJiFpIVCxiZVjFaJBVlpmeU5CZm5ugaGhjo
  Ghoa6RpaGusaGRrqJVbpJuqlluqWpxaX6AK55cV6xZW5yTkpenmpJZsYgSHPAAQ7GJdfSD7EK
  MnBpCTKq21aFS3El5SfUpmRWJwRX1Sak1p8iFGGg0NJgrckEignWJSanlqRlpkDjD6YtAQHj5
  II736QNG9xQWJucWY6ROoUoy7Hn/dTJzELseTl56VKifOuAykSACnKKM2DGwFLBJcYZaWEeRm
  BjhLiKUgtys0sQZV/xSjOwagkzHsEZApPZl4J3KZXQEcwAR3BzlYJckRJIkIKmA5CufdHvJsz
  xTLl4yy+OteXYQyLU1Lndf/OeJDy2NrjeXz3892nr0mq86f9/nnfYbmGqFy6zPmKrmDetp4vX
  E+dP3/77ajJlJZ59nH+bsFpZ3KD1r8+tcNV+l/vtVzGp98aDvvLx7W/PrrPtqU59MXMyqVHz2
  Vs8G//flXFqu3E68sN+WrdLJFKLMUZiYZazEXFiQAbjeeD/wIAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-10.tower-268.messagelabs.com!1534745267!5703828!2
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10502 invoked from network); 20 Aug 2018 06:07:47 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-10.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 20 Aug 2018 06:07:47 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 20 Aug 2018 08:07:46 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 1B6A35F7F9; Mon, 20 Aug 2018 15:07:45 +0900 (KST)
Message-ID: <cover.1534743380.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Mon, 20 Aug 2018 14:36:20 +0900
Subject: [PATCH V3 0/3]  da7280: haptic driver submission
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
X-KSE-Antivirus-Info: Clean, bases: 20.08.2018 03:16:00
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
end-of-patch for PATCH V3

