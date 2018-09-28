Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D618C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12A6206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12A6206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeI2E37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:29:59 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:56729 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbeI2E37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:29:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 686BA18028980;
        Fri, 28 Sep 2018 22:04:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: team23_24c38eebfac5f
X-Filterd-Recvd-Size: 2495
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:04:12 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Bad MAINTAINERS pattern in section 'SOFTWARE DELEGATED EXCEPTION INTERFACE (SDEI)'
Date:   Fri, 28 Sep 2018 15:04:11 -0700
Message-Id: <20180928220411.31488-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	13609	SOFTWARE DELEGATED EXCEPTION INTERFACE (SDEI)
	13610	M:	James Morse <james.morse@arm.com>
	13611	L:	linux-arm-kernel@lists.infradead.org
	13612	S:	Maintained
	13613	F:	Documentation/devicetree/bindings/arm/firmware/sdei.txt
	13614	F:	drivers/firmware/arm_sdei.c
	13615	F:	include/linux/sdei.h
-->	13616	F:	include/uapi/linux/sdei.h

Commit that introduced this:

commit ad6eb31ef90355993eb55ff77e0e855ae7d91e4c
 Author: James Morse <james.morse@arm.com>
 Date:   Mon Jan 8 15:38:09 2018 +0000
 
     firmware: arm_sdei: Add driver for Software Delegated Exceptions
     
     The Software Delegated Exception Interface (SDEI) is an ARM standard
     for registering callbacks from the platform firmware into the OS.
     This is typically used to implement firmware notifications (such as
     firmware-first RAS) or promote an IRQ that has been promoted to a
     firmware-assisted NMI.
     
     Add the code for detecting the SDEI version and the framework for
     registering and unregistering events. Subsequent patches will add the
     arch-specific backend code and the necessary power management hooks.
     
     Only shared events are supported, power management, private events and
     discovery for ACPI systems will be added by later patches.
     
     Signed-off-by: James Morse <james.morse@arm.com>
     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
 
  MAINTAINERS                   |   9 +
  arch/arm64/include/asm/sdei.h |   8 +
  drivers/firmware/Kconfig      |   8 +
  drivers/firmware/Makefile     |   1 +
  drivers/firmware/arm_sdei.c   | 619 ++++++++++++++++++++++++++++++++++++++++++
  include/linux/arm_sdei.h      |  79 ++++++
  include/uapi/linux/arm_sdei.h |  73 +++++
  7 files changed, 797 insertions(+)

No commit with include/uapi/linux/sdei.h found

