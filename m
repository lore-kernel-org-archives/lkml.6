Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50500C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A60A20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J4N6LO0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A60A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeKIIRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:17:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43740 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbeKIIRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:17:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA8MYi5j034184;
        Thu, 8 Nov 2018 22:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=fDfd5UVQ76quA5nFVNYcCoEc9wCOttr68DSVvn05eUc=;
 b=J4N6LO0n7CHBmn+56AZMnLnoaltvIzrowcZVLoJ5+7lmIU6Mn3IZoFcIm7CNacW8WEzW
 3VMrBQvlH+OJVCisIffTRUGqdGqIMtDweS1Ez1aL3SeK8GLe6+JMPdPae1pClQ8EQEII
 E08aA4q0y3qrtRHyp7+Uizmdc1FEJen2bpO5tyuoh1oPGDUpthldaQpMcdD8P7ZlpXZ0
 pFimsQygYKr3UnvGR6bbBaNmA+jqssKU2Ch0ktjeU4/eTYkHD1a3XsRm+bP/g2eEOKoX
 7Bw5Ct0vwErxq0MR0BJLMdWFw/oP6ynnSRLIV0k6JffnBsj8PH0coiG+ciVKgYxiSC47 Hw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nh4ar4407-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Nov 2018 22:40:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA8Me2s6026193
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Nov 2018 22:40:02 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA8Me15Z030484;
        Thu, 8 Nov 2018 22:40:01 GMT
Received: from localhost (/10.145.179.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Nov 2018 14:40:01 -0800
Date:   Thu, 8 Nov 2018 14:40:00 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: [GIT PULL] xfs: fixes for v4.20-rc2
Message-ID: <20181108224000.GB15721@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811080190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the start of the stabilization fixes for 4.20.  Let me know if
there are any problems merging; I just did it against current master and
saw no issues.

--D

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.20-fixes-1

for you to fetch changes up to 837514f7a4ca4aca06aec5caa5ff56d33ef06976:

  xfs: fix overflow in xfs_attr3_leaf_verify (2018-11-06 07:50:50 -0800)

----------------------------------------------------------------
Changes since last update:
- fix incorrect dropping of error code from bmap
- print buffer offsets instead of useless hashed pointers when dumping
  corrupt metadata
- fix integer overflow in attribute verifier

----------------------------------------------------------------
Christophe JAILLET (1):
      xfs: Fix error code in 'xfs_ioc_getbmap()'

Darrick J. Wong (1):
      xfs: print buffer offsets when dumping corrupt buffers

Dave Chinner (1):
      xfs: fix overflow in xfs_attr3_leaf_verify

 fs/xfs/libxfs/xfs_attr_leaf.c | 11 +++++++++--
 fs/xfs/xfs_ioctl.c            |  2 +-
 fs/xfs/xfs_message.c          |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)
