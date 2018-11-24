Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0348C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9251E2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g7Acg427"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9251E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeKYDyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 22:54:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33136 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYDyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 22:54:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAOH2CVa126891;
        Sat, 24 Nov 2018 17:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=8iKRPJPWj3gkdXJ+PdZeL7RkqMOadVCZ9tj7qEjgHJY=;
 b=g7Acg427O0jYqZOMsK0jzwkN24Myo7gdhdagXJu5cHha44ilxvNsHT7aWR62wqh89xzs
 MAKSEa5Qt5dVxuOUEDpnBuNy4aApiVOnEkDVOe9W7N7uQ6OJ2wgJrQ/qH6OGtwCPQKzQ
 36k3FRuAqcU0etEijS3eal9+P6VHtu/rjVXrtjS8smln0jwlSu9FK+9kj/ef/SsijDVf
 KgaCEzPSgFOSsGL9BB1aH51WXU3EExuWNPdZ0cmEjGeMaWsP8CUmBLSwbu0/Tx2qBVTY
 KH7i/eWCJlgQpeu1kVMoWhCP1jnTQOxBHDsou3ucTemXSvJJxsuIFm3orp+hwyaRrcUs cQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nxx2ts16d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Nov 2018 17:05:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAOH5fi8030614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Nov 2018 17:05:41 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAOH5euv023442;
        Sat, 24 Nov 2018 17:05:40 GMT
Received: from localhost (/10.159.224.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 24 Nov 2018 09:05:40 -0800
Date:   Sat, 24 Nov 2018 09:05:40 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: [GIT PULL] xfs: fixes for v4.20-rc4
Message-ID: <20181124170540.GY6792@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9087 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811240162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Dave and I have continued our work fixing corruption problems that can
be found when running long-term burn-in exercisers on xfs.  Here are
some patches fixing most of the problems, but there will likely be more.
:/

Anyhow, this series merges cleanly with master as of last night, so
please let me know if you encounter problems.

--D

The following changes since commit 837514f7a4ca4aca06aec5caa5ff56d33ef06976:

  xfs: fix overflow in xfs_attr3_leaf_verify (2018-11-06 07:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.20-fixes-2

for you to fetch changes up to 8c110d43c6bca4b24dd13272a9d4e0ba6f2ec957:

  iomap: readpages doesn't zero page tail beyond EOF (2018-11-21 10:10:54 -0800)

----------------------------------------------------------------
Changes since last update:
- Numerous corruption fixes for copy on write
- Numerous corruption fixes for blocksize < pagesize writes
- Don't miscalculate AG reservations for small final AGs
- Fix page cache truncation to work properly for reflink and extent
  shifting
- Fix use-after-free when retrying failed inode/dquot buffer logging
- Fix corruptions seen when using copy_file_range in directio mode

----------------------------------------------------------------
Brian Foster (1):
      xfs: fix shared extent data corruption due to missing cow reservation

Dave Chinner (11):
      xfs: uncached buffer tracing needs to print bno
      xfs: fix transient reference count error in xfs_buf_resubmit_failed_buffers
      xfs: finobt AG reserves don't consider last AG can be a runt
      xfs: extent shifting doesn't fully invalidate page cache
      xfs: flush removing page cache in xfs_reflink_remap_prep
      xfs: delalloc -> unwritten COW fork allocation can go wrong
      iomap: FUA is wrong for DIO O_DSYNC writes into unwritten extents
      iomap: sub-block dio needs to zeroout beyond EOF
      iomap: dio data corruption and spurious errors when pipes fill
      vfs: vfs_dedupe_file_range() doesn't return EOPNOTSUPP
      iomap: readpages doesn't zero page tail beyond EOF

Eric Biggers (1):
      xfs: make xfs_file_remap_range() static

 fs/iomap.c                       | 53 +++++++++++++++++++++++++++++++---------
 fs/read_write.c                  | 15 ++++++------
 fs/xfs/libxfs/xfs_bmap.c         |  5 +++-
 fs/xfs/libxfs/xfs_ialloc_btree.c | 11 ++++++---
 fs/xfs/xfs_bmap_util.c           | 10 ++------
 fs/xfs/xfs_bmap_util.h           |  3 +++
 fs/xfs/xfs_buf_item.c            | 28 +++++++++++++++------
 fs/xfs/xfs_file.c                |  2 +-
 fs/xfs/xfs_reflink.c             | 18 +++++++++++---
 fs/xfs/xfs_trace.h               |  5 +++-
 10 files changed, 104 insertions(+), 46 deletions(-)
