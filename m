Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490142-2-9031575872551970066
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
    t=1520490141; b=vlKWsSP/XSdgMaM973dmc7oBZ+bzRgwo6FpUdTCapoHiMht
    zdQis4hJOSzziA3VdywktZ2gHj48/2OSd3TRWu6rNQUnO1ZxB9KVWO8b21dc63s+
    iXkVjqrhOA93MNgIKXqcquRsoY1Bou/xThPC9+GgofBGWR3fsMyMExEw+n44KqfE
    nqznWmPM22+RZl3KhOXv4HssetiHFG8aZGV7u6Lr516CXgPEe9hbe42GV8AumFCA
    6/MXvrZXji3NQ1p9rO6tXVAyQPeXxWKE0SWP/JnhTNsJ3uUCRoL+GN6rUk+Ym6+a
    RhE8pWTq2wVKeoABbno0aOapVOi4W6gwgl3IvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490141; bh=EAmC4R
    PPl1/KWkvIXxlVVHxqPlv2F/XTSY1sEEVHh2A=; b=Gdkysnq/GSQh1NZr9cMyGu
    KMB42FJzulRT+UfbSAi8XVYlAc31HwJGkK25laH6ANHmPE7lavFJBMW7YxRIX1Gg
    OgQAjR9p0BZl1PCiFBDv5XaWyDxCMvsgz/rZmmzYvdQBjsJg7Qmq/FFWX/OhWltK
    F8PAljmAhml8Zu23Rpc0l8jGBUQ0MpbDwLG2DYb8CVjysbORCmQe94pvSuHZa7Kg
    Bl+TsWY5aFYPNwlN7dQGPXzLAtA6OuVIVqdlc5Ok1WVwHttR1vFILsGcn/ZyqyFr
    B2OMCfu/jw3di5a9XfRof85+r3V8L9XiBMdhG3TngKmuJDBc62wDUh6f/cN3FpRA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OgU+GAX4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OgU+GAX4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935211AbeCHGVw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:21:52 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:45505
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964793AbeCHFAy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Gibson <david@gibson.dropbear.id.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 049/190] scsi: virtio_scsi: Always try to read
 VPD pages
Thread-Topic: [PATCH AUTOSEL for 4.9 049/190] scsi: virtio_scsi: Always try to
 read VPD pages
Thread-Index: AQHTtpozqPmr1ZmJ1ECH4YzV/xtnhg==
Date: Thu, 8 Mar 2018 04:59:13 +0000
Message-ID: <20180308045810.8041-49-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;20:4bHSBqsg7XYoIbqdm5wqK5fsCyUnKY3apkpLx60O0d6fQAfwDnwfljuqDU2pBm2/Km9cD4JUy10Z0EKax7Cp2AfVpt3l3qfaqKDl4lU/4D/lIU6f6lzaxjOpXjKcIzhlPARkAUR3jbz9qPww5fR5w46su3TfjqpYRZ8x5uFcsWg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bb93694-dd54-4bac-8754-08d584b18c69
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11092B36EFC566022E808049FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(5890100001)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(4326008)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: XHQtUXnmoE5zot20ovp6UHCLAa+ONgXSLxDwE0nRHmC6/MtGrFxghRH4BsmOuQI1ZQHlT4DlKcCbLkW1QhljpMxMAJ+B5cfSlDHSJ0IphIcCqVkdHIXKb4TflQ7WaHPb7Vjpkbvm4hSTynvR6jBsp5mVSFy8aDFdXYuWrEqu0qKFMfXHYRRgmVZzwhb+OUFNqoUl2YXO20R70DwrSbxC3H4w3oI9wkSnpBFFZ/UTC9NkraRUjNmA8kKDCkwCz0zeQYNN2wzUV3GeM3jMfvs4TsI4LiHXFIrSbsQzzEXXvebKIdEPBsOIFgj+TdzBv4aHz+u/Lc+hRx8ZFyc6qfjcYA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb93694-dd54-4bac-8754-08d584b18c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:13.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index c680d7641311..8f4adc1d9588 100644
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
@@ -705,6 +706,28 @@ static int virtscsi_device_reset(struct scsi_cmnd *sc)
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
@@ -776,6 +799,7 @@ static struct scsi_host_template virtscsi_host_template=
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
