Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490552-2-4378808538826356139
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
    t=1520490551; b=skwipWNvM9nAqcSFHjtgksndFkDQa2bmSfht2Z2yE7Ux43W
    Cuj7g5cY7+ndasw9GNIMQ5RmCFtBPpJLD+vDzYr92MINacFjMpX6GGvaDYuAPHBr
    ieUT69cGop82mX/FCPKVIBhQH4yUlWtpJw6SmuWXTuf0sHFe9xE2DUKkbbOMBxWZ
    F9hXX0uxq5feSx0KyMhpcRS3o/xvTdh57GI6zFvyD/n602ZL7dAlgAsOS1Tw/isv
    64e0cjbZ3dsDlK5zQHtPNK6GwBTWPYEsoIRYG09D6ivS3FkAeCCDdf/D7kcv+lXG
    qHpMBOGVZb/9y6aKpyHZGr78ZaUx43PZHnSz0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490551; bh=MJL2AK
    s3vOsxWSXKbQ0+VjpeT4fCvade7sK8kRi6t30=; b=WU3IfCukhe/xADvOnkoyOX
    DNJMJ5O5lXpHZF7rJiIflitYhxcD3FM5iq7OQPySpXbDj9e+eEKFhuz3LHlrytyF
    86JbJEMEIf4OBkIbBB5DQfkxK1uEmcNBA8hukTmlXz/6IL587/ZYmM3f5Vih/Tv+
    h7nlCaKv9GhHBewp4tJxiG5HLIWMKH6noqWiG2ieUJ/gtG9jPM1uyPbNyrS/XPfl
    V9ZcstY9arRPA//YzbMuIRDzcFHupd7YYp7Aex+/lOsljjBOmBglI0V8Pvtca/1Q
    Eora0byG0Dm7ztcOS/AZA+LqMORurRf95RwEpwkZNhOEX17lODcloqRQbkO0RVIw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TzkPqgfV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TzkPqgfV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935240AbeCHG2x (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:28:53 -0500
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com ([104.47.33.114]:8240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751240AbeCHFAS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 026/190] bonding: handle link transition from
 FAIL to UP correctly
Thread-Topic: [PATCH AUTOSEL for 4.9 026/190] bonding: handle link transition
 from FAIL to UP correctly
Thread-Index: AQHTtposDZgZkCT+bUu3pmFqaMn1FA==
Date: Thu, 8 Mar 2018 04:59:01 +0000
Message-ID: <20180308045810.8041-26-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:y6Lq1aOMceCk1NJzoB3DBeIubPInjL/rBrMs7jG0XuecfFX7e9Kpzy8CDXNP++iBtSSyY/y4a5WrdDEDwyddL0AlSpXF/uHeHffJWIcF3Rs5W+UU74OUuqwFgB3r/1XEMDv7pq3L26iya9h30EahdkyOa2x8uAF43Sms4l/QeV6g5/5yZC4YW+RLg6gWWvwpzjjgsSn5FEueM1tK43/ACK49KZkKB7YjAn0S2rG3MQzqU/P9GZp0gee+hnUmxlC6;20:n4WMmB95mCbXrvql6/1SisvEq1FjTkCGWV1w8iUEFgCW6z2yt0IKg/w2hrtKllKW3Go/xTrE5ZdeansmEoP3VOVaY0LShJ038tFXsdh1CXJUn9dABBoELsXZZGdYlRbpiPH5yu0yTOcgiC8swKL567dH4IhrL72/Q0JMwV29pH8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0c94ef8-2cc3-45be-30cc-08d584b1740e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09837E4BD0FF18590622E407FBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(575784001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 1swwIugbx8bCc55oAj9IWh2DiEyXO/4VJI1xNojcqfVSQHInodls0n75+QUEXWj/wc/8h6A0qqQXJaRumzkaA1q7yRDAkvRwVHenv4gElMxsyKRk039BL4D8izkHX/UXL1qPzAdUcqUz+o+pAO/tTI8VpyytvltOEJCZayMzKMHP7I87XXVDo1thN3IounK16wC5isdDxibRtR+TwlMYtRG91u8n4XhDaYQyFK0y5LlACpfwxmWOxzzcWR9uZtc5zOWu5mf74uR3EBsj2Wid3qcJzU48p5B0qHE//2dnrhjGc2b/PwNTswD5LR1BimuR3KVIN2IlR0x3n+Mfn2ANYw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c94ef8-2cc3-45be-30cc-08d584b1740e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:01.6481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit fb9eb899a6dc663e4a2deed9af2ac28f507d0ffb ]

When link transitions from LINK_FAIL to LINK_UP, the commit phase is
not called. This leads to an erroneous state causing slave-link state to
get stuck in "going down" state while its speed and duplex are perfectly
fine. This issue is a side-effect of splitting link-set into propose and
commit phases introduced by de77ecd4ef02 ("bonding: improve link-status
update in mii-monitoring")

This patch fixes these issues by calling commit phase whenever link
state change is proposed.

Fixes: de77ecd4ef02 ("bonding: improve link-status update in mii-monitoring=
")
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/bonding/bond_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 63d61c084815..2aef283713c1 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2063,6 +2063,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 					    (bond->params.downdelay - slave->delay) *
 					    bond->params.miimon,
 					    slave->dev->name);
+				commit++;
 				continue;
 			}
=20
@@ -2100,7 +2101,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 					    (bond->params.updelay - slave->delay) *
 					    bond->params.miimon,
 					    slave->dev->name);
-
+				commit++;
 				continue;
 			}
=20
--=20
2.14.1
