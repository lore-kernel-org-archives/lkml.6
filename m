Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD628C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3231206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3231206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeI2ESj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:18:39 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:59540 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbeI2ESj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:18:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 23DCA100E86C5;
        Fri, 28 Sep 2018 21:52:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flesh65_53db64d42d139
X-Filterd-Recvd-Size: 2881
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:52:56 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Bad MAINTAINERS pattern in section 'DONGWOON DW9807 LENS VOICE COIL DRIVER'
Date:   Fri, 28 Sep 2018 14:52:54 -0700
Message-Id: <20180928215254.29290-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	4447	DONGWOON DW9807 LENS VOICE COIL DRIVER
	4448	M:	Sakari Ailus <sakari.ailus@linux.intel.com>
	4449	L:	linux-media@vger.kernel.org
	4450	T:	git git://linuxtv.org/media_tree.git
	4451	S:	Maintained
-->	4452	F:	drivers/media/i2c/dw9807.c
	4453	F:	Documentation/devicetree/bindings/media/i2c/dongwoon,dw9807-vcm.txt

Commit that introduced this:

commit 5b0a205466578432ce8faadd08f8d7ef895a180f
 Author: Alan Chiang <alanx.chiang@intel.com>
 Date:   Tue Apr 24 22:12:08 2018 -0400
 
     media: dw9807: Add dw9807 vcm driver
     
     DW9807 is a 10 bit DAC from Dongwoon, designed for linear
     control of voice coil motor.
     
     This driver creates a V4L2 subdevice and
     provides control to set the desired focus.
     
     Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
     Signed-off-by: Andy Yeh <andy.yeh@intel.com>
     Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
     Reviewed-by: Tomasz Figa <tfiga@chromium.org>
     Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
     Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
 
  MAINTAINERS                |   7 +
  drivers/media/i2c/Kconfig  |  10 ++
  drivers/media/i2c/Makefile |   1 +
  drivers/media/i2c/dw9807.c | 329 +++++++++++++++++++++++++++++++++++++++++++++
  4 files changed, 347 insertions(+)

Last commit with drivers/media/i2c/dw9807.c

commit e6c17ada3188e0deb43652b0eed249f37e0d44b0
Author: Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Fri Jul 20 17:07:15 2018 -0400

    media: dw9807-vcm: Recognise this is just the VCM bit of the device
    
    The dw9807 contains a voice coil lens driver as well as an EEPROM. This
    driver is just for the VCM. Reflect this in the driver's name --- this is
    already the case for the compatible string, for instance.
    
    Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

 drivers/media/i2c/Kconfig                    | 2 +-
 drivers/media/i2c/Makefile                   | 2 +-
 drivers/media/i2c/{dw9807.c => dw9807-vcm.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
