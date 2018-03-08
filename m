Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486443-2-18197382113051592251
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
    t=1520486442; b=T8u+0Fztkh/5OSLwlf7IOzKnduKWHRXE722nUDFySvz1A/L
    pOEw5JeSHjJ3slYt6rPRUv6cwiSE8++31UXwoV1pAiP9v3FDP+cDXrt1kSswuSCa
    Y7j3SyMoGK2kV8AWDDQ0PC4Nza5+22Jx4Wd1zwQ+jG4Bnels5P/MFnj+WW0Jjdn/
    OUwaMVozjLliFZtbAOKUy9mrhwRoC3UvKR/Py/M2TlPBuBp4VKxAmos0jt6suUkw
    UqIyHDKunoaTkDVg7JTuDfWC8on/LVc4XGVE5BBwN0e8i2vF2MBX3ASxrKeKqTFL
    Z4fLDv+fxGOabZ6f7p/Cf+pvgB6x0Et+R6Kp7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486442; bh=wZRs+6
    srg5qn1ZDoIIpH/26Cw+sHMvZVjup1SQoWOkE=; b=j7Mba0eSeRzi9RMNpX5Jql
    qFR2OCfM6BGAkTOhp1jUfrCHVQfNilq4V4oBgJl4IQekAahGKWHKzAh1MAyfazpL
    BoEAQCuIEwi1x1+gic2xSA+JjXmDD0RIkWsNxPvGJW3qUzFsCZpoVrz8zjAVZeW6
    Oxdhl5qFycyFfSbfuXXNOhwHzqWod9GkJIuHxquPFrRaxMI5LxHCuFwYC07/1YSf
    J5XjMQih46c3FQj+9AvtOgYcdAiP6/ygYofKSocZTr5kXieJykdRDXWa5x2ZIndw
    +IDzboDj7cwvkndpo2Suf7tVCupHJdCE3o3duaeOWEg5ft4OUbZ3dMdZM6Um+NWw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R5OwfnN6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R5OwfnN6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966096AbeCHFUK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:20:10 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966705AbeCHFII (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 04/53] scsi: sg: close race condition in
 sg_remove_sfp_usercontext()
Thread-Topic: [PATCH AUTOSEL for 3.18 04/53] scsi: sg: close race condition in
 sg_remove_sfp_usercontext()
Thread-Index: AQHTtpq+3Uv4LuhYE0yep0KdfxwJyg==
Date: Thu, 8 Mar 2018 05:03:06 +0000
Message-ID: <20180308050230.8876-4-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:KusW/8BYmlkJSd1SN+Dx/7KuzTLb66lGnTylgeds5AIOO/O4UsghSM9gK4iaxbKaIS6JfFb+5TuVBjQEcKV98npsjR79itj27JTdzsPfCceFz8oIYdYUeUOWbncyiJD/uBfCXAoRvDt7pS0BpYGpYs1gY7jTqQGbUlZGapOfkYjV3EQMVuLEyLsM4RMCmrl4iRCTQyvHqdh0zFMJGyHdfpQbNnzJM7CxTjiIBaSDS/h6DjeBwpMwy7p/6pF1FyBg;20:EWisvd+85J51mtWrrRyj2Vo8biCFHzE8m/H4wsi56hcS05abVd3tYuKnVqbiKYeqgrkUp7Dr7E1XFoJPvBVjPRkxYJ6p7/Sw0uu+8g915JEwCBCILtqlaCgEm3UtvXw+V9xeYSn/hML32OcSmPfwIGxPi3IJV4eYRtTKr4ZH2Dg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e50d9fe6-9b89-4897-9d63-08d584b29149
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727B96ED3D289E2C3275350FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Pp6CgWBDsYwvsFB46cz7d3FLTuUamiMKi28QGPdwUZG/jBvAvPT7mbD/MLEIEo5jkJ+hoxbqF2WwSH45JHvDw5kh92og5ovOlJf7d0O4FzYpFVDHzRY+rvrqiXFAeUWNwapTIhC7sYJetBBbDrxn03KWAzBfuklEBuGfewXBoXV8PnzpXspEvJ93Aq5nEUMZRx+2bISTE1LHaS5WdEo1ZdCXliy3Ph1bHuh71d1man1ulrAK86Zn0xzvp9Q7dslN5EBabDdJ9XkvtwRcDUYn5rWOrvv3Wcv9R14R1fZBNhPhTueB9Pu1F5Edw5HfEokmV+NZmH9NEP6dEpaVU6YaTQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50d9fe6-9b89-4897-9d63-08d584b29149
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:06.9147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
