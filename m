Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C0C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38843206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38843206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeI2EaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:30:12 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:35250 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbeI2EaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:30:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 321B5180A813C;
        Fri, 28 Sep 2018 22:04:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: front81_269029482992b
X-Filterd-Recvd-Size: 3606
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:04:24 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Belisko <marek.belisko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Bad MAINTAINERS pattern in section 'STAGING - FLARION FT1000 DRIVERS'
Date:   Fri, 28 Sep 2018 15:04:23 -0700
Message-Id: <20180928220423.31573-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	13899	STAGING - FLARION FT1000 DRIVERS
	13900	M:	Marek Belisko <marek.belisko@gmail.com>
	13901	S:	Odd Fixes
-->	13902	F:	drivers/staging/ft1000/

Commit that introduced this:

commit a0138163cfbfdfbdc20e4477c77bd7046bd66bb4
 Author: Joe Perches <joe@perches.com>
 Date:   Tue Jul 5 15:21:34 2011 -0700
 
     MAINTAINERS: Add remaining staging entries
     
     Add the staging entries from various TODO files
     to MAINTAINERS.  Add a few web links as well.
     
     Miscellaneous staging typo section header fix.
     
     Signed-off-by: Joe Perches <joe@perches.com>
     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
 
  MAINTAINERS | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
  1 file changed, 68 insertions(+), 1 deletion(-)

Last commit with drivers/staging/ft1000/

commit 6512edec48b2ccfe9bb969ce26ebbbcd49de6c4b
Author: Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed Oct 21 18:42:37 2015 -0700

    staging: ft1000: remove obsolete driver
    
    Remove support for Qleadtek Flash-OFDM modems. Telecom carrier is
    discontinuing service for the radio technology.
    See http://www.gtigroup.org/news/ind/2015-08-18/6996.html.
    
    Suggested-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/ft1000/Kconfig                     |   22 -
 drivers/staging/ft1000/Makefile                    |    3 -
 drivers/staging/ft1000/TODO                        |    9 -
 drivers/staging/ft1000/ft1000-pcmcia/Makefile      |    2 -
 drivers/staging/ft1000/ft1000-pcmcia/boot.h        |  158 --
 drivers/staging/ft1000/ft1000-pcmcia/ft1000.h      |   70 -
 drivers/staging/ft1000/ft1000-pcmcia/ft1000.img    |  Bin 305770 -> 0 bytes
 drivers/staging/ft1000/ft1000-pcmcia/ft1000_cs.c   |  158 --
 drivers/staging/ft1000/ft1000-pcmcia/ft1000_dnld.c |  762 --------
 drivers/staging/ft1000/ft1000-pcmcia/ft1000_hw.c   | 2068 --------------------
 drivers/staging/ft1000/ft1000-usb/Makefile         |    3 -
 drivers/staging/ft1000/ft1000-usb/ft1000_debug.c   |  789 --------
 .../staging/ft1000/ft1000-usb/ft1000_download.c    | 1058 ----------
 drivers/staging/ft1000/ft1000-usb/ft1000_hw.c      | 1586 ---------------
 drivers/staging/ft1000/ft1000-usb/ft1000_ioctl.h   |  123 --
 drivers/staging/ft1000/ft1000-usb/ft1000_usb.c     |  248 ---
 drivers/staging/ft1000/ft1000-usb/ft1000_usb.h     |  150 --
 drivers/staging/ft1000/ft1000-usb/ft3000.img       |  Bin 280414 -> 0 bytes
 drivers/staging/ft1000/ft1000.h                    |  366 ----
 21 files changed, 7578 deletions(-)
