Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969DAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B84021473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfA2N2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:28:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbfA2N2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:28:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TDSEuT177393
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:28:15 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qamd4bnhv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:26:59 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Tue, 29 Jan 2019 13:26:53 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 13:26:50 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TDQmEw46727234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 13:26:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B432A404D;
        Tue, 29 Jan 2019 13:26:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03E10A4040;
        Tue, 29 Jan 2019 13:26:47 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Jan 2019 13:26:46 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Tue, 29 Jan 2019 15:26:46 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Nider <joeln@il.ibm.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] RDMA: reg_remote_mr
Date:   Tue, 29 Jan 2019 15:26:21 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19012913-0008-0000-0000-000002B77689
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012913-0009-0000-0000-00002223B946
Message-Id: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=710 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed at LPC'18, there is a need to be able to register a memory
region (MR) on behalf of another process. One example is the case of
post-copy container migration, in which CRIU is responsible for setting
up the migration, but the contents of the memory are from the migrating
process. In this case, we want all RDMA READ requests to be served by
the address space of the migration process directly (not by CRIU). This
patchset implements a new uverbs command which allows an application to
register a memory region in the address space of another process.

Joel Nider (5):
  mm: add get_user_pages_remote_longterm function
  RDMA/uverbs: add owner parameter to reg_user_mr
  RDMA/uverbs: add owner parameter to ib_umem_get
  RDMA/uverbs: add owner parameter to ib_umem_odp_get
  RDMA/uverbs: add UVERBS_METHOD_REG_REMOTE_MR

 drivers/infiniband/core/umem.c                |  26 ++++--
 drivers/infiniband/core/umem_odp.c            |  50 +++++-----
 drivers/infiniband/core/uverbs_cmd.c          |   2 +-
 drivers/infiniband/core/uverbs_std_types_mr.c | 129 +++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  11 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   1 +
 drivers/infiniband/hw/cxgb3/iwch_provider.c   |   6 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |   1 +
 drivers/infiniband/hw/cxgb4/mem.c             |   6 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |   2 +-
 drivers/infiniband/hw/hns/hns_roce_db.c       |   2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |   4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c       |   2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c      |   2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |   3 +-
 drivers/infiniband/hw/mlx4/cq.c               |   2 +-
 drivers/infiniband/hw/mlx4/doorbell.c         |   2 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   1 +
 drivers/infiniband/hw/mlx4/mr.c               |   3 +-
 drivers/infiniband/hw/mlx4/qp.c               |   2 +-
 drivers/infiniband/hw/mlx4/srq.c              |   2 +-
 drivers/infiniband/hw/mlx5/cq.c               |   4 +-
 drivers/infiniband/hw/mlx5/devx.c             |   2 +-
 drivers/infiniband/hw/mlx5/doorbell.c         |   2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   4 +-
 drivers/infiniband/hw/mlx5/mr.c               |  17 ++--
 drivers/infiniband/hw/mlx5/odp.c              |  11 ++-
 drivers/infiniband/hw/mlx5/qp.c               |   4 +-
 drivers/infiniband/hw/mlx5/srq.c              |   2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |   5 +-
 drivers/infiniband/hw/nes/nes_verbs.c         |   5 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |   6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |   3 +-
 drivers/infiniband/hw/qedr/verbs.c            |   8 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |   1 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |   1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |   2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |   2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |   5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |   2 +-
 drivers/infiniband/sw/rdmavt/mr.c             |   3 +-
 drivers/infiniband/sw/rdmavt/mr.h             |   1 +
 drivers/infiniband/sw/rxe/rxe_mr.c            |   3 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   4 +-
 include/linux/mm.h                            |  28 +++++-
 include/rdma/ib_umem.h                        |   3 +-
 include/rdma/ib_umem_odp.h                    |   6 +-
 include/rdma/ib_verbs.h                       |   9 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  13 +++
 mm/gup.c                                      |  15 ++-
 50 files changed, 327 insertions(+), 103 deletions(-)

-- 
2.7.4

