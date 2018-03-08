Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487665-2-5598678191621863281
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
    t=1520487665; b=mWklVFLp98K2aamR42s4U/kTr2SlTtB8Edz9pEqwYgQa8tN
    DWuynsMNQLDShkOtDWH10a6ZfR3pw2WTwnJ5jS9RJtXmGn7YcCqi/P811OR5hKYH
    /eaaQ35grKMkeF8zFkGoBYBMB4w8Qc10xYimpzRKhRme/qpFpTs2+F4kTdKU1OX4
    2F72iuHEwTxNqkTBC3iMOHYDQL5sfLU+C/YDg7hp3KSMWeUuUJu5eCK4eF1BAb1Z
    ociXELZeIrRba2R0/7WPLckBmAm0FteVNABFT0fNbBmiQV7HKGBjNPVxBZujwfUG
    lLjJGERxju7wchvGEuL8PE11eJgEYsY7BK1qX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487665; bh=zzsuM5
    t05UKw7rvWbeKPXBxzN2UlK9duZ1Xh90uNNNI=; b=HMycGSwS6ATD3YQS+8YKIv
    fh9E0c55aljpGav+seaCAfJw9HIJWuVawSYlyiT2/DqEIlOfDO5ACSy4O/Z8yeHr
    s8vEbW8aGe18nmpF4WgevnVj3XCA23IVAaEbkCCs7yohi2xIc4NkL6xJLoF86reL
    IZtnAFNWDWsCXLs9i01ibXuZ2UlW+34fl4WLzKKOY+yFxJ7GmbM3ikuNvYqSWGCL
    Hh6Rdemm+Xuv1J+82Jbcw2JxdI1QDnybWi3dtaQgquia1jOwSUZ6EUx12i5uhrBz
    8URsx47bU9fOWWbuIi25mxgGP+kjaXodCbDQ/vaBZ2zYc5JtGZ1P5shTphXJ/YzQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RiEzGb/M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RiEzGb/M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965069AbeCHFlB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:41:01 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:57824
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966227AbeCHFFX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jasmin J <jasmin@anw.at>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 023/101] [media] media/dvb-core: Race
 condition when writing to CAM
Thread-Topic: [PATCH AUTOSEL for 4.4 023/101] [media] media/dvb-core: Race
 condition when writing to CAM
Thread-Index: AQHTtpqHjaTwdz8LnkmSseZqstGUXA==
Date: Thu, 8 Mar 2018 05:01:33 +0000
Message-ID: <20180308050023.8548-23-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:d6IQFL2i0EjjZsE75jsV2RgwyPzn2VKfY9PkPuAb4oIR3IcgnGEkhir0FBqH1BDGBSMmP0IKrUa3RGfu3Hyyl1YNV1B9JaKPYfvJQU1y8MIL3S0LgxEvBP+s5HK7bOpstd0Qf1gv1wBQ1cWKZJGWO2OAXCyT3B76qlDpOcjOj8GNg9bqQvaLECZGLvQEMmODje4MMLvGdcXs1scUhUgzYa4JdYnzC+7LKO6nbqTaySWMqlpfCWZpmky4s4NA3pIr;20:dSCMVsOaks3UkbjIX610IRb6Fow5EGPjdyWXKUGN7UR793tXlhakbrngg3w+S3NsoI0YkBLAUhQQ7IC0kLdzlcTKYQfE7JuJITKClWi+goLGRGqd9X/0M6C4kyjoNRX1VWfc793Zuoj2lDZnwsizT25eaxGMUIg2EjrZtV14v88=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ba09f5e-dba4-40b6-264b-08d584b22d55
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727A057FC7A3E749547EF90FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: dllN7xSL7lFOIaENPWiCfPkvvin9nTqA7NiEsre0TT/jYmrxDOek8YboFu9umAYL9AQpCIW6FrvqlVwOGIOPFtBySxrU6mEXAsk5leFRsdC3Ibv4NcdtrlLdNi/zunYt7koQfydQchLX8zngQ2fL4MoutcHeidhHEM63bJACdVklGuhvrbdhdGNXLZH1aViIvjj0QU91raEQtrEdlvQTsv3SKinydrckZBI5J6PG6LUkDubpwm2T67fUWnRQOYmZTYUBIlQjGHGOpqVTMLR6tlIpRqpywZIFj08/NYAYDaY0QiwLhRsXUfhU3LilBeLEl49pwLxdqT9F0VPYbRTOug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba09f5e-dba4-40b6-264b-08d584b22d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:33.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jasmin J <jasmin@anw.at>

[ Upstream commit e7080d4471d805d921a9ea21b32f911a91e248cb ]

It started with a sporadic message in syslog: "CAM tried to send a
buffer larger than the ecount size" This message is not the fault
itself, but a consecutive fault, after a read error from the CAM. This
happens only on several CAMs, several hardware, and of course sporadic.

It is a consecutive fault, if the last read from the CAM did fail. I
guess this will not happen on all CAMs, but at least it did on mine.
There was a write error to the CAM and during the re-initialization
procedure, the CAM finished the last read, although it got a RS.

The write error to the CAM happened because a race condition between HC
write, checking DA and FR.

This patch added an additional check for DA(RE), just after checking FR.
It is important to read the CAMs status register again, to give the CAM
the necessary time for a proper reaction to HC. Please note the
description within the source code (patch below).

[mchehab@s-opensource.com: make checkpatch happy]

Signed-off-by: Jasmin jessich <jasmin@anw.at>
Tested-by: Ralph Metzler <rjkm@metzlerbros.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-co=
re/dvb_ca_en50221.c
index fb66184dc9b6..77cf211e842e 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -750,6 +750,29 @@ static int dvb_ca_en50221_write_data(struct dvb_ca_pri=
vate *ca, int slot, u8 * b
 		goto exit;
 	}
=20
+	/*
+	 * It may need some time for the CAM to settle down, or there might
+	 * be a race condition between the CAM, writing HC and our last
+	 * check for DA. This happens, if the CAM asserts DA, just after
+	 * checking DA before we are setting HC. In this case it might be
+	 * a bug in the CAM to keep the FR bit, the lower layer/HW
+	 * communication requires a longer timeout or the CAM needs more
+	 * time internally. But this happens in reality!
+	 * We need to read the status from the HW again and do the same
+	 * we did for the previous check for DA
+	 */
+	status =3D ca->pub->read_cam_control(ca->pub, slot, CTRLIF_STATUS);
+	if (status < 0)
+		goto exit;
+
+	if (status & (STATUSREG_DA | STATUSREG_RE)) {
+		if (status & STATUSREG_DA)
+			dvb_ca_en50221_thread_wakeup(ca);
+
+		status =3D -EAGAIN;
+		goto exit;
+	}
+
 	/* send the amount of data */
 	if ((status =3D ca->pub->write_cam_control(ca->pub, slot, CTRLIF_SIZE_HIG=
H, bytes_write >> 8)) !=3D 0)
 		goto exit;
--=20
2.14.1
