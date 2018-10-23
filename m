Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DCEC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E75120651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9+Qrvoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E75120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeJWWLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:11:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39142 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWWLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 18:11:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9NDi9Cn085551;
        Tue, 23 Oct 2018 13:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=epbEsJEAWOS2EFxIvycpsRWXFthqXb8MVvixBqbEyxs=;
 b=V9+QrvoyF+JDLiAsubgh8C//su9lu8L911A7ugVzfuEmsMie6GeHNI0ajunGSmfbhGRh
 crowOlxwzxsrUO0zroIjvJyMapXrDpCy6CoDxHERkZbaStA76oq2YrkuKbRqLPX3jigP
 IvM+5S50UqjO1YIHpR2gHqtEtF9roOBWr3nAa1ZmsvrFgRC1gk2NT+K5zxLDzf9cCyah
 FcPYNxBHGxVegLz/aDX8KMlPYxt4Nd+t2aCvEgfKF54cKFWFPybrfDu8Yp/VHAk8ZzRe
 K2hR6+is7i0Opasc7K4fs8RYZ/EJBbY4JAufh7prAb60qlX6PEDmqro2ZrCqOQsAw+2f 5w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usu5cry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 13:47:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9NDliLc020362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 13:47:44 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9NDlg5T030448;
        Tue, 23 Oct 2018 13:47:43 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 06:47:42 -0700
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, Chengguang Xu <cgxu519@gmx.com>
Subject: [GIT PULL] jfs fixes for v4.20
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <743b8d6b-6b1f-8766-7db3-1df5d95227f5@oracle.com>
Date:   Tue, 23 Oct 2018 08:47:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=950
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit be65e2595b4c1fbeceba336d8ee83406726b1d8d:

  Merge tag 'trace-v4.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2018-09-06 09:06:49 -0700)

are available in the Git repository at:

  git://github.com/kleikamp/linux-shaggy.git tags/jfs-for-4.20

for you to fetch changes up to 1390643d1d5c539be4d7031a0c507565cb1168a0:

  jfs: remove redundant dquot_initialize() in jfs_evict_inode() (2018-09-20 09:28:49 -0500)

----------------------------------------------------------------
Just a few small fixes

----------------------------------------------------------------
Chao Yu (1):
      jfs: remove redundant dquot_initialize() in jfs_evict_inode()

Chengguang Xu (2):
      jfs: cache NULL when both default_acl and acl are NULL
      jfs: remove quota option from ignore list

 fs/jfs/acl.c   | 4 ++++
 fs/jfs/inode.c | 1 -
 fs/jfs/super.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)
