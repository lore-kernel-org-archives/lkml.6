Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEF2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76C2218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Q9bPowda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAYTl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:41:59 -0500
Received: from alln-iport-3.cisco.com ([173.37.142.90]:15297 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYTl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3056; q=dns/txt; s=iport;
  t=1548445318; x=1549654918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HNSyU5MJweJ0pYumgazBZlWXvD4ZFs9VU/cUSByRK34=;
  b=Q9bPowdav6zPGppJgIeoWQFj/yTL0XL1dJE249PetfgK8lUDL7l3aWIy
   h8FMhn9ljWVZ2BMtqZD8V/PPkvPtpIz/uddgJf7me850e/WdfJirTkLvF
   fTFkF9Kn9e5MMkzhPkFc4rSCSHUduhcUbZpmeTenqg8lj53t2gAl01cZw
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ADAADWZUtc/40NJK1hAxkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEHAQEBAQEBgVEEAQEBAQELAYIDZ4EDJwqMEYt2gg2YBxSBZwsBASe?=
 =?us-ascii?q?BUIJxAgICgwoiNAkNAQMBAQIBAQJtHAyFSgEBAQEDJxM/DAQCAQgRBAEBHxA?=
 =?us-ascii?q?yHQgCBAENBQiDG4IBD6tuM4QDAYYviySBHReBQD8mgy0iLoMeAQEBgS0BEgE?=
 =?us-ascii?q?rFSaFGQKJTwGNHotKCQKHKohUgiIggWpRhGOLCYoTkQsCERSBJx84ZXFwFYM?=
 =?us-ascii?q?nCYYAc4kpATZBMQGIb4EfgR8BAQ?=
X-IronPort-AV: E=Sophos;i="5.56,522,1539648000"; 
   d="scan'208";a="231567515"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 19:41:57 +0000
Received: from XCH-RCD-013.cisco.com (xch-rcd-013.cisco.com [173.37.102.23])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id x0PJfvt8011643
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 25 Jan 2019 19:41:57 GMT
Received: from xch-rcd-012.cisco.com (173.37.102.22) by XCH-RCD-013.cisco.com
 (173.37.102.23) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 13:41:56 -0600
Received: from xch-rcd-012.cisco.com ([173.37.102.22]) by
 XCH-RCD-012.cisco.com ([173.37.102.22]) with mapi id 15.00.1395.000; Fri, 25
 Jan 2019 13:41:56 -0600
From:   "Satish Kharat (satishkh)" <satishkh@cisco.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH -next] scsi: fnic: Remove set but not used variable 'vdev'
Thread-Topic: [PATCH -next] scsi: fnic: Remove set but not used variable
 'vdev'
Thread-Index: AQHUtFHYqawqLc39WkKU+KkDhwxaMKXAYXkA
Date:   Fri, 25 Jan 2019 19:41:56 +0000
Message-ID: <e2c3cd5a937045269760d703985392bb@XCH-RCD-012.cisco.com>
References: <20190125020014.11184-1-yuehaibing@huawei.com>
In-Reply-To: <20190125020014.11184-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.157.132.77]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-SMTP-Client: 173.37.102.23, xch-rcd-013.cisco.com
X-Outbound-Node: alln-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Acked-by: Satish Kharat <satishkh@cisco.com>


Satish Kharat
TECHNICAL LEADER.ENGINEERING
satishkh@cisco.com
Tel: +1 408 526 7504

Cisco Systems, Inc.
3800 Zanker Road
SAN JOSE
95134
United States
cisco.com

Think before you print.
This email may contain confidential and privileged material for the sole us=
e of the intended recipient. Any review, use, distribution or disclosure by=
 others is strictly prohibited. If you are not the intended recipient (or a=
uthorized to receive for the recipient), please contact the sender by reply=
 email and delete all copies of this message.
http://www.cisco.com/c/en/us/about/legal/terms-sale-software-license-agreem=
ent/company-registration-information.html
-----Original Message-----
From: YueHaibing <yuehaibing@huawei.com>=20
Sent: Thursday, January 24, 2019 6:00 PM
To: Satish Kharat (satishkh) <satishkh@cisco.com>; Sesidhar Baddela (sebadd=
el) <sebaddel@cisco.com>; Karan Tilak Kumar (kartilak) <kartilak@cisco.com>=
; jejb@linux.ibm.com; martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; YueHaibing <y=
uehaibing@huawei.com>
Subject: [PATCH -next] scsi: fnic: Remove set but not used variable 'vdev'

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/fnic/vnic_wq.c: In function 'vnic_wq_alloc_bufs':
drivers/scsi/fnic/vnic_wq.c:50:19: warning:
 variable 'vdev' set but not used [-Wunused-but-set-variable]

drivers/scsi/fnic/vnic_rq.c: In function 'vnic_rq_alloc_bufs':
drivers/scsi/fnic/vnic_rq.c:30:19: warning:
 variable 'vdev' set but not used [-Wunused-but-set-variable]

It never used since introduction

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/fnic/vnic_rq.c | 3 ---
 drivers/scsi/fnic/vnic_wq.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/scsi/fnic/vnic_rq.c b/drivers/scsi/fnic/vnic_rq.c inde=
x 74d2f2c..6a35b1b 100644
--- a/drivers/scsi/fnic/vnic_rq.c
+++ b/drivers/scsi/fnic/vnic_rq.c
@@ -27,12 +27,9 @@
 static int vnic_rq_alloc_bufs(struct vnic_rq *rq)  {
 	struct vnic_rq_buf *buf;
-	struct vnic_dev *vdev;
 	unsigned int i, j, count =3D rq->ring.desc_count;
 	unsigned int blks =3D VNIC_RQ_BUF_BLKS_NEEDED(count);
=20
-	vdev =3D rq->vdev;
-
 	for (i =3D 0; i < blks; i++) {
 		rq->bufs[i] =3D kzalloc(VNIC_RQ_BUF_BLK_SZ, GFP_ATOMIC);
 		if (!rq->bufs[i]) {
diff --git a/drivers/scsi/fnic/vnic_wq.c b/drivers/scsi/fnic/vnic_wq.c inde=
x 74cfc56..015af2c 100644
--- a/drivers/scsi/fnic/vnic_wq.c
+++ b/drivers/scsi/fnic/vnic_wq.c
@@ -47,12 +47,9 @@ int vnic_wq_alloc_ring(struct vnic_dev *vdev, struct vni=
c_wq *wq,  static int vnic_wq_alloc_bufs(struct vnic_wq *wq)  {
 	struct vnic_wq_buf *buf;
-	struct vnic_dev *vdev;
 	unsigned int i, j, count =3D wq->ring.desc_count;
 	unsigned int blks =3D VNIC_WQ_BUF_BLKS_NEEDED(count);
=20
-	vdev =3D wq->vdev;
-
 	for (i =3D 0; i < blks; i++) {
 		wq->bufs[i] =3D kzalloc(VNIC_WQ_BUF_BLK_SZ, GFP_ATOMIC);
 		if (!wq->bufs[i]) {
--
2.7.0


