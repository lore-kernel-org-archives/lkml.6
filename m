Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22F2208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pq+RkMe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22F2208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbeFRNIi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:08:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54742 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932843AbeFRNIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:08:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5ID43oc149424;
        Mon, 18 Jun 2018 13:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2017-10-26;
 bh=AxtY+1pDKOUcNINqtcRO5wkqA19booFd91GZr9LQ/UA=;
 b=pq+RkMe6O4RObAFAocJu0sWEqz1EEqI0Ro1oS4gICaM3F0FYYJ7qdTJHcfrMmdNZ9WeD
 7wf7uir27CTwdmdzcU2WAdXCIVcqrvy1Q+LEhBtevjTtm1lLXj/w9BaRQKWPiWQRbXWZ
 cV/ShtDPiZGXPFhxzOywZm4FU5k4rBcSixJHsseoDjQAyIspddfdtWAE7m6U17IEbPmq
 uFUZxNFkQXOTEQhecfFnicgNppYtMs80WE/YIeVwaTAxC+goH53yt8/uGYMYJSy/vpmx
 CTRCJZ7K8cfKd/xuBpOuNQpfciztqzyGRbMA67H8PYkAivZoZmSPDHhdPYLQ34rKkZth TQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jmtgwkxwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 13:08:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5ID8Ouq006713
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 13:08:24 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5ID8Nm3015121;
        Mon, 18 Jun 2018 13:08:23 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 06:08:23 -0700
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        JFS Discussion <jfs-discussion@lists.sourceforge.net>,
        Shankara Pailoor <shankarapailoor@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [GIT PULL] jfs fix for 4.18
Openpgp: preference=signencrypt
Message-ID: <8e359208-0084-a13c-ea8e-e7d0e7279833@oracle.com>
Date:   Mon, 18 Jun 2018 08:08:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8927 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806180158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 716a685fdb89942a50c4138141027e38336a895f:

  Merge branch 'x86-hyperv-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2018-06-04 21:37:30 -0700)

are available in the Git repository at:

  git://github.com/kleikamp/linux-shaggy.git tags/jfs-4.18

for you to fetch changes up to 92d34134193e5b129dc24f8d79cb9196626e8d7a:

  jfs: Fix inconsistency between memory allocation and ea_buf->max_size (2018-06-05 10:36:46 -0500)

----------------------------------------------------------------
This fixes a too-small allocation in the xattr code.

----------------------------------------------------------------
Shankara Pailoor (1):
      jfs: Fix inconsistency between memory allocation and ea_buf->max_size

 fs/jfs/xattr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
