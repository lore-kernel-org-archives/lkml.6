Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241720-2-9447683626961796629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241719; b=NnctoWIz/WEkjs2qDnnhz/kR2fOLOQkx3IJ9Fo2lKIOvtMxQtp
    DHGyXVavyQLn4/pf6ZWk7bNzFync7O8jZRhbt6dctP6K5A/GcH8U4mbeFMy73kYo
    ER5+OwDZlciOGdcc09zzv5urdAnkDJCfczMkBvCId5sfQ6s5c2wrVaOzHGhPpfJv
    yIcQicS1+nWt0/Y3LCEsxkuCiQGUd20686ZnAAQx5odsattGZ2SgAkSAfjVaNrDW
    KawCRC1AWkYFkDI1lyLmNuOM+W5wpXPN8GVMgL98gA8zgvI4RisEO7USUs1m7i3J
    zP01QxVofLyqmGqC6QIAzFL+2ebtyhcDsiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241719; bh=ILEvKGmpkK
    KJGWS6ga96BvZT1Au2ngryNO1jUNIiMHU=; b=tN4/NVEPQoPBhM4OL4NqdbcGHu
    7J/aePHZgguj23cSS7n6yuzmYsBT/w37z/a7cNrTWDY38so/B81cEoQn5DevhFh6
    qddMtPBoCQRNBBzDPk9PlHC84+JeSJWsnzIKnUbruY+R5qS3OQz2tv6VGbDdH/Pr
    Dg000CxZBD93+DxE/ueHPoRhWYYZ2YpcrN+KDa+5ujhuix+65cXH5VkUPH/8Roio
    dTIFaCJhFjeepcP/rolFo+aBfGK8H+Gl+3bNxJ5kFrk+54/wjbKBXh0FRnKJN7My
    1KG0VT4GNwhn/0LNAwb++JNk+SSEaQwWZb2U3oP2Imc1jNIyqOt0NtL4UTUA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eEFZDAos x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eEFZDAos x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfExLPVf0NV5K5ajdedDtDUKMWOWhayckB4ooMmpa9iMrMbry4ww8M8fTUldxdNY98DvYYXc8ZzsIF2tjiuH1ThNLRE2H4KfwT12O087gmx362/dJ7WK5
    Gq+OpuPzDUVAtDANHMOgjfsDds+hmP1+5IEvgnt/xskHnRr8o5cqXL/MhvHXdCtdKv1jrI6WC+3+q3vtRt5BZdxy0Ldqg2YnM3zAXIiuS5a0f1SaUvaY2Vpr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=SmCeFYOw6UMdjzz3AdkA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932232AbeDIClo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:41:44 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:2432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755479AbeDIA04 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jag Raman <jag.raman@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 030/293] sparc64: ldc abort during vds iso
 boot
Thread-Topic: [PATCH AUTOSEL for 4.9 030/293] sparc64: ldc abort during vds
 iso boot
Thread-Index: AQHTz5jygqlrEZg320GmHJ8quCkciA==
Date: Mon, 9 Apr 2018 00:23:13 +0000
Message-ID: <20180409002239.163177-30-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:wQ3TePbkqwI5b8UamSBLvmEruov/IDWntdlCjayKTBQPvGB3R3TOc2HEb5d6F6uALe1rNvjVuGyL2IzY5aUc7s0bblICOjyvhXiZhEEVDufFmaqEsIB9w4fMYNCfCL95OSji6All7zuy3QtyYBA6dseprZJxSesPonbswK4yG0C/1Z5hPtqY/LPUbiOHmptnocc8qN6SsuqvDnKLlYNmunQYU0AalJHbxqBekECVFBntfollvGwybDow9+0Yps1V;20:xy6z5jQX81AacsrTbPLegtWrj1EXxUFHMkRyYnDwAx8C8coFfP6DJkDn5iW/8h3tLso1PXj67sF2eEGxwKhU0SaJtMd09+QHqxBi39cpiXRfRH0WolWp66KGG8jFChfkEP5jcAK68cObY1LfddO2tqbM5ni8elWouSBAn/kJBXU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59d5468b-e6f1-4941-9639-08d59db0949b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885C56C3CD3A52DCC7F9ECFFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kfQMhd/zVWSSGQeFTOcDwVj0piOwEZ1VEulLSyvT7RYMQAQxS/qSdxQ2ohlkSCIP17B8aDbpSPAZOKv1zthw0WejvscLXqxBPIZoztv9q+NaILQHmQ+um+1h9IgEPMuiUN3zN3OiDMoRDqUK831d9r4WIIVk4FXjut5uXa3Yea+GoWi4LHN5rDZJ3/sqD4W9/dRNRmg0tUjtL6o6fv6y1v2N/mTpqDRwQ/r/NBAxn2RcTaQ2V+rQy5WMYV9SkFUPYe7uDiyuluMonFiQdW8xfL6HTbG4N0UwD2A801gQ+Ap2lbull34t/ktGrrxNAVAL6izTejMl76nnSsRAUMcB4r1A+XtJ1ZSGkICYcoZWxJNtlriUK/xBzQjUpWrQ2f+iVky2KRnrHp2sEBaJdAPnnKE7I3THYOBj7REqlZBBlTA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d5468b-e6f1-4941-9639-08d59db0949b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:13.7998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jag Raman <jag.raman@oracle.com>

[ Upstream commit 6c95483b768c62f8ee933ae08a1bdbcb78b5410f ]

Orabug: 20902628

When an ldc control-only packet is received during data exchange in
read_nonraw(), a new rx head is calculated but the rx queue head is not
actually advanced (rx_set_head() is not called) and a branch is taken to
'no_data' at which point two things can happen depending on the value
of the newly calculated rx head and the current rx tail:

- If the rx queue is determined to be not empty, then the wrong packet
  is picked up.

- If the rx queue is determined to be empty, then a read error (EAGAIN)
  is eventually returned since it is falsely assumed that more data was
  expected.

The fix is to update the rx head and return in case of a control only
packet during data exchange.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Aaron Young <aaron.young@oracle.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/sparc/kernel/ldc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 59d503866431..9cc600b2d68c 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1733,9 +1733,14 @@ static int read_nonraw(struct ldc_channel *lp, void =
*buf, unsigned int size)
=20
 		lp->rcv_nxt =3D p->seqid;
=20
+		/*
+		 * If this is a control-only packet, there is nothing
+		 * else to do but advance the rx queue since the packet
+		 * was already processed above.
+		 */
 		if (!(p->type & LDC_DATA)) {
 			new =3D rx_advance(lp, new);
-			goto no_data;
+			break;
 		}
 		if (p->stype & (LDC_ACK | LDC_NACK)) {
 			err =3D data_ack_nack(lp, p);
--=20
2.15.1
