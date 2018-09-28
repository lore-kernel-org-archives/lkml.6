Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A8DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C28206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C28206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeI2EVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:21:01 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:34556 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbeI2EVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:21:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 26339180A812F;
        Fri, 28 Sep 2018 21:55:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toys03_686375b16ac0b
X-Filterd-Recvd-Size: 1871
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:55:17 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'MAX20751 HARDWARE MONITOR DRIVER'
Date:   Fri, 28 Sep 2018 14:55:15 -0700
Message-Id: <20180928215516.30001-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	8835	MAX20751 HARDWARE MONITOR DRIVER
	8836	M:	Guenter Roeck <linux@roeck-us.net>
	8837	L:	linux-hwmon@vger.kernel.org
	8838	S:	Maintained
	8839	F:	Documentation/hwmon/max20751
-->	8840	F:	drivers/hwmon/max20751.c

Commit that introduced this:

commit 1f61cab8a729e00af77b51b44c3a8dc8ef3b3eb9
 Author: Guenter Roeck <linux@roeck-us.net>
 Date:   Mon Jun 8 11:15:23 2015 -0700
 
     hwmon: (pmbus) Add support for MAX20751
     
     MAX20751 is a multiphase power controller with internal buck converter.
     It uses VR12.0 to report the output voltage. This requires an explicit
     driver, since the VR version can not be auto-detected.
     
     The chip supports a manufacturer specific command to fine-tune the output
     voltage.  This command is not currently supported.
     
     Signed-off-by: Guenter Roeck <linux@roeck-us.net>
 
  Documentation/hwmon/max20751   | 77 ++++++++++++++++++++++++++++++++++++++++++
  MAINTAINERS                    |  7 ++++
  drivers/hwmon/pmbus/Kconfig    | 10 ++++++
  drivers/hwmon/pmbus/Makefile   |  1 +
  drivers/hwmon/pmbus/max20751.c | 64 +++++++++++++++++++++++++++++++++++
  5 files changed, 159 insertions(+)

No commit with drivers/hwmon/max20751.c found

