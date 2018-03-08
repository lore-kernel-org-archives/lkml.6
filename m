Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487977-2-5359523142233777217
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487977; b=bb1hn5NQMGrwR6Zd97A4XpEObQdyWi9rob26Q2eh0ws16wH
    8dMyEuXo0KU4E+LqfcjzuuaEbSbQA0ulOXrYCEOxsNrKUqfIqHrSGHtj28BCfihe
    /PcyVcxjSzvuQ42avZf9Jh2EsDZOz2MbkpbpplHbNSIRAN1v8LBAc6Wo8gZb7htG
    VveG/e7wqeP+48a2xJEc9Y1998b7ygk2xmtEcg0WNPHewjax9d266uRwZui/MRqY
    4fOlARr+rQLiIJsJboOmr1Y6BZ8jW3gRkyMjUbtgQqGQw5qvmVRyc7amkCsFAec5
    uW3Awpvbm+RN06Zu+uGCTlulbH2qvbany6EBGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487977; bh=wf3qVD
    9Jm1/UQsMbb7YcyhJ44Z4nVRTYkvB4lJaen6I=; b=f85pxMs/1cpkZwEDbCFYfO
    WaRI/T/ljlUuKmqQP04LZW8qB+6kCrluuShOrK0kOEzt6KoXDuPbrTRKUk3VUWXX
    lKYH6QSxuH0JmIZzhQhMRvCR6+dtoBNTMQRH3Fm/1LjUpmIMc3kpzSwRB84A5EYV
    pCpM7uS4GopbSyaaBHfviOOVIO9pFryqJK9yTCzRLiSQmVw6USGZy7VuZPfSy2Py
    oRJXBhbT5El2nI8MCEjFok74oQGp2tWHdwiUPe73sz0pEbcv0qz0FtXXUCBizE+g
    c0GksO25I879MUSiTOnkmG/H2P/DmhpvLfdE3HZ+MsixouXgfdnZjWauBuusDW2A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iSXbAsc1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iSXbAsc1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755421AbeCHFqC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:46:02 -0500
Received: from mail-cys01nam02on0130.outbound.protection.outlook.com ([104.47.37.130]:16451
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966090AbeCHFFK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 005/101] scsi: sg: check for valid direction
 before starting the request
Thread-Topic: [PATCH AUTOSEL for 4.4 005/101] scsi: sg: check for valid
 direction before starting the request
Thread-Index: AQHTtpp5TugofOSRO02VxXV8vlLpUA==
Date: Thu, 8 Mar 2018 05:01:09 +0000
Message-ID: <20180308050023.8548-5-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:WcQJ/jlqCFH5DI5MVOuk57VUnIo06qbsBLexI3OK4w7M7fFTZu5fLTjKFva5koFavVHdX+h307UR26D1HAIYTFQCJxEKQIscq/X1uudgwvCyLiDuYpmegTNt9Z/usKdDDwOYhViiwJB46F4lXF/q1uf4OHaJzO/D2nHv4U+me94Fd6bzxVrRghM1gPgLoYp6i7VdG27AOO7UYnKb4SORH6y4Xtzp3kiPadBZJe74H3PmWPoheMOFnNEYY+KesORB;20:KsQ2utQ5pD9K0td/F9T+wRHZX6i+vLseHamZPnsnDwDqPY4XrdDplHyDkKhQbuX+7jGe+gOZAvz+aW7bf8J8inxGP7ZbQpAVBqRdYG8TDur4XvX+Fwg+ihN6rRZPEGmCXKKtBTp4reWbPzB/hzhBjQe4r7gy0J0yoQWrlyduMKk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1752869d-9a6e-48b7-f334-08d584b227d6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098194DDDA4860DAE4CD29D6FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(6306002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(575784001)(6116002)(81166006)(99286004)(72206003)(966005)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: tkD+ow/7AhAC2qLShwxafK+3WFH8DgVg5q236KVYXPko2b51gRKysNdUB19MsTjoSNR+/SmZi3CI6jl1KTpTkmVpcoe95VVEbNAMD19ENzVcEqhg9E4cQAX4pehBJ2lkoHqfbpMlCPBkczaRJMowNOKppOE8TnZpPR1VHjlzOSyf2bdZRBvAnI/A6N5dkaZoScbCEatQVUSihYFV08fUUi1DPn/V1CrcNtfw6tQzURZrPQiF3vxwTeuY+KHbuYV1V3UtymZ6sZFnUkdMJFVpOlRsd/4JH4lpJ7UdicsQm4Q2YwPmQrFQ3xwu+GiQ7Rxb7pOZ8/moaKbG8k5/KkD+sQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1752869d-9a6e-48b7-f334-08d584b227d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:09.8548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit 28676d869bbb5257b5f14c0c95ad3af3a7019dd5 ]

Check for a valid direction before starting the request, otherwise we
risk running into an assertion in the scsi midlayer checking for valid
requests.

[mkp: fixed typo]

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Link: http://www.spinics.net/lists/linux-scsi/msg104400.html
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/sg.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0f0ff75755e0..27f92f4ea6bc 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -674,18 +674,14 @@ sg_write(struct file *filp, const char __user *buf, s=
ize_t count, loff_t * ppos)
 	 * is a non-zero input_size, so emit a warning.
 	 */
 	if (hp->dxfer_direction =3D=3D SG_DXFER_TO_FROM_DEV) {
-		static char cmd[TASK_COMM_LEN];
-		if (strcmp(current->comm, cmd)) {
-			printk_ratelimited(KERN_WARNING
-					   "sg_write: data in/out %d/%d bytes "
-					   "for SCSI command 0x%x-- guessing "
-					   "data in;\n   program %s not setting "
-					   "count and/or reply_len properly\n",
-					   old_hdr.reply_len - (int)SZ_SG_HEADER,
-					   input_size, (unsigned int) cmnd[0],
-					   current->comm);
-			strcpy(cmd, current->comm);
-		}
+		printk_ratelimited(KERN_WARNING
+				   "sg_write: data in/out %d/%d bytes "
+				   "for SCSI command 0x%x-- guessing "
+				   "data in;\n   program %s not setting "
+				   "count and/or reply_len properly\n",
+				   old_hdr.reply_len - (int)SZ_SG_HEADER,
+				   input_size, (unsigned int) cmnd[0],
+				   current->comm);
 	}
 	k =3D sg_common_write(sfp, srp, cmnd, sfp->timeout, blocking);
 	return (k < 0) ? k : count;
@@ -764,6 +760,29 @@ sg_new_write(Sg_fd *sfp, struct file *file, const char=
 __user *buf,
 	return count;
 }
=20
+static bool sg_is_valid_dxfer(sg_io_hdr_t *hp)
+{
+	switch (hp->dxfer_direction) {
+	case SG_DXFER_NONE:
+		if (hp->dxferp || hp->dxfer_len > 0)
+			return false;
+		return true;
+	case SG_DXFER_TO_DEV:
+	case SG_DXFER_FROM_DEV:
+	case SG_DXFER_TO_FROM_DEV:
+		if (!hp->dxferp || hp->dxfer_len =3D=3D 0)
+			return false;
+		return true;
+	case SG_DXFER_UNKNOWN:
+		if ((!hp->dxferp && hp->dxfer_len) ||
+		    (hp->dxferp && hp->dxfer_len =3D=3D 0))
+			return false;
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		unsigned char *cmnd, int timeout, int blocking)
@@ -784,6 +803,9 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 			"sg_common_write:  scsi opcode=3D0x%02x, cmd_size=3D%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
=20
+	if (!sg_is_valid_dxfer(hp))
+		return -EINVAL;
+
 	k =3D sg_start_req(srp, cmnd);
 	if (k) {
 		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
--=20
2.14.1
