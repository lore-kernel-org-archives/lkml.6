Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F82AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3DB2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3DB2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeI2E0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:26:42 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:45614 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbeI2E0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:26:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B6EFF1802642F;
        Fri, 28 Sep 2018 22:00:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crow47_850b9933e708
X-Filterd-Recvd-Size: 2026
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:00:57 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>
Subject: Bad MAINTAINERS pattern in section 'MULTIPLEXER SUBSYSTEM'
Date:   Fri, 28 Sep 2018 15:00:55 -0700
Message-Id: <20180928220055.30772-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	9976	MULTIPLEXER SUBSYSTEM
	9977	M:	Peter Rosin <peda@axentia.se>
	9978	S:	Maintained
	9979	F:	Documentation/ABI/testing/sysfs-class-mux*
	9980	F:	Documentation/devicetree/bindings/mux/
-->	9981	F:	include/linux/dt-bindings/mux/
	9982	F:	include/linux/mux/
	9983	F:	drivers/mux/

Commit that introduced this:

commit 256ac0375098e50d59c415fcbb561f2927fa8780
 Author: Peter Rosin <peda@axentia.se>
 Date:   Sun May 14 21:51:05 2017 +0200
 
     dt-bindings: document devicetree bindings for mux-controllers and gpio-mux
     
     Allow specifying that a single multiplexer controller can be used to
     control several parallel multiplexers, thus enabling sharing of the
     multiplexer controller by different consumers.
     
     Add a binding for a first mux controller in the form of a GPIO based mux
     controller.
     
     Acked-by: Jonathan Cameron <jic23@kernel.org>
     Acked-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Peter Rosin <peda@axentia.se>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 
  Documentation/devicetree/bindings/mux/gpio-mux.txt |  69 +++++++++
  .../devicetree/bindings/mux/mux-controller.txt     | 157 +++++++++++++++++++++
  MAINTAINERS                                        |   6 +
  include/dt-bindings/mux/mux.h                      |  16 +++
  4 files changed, 248 insertions(+)

No commit with include/linux/dt-bindings/mux/ found

