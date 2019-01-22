Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DE6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B472720823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfAVKA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:00:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727601AbfAVKA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:00:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0M9x58d116974
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:00:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q5y9ev7vv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:00:56 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Tue, 22 Jan 2019 10:00:54 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 10:00:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0MA0oZ93539378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 10:00:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A82711C064;
        Tue, 22 Jan 2019 10:00:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72DA111C050;
        Tue, 22 Jan 2019 10:00:48 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Jan 2019 10:00:48 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Tue, 22 Jan 2019 12:00:47 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Nider <joeln@il.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] update infiniband uverbs documentation
Date:   Tue, 22 Jan 2019 12:00:32 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19012210-0008-0000-0000-000002B44A9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012210-0009-0000-0000-0000222075CF
Message-Id: <1548151235-386-1-git-send-email-joeln@il.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=991 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small patchset to update the verbs API documentation with some
information regarding the ioctl syscall. First patch converts the
file format to ReST, since this is the new preferred format, moves
the file to Documentation/userspace-api, and updates the index.
The 2nd patch adds the new content, documenting a bit of the internal
workings of the kernel side of the API functions. The goal is to make
it easier for developers unfamiliar with the structure to understand
what is going on when adding a new function.
The 3rd patch updates the MAINTAINERS file.

v3 addresses comments from Jon, Willy and Jason:
 The location of the new content should be driver-api
 The location of the old (converted) content should be userspace-api
 MAINTAINERS file must be updated

Joel Nider (3):
  docs-rst: Convert user verbs doc to rst
  docs-rst: driver-api: Add infiniband interface documentation
  MAINTAINERS: add new RDMA/Infiniband documentation

 Documentation/driver-api/index.rst              |  1 +
 Documentation/driver-api/infiniband.rst         | 73 +++++++++++++++++++++++++
 Documentation/infiniband/user_verbs.txt         | 69 -----------------------
 Documentation/userspace-api/index.rst           |  1 +
 Documentation/userspace-api/rdma_user_verbs.rst | 70 ++++++++++++++++++++++++
 MAINTAINERS                                     |  2 +
 6 files changed, 147 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/driver-api/infiniband.rst
 delete mode 100644 Documentation/infiniband/user_verbs.txt
 create mode 100644 Documentation/userspace-api/rdma_user_verbs.rst

-- 
2.7.4

