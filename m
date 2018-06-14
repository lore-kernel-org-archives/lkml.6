Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 54CD0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB55B208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB55B208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935926AbeFNKsi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:48:38 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58143 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbeFNKsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:48:36 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id EB87D20006;
        Thu, 14 Jun 2018 10:48:38 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, joro@8bytes.org
Cc:     linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND 0/6] iommu: ipmmu-vmsa: Add more Gen3 SoCs support
Date:   Thu, 14 Jun 2018 12:48:20 +0200
Message-Id: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   this series collects patches sent to mailing lists in late 2017 to add
support for a number of R-Car Gen3 SoCs to the ipmmu-vmsa driver.

Part of the series these patches were part of went in through Alex Williamson
tree and are now included in v4.17.

These patches have not yet been collected, and need to be rebased on v4.17,
and this what this series serves for.

The series:
- Increses the micro-TLB size to 48bits to accomodate newer SoCs
- Adds support for M3-N, M3-W, V3-M and E3 to ipmmu-vmsa driver
- Documents M3-N, V3H and E3 device tree bindings

All patches have been acked/reviewed by, if nothing big happens they should
be ready to be collected.

Thanks
   j

Jacopo Mondi (2):
  dt-bindings: iommu/ipmmu-vmsa: Add R-Car M3-N (R8A77965)
  iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code

Magnus Damm (3):
  iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
  iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
  iommu/ipmmu-vmsa: Document R-Car V3H and E3 IPMMU DT bindings

Simon Horman (1):
  iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  3 ++
 drivers/iommu/ipmmu-vmsa.c                         | 38 ++++++++++++++++++----
 2 files changed, 34 insertions(+), 7 deletions(-)

--
2.7.4

