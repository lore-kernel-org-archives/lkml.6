Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117293-2-8658727685728522807
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
    t=1520117293; b=AyyPo+b0t8YfksL+UFNq4g8DopuYiysE1Y0PqLsX8fFUB3U
    cgdVDGYDFPQYSaigJaAdkQJiSZdUgM6Q+OHtynUwpRuikS6tdBUilDc2TjUCfdkH
    Fq7kU6pz9XI/ILaykSrTNcpMAju9BQaImWhHUK7kQ08JHBBcfcrqF/Z1JXOuv2/N
    dFNcelcgp2Y/qMRTYv6xh1/S0FxDLvf/HzBiMZMhCRFLRaWni6F28iWx/0iTtZAa
    WTDR2ADG/9DLDuf48UpSysOETrW9zMbf86t3iO31BYiAeU9P/MezEr65kJmvWmA1
    KeHo4szQSNnSZBXX2F5QBbSQRPDTLtHeZmnyUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117293; bh=wZRs+6
    srg5qn1ZDoIIpH/26Cw+sHMvZVjup1SQoWOkE=; b=e1/80h7+1CX1/y87W9uizl
    TiSCVc5jQKwN2GhtVYD10KHFABJewvub7tzkX3b1NPK9/7jXH8KlLyYy3Dd+4Gq2
    tZGNkmPFD3EPGMtSXUGEDRa2RcxGeNv5AJJ2eH/cAhN7MLieq8FYgTael72A+36j
    VDepDowBADajZ/YhRUydIg8dAl9kRfMLCbkc+DmUChgzL8tB6M6HRermGtHKXU+p
    O3QmpGQnXbGpJxna/971XtXEWcL7KtTKPAskXJLq1seZ7l0NMaU+VwH4stm5aJLK
    59kasUFEw2iRnvqe8zGvgmBKTxJ1UTT/l5eTPiG08nedgFpiWDGJWeleQzPldtuA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JKwwZScQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JKwwZScQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934154AbeCCWrp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:47:45 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:28704
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935520AbeCCWlw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 43/63] scsi: sg: close race condition in
 sg_remove_sfp_usercontext()
Thread-Topic: [PATCH AUTOSEL for 3.18 43/63] scsi: sg: close race condition in
 sg_remove_sfp_usercontext()
Thread-Index: AQHTsz+r2/wJT72oCk+suPi8qlI97g==
Date: Sat, 3 Mar 2018 22:33:36 +0000
Message-ID: <20180303223228.27323-43-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:1EMZXktmOQ9NGbrB7tC8P5aucAAvjFCj6GfU1fI0arZcszaEASir3FPcJi54KWuIKcZTCy/ivqoJXb9YmXE4BPFlzQKaejV3A5PmVIqFCKP1pAKuo/jDrjN7CRYNIcPMdJrsNrA9IbfHaN1gYT27/odFja2OgqdlHeDMfqgNPtYJ8lEWq3iEUdcE9Y0jK7DClpsVyXAZM3M3MK8eZitQltRBCddQVnDlDolV8NIDqdX9geBNwBYU+VBXsJhVrJt+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef7fa31f-85f0-450e-f0eb-08d58157f4ac
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06B7C42E81FD6A41CCA041FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: rh4WqzxnUyQiR2MRH+N9RUqkhg5xRIvg2neWEt4Ldy/mhUPCxe5ypOOu3Zj5k8AgbfLTF78AeH0rqJlLLWKOO97EaPr9a5p/Vzl6RROoAWyX0rbzggYlkmePrSsn9QrkVivTl9xUMXJHlvJy4pKYThLJCPy5fE1g38PgLU5jZqs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7fa31f-85f0-450e-f0eb-08d58157f4ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:36.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index bba2dcd4f324..cab426720144 100644
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
@@ -1353,6 +1357,7 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 	struct sg_fd *sfp =3D srp->parentfp;
=20
 	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
 }
=20
@@ -1902,8 +1907,6 @@ sg_finish_rem_req(Sg_request *srp)
 	else
 		sg_remove_scat(sfp, req_schp);
=20
-	sg_remove_request(sfp, srp);
-
 	return ret;
 }
=20
@@ -2250,12 +2253,17 @@ sg_remove_sfp_usercontext(struct work_struct *work)
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
