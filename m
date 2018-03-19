Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479694-2-3144367965692155741
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
    t=1521479693; b=nnhvuKQ/o/iLa9AzU8o2KdpRsGVC2f7fKXGgTXvN87/zA+O
    U6s9EGIRXsZttIQymkmgQr0h9rwzmg9cT56Rd4KPwUKKuPU06MHxZerNPIpYpSZo
    +N0/++yyYc7x/62u6vMHsDsGcpl5t0aAFjtnofNODJ9bo8dP/W8Hl1i2FOjtGm0V
    nMstGdSEh/fujSaWODuA8fczzt8erWjnUO4rH1ykivo3glWgw+Cn+LSnlb/RXAeZ
    8w26/W5fikngNRF0PLTh9nEUPRh2AV8X4TcBPqze81aQNc1SpdR44ZS8EG8VHD5v
    TXRXz2n7fgKhv9F5xIr8KrN+lH1R7gWQZor2Psw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479693; bh=1ZFwFE
    NoxiA5Ok7AYmdT9ymt3mzhFtbru6ZHYYENE4M=; b=dElqgWLx7FpyDHiYICq2q7
    sh0Mk714VSAt2pOqWO2lazVGtppb3G+K7SoYQkTFp4hs79KFzdzcsei4VcVrk0eL
    FjkEnyLggIWeltNz+b4Ak6nDYZUDDII1XyZdiDlK8d0kt0YRs4a8glfAXCiBfFVR
    T3qpHASQZ/8V/SV9DT/M9Y8BOOI4637QvLw2L7F+T7oIuno9jHDJNYWrwEP/GZ7G
    KSeCvtdcixolN9jVRoS+u1CguUVC4YO3u8ANMd3yw2SU8lXXYyT0SXp051jy9NM8
    hFTs8VpX9tAEVAN9Y/p4/FtkG5VYGSTiwf5v8MqI9+FvNx5v700Bb71RISClcLqQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UybINqnU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduudefnecuvehluhhsthgvrhfuihiivgepieeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UybINqnU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduudefnecuvehluhhsthgvrhfuihiivgepieeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966366AbeCSROQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:14:16 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:35072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966569AbeCSQKJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 105/167] rtc: opal: Handle disabled TPO in
 opal_get_tpo_time()
Thread-Topic: [PATCH AUTOSEL for 4.4 105/167] rtc: opal: Handle disabled TPO
 in opal_get_tpo_time()
Thread-Index: AQHTv5xjV8oZH49DyUy3iY/C81aI5g==
Date: Mon, 19 Mar 2018 16:07:33 +0000
Message-ID: <20180319160513.16384-105-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:lOI+2PNIV5Akutr6/A5R60oEajCLfQPxQgmDSHrieBRihI/cJALW0BcUISIdwjSbZvvSA5vvdh1wPiYhdo2r6giTC+7k5C7vjdZowzoiIDdniqZaqlxOaCM6/Xmp6PUVecS9QBsL1N8UZfOQtnqgWj8fzDXoiRtnrYvcQQE0zPaAVSz1AYCbZ01UGQ1VUbxedTigxWhbE/vtuCHuCYJ6Et+nlpAK70pgPM0tbAB1k/Q1ZVSg7zdmSNojL7Dz/7/V;20:Q/hXN/Y6oDdEIxrOaBVnf3OwcrnELMd0pMrNq+KSOp4Rduc00w0UCnkXhdPOlDSI6YeMlcH1gMrD7qYnsnXG8okJ8RoHT3WrnJFtam6X7DhseUsigqr8HX4RCuQlTTqnyyr5hY43L6z/0eeTtwuMzINl/FxEEB6hvsZ5BWH1+Ts=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf96968d-473f-4a37-f15e-08d58db3db1a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10955D2C9C0E2D3E700090DEFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218)(104084551191319)(211171220733660)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(377424004)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ojzYMo1eprUFAKmbN8sTpWlWsArmJgzDsoRLpnBPXbBj+Ysmj12fQKLoQNu7g4t2II5WzygMDSMqz5o7lJMnCmGdI1fMOjVrhuS6OD/jHXIryVauVjWP3imjWju4W/JiNV7Tj/beImLDQpcbpT4ZiR2tBa5QfdMyisZBr8fjunvQZMs8p6Ja7z10b7Mo0uVnqKSa977jZxzITq+hyswyPCwyMO9ZMFISP3mG3HT9kTTdIX+ImhI07X5KVGdMnfr64B/OqVc9UNRE47XN5cM+Ue0koze6JWSkLIZWU6Z7QnyUgHGK4U8LXaLQ7O0XrP4TyPDyx/cPoSIEFMYlxWCxMw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf96968d-473f-4a37-f15e-08d58db3db1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:33.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

[ Upstream commit 6dc1cf6f932bb0ea4d8f5e913a0a401ecacd2f03 ]

On PowerNV platform when Timed-Power-On(TPO) is disabled, read of
stored TPO yields value with all date components set to '0' inside
opal_get_tpo_time(). The function opal_to_tm() then converts it to an
offset from year 1900 yielding alarm-time =3D=3D "1900-00-01
00:00:00". This causes problems with __rtc_read_alarm() that
expecting an offset from "1970-00-01 00:00:00" and returned alarm-time
results in a -ve value for time64_t. Which ultimately results in this
error reported in kernel logs with a seemingly garbage value:

"rtc rtc0: invalid alarm value: -2-1--1041528741
2005511117:71582844:32"

We fix this by explicitly handling the case of all alarm date-time
components being '0' inside opal_get_tpo_time() and returning -ENOENT
in such a case. This signals generic rtc that no alarm is set and it
bails out from the alarm initialization flow without reporting the
above error.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reported-by: Steve Best <sbest@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-opal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 229dd2fe8f45..c6b0c7ed7a30 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -150,6 +150,16 @@ static int opal_get_tpo_time(struct device *dev, struc=
t rtc_wkalrm *alarm)
=20
 	y_m_d =3D be32_to_cpu(__y_m_d);
 	h_m_s_ms =3D ((u64)be32_to_cpu(__h_m) << 32);
+
+	/* check if no alarm is set */
+	if (y_m_d =3D=3D 0 && h_m_s_ms =3D=3D 0) {
+		pr_debug("No alarm is set\n");
+		rc =3D -ENOENT;
+		goto exit;
+	} else {
+		pr_debug("Alarm set to %x %llx\n", y_m_d, h_m_s_ms);
+	}
+
 	opal_to_tm(y_m_d, h_m_s_ms, &alarm->time);
=20
 exit:
--=20
2.14.1
