Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBD8C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3D42073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3D42073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeI2EQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:16:43 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:53813 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725266AbeI2EQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:16:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1E9A8837F242;
        Fri, 28 Sep 2018 21:51:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: queen00_430ce4b1c9559
X-Filterd-Recvd-Size: 3278
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:51:00 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: Bad MAINTAINERS pattern in section 'ARM/ACTIONS SEMI ARCHITECTURE'
Date:   Fri, 28 Sep 2018 14:50:59 -0700
Message-Id: <20180928215059.28636-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	1185	ARM/ACTIONS SEMI ARCHITECTURE
	1186	M:	Andreas Färber <afaerber@suse.de>
	1187	R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
	1188	L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
	1189	S:	Maintained
	1190	N:	owl
	1191	F:	arch/arm/mach-actions/
	1192	F:	arch/arm/boot/dts/owl-*
	1193	F:	arch/arm64/boot/dts/actions/
	1194	F:	drivers/clk/actions/
	1195	F:	drivers/clocksource/owl-*
	1196	F:	drivers/pinctrl/actions/*
	1197	F:	drivers/soc/actions/
	1198	F:	include/dt-bindings/power/owl-*
	1199	F:	include/linux/soc/actions/
	1200	F:	Documentation/devicetree/bindings/arm/actions.txt
-->	1201	F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
	1202	F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
	1203	F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
	1204	F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt

Commit that introduced this:

commit 81aa283c692401ce82795fb0da68ead413055360
 Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 Date:   Thu May 31 15:17:34 2018 +0530
 
     MAINTAINERS: Add Actions Semi S900 clk entries
     
     Add S900 clk entries under ARCH_ACTIONS.
     
     Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
     Acked-by: Stephen Boyd <sboyd@kernel.org>
     Signed-off-by: Andreas Färber <afaerber@suse.de>
 
  MAINTAINERS | 2 ++
  1 file changed, 2 insertions(+)

Last commit with Documentation/devicetree/bindings/clock/actions,s900-cmu.txt

commit d0e45d686a3ef18a20d4eac6675b76d3656c4727
Author: Saravanan Sekar <sravanhome@gmail.com>
Date:   Thu Jul 19 11:06:46 2018 +0200

    dt-bindings: clock: Add S700 support for Actions Semi Soc's
    
    Add clock bindings constants for action S700
    Maintain common clock dt-bindings for Actions Semi SoC's
    S700 and S900.
    
    Signed-off-by: Parthiban Nallathambi <pn@denx.de>
    Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Stephen Boyd <sboyd@kernel.org>

 .../{actions,s900-cmu.txt => actions,owl-cmu.txt}  |  20 ++--
 include/dt-bindings/clock/actions,s700-cmu.h       | 118 +++++++++++++++++++++
 2 files changed, 129 insertions(+), 9 deletions(-)
