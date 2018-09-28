Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FC0C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651DA2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651DA2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeI2Eao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:30:44 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:55021 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726569AbeI2Eao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:30:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 24F64181D337B;
        Fri, 28 Sep 2018 22:04:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: club85_2b326dc16d834
X-Filterd-Recvd-Size: 3863
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:04:56 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>
Subject: Bad MAINTAINERS pattern in section 'Texas Instruments' System Control Interface (TISCI) Protocol Driver'
Date:   Fri, 28 Sep 2018 15:04:55 -0700
Message-Id: <20180928220455.31806-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	14531	Texas Instruments' System Control Interface (TISCI) Protocol Driver
	14532	M:	Nishanth Menon <nm@ti.com>
	14533	M:	Tero Kristo <t-kristo@ti.com>
	14534	M:	Santosh Shilimkar <ssantosh@kernel.org>
	14535	L:	linux-arm-kernel@lists.infradead.org
	14536	S:	Maintained
	14537	F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
	14538	F:	drivers/firmware/ti_sci*
	14539	F:	include/linux/soc/ti/ti_sci_protocol.h
	14540	F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
-->	14541	F:	include/dt-bindings/genpd/k2g.h
	14542	F:	drivers/soc/ti/ti_sci_pm_domains.c
	14543	F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
	14544	F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
	14545	F:	drivers/clk/keystone/sci-clk.c
	14546	F:	drivers/reset/reset-ti-sci.c

Commit that introduced this:

commit 7cc119f29b197f967161ca94c9d5cb5073b4b52b
 Author: Dave Gerlach <d-gerlach@ti.com>
 Date:   Tue Apr 4 08:59:27 2017 -0700
 
     dt-bindings: Add TI SCI PM Domains
     
     Add a generic power domain implementation, TI SCI PM Domains, that
     will hook into the genpd framework and allow the TI SCI protocol to
     control device power states.
     
     Also, provide macros representing each device index as understood
     by TI SCI to be used in the device node power-domain references.
     These are identifiers for the K2G devices managed by the PMMC.
     
     Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
     Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
     Acked-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Nishanth Menon <nm@ti.com>
     Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
     Signed-off-by: Santosh Shilimkar <ssantosh@kernel.org>
 
  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 57 ++++++++++++++
  MAINTAINERS                                        |  2 +
  include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
  3 files changed, 149 insertions(+)

Last commit with include/dt-bindings/genpd/k2g.h

commit d16645054d2f55e4011c9725ddf2dbe6177e942a
Author: Dave Gerlach <d-gerlach@ti.com>
Date:   Fri Jul 21 09:38:36 2017 -0700

    dt-bindings: Drop k2g genpd device ID macros
    
    Commit 7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains") introduced a
    number of K2G_DEV_x macros to represent each device ID available on the
    K2G platform for use by the genpd, clock, and reset drivers. Rather than
    use these macros, which are only used in the device tree for property
    values and not actually used by the drivers, let's just use the device
    ID number directly in the device tree to avoid macro bloat.
    
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
    Signed-off-by: Santosh Shilimkar <ssantosh@kernel.org>

 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  5 +-
 include/dt-bindings/genpd/k2g.h                    | 90 ----------------------
 2 files changed, 3 insertions(+), 92 deletions(-)
