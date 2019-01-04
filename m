Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1406C43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDC4217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dDxJpDVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfADBHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:07:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57472 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfADBHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:07:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x04148fS123931;
        Fri, 4 Jan 2019 01:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=vFyTRa25Lx7vUbyl8KQADhpPX3XJdK/LWPOGMXoOBWg=;
 b=dDxJpDVnKxrgZ69enUoTrCygqsygAAGYr+09l2Vsir+FkwnOKF5xmjdY3uNIwdOXw5oq
 2rJgD3hnoEn6VEg1Dl+7/MtgAqf4VJAHIQFfydndLOs64XZ9oi2p6VIYI6hU8Po8hvTr
 xS4VEnlrD2IUb58E1hAxWbWJe418EyzNimfkGR6Wz5Z0A2tXF8KZKdaH4IhGAjt1omkM
 JkuMgkbQ8QlIyEGEFQyjxZgAAgPlL6C/BruZFj5ziYkrDDzVO4X8xFYaf8qz8zhNzea/
 OCVhjj3gqKcyrMdoHzeT0uoHdiVg/YrrfHHoVcVrNORuYySBp31RazJPhIETkU8w//f/ zA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2pnxeea20d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 01:06:54 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0416mfT019542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 01:06:48 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0416lYP012977;
        Fri, 4 Jan 2019 01:06:47 GMT
Received: from localhost (/10.145.178.58)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 17:06:47 -0800
Date:   Thu, 3 Jan 2019 17:06:45 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] iomap: more updates for v4.21
Message-ID: <20190104010645.GA12689@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=802
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Christoph Hellwig and I have decided to take responsibility for the fs
iomap code rather than let it languish further.  Let me know if you
encounter any problems with the merge.

--D

The following changes since commit 3cc31fa65d85610574c0f6a474e89f4c419923d5:

  iomap: don't search past page end in iomap_is_partially_uptodate (2018-12-21 08:42:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-4.21-merge-3

for you to fetch changes up to 31af12efd0a259de9b0d8ef626503911f13b584f:

  iomap: take responsibility for the filesystem iomap code (2018-12-21 08:43:05 -0800)

----------------------------------------------------------------
Changes since last update:
- Take responsibility for the iomap code.

----------------------------------------------------------------
Darrick J. Wong (1):
      iomap: take responsibility for the filesystem iomap code

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)
