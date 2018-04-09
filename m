Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237877-2-4027294279608458956
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
    1523237877; b=elj0i4uF2trO6SkzfiX/J9lHrv/VDQaLDAv5wpUNzZ2t2aAS/2
    ak9hMBpm9M4eEIxfACFKqlCJJf80e/RfCVzc6WhL5hqn1hUgUjnWhXgqIJmCHchi
    5yNEGtBA+CEoeGywd5sDoBWH3jdgBUxiCdXPHsg2xCj3vAvjyUVQp/+OgvXFwerW
    97KXO+8qEbCTQSl3F3YNE7oLn+mc7dDqzN8Jtp6LcKGLAAw0dwXY1ndViXq1Z1Jh
    cyX/uGPloGDdxzeZWWhOVJMV7lCMf7zQnCxNtk36tbmeR2BvYw1OC6DpLenYTGph
    R8Ad8yY4G1yTALtHFHxJiBqWgMv+/AOAbBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237877; bh=ILEvKGmpkK
    KJGWS6ga96BvZT1Au2ngryNO1jUNIiMHU=; b=tAUVhEOxMkXNyBTw9r5LIANPgX
    q8Flj4B5uo6q8D4TtrBsymY3yzKD9LWm0Kutl0GFPuI+EsjV2kgxqp/qBBZGXm2i
    CajwYdk0+Hf/D//YWvj5AUQz+yBERf99EN1XoHRCPLzj7ZlHaZGJQjuOBWNXcjYC
    j+Jlf3C0lTsIX+6e3J1FRxSqsuPOfYhGBuJY9wuy09zhOb7mfm39AhNgO+ASIfOg
    SJS9qW0JgIZ7q/JhxG3FfA89ouueQuLPhmSXJrg8OT7z1yZGDC1upSk30xQce/kF
    mfcyWESlneTqG051X35OKI8DXipw97SEnkbTz4DC2UOtv3/rsBNkRHcKwhHw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=pAIERPjG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=pAIERPjG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCgayo4/EVqFkf6HjRWVCERlGADuaRXEN9uDFlsCVaSLQ8rSpBwoJO0HMdWvUaiQnzv5SiIjc9u1ROTbfJ/a3cJJcX4iIkl/PFYsL8P4rMRZwM2tU3s3
    qMfunAuvnD+q4ilwhEMSOOuaCKz9bvFZAlzSJELngtGBzBrrdVB/ebtFbq1dn3nFDMdDo0+R47KWIUgnCOWb1Zue7pEM3grvyWTPkutKwFSWHYOzGzimlBI8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=SmCeFYOw6UMdjzz3AdkA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755917AbeDIBhy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:37:54 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:10752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755746AbeDIAfD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jag Raman <jag.raman@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 014/162] sparc64: ldc abort during vds iso
 boot
Thread-Topic: [PATCH AUTOSEL for 4.4 014/162] sparc64: ldc abort during vds
 iso boot
Thread-Index: AQHTz5mZNESHStiScEuU2KfvzkRC1Q==
Date: Mon, 9 Apr 2018 00:27:53 +0000
Message-ID: <20180409002738.163941-14-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:KpH94KplyYXYdhM5/p/Q5fnQyVuC/ArcNOPf9awbgXSRxVikna7KrOq+8CZAyxGSe3gzKB6tmryTczOXjZEeIYwmomzo3w0sVtZAIQCM7KFiqG1UN6sMX8kENVCHGS4RbMc/mzrKooXqM6/APrE9hIDDRnGMJvWSgWG6mMYGcavIYyVU65f0T4gOUEm+4SQk9t3xmauIMSbaURDJD2KbANNK5b2y9lCAqii68EZPp4QfQriqp/N9HDetGaP/s6tJ;20:BHD8WhkJUpPtZTbLmRKGC6x8j8RwQMNt4sph48aheXByNJkKazvjKjck3L8V8rztO4OYch6sBonXEUuvjGMaNm1ocY+AE53fR2mdXQ6PezgLbPg65VZ/UJacn07R/w2J38y7ZTsX9rp43BgIeUnL/Dd0Fjpvnuk0CkjqxQs/Tmg=
X-MS-Office365-Filtering-Correlation-Id: aa9e8c0d-07a1-451b-0c26-08d59db1b92c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10130FF6D9264ACC09C789ACFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: M1IA/yDBOHODF/s67fLpovmlCcAnREQUfWIRUe0/A/duxuCZdITa+yMgN37+giH7vWzh0U2+WwGF0G4RUw4oconoe7kcDiY8uONAxniPgnTOaOB1ufWzvlAi8ZpBTbLunl6CDbQ6cQz3z6fn0mNIKkF/Dr+qTUQVDF96Y6bYHzUlea3K06jBn59nT3+puyZolu26FIbJeYzfMnNCiKc7HxtNOij3Yf7U0nHFIILnHxMdaWETsvYI6gPMHEng0SUEGjNb7nmfvJCrebabWNArzCkvKAPCbzoeYovwqJCD6h81X3q0VW7XkYDJ85v7dNm1DesOLc5BbjtnOZjujNlc67BvUHc0abHK91kxu8IjAECxjZD32sS6I8L4JSjZcJWJSxwCEIsEVPIIGtTn/VOQkO0C2Bwje7QDIX56MznDtDg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9e8c0d-07a1-451b-0c26-08d59db1b92c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:53.1141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
