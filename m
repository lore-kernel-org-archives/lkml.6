Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486248-2-13605106704690729683
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
    t=1520486247; b=HvljcuE1TjQ3lqTcVayVmSBYO++HjPS162OcDgSegTOrCA7
    mXcO4jAdTLtZd9LfnUUH6+8Lh/wIvVbUxXY9fwcHML9Q8JJGMaakWhpdEwfH/H9O
    nxlgqvisL7KhKMEZu7c62XBG1HQqMsyOhGgX9XlbcsrAmsk2VEyOV55kicO2/Drk
    ljGbwY85SBrmCVMUO8BNwLmfVmRiz6R4Ce/Z0MHdj/5KgqHg7P1gfJ1MsCrAG4Cs
    pwwq4CJROQX80U/BmmW8Uak9HkEc61ovJJpfaCr/H2KhRhFybg+mnwird6+LySyQ
    k/QuKo2LJgjNhDuFqEWJGG8hNU0zwOoVfTUuQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486247; bh=YCkAZc
    cCMLHr3zFnWkHFagOgSS/W5J9eKkuOuOdjhes=; b=QEsQHxIcHDOh1LsJJvVqSt
    dS1jp9mQy9t2A2LLKAwtvdnZFZQLQQELHZISVJbGREdXSTPyBwMqlDNfki7O7gTj
    RmgRLbmyM3ac9HPC7WpbLSbmRIzDHCIfDJyWGc0s58qzsFO+X9B66nvmNOvYMCx8
    vAc5wHpTunk9+ARkr04BXtK93UEuwu1B9LsSifWHioGMNMxDOf1KIUxHladdlyTK
    n1ZXjgqkr8o1+289AM/572PTusuP7MTUrgT6EdICKb/D0oDch9tZfBFpxCJCKyFa
    tVLwlOwUz+QdvEwnabgpL1Lx9NsZcyXcuOHwrRkY74PyWaEKcgEYFl229linU/Dw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i06VjNbV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i06VjNbV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966788AbeCHFIt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:49 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:62624
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966763AbeCHFIn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Gibson <david@gibson.dropbear.id.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 19/53] scsi: virtio_scsi: Always try to read
 VPD pages
Thread-Topic: [PATCH AUTOSEL for 3.18 19/53] scsi: virtio_scsi: Always try to
 read VPD pages
Thread-Index: AQHTtprDIq6oJfHqFEChhfKI1a+WqA==
Date: Thu, 8 Mar 2018 05:03:15 +0000
Message-ID: <20180308050230.8876-19-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;20:QgzHkFVM3ToEuuRN8cb6EF6GelV5yQCEzix/Wh9klDXnQgp/yZe+RwCt6ffKwXZbHDKbTWMPtELJSKFMHAZ3btrFU9PqMGybtKseXORCJIuqO354WmZJ2gcsNd/IWG8YK3jBUbPdGAM2gWbyk3BPn7rK1cHFQ5lWhipKdsBZ/1Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c656db8-533f-4d62-052a-08d584b2a82a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087107DE1104BE093B9CC8B1FBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(5890100001)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ikiSOm/GhgtyfQsXegATYrQBDcdLcMEgiKy4+0RIlZOAV/mruBjhjpWwfYakUx+V8SXqq6NDpwP6DEIW1GsS5Rpkp4un3zg/PbWXx2hKPrzCq7YaS3XIqT+ZTCVWW9wDdDREY8M5nqTYBD9sm2d7TW2n68oQbCC1m0OOILTOo+5bcIFbozd+qLBqCc5vRXaGLW1bGLYI82TxeufJg3e2kmYxrARrkqBXkRRHUGKYtFhcDTOAsl5QkUezOzGPMPDANYTrB73dIyuDQkjAEgiZqUUmjSW5EFe/vwgHdsx6is0WZSJiEbWrh+ZHdVfvO2OpcEEucJhS5kFkVqkneBk7Jw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c656db8-533f-4d62-052a-08d584b2a82a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:15.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Gibson <david@gibson.dropbear.id.au>

[ Upstream commit 25d1d50e23275e141e3a3fe06c25a99f4c4bf4e0 ]

Passed through SCSI targets may have transfer limits which come from the
host SCSI controller or something on the host side other than the target
itself.

To make this work properly, the hypervisor can adjust the target's VPD
information to advertise these limits.  But for that to work, the guest
has to look at the VPD pages, which we won't do by default if it is an
SPC-2 device, even if it does actually support it.

This adds a workaround to address this, forcing devices attached to a
virtio-scsi controller to always check the VPD pages.  This is modelled
on a similar workaround for the storvsc (Hyper-V) SCSI controller,
although that exists for slightly different reasons.

A specific case which causes this is a volume from IBM's IPR RAID
controller (which presents as an SPC-2 device, although it does support
VPD) passed through with qemu's 'scsi-block' device.

[mkp: fixed typo]

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/virtio_scsi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index b83846fc7859..a85b5e6574e6 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -28,6 +28,7 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_tcq.h>
+#include <scsi/scsi_devinfo.h>
 #include <linux/seqlock.h>
=20
 #define VIRTIO_SCSI_MEMPOOL_SZ 64
@@ -664,6 +665,28 @@ static int virtscsi_device_reset(struct scsi_cmnd *sc)
 	return virtscsi_tmf(vscsi, cmd);
 }
=20
+static int virtscsi_device_alloc(struct scsi_device *sdevice)
+{
+	/*
+	 * Passed through SCSI targets (e.g. with qemu's 'scsi-block')
+	 * may have transfer limits which come from the host SCSI
+	 * controller or something on the host side other than the
+	 * target itself.
+	 *
+	 * To make this work properly, the hypervisor can adjust the
+	 * target's VPD information to advertise these limits.  But
+	 * for that to work, the guest has to look at the VPD pages,
+	 * which we won't do by default if it is an SPC-2 device, even
+	 * if it does actually support it.
+	 *
+	 * So, set the blist to always try to read the VPD pages.
+	 */
+	sdevice->sdev_bflags =3D BLIST_TRY_VPD_PAGES;
+
+	return 0;
+}
+
+
 /**
  * virtscsi_change_queue_depth() - Change a virtscsi target's queue depth
  * @sdev:	Virtscsi target whose queue depth to change
@@ -752,6 +775,7 @@ static struct scsi_host_template virtscsi_host_template=
_single =3D {
 	.change_queue_depth =3D virtscsi_change_queue_depth,
 	.eh_abort_handler =3D virtscsi_abort,
 	.eh_device_reset_handler =3D virtscsi_device_reset,
+	.slave_alloc =3D virtscsi_device_alloc,
=20
 	.can_queue =3D 1024,
 	.dma_boundary =3D UINT_MAX,
--=20
2.14.1
