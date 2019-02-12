Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527F9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D6121855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBLBdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:33:04 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:39282 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfBLBdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:33:04 -0500
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id tMoeg0a38nBo4tMofgxu8g; Mon, 11 Feb 2019 18:24:56 -0700
X-Authority-Analysis: v=2.3 cv=J8fUEzvS c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=CFTnQlWoA9kA:10 a=Q-fNiiVtAAAA:8 a=RjZbBj-ZYXHDtvs8VwUA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id A62BA300BE54A6; Mon, 11 Feb 2019 17:24:52 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Some minor updates and fixes for the BRCMSTB DPFE driver
Date:   Mon, 11 Feb 2019 17:24:40 -0800
Message-Id: <20190212012443.21819-1-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJoLHwhuWBIRn6zYfhhO6B1Cb6r84+/IcQgdlCTJ3gJBXlxtz0E2mvP0wTwFrnIyIo7bsREvdclm+SP/XYwGgAQxHae9w+2up4UJmo8nKnvvt7yfiNXG
 XgMsEfRm7NSfcXhMZSHe9/O7Al8JolCyHsBa+CNqOOVksV7Gnu0gRuFahpAK3S88KZ5GI8y6aKWqFj3CS8TpsvWvDNqyYasXZXeW8wakI2xzon95BGwoh9Ae
 h1dpTfJOzmdmwo2lR9+scm/xgO+KA8aFwWlS5oYqUDXF8uR/GGGbuL3gBfgWa6Cg7QMEGGS+DgrgrsPsAaq/PTsit15OllUG05uslNdYnrnjfFU9O540bUJt
 OlWA88myzXQaHGmnj7dIlVcEPE4qbgOcYvP5WHUrLotxPY1JP326VkMoROVu7TF3bOfarAtit/SZWyE68TxhUnvbZ0Lsxg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

This series contains three unrelated improvements or fixes for the
BRCMSTB DPFE driver:

* use msleep() over udelay() to be more scheduler friendly
* optimize generic_show()
* work around a firmware issue by reading byte 3 instead of byte 0

Markus Mayer (3):
  soc: brcmstb: dpfe: use msleep() over udelay()
  soc: brcmstb: dpfe: optimize generic_show()
  soc: brcmstb: dpfe: use byte 3 of registers MR4-MR8

 drivers/memory/brcmstb_dpfe.c | 46 ++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 20 deletions(-)

-- 
2.17.1

