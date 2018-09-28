Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA2CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7943206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7943206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeI2ET2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:19:28 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:55973 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbeI2ET2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:19:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 08D201802A36D;
        Fri, 28 Sep 2018 21:53:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hose26_5afae49836f32
X-Filterd-Recvd-Size: 3448
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:53:45 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Bad MAINTAINERS pattern in section 'IPX NETWORK LAYER'
Date:   Fri, 28 Sep 2018 14:53:43 -0700
Message-Id: <20180928215343.29591-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	7639	IPX NETWORK LAYER
	7640	L:	netdev@vger.kernel.org
	7641	S:	Obsolete
	7642	F:	include/uapi/linux/ipx.h
-->	7643	F:	drivers/staging/ipx/

Commit that introduced this:

commit e02554e9a4338c58e75fdfb0ef908a5adc86cba5
 Author: Stephen Hemminger <stephen@networkplumber.org>
 Date:   Tue Nov 14 08:37:14 2017 -0800
 
     ipx: move Novell IPX protocol support into staging
     
     The Netware IPX protocol is very old and no one should still be using
     it. It is time to move it into staging for a while and eventually
     decommision it.
     
     Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
     Acked-by: David S. Miller <davem@davemloft.net>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 
  MAINTAINERS                                   | 3 +--
  drivers/staging/Kconfig                       | 2 ++
  drivers/staging/Makefile                      | 1 +
  {net => drivers/staging}/ipx/Kconfig          | 0
  {net => drivers/staging}/ipx/Makefile         | 0
  drivers/staging/ipx/TODO                      | 4 ++++
  {net => drivers/staging}/ipx/af_ipx.c         | 0
  {net => drivers/staging}/ipx/ipx_proc.c       | 0
  {net => drivers/staging}/ipx/ipx_route.c      | 0
  {net => drivers/staging}/ipx/pe2.c            | 0
  {net => drivers/staging}/ipx/sysctl_net_ipx.c | 0
  net/Kconfig                                   | 1 -
  net/Makefile                                  | 1 -
  13 files changed, 8 insertions(+), 4 deletions(-)

Last commit with drivers/staging/ipx/

commit 7a2e838d28cff6718a0bdf66164465402f8e40ed
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri Jun 1 20:39:54 2018 +0200

    staging: ipx: delete it from the tree
    
    The ipx code moved into the staging tree back in November 2017 and no
    one has complained or even noticed it was gone.  Because of that, let's
    just delete it.
    
    Note, the ipx header files are not removed here, that will come later
    through the networking tree, as that takes a bit more work to unwind.
    
    Cc: Stephen Hemminger <stephen@networkplumber.org>
    Cc: David S. Miller <davem@davemloft.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/staging/Kconfig              |    2 -
 drivers/staging/Makefile             |    1 -
 drivers/staging/ipx/Kconfig          |   61 -
 drivers/staging/ipx/Makefile         |    8 -
 drivers/staging/ipx/TODO             |    4 -
 drivers/staging/ipx/af_ipx.c         | 2082 ----------------------------------
 drivers/staging/ipx/ipx_proc.c       |  338 ------
 drivers/staging/ipx/ipx_route.c      |  293 -----
 drivers/staging/ipx/pe2.c            |   36 -
 drivers/staging/ipx/sysctl_net_ipx.c |   40 -
 10 files changed, 2865 deletions(-)
