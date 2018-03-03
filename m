Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118043-2-11309526290983548976
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
    t=1520118042; b=RpUjwuPYlyY1w7A3TB2f2JB4+wwHuYz6R6yfTq5kooaBH8R
    k2OWmlT4YaamQf0YkzSE+TBAKeX9FLDqXO0+Z//lNUfcqFoCilYP34fVj9Az+bv3
    LNX6uUl+7Q8V8CixlxqZUwX7zWWFBNKwiDP31f/mxLuW3vnAwu10DERJjKIlXF66
    Jc+N4zb2wbucem517/vtOie3/jDVV3wQCBJBfen0PTJMhmY17ruGXTjKttQQ6QJs
    GN9Q3XO+XVO10gSd4FwbzliLrjL702eWEOoW76a2ZEnW2JiAxB9hHb1Im70JQwsa
    fCPyPc+1YJBLMmTP+AkGhaDf971xR8covWFvWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118042; bh=yrlfxg
    n6k9m2IooDgwFa1UZJ8tGAK0zbDHkYN0dGZag=; b=tAB4qy02iP+KNUGGYdIqdo
    nDbdkcyYDlnBIZPO4bOs1NkDS6lhhV5h2Gt0gmhNc8z/ULtrWjJ+cdX6g/ZNtuf0
    wkqtAwfuIp7UumiLOGFC3ArNvm4+VWcnsrNh45KpMV/D8mJGiEcUla/vkfiQECLz
    jql8nXvKbLRvLsonvkpGJ+kCP2ARIP9Fu92FvI062L1AVs/XPzEdN08jXWXx2W2W
    SBTEErdHuneDVUbC5xAFT39cd2x7KVu1Jxp8XARMR2fCQ0N/qc+hcUY+IkkZjnCX
    DEm/RT78KoRe8JatHHal+Kz67BILPcJA9b5IctJEDXfsbJaPWfA5BiGOByaH4Cyg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eTA2c3SZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eTA2c3SZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933048AbeCCXAj (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:00:39 -0500
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:9680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935306AbeCCWkv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 103/115] scsi: core:
 scsi_get_device_flags_keyed(): Always return device flags
Thread-Topic: [PATCH AUTOSEL for 4.4 103/115] scsi: core:
 scsi_get_device_flags_keyed(): Always return device flags
Thread-Index: AQHTsz9smJmzFfB8qk2heBDcPKR/MQ==
Date: Sat, 3 Mar 2018 22:31:50 +0000
Message-ID: <20180303223010.27106-103-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:JA0pAy5ERQXQBlgy73HyNX9myBCCzPl4XLrnS0JzSqHlkhp2slOWyclkptS7xiLPnKdI7N9RoIqF2Vp25IGbCf62YjJJ8Lt0/hQUSYMR2zTyZGL4kd1Y++yb0N3tW8QUS5ZHKe9N/UMqFki5fEN1aE5zWmfDTtSXnHKPu3GJNETw5jxx/JPsZ6DERVW1Scb8EplF1ouBBzsgwhpwQ5GQp9i0E05qZ1BI+nl0uevwnzzN+ug4uwzs6mnu0C34jMxO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec02307a-9f82-4037-4554-08d58157cf54
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0939C89CC9207500EE37A4C4FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(575784001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(6666003)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: /vjMCmpGEWPVo56yhNN8C5CYD8RLhGzC7AVqxZiBRzM7OjiGJRgaEYiZn79aza8vRzQwFUMPkoW6IHqVQVz1x2AirHJYlzyCpbYWqn+Kx4eJrpOnBkKFqrdqgj3D05uFIhF2JFL6p1yKYGyhYY/Zt1JaWNTIenp4wobJdU7Bgds=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec02307a-9f82-4037-4554-08d58157cf54
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:50.8708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit a44c9d36509c83cf64f33b93f6ab2e63822c01eb ]

Since scsi_get_device_flags_keyed() callers do not check whether or not
the returned value is an error code, change that function such that it
returns a flags value even if the 'key' argument is invalid.  Note:
since commit 28a0bc4120d3 ("scsi: sd: Implement blacklist option for
WRITE SAME w/ UNMAP") bit 31 is a valid device information flag so
checking whether bit 31 is set in the return value is not sufficient to
tell the difference between an error code and a flags value.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/scsi_devinfo.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 60720e5b1ebc..74126b8591c8 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -589,17 +589,12 @@ int scsi_get_device_flags_keyed(struct scsi_device *s=
dev,
 				int key)
 {
 	struct scsi_dev_info_list *devinfo;
-	int err;
=20
 	devinfo =3D scsi_dev_info_list_find(vendor, model, key);
 	if (!IS_ERR(devinfo))
 		return devinfo->flags;
=20
-	err =3D PTR_ERR(devinfo);
-	if (err !=3D -ENOENT)
-		return err;
-
-	/* nothing found, return nothing */
+	/* key or device not found: return nothing */
 	if (key !=3D SCSI_DEVINFO_GLOBAL)
 		return 0;
=20
--=20
2.14.1
