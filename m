Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B24DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92AC208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ym17ttrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92AC208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeH0UH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:07:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60566 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeH0UH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:07:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7RGJW6u153570;
        Mon, 27 Aug 2018 16:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=MGgjMmSUBUsqM7mt1pOqYh7D3G9R2MTY+oswJ7rjd9Q=;
 b=Ym17ttrQbo9vIyhTJRVfvBF95tbRdjnbT9Z68U/pcP6vIW7YjbX0cntZXTRqzafpUoTn
 m9WjxyhTdp7JhyP21wMdEEm6SG/R6FGuRubFJFQPKXnaRf10GULKKpBueh1lIp/n43p1
 /RKoHLbopbxEyvLTAxV70926BVJejS7+FGcd75eF4mOSdgt29YrJZPraSZOn5Wfu4tPG
 ige5FJJqFlfH5IJLkJAc/Kew8oHcw+o/AcxiCIqttIchbbzH8pVu9HcIF4C2A3GiSEXK
 UgaduW+tXLjvA/DfNoUXdv3ksq1k9XEz7Y5Ghjki1vl12owfJFNieJ/gHVAl+7FFWdhp Yw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m2yrpxv9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 16:19:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7RGJqTG024754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 16:19:53 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7RGJpeS001160;
        Mon, 27 Aug 2018 16:19:51 GMT
Received: from char.us.oracle.com (/10.152.35.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Aug 2018 09:19:50 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 06EFD6A0112; Mon, 27 Aug 2018 12:19:49 -0400 (EDT)
Date:   Mon, 27 Aug 2018 12:19:49 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     linux-kernel@vger.kernel.org, jgross@suse.com,
        roger.pau@citrix.com, axboe@kernel.dk,
        xen-devel@lists.xensource.com
Subject: [GIT PULL] (xen) stable/for-jens-4.19 for 4.19..
Message-ID: <20180827161949.GG29187@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808270173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jens,

Would you be OK pulling the following branch:
 git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.19

which has a fix for flushing out persistent pages at a deterministic rate.

Thanks to the L1TF I did not manage to send this email until today - but
hopefully it won't be an issue to push it to Linus after -rc1?

It is based on your 'b86d865cb1ca (for-4.19/block) blkcg: Make blkg_root_lookup()
work for queues in bypass mode' branch.

Thank you! 

 Documentation/ABI/testing/sysfs-driver-xen-blkback |  10 ++
 drivers/block/xen-blkback/blkback.c                |  99 ++++++++++---------
 drivers/block/xen-blkback/common.h                 |  14 +--
 drivers/block/xen-blkfront.c                       | 110 ++++++++++++++++++---
 4 files changed, 163 insertions(+), 70 deletions(-)

Juergen Gross (5):
      xen/blkback: don't keep persistent grants too long
      xen/blkfront: cleanup stale persistent grants
      xen/blkfront: reorder tests in xlblk_init()
      xen/blkback: move persistent grants flags to bool
      xen/blkback: remove unused pers_gnts_lock from struct xen_blkif_ring

