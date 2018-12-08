Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B31C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EFD20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bpx1viQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EFD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLHQgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:36:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:39754 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeLHQgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:36:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB8GYmBD127006;
        Sat, 8 Dec 2018 16:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=RVmaVVPxEo946D8ILnxSXrrgu6WYEbM0c5R0ClN1t4I=;
 b=bpx1viQhWDPBuqii1QPPugGeR9RIyulZxu1MwkO5REhmROwLQLeFuNEMsfywPTIxFukF
 iEGic7mFicj5qxx3kw8FvUYteugwNMKkKLR7AMoW6gdWthWo1nP88NnwuirCa+C0jGkF
 U60xl2OB/S9yC2fUYKflSQLqgLRwAiX9nZ9x0F7rosWpm3JUXrm04QjRhdvYTgUuzJ/D
 ILk39n838GMZRi3ihHzj6263r3HM/NKq8WApeIsi+Q5fgOQpomKvOpu1FB3lv/qPdzdp
 +gwWkf0bQC4olcpniXlv8XhTCkhmkESrMOPtFnS2NDN8/xgqyLFaJwcziZOLZ0kYaocX Xg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2p83fds809-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Dec 2018 16:36:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB8Gad3K010347
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Dec 2018 16:36:40 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB8GadHr014217;
        Sat, 8 Dec 2018 16:36:39 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Dec 2018 08:36:39 -0800
Date:   Sat, 8 Dec 2018 08:36:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: [GIT PULL] xfs: fixes for v4.20-rc6
Message-ID: <20181208163639.GR24487@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9101 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812080155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are hopefully the last set of fixes for 4.20.  There's a fix for a
longstanding statfs reporting problem with project quotas, a correction
for page cache invalidation behaviors when fallocating near EOF, and a
fix for a broken metadata verifier return code.

Finally, the most important fix is to the pipe splicing code (aka the
generic copy_file_range fallback) to avoid pointless short directio
reads by only asking the filesystem for as much data as there are
available pages in the pipe buffer.  Our previous fix (simulated short
directio reads because the number of pages didn't match the length of
the read requested) caused subtle problems on overlayfs, so that part is
reverted.

Anyhow, this series passes fstests -g all on xfs and overlay+xfs, and
has passed 17 billion fsx operations problem-free since I started
testing; and merges cleanly with master as of last night, so please let
me know if you encounter problems.

--D

The following changes since commit 8c110d43c6bca4b24dd13272a9d4e0ba6f2ec957:

  iomap: readpages doesn't zero page tail beyond EOF (2018-11-21 10:10:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.20-fixes-3

for you to fetch changes up to 8f67b5adc030553fbc877124306f3f3bdab89aa8:

  iomap: partially revert 4721a601099 (simulated directio short read on EFAULT) (2018-12-04 09:40:02 -0800)

----------------------------------------------------------------
Changes since last update:
- Fix broken project quota inode counts
- Fix incorrect PAGE_MASK/PAGE_SIZE usage
- Fix incorrect return value in btree verifier
- Fix WARN_ON remap flags false positive
- Fix splice read overflows

----------------------------------------------------------------
Darrick J. Wong (4):
      xfs: fix PAGE_MASK usage in xfs_free_file_space
      vfs: allow some remap flags to be passed to vfs_clone_file_range
      splice: don't read more than available pipe space
      iomap: partially revert 4721a601099 (simulated directio short read on EFAULT)

Eric Sandeen (1):
      xfs: fix inverted return from xfs_btree_sblock_verify_crc

Ye Yin (1):
      fs/xfs: fix f_ffree value for statfs when project quota is set

 fs/iomap.c                | 9 ---------
 fs/read_write.c           | 2 +-
 fs/splice.c               | 7 ++++++-
 fs/xfs/libxfs/xfs_btree.c | 2 +-
 fs/xfs/xfs_bmap_util.c    | 4 ++--
 fs/xfs/xfs_qm_bhv.c       | 2 +-
 6 files changed, 11 insertions(+), 15 deletions(-)
