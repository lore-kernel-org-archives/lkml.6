Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490686-5-7417363028395380027
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
    t=1520490685; b=D+E7Ik8UWtjukfKSeh/P5D6F7fn1Tr1c+hb2Toc2HhFdcqd
    +ReFeiIhawpmhEUA1JxXTiU1lUQ5MN4RxAERCPohFDcQru1m78KgAhK7ZDtLW4I4
    URGeNgh3lX890mg//hYHF2VfEgX4d1ir4Qv4RXWgat7swYxTxQu6YZ+Zh3CArCld
    W0lJdTip08HSUeu26HUupCVYwBo6sGVVaIL6K3s2wEhnMuk76hTpRyDGH5/2dKUS
    OYKAcOFN8uTPhOqkQUBcceFVMr7xu2JGeZKizhYn8HD9xz82Pyvaa16aUch2yEUJ
    UmZiXlpTJikIuEDIjoAxrOz8uTVgYds2imHX6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490685; bh=7mk7dN
    jFm/D+1YKZYgoaT56ARq3RQ8SGQoUlRzpy2jc=; b=EM31cvNzHSQEugtx8KefJP
    tImsLWpgAhGAMlWdh2xKZoGCisBMpUJG/hUpFSq6wSVZX/oAZ8ioxogg+kaG8/13
    VfoIgHPRdG4Po+pX8OBkXDyA/AJUUNXILOdk/QN5BQ1oP3KLnB2lm/7WhL4rCbcE
    vvmJEWSzy6IuLAweBKbRukOOxX5zB2Gew+E2ytTNp6LJZPQdAeMInXrW1Qqu37zA
    AnGyMWWHhV9yKUxV90I7KfwxEekFpUdOCo2zEGhxRhtbz/dbSprQngz9CVhezSpy
    im2x1saeDhrekbJ4v6vDS/nKjHXX7CTD0flbgg+fsUwUOJggZgxHS/98yMIGbEkg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cFtJSItU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cFtJSItU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966128AbeCHGbW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:31:22 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965575AbeCHFAE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 011/190] scsi: sg: close race condition in
 sg_remove_sfp_usercontext()
Thread-Topic: [PATCH AUTOSEL for 4.9 011/190] scsi: sg: close race condition
 in sg_remove_sfp_usercontext()
Thread-Index: AQHTtpoo7J/qrOZoWUm+2bndKOo6Hw==
Date: Thu, 8 Mar 2018 04:58:54 +0000
Message-ID: <20180308045810.8041-11-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:tg4fMUJECG+rHMLGFYJrMgvQrET04G0YZdU3LrbFDXv6SAMct91cwHtsZY2SH/ScKOdzp+YVX5gqklXaWVdJ4Lqwys/YhojN05bw0NFfEQLAGQ8b3s8/RI1Xk8gOFWcL0A9v21jc1HQViaT1Zs8f+TczoEF12UwShCWykG5SzpXruGsvUKveRV+0gjsEGyDq24wM6Se86qVFOpwrAq2nCRG7xF4eTatKikC8GDEXa83fsDRc809ToDmR3azvO5/S;20:mnoTfUb2CSMzszARxJR2fyg9io0u0pTG47uJImLvjUXpeNduZTWbLMea5S5gO+1E729WKsTJmZhlfHQb7U8xGiO8WT5fJL5i7mQGzRv9CLtRC2eoc721Cs9j8B9H3vJLdtUS5bQQ5HvZ1ev564VwwV+uvTGABUF5ApX/gA4Tch4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea62eb8a-6349-4589-966a-08d584b16f8a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920F2D519C2C77DB7C78B74FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: IjzcKVNfH7OY+dbeQcHUAmkxXrMiNQVky8fJvCpNlorsqMysC3r1w5+kDMUSIwrhu4GFRfR76lkYl7K2pqR4Th1jkI+g+1CFjXec7PVmb2lva+ydAePsl8oc/yY1gjddSLNu4MKbg8mxF8OdjvOAAu+CWb48JmZoe4gEQ0srkhoadoEffULKmHQcqlCA88AIfcRgiRjeRIxtRXuxQ4s7BBFvl4w/Xgyb6ZMi5U6JjpbjYPUDFHK/vxXG16omBLNQFWV0KSwO9R9sGv4FqK4oMA91Muopp+IZMYGIGUwkJSy65H8hUeeIGL/J6Lh6VXeiVdpAaqZcm18PgUZBBz4EPw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea62eb8a-6349-4589-966a-08d584b16f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:54.2508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 97d27b0dd015e980ade63fda111fd1353276e28b ]

sg_remove_sfp_usercontext() is clearing any sg requests, but needs to
take 'rq_list_lock' when modifying the list.

Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/sg.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 6b6064dc3467..e6333cae8550 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -524,6 +524,7 @@ sg_read(struct file *filp, char __user *buf, size_t cou=
nt, loff_t * ppos)
 	} else
 		count =3D (old_hdr->result =3D=3D 0) ? 0 : -EIO;
 	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	retval =3D count;
 free_old_hdr:
 	kfree(old_hdr);
@@ -564,6 +565,7 @@ sg_new_read(Sg_fd * sfp, char __user *buf, size_t count=
, Sg_request * srp)
 	}
 err_out:
 	err2 =3D sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	return err ? : err2 ? : count;
 }
=20
@@ -800,6 +802,7 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
 			"sg_common_write: start_req err=3D%d\n", k));
 		sg_finish_rem_req(srp);
+		sg_remove_request(sfp, srp);
 		return k;	/* probably out of space --> ENOMEM */
 	}
 	if (atomic_read(&sdp->detaching)) {
@@ -812,6 +815,7 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		}
=20
 		sg_finish_rem_req(srp);
+		sg_remove_request(sfp, srp);
 		return -ENODEV;
 	}
=20
@@ -1302,6 +1306,7 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 	struct sg_fd *sfp =3D srp->parentfp;
=20
 	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
 }
=20
@@ -1846,8 +1851,6 @@ sg_finish_rem_req(Sg_request *srp)
 	else
 		sg_remove_scat(sfp, req_schp);
=20
-	sg_remove_request(sfp, srp);
-
 	return ret;
 }
=20
@@ -2194,12 +2197,17 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 	struct sg_fd *sfp =3D container_of(work, struct sg_fd, ew.work);
 	struct sg_device *sdp =3D sfp->parentdp;
 	Sg_request *srp;
+	unsigned long iflags;
=20
 	/* Cleanup any responses which were never read(). */
+	write_lock_irqsave(&sfp->rq_list_lock, iflags);
 	while (!list_empty(&sfp->rq_list)) {
 		srp =3D list_first_entry(&sfp->rq_list, Sg_request, entry);
 		sg_finish_rem_req(srp);
+		list_del(&srp->entry);
+		srp->parentfp =3D NULL;
 	}
+	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
=20
 	if (sfp->reserve.bufflen > 0) {
 		SCSI_LOG_TIMEOUT(6, sg_printk(KERN_INFO, sdp,
--=20
2.14.1
