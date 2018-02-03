Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682006-2-4531011084699289906
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682006; b=FIKy6TPz1zcGdlIY0fPM2wGp6Ra903zW1zv/JN7CtoThB9A
    7hDaYmH3niHtaxcYQmUlFCdAQV5xK+k98Z3gtf7NITjUMDUL8SV4HE2Swiov4173
    pYrh9J1bTruE8oNWt1SMCb4w9d6uxbIkYnIwtQe1V/E+4vo5LQ/eYEUX+7VZGA/3
    mBLeP5IAJbOPIEZOsPwlzlapqtLE+zvkLshgtnVV3CGH4RV0ZDyN3og56wKnt1aB
    2o0bUDnlzlSktAyoM4mU7GLSubSa2vdDZgq0PJq3KIP4l7QTsnwQbeE9e34/6Et/
    VxxQp9FxxDW150jze7Ye3Pdi0B4jdpAL0oKdutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682006; bh=K0/BeI
    IIMGSmyqBE8XqkWy2cj+I8JB78LxEQUyLGBFY=; b=V+RbgA2G7S/RQLDjULOGWx
    43i8G4/4+jVDKDz3X0/sW0PnlpYv96gV4SaGihgwe2GGDVns09lmx2UaS9u/YYby
    nunkOW4M9Dh2F4pB2Lb8u5vvFBDGVShKNxDod3Aubb+k3UuXNt2Nk3GtrHGgQ136
    5qFCH3ff0wGQLxYVKvYBuiOytTr+YuHmnqHWQ0ygYn/NdVSo+5GPm7RGpReMGy8C
    FUVrtSWtW9hXr/YFn9+cmvf/f5YnsH+OyrDHGZRi56syBdsaACuTcf1EEiZZlst0
    ceecE9I2KNi48coah8TawFID3tJgVwaRENgmZDN2Z2fgvEXN7PXljwxqW1TwV1BA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bYnLZY/u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bYnLZY/u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeBCSUC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:20:02 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753486AbeBCSGq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Cathy Avery <cavery@redhat.com>, Long Li <longli@microsoft.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 07/24] scsi: storvsc: Fix scsi_cmd error
 assignments in storvsc_handle_error
Thread-Topic: [PATCH AUTOSEL for 3.18 07/24] scsi: storvsc: Fix scsi_cmd error
 assignments in storvsc_handle_error
Thread-Index: AQHTnRmCHBls5cJfmE+NOScg0Rvcig==
Date: Sat, 3 Feb 2018 18:05:01 +0000
Message-ID: <20180203180444.10801-7-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:RgfcNcG4hV1thDht0F+KgbPJrhtTQdaqkR1b7KSRbL43iiMJVJWsFp8kp3XrYr/VpTuO2HH454OEg/oUn/JNn+YeTQJThr2b8kL1Y17BxjCV7ivMkIvj6lIddSqaPP+p3LSsqCI8bUHH0Cv4UxkIyWEnD7wzC6uBOn/dWeXcCite23KAdz2Qmo6QPQlQcl4uMsAW6m9XuQZ+UntCwMJWfPX81x3auf9GhaNPE5Q9TxYqzHfc/ZnUwp8mbd5UafIm
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8bcb9e7-1c06-4fc6-4f67-08d56b30de0d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB09935E4D89FF60DDBB55D8D5FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 0X32dZA46F5quMdG4zLKQ34spWKj2QgoYbzRM8l46CzccBvV7YQM5z/HucZ8Kzopg6P7G+NKTA6D2yyWSislBg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bcb9e7-1c06-4fc6-4f67-08d56b30de0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:01.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Cathy Avery <cavery@redhat.com>

[ Upstream commit d1b8b2391c24751e44f618fcf86fb55d9a9247fd ]

When an I/O is returned with an srb_status of SRB_STATUS_INVALID_LUN
which has zero good_bytes it must be assigned an error. Otherwise the
I/O will be continuously requeued and will cause a deadlock in the case
where disks are being hot added and removed. sd_probe_async will wait
forever for its I/O to complete while holding scsi_sd_probe_domain.

Also returning the default error of DID_TARGET_FAILURE causes multipath
to not retry the I/O resulting in applications receiving I/O errors
before a failover can occur.

Signed-off-by: Cathy Avery <cavery@redhat.com>
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index e511e3406cfa..96c6e75bbfe6 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1029,10 +1029,11 @@ static void storvsc_handle_error(struct vmscsi_requ=
est *vm_srb,
 		case TEST_UNIT_READY:
 			break;
 		default:
-			set_host_byte(scmnd, DID_TARGET_FAILURE);
+			set_host_byte(scmnd, DID_ERROR);
 		}
 		break;
 	case SRB_STATUS_INVALID_LUN:
+		set_host_byte(scmnd, DID_NO_CONNECT);
 		do_work =3D true;
 		process_err_fn =3D storvsc_remove_lun;
 		break;
--=20
2.11.0
