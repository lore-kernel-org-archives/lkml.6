Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118451-2-10215455749737051717
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118450; b=S7qSUqEq19rSiFU9ujIphZPaTGr2ug8SxLMpKt15l1LF3wQ
    U9JiIkwGxzJdaoGuXW8wNg6nT6U/3s+EaWVk8EtPHPWYHd3SWf1Fjjmf6ou/o20h
    W0NcRZwcQFwwq4EHnG4UWFhszXlPurQnuWYWkatqavZiAhNs/1720u6SwX0tUfED
    zTcq/Gdv3jwUyatpcrZiB5VBIuMnZAhw9HxMA4P/ZHEr/09CpEEnAJ5/S+oIUej9
    Rk2dpC8TrIoYT8Ua4vlRrFF6i/supZzdzD/PhFJxorRCY/r7udcaurSkR8HDyL99
    B2aHYR1xK9R9dhnc0o1iYCesBZx8CirGLXTTQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118450; bh=An1r8B
    TK0ckusMnCGRiBRst39xfW7jSS/ooViELnpkE=; b=WOZlfw9XWnE1hpaCrWpI8s
    VLl8p82iknE49HjzN3TRd2JDDDwLVplTPoRrmV1hE1zpD4XLV0HfXgnDPQRg1LeA
    ULjO/PiAgVuWoHjwM3wjOUUnBhInTzEPe3SBNnTQZY59O9cL0lK0sK5ZwvHWUzdT
    xAO/YEFCnSvYP4fvrSNW1qLddIWBV3z8ddLMaxMpc/piMX9efW8O9v2+j+e2VQI9
    lvKQDsU5KNvrozkctZiqD6vShH/imjEzMzEWBnqXle3Nr7wRKxM6O4c13HCac88d
    LsGUNIWgmobYSrkyS3kTJz69BmR/S1XQIbi4f58/tVU0gwST6F2rTGEkkv6kewig
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OzkH/paL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OzkH/paL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeCCXGV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:06:21 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:62880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935185AbeCCWkL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 079/115] scsi: sg: close race condition in
 sg_remove_sfp_usercontext()
Thread-Topic: [PATCH AUTOSEL for 4.4 079/115] scsi: sg: close race condition
 in sg_remove_sfp_usercontext()
Thread-Index: AQHTsz9jHoKusSIcEEuhvZfBeIKuhQ==
Date: Sat, 3 Mar 2018 22:31:36 +0000
Message-ID: <20180303223010.27106-79-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:PdjQJuRc25cJOaJLI73DRoUFPD76w4JbUAxPLjVQe7TQuRo5yLpIEn9BSusoU/DcyXc4DwgN+gTlU55YcfWbyn7EwgqvaEuoBLe5GkdazouVebh3sRIKqZtR8Mvd+KgR4j7ZmkZEyb63+slaQd0qts7PPIr2vTghRwfGvWGQgql0iDN9wzNAncJxXToy08IuoXnrn/QWz5WyNsxNDfNh4g4PT/JiM4X2tIMtQiApZq+7JsOx3uvQ3PyeFNIb/lJg
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2242a27a-afcf-4c56-e6b0-08d58157b66c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103348D40DAD9A825D24C2BCFBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6512007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: lgINJ9TF7B8WcaJvIdHs6HUMo/x7hs3mcHu+EjkqClDvwxmVnMKjIexzBzdgP7tFJ/Bkwnk0fi90siGuKzNqFPX1QWbbspsWTAHuUUKOISAnBggS9q+iMhg8y8WbnjSML9LqoYJVA2nPJH8Z7Sh6ggMg5na5VFBFqTJ+joGC11o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2242a27a-afcf-4c56-e6b0-08d58157b66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:36.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
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
index 27f92f4ea6bc..dedaf3e89bb5 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -535,6 +535,7 @@ sg_read(struct file *filp, char __user *buf, size_t cou=
nt, loff_t * ppos)
 	} else
 		count =3D (old_hdr->result =3D=3D 0) ? 0 : -EIO;
 	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	retval =3D count;
 free_old_hdr:
 	kfree(old_hdr);
@@ -575,6 +576,7 @@ sg_new_read(Sg_fd * sfp, char __user *buf, size_t count=
, Sg_request * srp)
 	}
 err_out:
 	err2 =3D sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	return err ? : err2 ? : count;
 }
=20
@@ -811,6 +813,7 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
 			"sg_common_write: start_req err=3D%d\n", k));
 		sg_finish_rem_req(srp);
+		sg_remove_request(sfp, srp);
 		return k;	/* probably out of space --> ENOMEM */
 	}
 	if (atomic_read(&sdp->detaching)) {
@@ -823,6 +826,7 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		}
=20
 		sg_finish_rem_req(srp);
+		sg_remove_request(sfp, srp);
 		return -ENODEV;
 	}
=20
@@ -1312,6 +1316,7 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 	struct sg_fd *sfp =3D srp->parentfp;
=20
 	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
 }
=20
@@ -1856,8 +1861,6 @@ sg_finish_rem_req(Sg_request *srp)
 	else
 		sg_remove_scat(sfp, req_schp);
=20
-	sg_remove_request(sfp, srp);
-
 	return ret;
 }
=20
@@ -2204,12 +2207,17 @@ sg_remove_sfp_usercontext(struct work_struct *work)
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
