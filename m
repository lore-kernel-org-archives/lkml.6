Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD838C43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A55021872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EduwN1Fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfADBG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:06:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfADBG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:06:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0414v0o171049;
        Fri, 4 Jan 2019 01:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=e5FY4nEbrR8eTvpbgmKqWJLJ9uOGP35CNAZWVPmLRkc=;
 b=EduwN1FoeJ2z+bgAHH7499QVeujC3fGkFl/2C9wQYdQZyCWwEjI+rW+GQQsbLxh/YWSB
 5IYvGW6BIl8/ActwHOYthxcSZbfQvlNr0bpHyy8v0wr+PG1xkbTEfa2KbACY/yuMFpCA
 YH/x8GmsEprNk67bJgOXVQIL1gzWSoLKTe7ZnPqMig1cpx8B+gqLtptJ05sHAGZaPEYr
 /lU8pIjm9LwoANp8ttVRMasQ7FK0eUA7CYb7BxRNyjpbLxoL649EMQcauN1OQC9v24wC
 EVTeJBFaN6L1F8WeD3Y4g7SzxvcPLMme7KHkgMuohOrG/1O6t33JFs7vcgiPO91qvC2k IQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pp0bu1xvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 01:06:52 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0416kkm018459
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 01:06:46 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0416jC6011351;
        Fri, 4 Jan 2019 01:06:46 GMT
Received: from localhost (/10.145.178.58)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 17:06:45 -0800
Date:   Thu, 3 Jan 2019 17:06:44 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net
Subject: [GIT PULL] xfs: more updates for v4.21
Message-ID: <20190104010644.GC21010@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a couple more small bug fixes for 4.21-rc1.  It has undergone
the usual testing regimen and merges cleanly with 4.20 final.  Let me
know if you encounter any problems with the merge.

--D

The following changes since commit 65eed012d1f2d0f0bf0ffc036826d58147de77b8:

  xfs: reallocate realtime summary cache on growfs (2018-12-21 18:45:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.21-merge-3

for you to fetch changes up to 90be9b86da9039fe6cf2880dc16fd0b0899603a5:

  xfs: xfs_fsops: drop useless LIST_HEAD (2018-12-29 10:47:58 -0800)

----------------------------------------------------------------
Changes since last update:
- Remove a couple of unnecessary local variables.

----------------------------------------------------------------
Julia Lawall (2):
      xfs: xfs_buf: drop useless LIST_HEAD
      xfs: xfs_fsops: drop useless LIST_HEAD

 fs/xfs/xfs_buf.c   | 1 -
 fs/xfs/xfs_fsops.c | 1 -
 2 files changed, 2 deletions(-)
