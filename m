Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C354C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A52206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A52206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeI2E0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:26:47 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:36151 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbeI2E0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:26:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id F0C1A2195C;
        Fri, 28 Sep 2018 22:01:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: angle64_8e964c9dad15
X-Filterd-Recvd-Size: 4586
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:01:01 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vandrovec <petr@vandrovec.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Bad MAINTAINERS pattern in section 'NCP FILESYSTEM'
Date:   Fri, 28 Sep 2018 15:00:59 -0700
Message-Id: <20180928220059.30847-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	10052	NCP FILESYSTEM
	10053	M:	Petr Vandrovec <petr@vandrovec.name>
	10054	S:	Obsolete
-->	10055	F:	drivers/staging/ncpfs/

Commit that introduced this:

commit 1bb8155080c652c4853e6228f8f0d262b3049699
 Author: Stephen Hemminger <stephen@networkplumber.org>
 Date:   Tue Nov 14 08:37:15 2017 -0800
 
     ncpfs: move net/ncpfs to drivers/staging/ncpfs
     
     The Netware Core Protocol is a file system that talks to
     Netware clients over IPX. Since IPX has been dead for many years
     move the file system into staging for eventual interment.
     
     Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
     Acked-by: David S. Miller <davem@davemloft.net>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 
  MAINTAINERS                                    | 2 +-
  drivers/staging/Kconfig                        | 2 ++
  drivers/staging/Makefile                       | 1 +
  {fs => drivers/staging}/ncpfs/Kconfig          | 0
  {fs => drivers/staging}/ncpfs/Makefile         | 0
  drivers/staging/ncpfs/TODO                     | 4 ++++
  {fs => drivers/staging}/ncpfs/dir.c            | 0
  {fs => drivers/staging}/ncpfs/file.c           | 0
  {fs => drivers/staging}/ncpfs/getopt.c         | 0
  {fs => drivers/staging}/ncpfs/getopt.h         | 0
  {fs => drivers/staging}/ncpfs/inode.c          | 0
  {fs => drivers/staging}/ncpfs/ioctl.c          | 0
  {fs => drivers/staging}/ncpfs/mmap.c           | 0
  {fs => drivers/staging}/ncpfs/ncp_fs.h         | 0
  {fs => drivers/staging}/ncpfs/ncp_fs_i.h       | 0
  {fs => drivers/staging}/ncpfs/ncp_fs_sb.h      | 0
  {fs => drivers/staging}/ncpfs/ncplib_kernel.c  | 0
  {fs => drivers/staging}/ncpfs/ncplib_kernel.h  | 0
  {fs => drivers/staging}/ncpfs/ncpsign_kernel.c | 0
  {fs => drivers/staging}/ncpfs/ncpsign_kernel.h | 0
  {fs => drivers/staging}/ncpfs/sock.c           | 0
  {fs => drivers/staging}/ncpfs/symlink.c        | 0
  fs/Kconfig                                     | 1 -
  fs/Makefile                                    | 1 -
  24 files changed, 8 insertions(+), 3 deletions(-)

Last commit with drivers/staging/ncpfs/

commit bd32895c750bcd2b511bf93917bf7ae723e3d0b6
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri Jun 1 20:23:10 2018 +0200

    staging: ncpfs: delete it
    
    The ncpfs code moved into the staging tree back in November 2017 and no
    one has complained or even noticed it was gone.  Because of that, let's
    just delete it.
    
    Cc: Stephen Hemminger <stephen@networkplumber.org>
    Cc: David S. Miller <davem@davemloft.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/staging/Kconfig                |    2 -
 drivers/staging/Makefile               |    1 -
 drivers/staging/ncpfs/Kconfig          |  108 ---
 drivers/staging/ncpfs/Makefile         |   17 -
 drivers/staging/ncpfs/TODO             |    4 -
 drivers/staging/ncpfs/dir.c            | 1232 -----------------------------
 drivers/staging/ncpfs/file.c           |  263 -------
 drivers/staging/ncpfs/getopt.c         |   76 --
 drivers/staging/ncpfs/getopt.h         |   17 -
 drivers/staging/ncpfs/inode.c          | 1067 -------------------------
 drivers/staging/ncpfs/ioctl.c          |  923 ----------------------
 drivers/staging/ncpfs/mmap.c           |  125 ---
 drivers/staging/ncpfs/ncp_fs.h         |  101 ---
 drivers/staging/ncpfs/ncp_fs_i.h       |   31 -
 drivers/staging/ncpfs/ncp_fs_sb.h      |  174 -----
 drivers/staging/ncpfs/ncplib_kernel.c  | 1326 --------------------------------
 drivers/staging/ncpfs/ncplib_kernel.h  |  215 ------
 drivers/staging/ncpfs/ncpsign_kernel.c |  128 ---
 drivers/staging/ncpfs/ncpsign_kernel.h |   27 -
 drivers/staging/ncpfs/sock.c           |  855 --------------------
 drivers/staging/ncpfs/symlink.c        |  182 -----
 21 files changed, 6874 deletions(-)
