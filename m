Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237475-2-7383681679753153405
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
    1523237474; b=cT6/Kq6Dbf8E+zQmwT1dpisZOEKzEk1OmCpgeFnNZQC84iF24B
    HCyepZaxVJQ4L9u1quiAZibSnQVDD6xFpWwhIEdP+oNIU0XJQL6h1WMKJGASpCZC
    2OF7BgcFRi1vqtSsRJ8sily7ZFmzUsW2fwxOQ+RZHTAiVWw0E2MxHqjgZJR+jWwK
    7gat78h1PIYTXq74r+OEIHecfhy6YUeCt640uvnIVHrvy5iV3lTR4h14Q1f2vTZS
    C6xGNm1X02JciZOsDLFs4UXU3TOsKpIVTasIuQQ0uL/+lOboAS22tojTWnzXZ0qG
    jnhVroTg3A8CVLWZEWb96KOvj7mZtX6mXOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237474; bh=g11R5ZqZfY
    4tY/L6f8CFRTA4SO1gBK09sRYYLVGe2Es=; b=pK6p1yL2yV5h7vz9/WMIYzRncW
    6sJxOYkPtu8TFmDwN0hcxzbU8tS+Ssi/QzHEqf/Uj0Qm4/sgVFSW2EuyadNFIspY
    1Kpan5kbXDhS2bUJRehbbPg3pqxZJEZew6GryyA3e5qJnACn/Zp7V51K/MDEL+A4
    nf/KOUe/n2gh6/SHp6y/fh5z1S2jhGYIt0BqzlMSpD5766CQS3L5YdqxC3h+nZ0c
    CrtZ25o0Hl7QfsdUuGk/EB+PoTIg0Tg7vW4svw9RHBCq31iB1xRK8sliuvCzCFgu
    VQjcEmBU9JaOtgZISrY4myKdhXcRgXfX1apbAerdWpBdbb/EcgYect/k0nHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iZjCI8cq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iZjCI8cq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNeVKTOm2TFD0s1Kfs+Yt5Cx/n+5WmoT/Bz8AurkU/GZ1VvzcXUl2KZkJF/7MO03fSQ2eF+2dxNIkxVHryf2NAYKzFxx+/AlhoT9rRnVzfgUlIF3C0kn
    OkLfZPEmL9DHWL7l6fU2XPxpU0n8UjcHXMeG3dNBjaLG1oEcjB/WEOSnrPhfqdPWEZ52H9Vb7XgNLS27JxW6HbgQdehq3rX848UzO5hRIbsBnArSZ7PMJY43
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=79_Hdkez2R8A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=n9Sqmae0AAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=oMkuXpgP3ZEgjMX1XNIA:9 a=wPNLvfGTeEIA:10
    a=UmAUUZEt6-oIqEbegvw9:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756622AbeDIBa5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:30:57 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:9440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756171AbeDIAf4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: hayeswang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 043/162] r8152: add byte_enable for
 ocp_read_word function
Thread-Topic: [PATCH AUTOSEL for 4.4 043/162] r8152: add byte_enable for
 ocp_read_word function
Thread-Index: AQHTz5mlei8E0JuYQ0CYmWIVJjNYxw==
Date: Mon, 9 Apr 2018 00:28:13 +0000
Message-ID: <20180409002738.163941-43-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:2dHL3N7V6Iku+gpheVNhdYQ/N0Hb16IuCBcD5zJwbpu3MrEDZznsNmobIx5gquB47fRIfbuilN6ngnrbmHltvz6THTGyoh1MM+oCZxoI0DjGeE8bcJ8LURWRT7BMwd7Kz2SQKRUNRs4c9JelpJKygHnKmC3RQrZ7m7dK6WZg6X/82/dIqFPesSFqYoQwArkflkBE1Oj0JcBX0FbpJvv/d1CGKDaHCimZK33cWGyuKendLTtxDnf4UpfiJD2knWen;20:1aPQ+4iGkmfYyi9RtxJv0dt0zxXtRFzmXLW6PQVvmDQb62URGUKbHwn/TS8aioBq2Mh8nqQPH2wuYKqqSziQ03Yg5bC9vRjkWjUsn2Kj+i6LXyaaYdBTAVvn2JUotkNn7yUE0+KI/RfqUxoyhslJYGhcnCFOGFfkxIiDDaMV5DU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc06bcd0-87be-45a8-1381-08d59db1dad2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725D5F217FA1E433B6274C1FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fHD6pLcoA3haoqu8/j0RikLl13FW+/RR7o5O+UswJ5GFdrP1HfcigAfDixSUPJq0e37ZfZgg1gypcs8kcTVd3bjaXzUfZ8ZhRfLZcU4szIonN18DkvfKqL6jf/wkYFEZxuPXLCEUrwMtvRCrZVJLgOzAw09ZyKTdpScEUp3UEDPA/pxHQRUI4s3OyRY4t1EbGXtZPTii5ol3+DQwLxsrgHjgsOSVSkUherS6IOZ4PUPcKDACGTl0kAMr0Y5ZMOtDExi7FWBZ2Ue5cW6VhTM6/yOuPjH/ZtRTEcq9P0Kkyt0t5mJ+TsP2G/GvVa7yIc+XuZdMkCVWe3V8lj9rVD+e+Ecw17r9Dge+zuPfLZ+Dmz0rns8cJCopvjiZpllN1Jzs1qKyV9X5VWm/Z4B5tfhqrB6SOZrVrqqTQDrlApv4UPI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc06bcd0-87be-45a8-1381-08d59db1dad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:13.9424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index 89950f5cea71..d91d094c11d1 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -853,11 +853,13 @@ static u16 ocp_read_word(struct r8152 *tp, u16 type, =
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
