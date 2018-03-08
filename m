Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520485724-2-1711062645061077693
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
    t=1520485723; b=DnLb9LXrInNjPBcMaklKC2q8uxeVjRtufxpKnlTQSPrPTHN
    w5GmdsFX1/F51xQ0y0KulOeffp4TQMBj/g4TXhw3HPgYzTvohe1I8GTCKJvD6PJf
    v+YFk84SAv3DdjK3auc0Jx23FeZqZuZ17uH/oRMiR52M14VcKNeOAf2B3epRAH5B
    0/bNnQdqjoeJGFCepnWEsTg5gMuil/11qdNJF3dBG7GZlPMFcYY+96VBHCvOu0wB
    XSxZ9yuPohyuTfzxM9gaI+UwerZ94Sjqt+0d8b4327ztptxp+QAi+0laoTt0qETf
    4gdZCiCZRNwrtmhHing1TC99/PQbfVnhn9EMJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485723; bh=ng53lI
    crjlk2ZjFAgRBjfa4K/zfKgDdez/YVGwwp4XE=; b=DMmIKDHR0qXXu+vCFf5aq4
    H03cglF4UPhweBagozp8C8U7OfiQ7JV2pk1rd3E1UnKgua+NGIl5dLF1yKCc3zmL
    auSZ7V47Pb674mTGEJR0a24Z540Jh66giPEFoqXABL6aLKFI85+lphi5iF5i4lc2
    ZOrytt15SisLPuLDKNU7KazBkqSNpQYHBY3cSSspZDjHfhXj6MHrq/JVo6YOx/Y6
    ROxZs0q5jTnepMc0lZXOYi4aWnz1pQYymJjjjdoBydNMWevJYIHmmAVR2qOMWTq2
    0IHxsp775oIdaiA9KtH6dBzLwLhb56a4CG/VbPMpswFmjY0NL5QELriwEm4HpRmg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l7hW3DNV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l7hW3DNV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966759AbeCHFIm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:42 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:62624
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966479AbeCHFIk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jasmin J <jasmin@anw.at>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 16/53] [media] media/dvb-core: Race condition
 when writing to CAM
Thread-Topic: [PATCH AUTOSEL for 3.18 16/53] [media] media/dvb-core: Race
 condition when writing to CAM
Thread-Index: AQHTtprCPkTIypsnXk6YnjDrzGkFcg==
Date: Thu, 8 Mar 2018 05:03:13 +0000
Message-ID: <20180308050230.8876-16-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:xzD5AzjZQV6UbPykB01MW6mNlyEx+M1tWM8h17thYF7UBZkJ8Dq5JjNyBDJKzyfJPVhpMO1Ck85z9+pPoHKQr5l2EaADVpVh8BaqARsLzih1uh5f5WDgD0/KrFDa7pgAWaCmVTHro4THw5mc4IM6uzs4lka36xJoniot8thhw1ez2+aTRcS5mUP49cTA/ZDzvbG5Sr2L277x9Oi3qkmzyMJvEkYewZkwk4JdOGDzgMOx6exAGFfTrrXyVbLApp4G;20:TDp+/9QHdbjnoL/JS7urbvmxGF2zNrwkzA3gOVGzFKYsDjtEOOMM8fjlW1n6wMsi2VRAb85nKXVy6VnfGaBBTsKrxd/HG0dAYmLyef2j+Csaj/PeQPpXv/MicDvx5AQ2MMbaXEOY+gXZKAeR+/APYToYxVqm0oHdZFKzfV0127Y=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70355aeb-0177-41b5-d949-08d584b2a622
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871C4C11EC779BE56B8919CFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: TDzoHflM5D24d6G/pJAD7vir5MpMRHhMJKsdKD+/imm4e1xkzv2Qa+FD6iW+XUbiguxwqCHLuZboStlTwyHdmnxJ1c7XLim5NdvacOV0xs7Xe8LZdCYZ2HH0jZDYmLzt48bDy5a8GZv4Kl7kc2oAT29Ndkcf8IwO3J82SRxJYUhmP8S8OOX6oDAyX+mr/T2lr4Jt/ir39xPutyeieggLm/x4kMfT6IxT7YlZEIZ8W7273Rq35ezBC812SaFINrEIhEgIMTO4fV12y5Uw8YmepJb7THUFRSVRLyXSI4m5EmkcY2xktDIlHKjWPFQMQWS7BYkNI2bHUwagwkFr0BlHvw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70355aeb-0177-41b5-d949-08d584b2a622
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:13.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index 0aac3096728e..051bdfac6a1d 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -749,6 +749,29 @@ static int dvb_ca_en50221_write_data(struct dvb_ca_pri=
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
