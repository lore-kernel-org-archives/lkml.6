Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487610-2-6222471304755098049
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
    t=1520487610; b=LGT+7pzeVTj2MKByh5V61wd3lRxBwHcNEfXhmZkf+Ev282t
    C6vBV1dAwKS80N+rsb3d2y8ata2Dnso/ZQo1q1wSsBma5aKZr0JoZLijJ1ZS7znV
    U0acYp+Nf/WFeCm7d0VyoNu97V42iXW+edjaXQ0Qe07scgnUHNUPfpm9tsWyZdbn
    IUNiXXC3fgYDgbkrz0YGAZeqs5GTjiWukJMwuUzDJ7y/jXLIrwoMyKyan3PLfbXC
    S8ks75fMnLtft//xnMdDPwtF1rmm6M2A6DMLSP+cUEWu8cJICF4vjFiDZWfoL3EO
    9l7JW4Z9THnL5s49AgLsyc1neIyeWuWDkkC/9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487610; bh=Lyr2Rr
    G0v81SI8GkMBDNLp+X2pZdt8TS2ijJR7PG7F8=; b=qWquDpdRlGJr7L1IOQ4RY7
    WFjD2Uv2EevE2YGKuYhX3Tmxz472H+52WWMqGrJwEFEth50Pj1y/5ofvEmi1zI+R
    CFXjjnXT+Apg9zDzKnSeniUSf8lPPKIb2H28VXfNrG4faOFzoBi0gWwQ3o9hanZt
    SzAzG4ngB2JImOJ8+5hbquCSTTGew9/iGxv8PeZuxLbBABohmOxljqypmbepiUeX
    tMUurVnGgyxACtzkFGw7E3kyphnXncPXfHilISk8Oy33qKwsf0jsjeEpfdU1ksZY
    SZjltefkYjow1HCo1VoZzREZ1H8vcI7vWEl8UWOQCHF6tJYORIYF2wNHzOZjUTzQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zf3y0H77 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zf3y0H77 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966297AbeCHFjz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:39:55 -0500
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:13526
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966056AbeCHFF0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Gibson <david@gibson.dropbear.id.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 027/101] scsi: virtio_scsi: Always try to read
 VPD pages
Thread-Topic: [PATCH AUTOSEL for 4.4 027/101] scsi: virtio_scsi: Always try to
 read VPD pages
Thread-Index: AQHTtpqI0WQXE8rjj06zcEVNEn8IZA==
Date: Thu, 8 Mar 2018 05:01:35 +0000
Message-ID: <20180308050023.8548-27-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:Da7t3ERqgOD/ud7L+ZL/wlFfdeGK/HIILfrmsq97niE+jrAW7mPvM/pvaHZ63YWGw5QBew2grFdG2l2YkdTEdiBBoohLOPcJvb1dXHLDjrmjwlQTr1nNrQKAidQrO9VnlbZzKFOgkX135WyjGGHvUmLZhsbJo9FAPJbTIGgeRn4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d387058-2ae2-47c6-4fe7-08d584b22e68
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727768D007601C1E3178EA3FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(5890100001)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: EaravYCKZWH/AEEDbfzOUf57gRCyAjXmKQJcsmsN/3GA/GQTmDO5MGdD6UXUBrsXDnKV8iVzSGCtKUdfUxDFVDP29LQY+KLCBEkqFF2QBsl4gSBjWlU+L2h93zQuCmTEqIKkgi8IHbbAcd2gIy4E0/Na9c4BhIJdQchQRvodD9HNGS54MLc/imV/2VH9RYN/pWwRH7Qz8Jpw2OoRVeR0qRM2pLI8kbl1PTvFr1PdZvXgDCXFuU+jAHkavy47b18befGEtUE1MxYF5zdK4QYjjkF33SwO/zYdS3j9VFI/ys4EivIVNE29cSb6pu51s1u37cv57oNsyoukauXOTxYk+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d387058-2ae2-47c6-4fe7-08d584b22e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:35.6140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 03a2aadf0d3c..578fae4d474f 100644
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
@@ -704,6 +705,28 @@ static int virtscsi_device_reset(struct scsi_cmnd *sc)
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
@@ -775,6 +798,7 @@ static struct scsi_host_template virtscsi_host_template=
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
