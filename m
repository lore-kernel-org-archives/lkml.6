Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240834-2-13739532449727897376
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
    1523240833; b=fL5VgoGRI/kBKhxwvKmAMkaUDwkb/M7ET1dzQoHHAf0tT1qXvY
    1dg/rWyr1Ps2RKtbZiZlYDkEV7FJjt4jzWELjIh3Lsu6FZo/NvGktZRxdgH2gWYL
    6wnWekadeDcYp2D7w9Zmg+gNL1Su8pNPYbh4E7ZrbD21b1jsER1m9Gay6ktdNUG4
    CbeF+CK8wl1CnvTtNk5t9dYGsi99Sj96M2a0aU+0+ecHqb71j6uJ8iZScbYH7CWC
    MF8L6f89FhyKt0s6S0gylxjJzH+a6EcnEniwslOhOTCheECVYU8B18zCNxaGN0sU
    ttwXFnx+IiISVCOK5WhUorX64j1ebLIO5Yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240833; bh=wFJJa9S4HV
    8FpdjGRpjjBih+Ok0MNIYMISEMDg2QFxc=; b=DmwUJvbtQ8QHd0dSv3S0tmyjqG
    d8kVh61zEMUkQuN8P4SJZYv4KcAeL/eBsIah1UE1d7TAWe4XSbAo6ynNsJk8bbJZ
    srR9YDk+pub4Y0Pjwqq6tkf6m8aQHBq9OYZ0IICeGqBVfIRH3u8uflN3BhngnJX2
    X7KZyJER1yRmt269dE0IoWDdJar+7K9qE/ttQUGhbt4e13G7yHuC0WxVYS09dXXY
    aOEqtd7J+GkgWrP5eaPbt8lqvOzJAaresT2lcniQc93hcVbgHfC4WIvvP2Fm0igB
    ipJXUNKPtDHFRqsqbPrkRkO0hnDie0fd88B8lNiHMZelkSmcECb94jzRksqw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LRYjoFUb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LRYjoFUb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAf4QpHECQjPCTmfylZ8uEr9rZbvqZSFlor0r2+9qIAyZvTTD3kB5CsecW3QzcpH8mYzKOX9JRn1KMyQqtSyfOSZvkUHrAyG50bKK1cdiXdxlUAEsCkB
    RPbfOf4ABHxCHD6TCx6PX7k4iJNO1FQUz66KlXHGBpp9q77teleR+/2ewtFxkKH89p3vezLUKoOTSE2buPSy8k/I3/Ue6XQXTJGmHbxiTv9km+k8Yb9dTNi4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=NRvXzNVNPVoA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=n9Sqmae0AAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=oMkuXpgP3ZEgjMX1XNIA:9 a=wPNLvfGTeEIA:10
    a=UmAUUZEt6-oIqEbegvw9:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754879AbeDIA2r (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:47 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:12595
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754315AbeDIA2k (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: hayeswang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 084/293] r8152: add byte_enable for
 ocp_read_word function
Thread-Topic: [PATCH AUTOSEL for 4.9 084/293] r8152: add byte_enable for
 ocp_read_word function
Thread-Index: AQHTz5kNg3u+/qH3L0Kl9y1muvllvA==
Date: Mon, 9 Apr 2018 00:23:59 +0000
Message-ID: <20180409002239.163177-84-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:HeMdG8A1nHlJtTy/OF4FXiXEN2RsbrRKmhBmE+KacGgtIa6O8vIYH29o1LuZsOu8IKcBLXuJ2BWbXKFxh6hlDrocIrxCk2SoE460SGzO0ACYqjd/uXHqNFCwdb9S3C6BV7fOGQlc2TtPi//dOwG2Ck7ZGo0s3wlp0Yq6zWRVE1hIPMdYCpESBWgSTvhRGPF1hQuSB5qu4qMlEr4ALD8qIJbydBGpimUYjNz3eLovhCgfYcelcSh9nFCJwappTJ5w;20:cGNCNC145x6Jug89EH6Ny4ysQBdz7gl7UlzNwamz0ybvNXXbJDfq6sIC0SwpXBqsuYotpnp2MD21X8E0O0FNP4mQKeNRrkYO/v3u741+P+9+D6OfxiaXHRRliaPmk1HKNSQ8AnLyXOeekAsBJLOsjDpLNZhclku/OAXMzlSuHgo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1b4e08f-6b8d-4d8e-204e-08d59db0d3fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807749F09168EE1DBBAD736FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SzTEPm14Rc128cTgoL4/xsJfyVoiCw7+XFOzWFW7sxre37GoAR7SVunqZCyW0MiKQIIQovvQ4ZJkp1eknWOYOlyCKBIWCKmmS4XD+FwIbZAskrQx9VureYSEyj3Rh3bfHWemUN62Qn82/iY4o0CSgnKI7oPfXI+F6M9alZQAN48us4JPGP7pfQba9YLXW60j+Nm1HRNKk5l/iDz4Z5n20qGdtETnlQ341IjqzOH0qTlOTglJCGYyjQuQzL+WMNghksR0giTtBQeskcUQqn1My5NXGEwILpKQBfRY6HaWrCNgwtXlolT0t1+ni+vHb4CYlDWsuq+1JYVMuiL4AveXfrMuJ8mmLp3iocTrohcfG4/09EKgq+zyyx2LwCS/1BgLDF35t5omy+k5SbrWPoAlEH1YREaYLg5FnzeSr66yX3A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b4e08f-6b8d-4d8e-204e-08d59db0d3fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:59.5187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
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
index b2d7c7e32250..29b7eb9085ab 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -871,11 +871,13 @@ static u16 ocp_read_word(struct r8152 *tp, u16 type, =
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
