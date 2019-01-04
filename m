Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78076C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FF921871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfADQA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:00:59 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.5]:47700 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727192AbfADQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:00:58 -0500
Received: from [67.219.246.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-east-1.aws.symcld.net id 68/D9-05658-8338F2C5; Fri, 04 Jan 2019 16:00:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRWlGSWpSXmKPExsXi5LtOQNeiWT/
  GYP9uLovDi14wWnz9dpvd4uanb6wWl3fNYXNg8dg56y67x69ta1g8Pm+SC2COYs3MS8qvSGDN
  ODdnNlvBb9aKn5/2MzUw/mbpYuTiEBJYxShx9sYKRghnC6PE9dkP2bsYOTnYBHQkpuw/zAJii
  wiIS1w7chYszixQKfHs92Y2EFtYwFbi17QZrCA2i4CKxOzXd8HivAJuEktv9oDZEgJyEjfPdT
  JDxAUlTs58wgIxR0Li4IsXYHEhAWWJLSsuMELUK0isPXCeaQIj7ywkLbOQtCxgZFrFaJZUlJm
  eUZKbmJmja2hgoGtoaKQLJC0s9RKrdJP0Sot1UxOLS3QN9RLLi/WKK3OTc1L08lJLNjECgzGl
  gGHvDsZJy9MPMUpyMCmJ8qYx68cI8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuCd2QiUEyxKTU+tS
  MvMAcYFTFqCg0dJhPc2SJq3uCAxtzgzHSJ1itGYY9uZzhnMHG/m/pjBLMSSl5+XKiXOK94EVC
  oAUppRmgc3CBavlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ834HWciTmVcCt+8V0ClMQKe
  YSOiAnFKSiJCSamBcd3Ny01lJm6tekyN+1Lxh+3GN7/i/l/YZNz4rP8svOFfE4HjGwNAry15y
  57MW/xcpDKL5b1tftL5WFwisPXi06b3P1BqJg6v2hOc/Z5h+21VnjcZdftay9Ig71QV9m5c85
  Q4/8CFD/b5AYoRYYIaB85+giyZs3Z/XHfhp3/T2dLmMcvrKwLlKLMUZiYZazEXFiQAWUJPO0g
  IAAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-16.tower-385.messagelabs.com!1546617655!6434161!2
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29104 invoked from network); 4 Jan 2019 16:00:56 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-16.tower-385.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Jan 2019 16:00:56 -0000
Received: from MTK-SMS-XCH01.digi.com (10.10.8.195) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 4 Jan 2019
 10:00:55 -0600
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 MTK-SMS-XCH01.digi.com (10.10.8.195) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 4 Jan 2019 10:00:54 -0600
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <hadess@hadess.net>
CC:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex.gonzalez@digi.com>
Subject: [PATCH] Input: goodix - decouple irq and reset lines
Date:   Fri, 4 Jan 2019 17:00:47 +0100
Message-ID: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation on the Goodix driver requires the two optional GPIOs
(RESET and INT) to be provided.

However, it is possible to designs the RESET line pulled-up and only provide
the INT line. Such designs do not work with the current implementation.

The patch attached allows for designs that only provide the INT line to have
a functional touch on the default I2C address, even though some functionality
like the sleep mode will not be available.

This has been tested on v4.20 with a gt911 based touch panel design that only
provides the INT line.

Alex Gonzalez (1):
  Input: goodix - decouple irq and reset lines

 drivers/input/touchscreen/goodix.c | 59 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

