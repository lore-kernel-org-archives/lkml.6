Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235675-2-3347143647407598487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235674; b=ebMkSkQum1otPzQsEwEPfIXhKaBEUdQt4i4dZVOU8ldd6ig9Vb
    q+N4NuDriE3dYHguI0o9KTcSDF3Bb2rdJVwiRQnmOoQozVs1dXktKZAFNnL5eWBN
    7+7XfUSS3j+93VIZmJOaeB0FNpxPd3C8L1OlY8TbesgcwyUlyvE8fVI2DC1m68bJ
    MQxtMwN+vYNp3VUl8cSR8WM/qL07jIz/j3H98Yjb9fVoI96fwWouYNWPNF1VIBbK
    0IbOvxheO7fwlDoRIs+oEV+psO/XlNUfTzrOF25i29f1nkbXSVvjQ/ffBCn2EY9P
    sL2CTPOE1sa4YKNfRxK4lsa8YsUWx1mV5+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235674; bh=kL2h3MfuLj
    5VM6OCUDwLgePqtDSudxa3SnAQXsNTiEM=; b=FVGEcCB7K5no27/FvLtXOPLrld
    fARtpBaxG7U6YjXxjsVV0t+Vf2WTkndgndnBqe8VcASjLv6uv+f4ZjB1cTB1Vqzr
    fBwvYwh6CvAvwmDLq6GNDpMEFjdId9DUQblB8QEUP0AqXlFm0v6/2NQgAu2JVE/N
    YGv356UYZK6D9yrErsID9cTwVBiG6m1P+nb2Uw+Op176cvojZXTi3KjrUSCh5BM0
    u2klJIunoVPh4pDbSfBkjCHVaszVleselqWr+XHOC/XNIIyNJt9cqytNFnUhbOXa
    UlY02+z8dNfspWg9TSuqvKPi0cEZwpc34EMI3LTJGPr66t1k9q7sXstYYDdg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EN2hTRIl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EN2hTRIl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLiYiPHpZ9/7Kx1wuTumZGTTEYS0zTdh+lCA+jaJ9sk2bYWqDop6F5FcWsh0ZNljV/TQpW2vV4mCdhhq2zSm83AChmFLMJ+Mp3z50muTxO0fzPG2fWcW
    /8KNNewAtvFqzEecgJoxVXb8Q7CdI4fWLC4o8d/3Kwj/1rtVvyH5LT9AiAEu/dOJNecFeS+bogec9fIXX5I6EDAs5P/eS/rjfuBTV6pkg95rjaPr/xAFV28W
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=SmCeFYOw6UMdjzz3AdkA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933181AbeDIAjk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:40 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933161AbeDIAjh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jag Raman <jag.raman@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 012/101] sparc64: ldc abort during vds iso
 boot
Thread-Topic: [PATCH AUTOSEL for 3.18 012/101] sparc64: ldc abort during vds
 iso boot
Thread-Index: AQHTz5qjEuyZpKvYi0WNGTdFsGToiw==
Date: Mon, 9 Apr 2018 00:35:19 +0000
Message-ID: <20180409003505.164715-12-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:ksxOYg8FMdU8k8ftWi9wPluLbzBRflWBF9VoXztMGs9LlhMsqeRRBI3SfU/LFxLf61/7Ey6qcECjE0KeCcdGNgCJWS/ZE5/U2OqDa956R2TXRfzC87LwEDUJ/7nvfr21gjlCtDW9oPsGuQObS8PZ1MTaLKbsZV/hTX0uDVwcEV8s18+0eJ3WgqV8DwiAG+JzklOK4B8PDTAO9gV+LjzV8QFVyNcAUVPMDQicsTeRD5NOB2NdzwC4LcElrgHnyYdc;20:mkHsxji8QGw7zR3+F6CzAeK6smT2xzCrnLqudW0EqdN2vM39buUreJPmrZxXMtE8tPskQGOAVVQo+kKS8hVvZxW6EaquGtDxatg0lK4eq9XPfklXtMC98VPqlVAeKcQewSUoQs8Lp+RrNxLObbJFjZ+lOMxO1Hi4qlBg8wBjmtY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9ba2e3f-d27d-4740-8f4e-08d59db25d4c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10478E5A53922E23C0D1A672FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UuQ/MAy760Iy4yq0x0BU/pgbCVuKifFsgNOdPKKh0ii2iyXuD1XpERzsxTwiWal5p1kzm9tEMfD9+k0Ta2vYEhTp+TsQn9ErFiBdnGyVyV9gMB2i9wk8K9DhEmvfVgCHooIVZcJ3T88P1dbcu4Nm2LJQCK5Z27C1oKiyag8xLLyy2CpJ4FarujR0UaPmvct+N+RXYGPB9nrBUAeps4wZQqrKc+SMqt3c7c7VWbkCzw21AhosF4/MWXSa31sKHuG3H+am/cOxd54xoCiE1P8lgbDchCAugl18qp/BO0loo32cqyTSxOki18BB30Fu2nAEcqe9P8memIsZ/qfsrVaua2zbB9FN4wH2aYKcWBqD1v9nW2rUHHYHmsS2Q+izkSWN4oAvia2sYBtyXR/aYnZ9bFfiq3pQaeWGaPUGYtzYNIQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ba2e3f-d27d-4740-8f4e-08d59db25d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:19.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
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
index 71762565513e..8bca543977fe 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1693,9 +1693,14 @@ static int read_nonraw(struct ldc_channel *lp, void =
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
