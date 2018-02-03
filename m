Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682021-2-15763038800335019488
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
    t=1517682020; b=Xh/QAg2PM9kQAm3Fu3vTqlBcb8sRqv8twQGB1W+kTVQNn4u
    iMX/2pdqiRhXgxKRQDVhLq0jImHoSZ0MVXt4w1tVkPzl/ufGDAOFQunKKYsgnUvz
    vnJe/BdnjIX26w4P4aoKZWQpP07HtrUbZWrmoKGYzA8wpCO61m+zdrb3OVSS/Bf/
    Z8XPgyc/zEn+dtvVpA1gexqo5Y8WJTcO848yPLeC0pdYCpYDEl1K4adLDKiVoyMp
    WUIPo19nVRNRZsazKCKA5pxBz7O3KWV/RRD9CJmOUE9NTfKOoScSfq92dn3aE63/
    iAuRQxrYzFWcyZgstm60Ujim/P0m/g8hbZ43Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682020; bh=j0luWy
    /C0TGO0E7JKV/2t6r8vWrIIOIDYx5AeiyF44Y=; b=ni8G0xGniZkzCf+2+1IXgy
    xdqVR/cIyyrEfCRj3jReUSnNZb2LgCK3BToesSN1WHNbJE+L8tgcZ/g9weQyNvUL
    d3DEbOb3s8xdz3WPdbgvj+peUV/d3Nu/lQmUcdoaLV8hkcMlVhx+PUJpwW/j+9KZ
    3S+uIFGnYa1GfEa2o58IVjSYktv4YLiWy/grKVh0tEwbkuzg0Rutb0MMh4L4GCrs
    fVbuxeEJEPalc0A7A4CnOwEZwNEr3UkfHpNPnMYP5yCA1lNdGBCpHoDCON9QLUWV
    x7EmmGKHPSHZz3oKFIELnsW66Yz6w2GlQ61iNyHm0Uex7hZ6JSULuSgWAQXsqk4Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XESNHvbt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XESNHvbt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbeBCSUQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:20:16 -0500
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:63252
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753485AbeBCSGn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Cathy Avery <cavery@redhat.com>, Long Li <longli@microsoft.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 09/32] scsi: storvsc: Fix scsi_cmd error
 assignments in storvsc_handle_error
Thread-Topic: [PATCH AUTOSEL for 4.4 09/32] scsi: storvsc: Fix scsi_cmd error
 assignments in storvsc_handle_error
Thread-Index: AQHTnRlvXi0jkV5B2UiXNGaPWCrR5g==
Date: Sat, 3 Feb 2018 18:04:28 +0000
Message-ID: <20180203180413.7438-9-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:AnpO8g+fUZWhQFtzcVlFwNuLDtJAD8KJHs4YiQCQW56xQbQuX9cfRqalWmdqgylj/ENOOwufnXFHEJc2Ccwp1oDOdqtCUoSlZwTmOPt/ZjFkV9b/SMvBNGoWoE5Fejli2NqZAYC2YHVjjAF7SO9DkcRHoL+K1nW9qMNyYucv5EjAEwSOjO43Xkiwc1B6ETJp1FECggyi2u0ayN4WDAKMQVIzAhCypxMLdzgZFvUz3O8cVcgBfaQCtbT9gT0mBu2x
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ca2ecd9-e12c-49d1-9c17-08d56b30b95b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB108936D27FAC703A620F8C62FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Nz7wLV3Ws5C9Qv1GMOdapjU/RkzLwLCEzOv7gxTeAECdvnwjmWB36kj1MEy/icXfjbMfrV5lzM0eXZqD0c7hQg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca2ecd9-e12c-49d1-9c17-08d56b30b95b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:28.7214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
index 5e4e1ba96f10..351d81dc2200 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -890,10 +890,11 @@ static void storvsc_handle_error(struct vmscsi_reques=
t *vm_srb,
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
