Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6470EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AADF2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfBUOPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:15:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbfBUOPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:15:02 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LEACMM132866
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:15:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qsw3c9vda-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:15:01 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 21 Feb 2019 14:14:59 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 14:14:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LEEs3r19595306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 14:14:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6686A4051;
        Thu, 21 Feb 2019 14:14:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E9B9A404D;
        Thu, 21 Feb 2019 14:14:54 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 14:14:54 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com
Subject: [PATCH v3 0/1] s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem
Date:   Thu, 21 Feb 2019 15:14:53 +0100
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19022114-0020-0000-0000-000003198E2E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022114-0021-0000-0000-0000216AE02A
Message-Id: <1550758494-28227-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=847 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patch is to standardize the device-driver interface
for the VFIO_AP ap_matrix_device to satisfy user-land tools working on
hot-plug (UDEV/LIBVIRT).

Christian Borntraeger reported libvirt looping when a matrix device
was available before the libvirt start.

Marc Hartmayer debugged this and circumvented this in libvirt:
https://www.redhat.com/archives/libvir-list/2019-February/msg00837.html


Pierre Morel (1):
  s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem

 drivers/s390/crypto/vfio_ap_drv.c     | 44 ++++++++++++++++++++++++++++-------
 drivers/s390/crypto/vfio_ap_ops.c     |  4 ++--
 drivers/s390/crypto/vfio_ap_private.h |  1 +
 3 files changed, 38 insertions(+), 11 deletions(-)

-- 
2.7.4

