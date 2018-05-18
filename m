Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4055432-1526653905-2-12378684279714082607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526653904; b=Y6xIsaXWwLZzSpxToCMidbOk6odDnG45KJu/MLzY4BtCj8qrEh
    VBhWd1JNXCgyQoX5hTynPa63qoyJPB3EEK/WsLD8vnKlYLouzuYzyfT5GRiI/uA5
    ixvhdjPoD+ZlFWihEa8ZGKhmY/91HFL+aJDPWQP8appmKw3KFOibW2UzH8bPgUbj
    E3bK4le3s2uNEH/p98h/mVT/f6ahtrAdVAslxshdWguus4Laf6jUCIaW/HDNKGD0
    +0u4K86aA2MwObX8p8IQlc+xLH5O9Ox8ygi9hxX5PPJqlI2+tWh2g2WZtk6tJpT8
    j+uIgIxr8MD/kzmKxMB224ho5GZvJq99q9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1526653904; bh=K6QBg/DD4by1kCz7zyh0ckqoc1aRzp
    4X1rdjHj/6yO4=; b=SX/hq815PjJCOKUA67+yo3lXLCYthlc8z0KZRLrpnRZGiI
    A3zu9i5ZPdaX08JfFe8JZlUwu/FuCP5XWnwIdtP3B2VNEh8RRGG1e1IxxqjAeX8A
    Bmmmh1bre5GJ10xh2SmM3I682rN+q5iNTMdUe9qkZ2PgyxJMBEydPMIQPrLNdoEz
    7D6dCSSWanDz0aYR/naf/nPYpzWtYScHIi42Wm2BEPZj2J3ATFOcpnrfnFuLhmAK
    EcRSXppjYbSk3h7mhnq8PeydlytzB5m1IQLHAiede1xzKvI6xX96E+pAvjuv5W1r
    8uFwzLdXYc1scZl8nyHSH3LX7UYrDjtEvfhwR1Ng==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=HVIOVN5M x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=HVIOVN5M x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNuaupx11uCp2QmZ0uBntyF1IIWHPQgHPglHNtOlr7Y9dAV6QWiMiHk3Tl4Y5Kzbaet2rvKHAnhsL+0USAEgtZzT/JYu8gon9cepmLb3OJ0YFLDWvqxG
    CAI+D6DaM/SDXv34YZgVg40I74s40P8+Ea20NDkI6gz/5Tw7LlSYgMl5lsbr79uxKpuLsSrweYR2oraCw7/rQiHUKaelEDO9tFI3DYkdRWK5hhrPDpl/OLqC
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=cnfiXbT_5AhYrKBE3X4A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbeERObl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 10:31:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35980 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeERObk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 10:31:40 -0400
To: Alexander Potapenko <glider@google.com>
Cc: jthumshirn@suse.de, jejb@linux.vnet.ibm.com, dgilbert@interlog.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-scsi@vger.kernel.org, dvyukov@google.com, hare@suse.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180518142318.200260-1-glider@google.com>
Date: Fri, 18 May 2018 10:31:26 -0400
In-Reply-To: <20180518142318.200260-1-glider@google.com> (Alexander
        Potapenko's message of "Fri, 18 May 2018 16:23:18 +0200")
Message-ID: <yq1y3ghghmp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=582
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180159
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Alexander,

> This shall help avoid copying uninitialized memory to the userspace
> when calling ioctl(fd, SG_IO) with an empty command.

Applied to 4.17/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
