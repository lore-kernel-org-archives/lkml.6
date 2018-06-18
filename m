Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DBAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A1120852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A1120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933947AbeFRLRb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:17:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932720AbeFRLR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:17:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IBEdtC019095
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:17:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jp9bqnv56-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:17:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 18 Jun 2018 12:17:27 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 12:17:25 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IBHOXU25165852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 11:17:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11C2242041;
        Mon, 18 Jun 2018 12:07:27 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC23C42045;
        Mon, 18 Jun 2018 12:07:26 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.186])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jun 2018 12:07:26 +0100 (BST)
Date:   Mon, 18 Jun 2018 13:17:22 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.18-rc2
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 18061811-0016-0000-0000-000001DD3A3E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061811-0017-0000-0000-000032313E01
Message-Id: <20180618131722.46ed6b3d@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

  common I/O layer
    - Fix bit-fields crossing storage-unit boundaries in css_general_char

  dasd driver
    - Avoid a sparse warning in regard to the queue lock
    - Allocate the struct dasd_ccw_req as per request data. Only for
      internal I/O is the structure allocated separately
    - Remove the unused function dasd_kmalloc_set_cda
    - Save a few bytes in struct dasd_ccw_req by reordering fields
    - Convert remaining users of dasd_kmalloc_request to
      dasd_smalloc_request and remove the now unused function

  vfio/ccw
    - Refactor and improve pfn_array_alloc_pin/pfn_array_pin
    - Add a new tracepoint for failed vfio/ccw requests
    - Add a CCW translation improvement to accept more requests as valid
    - Bug fixes

Shortlog:

Dong Jia Shi (4):
      vfio: ccw: fix error return in vfio_ccw_sch_event
      vfio: ccw: shorten kernel doc description for pfn_array_pin()
      vfio: ccw: refactor and improve pfn_array_alloc_pin()
      vfio: ccw: set ccw->cda to NULL defensively

Halil Pasic (2):
      vfio: ccw: push down unsupported IDA check
      vfio: ccw: add tracepoints for interesting error paths

Sebastian Ott (6):
      s390/cio: sanitize css_general_characteristics definition
      s390/dasd: simplify locking in process_final_queue
      s390/dasd: move dasd_ccw_req to per request data
      s390/dasd: remove dasd_kmalloc_set_cda
      s390/dasd: reshuffle struct dasd_ccw_req
      s390/dasd: only use preallocated requests

 arch/s390/include/asm/css_chars.h |  62 +++++++-------
 drivers/s390/block/dasd.c         | 171 +++++++++++++-------------------------
 drivers/s390/block/dasd_alias.c   |   6 +-
 drivers/s390/block/dasd_diag.c    |   3 +-
 drivers/s390/block/dasd_eckd.c    |  46 +++++-----
 drivers/s390/block/dasd_eer.c     |  10 +--
 drivers/s390/block/dasd_fba.c     |   6 +-
 drivers/s390/block/dasd_int.h     |  26 ++----
 drivers/s390/cio/Makefile         |   1 +
 drivers/s390/cio/vfio_ccw_cp.c    | 140 ++++++++++++++++---------------
 drivers/s390/cio/vfio_ccw_drv.c   |   5 +-
 drivers/s390/cio/vfio_ccw_fsm.c   |  17 +++-
 drivers/s390/cio/vfio_ccw_trace.h |  54 ++++++++++++
 13 files changed, 282 insertions(+), 265 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h

