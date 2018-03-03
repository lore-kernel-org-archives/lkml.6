Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119563-2-14035384903428594027
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
    t=1520119562; b=jmnjRiI/fIhtpaD4/PMr2p86L0pm3B1pZ6AYko+Eg1LEUlA
    qivLoaR3kmjgA6Ff/pjrXRmZNDBg3oYH9Nz1d+Pv1gLAZcl+63CWOw9onGR1DLzz
    OMnc4urkr3A1Yh1d3+QTfWcHBX6PpPMYTjgimOBVYEpvm2m/bf8y5nm5WzjnZ9Oc
    o0R8V9Z8H0HxTm5t2RTYbcbn+8HvaHGCRNAT3UlodmKyRXw12awM5SFZNtX+XHY6
    iCWvZrkRcMb9X9XYXKRsKb7+OJso+Qgp7Zdh0iece58+KbEk4N17kZQokdhlbkv5
    o78my4X5SUxgpFTx3rAA9dWHL48EsbSIgw/KoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119562; bh=RuWn13
    lHwHhkhJ/+YHtlf/Vo4+W4mYU3J92S6T3JmIc=; b=e7OIJZnNcv+2mMDVQxWZ4M
    5sK6706TjEqZHaGTl3anbqbdMWbzcgeRqdn3NfS4S2ErHTaMdP7bpWgmVBvdUunD
    Av+xSYhgOuo3n78c8N7nZA/sjBthUvK6xCray83mvc2p8on+Yn9GDbQMvi4y1JLI
    yl1X+fgO/EL4x5Kq7O30S52odmpNi/YMsT2jSBRrE6s8K5jhpEXf75ooZqXGtrmW
    pf9BbNQzKMLplMXu4fU1IlKLKQUfpqL4XUkimmJIVzKYHvcfWZ4JblTlF5slnyYL
    5Xz09ij5LBSt4f6ZicMxTeGC+MhmXF92W2+JSxJMUZWBBEfeCkJyZu/iJ1ooF51Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LnbZ66oy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LnbZ66oy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933123AbeCCXZ6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:25:58 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:23840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934413AbeCCWhI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 204/219] scsi: core:
 scsi_get_device_flags_keyed(): Always return device flags
Thread-Topic: [PATCH AUTOSEL for 4.9 204/219] scsi: core:
 scsi_get_device_flags_keyed(): Always return device flags
Thread-Index: AQHTsz8nvFEeqYPsU024Z2fqc8Mrxg==
Date: Sat, 3 Mar 2018 22:29:55 +0000
Message-ID: <20180303222716.26640-204-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:K70893LONwWFKAjEVVpm/9/gJGssUCdB2EaNub+Cu+fkBEQbJ0MRDWRdNxorXJM9/Y+/I7TKa90Piwut8NGQn6eRqAD0mcOzQUdCqreuHZhRRR2AQkUs7ZzLQR5S7Hu2XQR3FNC4tK7eMk1Z7J42gvUczDf4QiMBuBwHFl9oLXhzYj+zjLD6Tgr0AFrECHp6oYz74WY06IrAnsuTkNOFS0wDFFEbMRG012V4ADsmTwod7KM0gLochZH7TQS5nthK
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68fc52f7-cdd3-420d-1713-08d58157444f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB09693D6BAAF2EB12396BB3E8FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(575784001)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sJxcE+i+Ni52kcoBo4rKBGSVSNwhgZ+H0AtT/F2VvptnkzkLmbcKy3GuSxL7CLttwg0cSicneGWdKCAIxfUaiJuqsVVWY4MP9nKs0tXHmb5PjVmlGtpCABL4KK2GixGbT9+ewVWI/zzBWnHbfpUrA0ivjXPtwaMtmHYYsWNATqI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fc52f7-cdd3-420d-1713-08d58157444f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:55.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
index 26e6b05d05fc..9545c40daa5e 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -596,17 +596,12 @@ int scsi_get_device_flags_keyed(struct scsi_device *s=
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
