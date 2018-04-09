Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235436-2-17489603669517025704
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
    1523235436; b=ExgdjMwnVHIZOJoev2Yxfv85Ta305+hvWPlLrMpS+gYkVFzvZq
    uljl4YiUdYbYHnmGoA9H7tybCDqT1g9/1TsykLnk77U5+ulaOYHy8C2/sdfPMfNq
    YAm+Ljca7PY9ymuX/fke3ctAQX+7dL5ZVnBMjzrakeGrTSaAA9Mr6+QaT1u5fgtH
    kA66mFN3zP+085fS6sKPQ4R3bG8a/3czBSFbAW5QBko12ZdWDGOCa1f/CZdHTP/y
    5IZhR7IPcmO3IgPa6RhHyPDJi8LNw8oME29StM5ge5kLyBuo5DBYEJ4352+UxMrl
    yhw//rDDu/HgpJgiGNxfh7v6F0uvHDaYdkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235436; bh=hhcndDXo11
    hGjCfMGio61gfx9sicuIM56vHBAo/xwBI=; b=U19SSVd0mP419X4GjCCTkhZKu/
    zRV7197Y5fchJATUIuQKtTX5QM4kG6Dj+c9bxpRT8LMKITb+C20XpOPnCWFMeW1w
    zdDqThdIccduPu+CU8qOEoak4KWaYKYG7AjMSqhqkZdFjNwfD/suhPlM46ql0hn/
    9bHVnrHfYQAJb0PzwGABS8D1HmGCwGlC725nwDcRECC5LZOwZ4nZdEw/Li9O3nXU
    9van2CbISpSIyiU8SKG7dUERkO90MM5qdotK1XhBi2EG1n8W8GF1wxIkOwyHTdSU
    WxvazduDV7YgUnGtwFHD680tZaqw4iuqc40Xfr9JK0HrE8hwbr5BMujuRr/Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XXaHzLt3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XXaHzLt3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFLyAF3y6RjmI0Tuye4bhQtJdRJg5YK25989GTFFC+DXTwRQCZqKEAwJi+sYusBZsgROnJHWT6VU4d4Hk3Z8rqVTg3YOqJ4vN+uy1ryqWwGRoudai4oG
    ysx6dxr7KWRnN25AAW/MfIQYHohn2Ss9HLxyfz/yqqJIFqg68FHkm5PJQIbGPpWzEOYkiDEHO0yUl/vBzAqvfstL6aCJ/e3f0USsFqNjmF3/mCDDwAfslpY8
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=wedSEW4dgVMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=n9Sqmae0AAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=oMkuXpgP3ZEgjMX1XNIA:9 a=wPNLvfGTeEIA:10
    a=UmAUUZEt6-oIqEbegvw9:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933271AbeDIAkW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:40:22 -0400
Received: from mail-sn1nam01on0127.outbound.protection.outlook.com ([104.47.32.127]:39117
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932553AbeDIAkT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: hayeswang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 035/101] r8152: add byte_enable for
 ocp_read_word function
Thread-Topic: [PATCH AUTOSEL for 3.18 035/101] r8152: add byte_enable for
 ocp_read_word function
Thread-Index: AQHTz5qxsUpUmPuF6Ei9jRtIfsIzmA==
Date: Mon, 9 Apr 2018 00:35:43 +0000
Message-ID: <20180409003505.164715-35-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:xhhW08a5tdreU2lCBisigjWOxwXeCC0HWKRPmqFsENJTEbB1+vPvSQykqcc3sOy3FTaq8r4BE/8VQ/ny88R2EbA+A5hjTL03XOMi15IzRMUFB3Vv8KjCtSiG3b6h2/NVuSlGe9V4dVJOxWdsBtTIXZAJtBGmT1VLChWui00qVFHeUzHqu6sUvXQHiuCLkUG/UU3H9zPhOwic/AWRJjrdY3Ab7DW2gc2fJ9y2iC7clvIGzj3mm8i+N3VZ6EE159pM;20:hNJ+cIRhx/ABBUJhJHA2eb2Xf+NvRNOg6JwVwurXTYQPPQZE/bQ2vKXnwEhypVFDjL9jI5DiuDz8qE08P48iP5bfNokDWEgkB6iFaTrsIsvQL3/++5fehoIHH7wH6e3eu+NrfmIMkp7Qdke8ZiJpf2fpzcAHVVGZwy3G2m0ChDs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79d72c55-2106-4167-9a58-08d59db2776e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096667C4A3576926AC86FE11FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(575784001)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: K9mcvhJL3LCZsFIC5lt6uMMky7rfWlOSGykSQt4qwo+1Tri5oUDpEobKN67+eREDcRlie7+csoT4BN0hXXAT4YzOIXryrpvNyfKikvQBlZh/PqAdlbEE2deYR4Mjd4fz57OmE+nTRa4ybloG4Z29PeNEkKT84b3pvC4ZMVfHNbzL3/CZPkXAiR3uPrgykk39WlnIo+Y5y3v6NY85MOzfJ3ubT5MKwyxY27RqlNiVkGbT+6oUuX1unynJhDGi6KufD4tz2TeGN9Zkw359NMSnVfr2czSd4FowrCG+Qip17VAYnO1TsWOfCdLQCGrFtrsNWlf5Snh7cUsjkdOxK2dLCzXqNOJHpc0DoWCfPEY+R657D8McYB/PlorLvxSHh7EXh2T0MYLMzyvBBZ2pTxf7YLVEBRXOQWJuK3evwcye478=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d72c55-2106-4167-9a58-08d59db2776e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:44.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: hayeswang <hayeswang@realtek.com>

[ Upstream commit d8fbd27469fc02049c674de296a3263bef089131 ]

Add byte_enable for ocp_read_word() to replace reading 4
bytes data with reading the desired 2 bytes data.

This is used to avoid the issue which is described in
commit b4d99def0938 ("r8152: remove sram_read"). The
original method always reads 4 bytes data, and it may
have problem when reading the PHY registers.

The new method is supported since RTL8153B, but it
doesn't influence the previous chips. The bits of the
byte_enable for the previous chips are the reserved
bits, and the hw would ignore them.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/usb/r8152.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 31cb1cda7166..c0b6b8875eac 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -804,11 +804,13 @@ static u16 ocp_read_word(struct r8152 *tp, u16 type, =
u16 index)
 {
 	u32 data;
 	__le32 tmp;
+	u16 byen =3D BYTE_EN_WORD;
 	u8 shift =3D index & 2;
=20
 	index &=3D ~3;
+	byen <<=3D shift;
=20
-	generic_ocp_read(tp, index, sizeof(tmp), &tmp, type);
+	generic_ocp_read(tp, index, sizeof(tmp), &tmp, type | byen);
=20
 	data =3D __le32_to_cpu(tmp);
 	data >>=3D (shift * 8);
--=20
2.15.1
