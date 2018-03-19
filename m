Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521479291-2-1492884259640684205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479290; b=FutIgkZBTudcd7xjrrRNNfk7Z5gsobJGPxUgiziEIxsATMP
    65HSkYJsbjxwU3sFeCgPM/Fqw+F92TFH12tJUYAfvb8fIUxw+9H22U5PTAR6wWTD
    qn0HfKwTAs9kuTfiBnb0FqqZxXSkbiS5io7V9T1tsiu8vnsAnO77r4v2wSb7qxWR
    43UcNQj7yXIxE+EAm1l+IYio3WngWiNV04DqXZznJdcKcvTq5+5xE/g5htEbbc2S
    Mul/S7ONHy8TldkpgA6opNmVaKzUameqeIRFH8s/TNgUF1ajp45R5mCEOPA5aqU1
    dKpaZ1wW2hzxVTAz33Geyd3c0DI6eZAxsCg+9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479290; bh=svjQZm
    yqOR+g1RFFJgVNtJTsG69AafiOqHNlubJcnYw=; b=tFw7mWV0zGp2y3EWNqT4Ai
    2nhS4avZMtyXsoCLaSdLG5QqqVTpM8F8+fO58QbHNRDU9lIrzW1G5Tbc9YvqOYUA
    27faTaVxuElE0RhqJjAQjTs2hAiI7tLMcXFljiwjQIBFJJ+Qn5/rf1u/q5QDJ4I+
    ZMKoHWNt/nt5347paI7ZLZLnxcaseRmQng8hHnb4EqxcBKh6OoFXDdb0k/3ZpKb2
    EvkQFr7195Wwc4+y1uoV0AC5aypN2GYR3Lek0jA2tNd1uARTQAU/JyMhgE/XUrGp
    0vP8wTug9WTuZnD3REyE9xJs0e1byvapY/QGSDWXIs5FWTNTb2EwbOeb/F7v/DxQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dlg0iWfm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejkeelnecuvehluhhsthgvrhfuihiivgepudeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dlg0iWfm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejkeelnecuvehluhhsthgvrhfuihiivgepudeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966806AbeCSRHb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:07:31 -0400
Received: from mail-by2nam03on0091.outbound.protection.outlook.com ([104.47.42.91]:31330
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966373AbeCSQKs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 132/167] ARM: imx: Add MXC_CPU_IMX6ULL and
 cpu_is_imx6ull
Thread-Topic: [PATCH AUTOSEL for 4.4 132/167] ARM: imx: Add MXC_CPU_IMX6ULL
 and cpu_is_imx6ull
Thread-Index: AQHTv5x4FgsVUvEJ7Ued6FtI/b04Hw==
Date: Mon, 19 Mar 2018 16:08:08 +0000
Message-ID: <20180319160513.16384-132-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:eCxkFGu92IyJKmrsDs8DJL/TfGKEAxAoeh3foykcTR5VHagFwY0v6IfXg5XKvcHhcevrNUdP+WwTinQ9qfkqAdSYQIb/XEXL9H4T8SXrigV9U9/mMpA/YAt15v0Ie76pQaBvtpzpCL3cnV8FuAfdkXkyXQH9Q5j7CEJ6N5D1w/YHM3pl+85AAJir/y+/Hm6fBelWNmSIEg0V1OGYS9DskvoBaE/qbRkATa7ya2yI40zMQ3G9SewECq6Kv26esVVP;20:TdqsTBFbwalqP34VCmN+ksGSGy38Gg3WC6HQp5jDxUesDy2JBPxyEkYMLIwKX0jFlFWrHNGcX3BOGupE0PEcKz7kqjUulQf3lYDVg226eaBd9jMHL519oNb0YpZGYkPEfc2VaEqygpB7cAzfiP7fQTVGAQQ/EiO4r+cVY9u4u60=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d55807b-d61f-4037-742f-08d58db3f54a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10452A550F6A7091ED6BFB22FBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(86612001)(66066001)(6436002)(76176011)(10290500003)(6666003)(2950100002)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(575784001)(102836004)(8936002)(6512007)(7736002)(3280700002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(4326008)(8656006)(2906002)(14454004)(81166006)(316002)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(53936002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: IWeFtrhEWNDTQokFI4qPxzoM3yAiMTHFiPDnyqQNT9hA65Teth1XP4yqqTukMO0eh8V+HwgL2OMYPqA6Wuee6AbvXLS7rvKgkQqECA0/8CT4movMJu8sFpy+FGaggAfUCBFLW5UtS/VPTfdN2vsxIfODHxr7Y6vRJ/PuEWaIfyjJV+X5Q6vI404NBVtZ5UDlkWneVLZs/rjcQw/m5nr0cKXiXlbxRrjZlAcc+bKj7wRBhPYsMrGqCVX0dZQM0cut+kneQvGrkfM5TebvfuEAvFZRQMiSybocr8A1vOTfG8yKvlPTC5JNEdSPCTYca09bPHQHv5LVrQwnvF/oquYpUQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d55807b-d61f-4037-742f-08d58db3f54a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:08.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit b3ea575770c7eeb259c77b6861cd14d00eb309df ]

Support for imx6ull is already present but it's based on
of_machine_is_compatible("fsl,imx6ull") checks. Add it to the MXC_CPU_*
enumeration as well.

This also fixes /sys/devices/soc0/soc_id reading "Unknown".

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-imx/cpu.c | 3 +++
 arch/arm/mach-imx/mxc.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 5b0f752d5507..24be631e487d 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -133,6 +133,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6UL:
 		soc_id =3D "i.MX6UL";
 		break;
+	case MXC_CPU_IMX6ULL:
+		soc_id =3D "i.MX6ULL";
+		break;
 	case MXC_CPU_IMX7D:
 		soc_id =3D "i.MX7D";
 		break;
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index a5b1af6d7441..478cd91d0885 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -39,6 +39,7 @@
 #define MXC_CPU_IMX6SX		0x62
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
+#define MXC_CPU_IMX6ULL		0x65
 #define MXC_CPU_IMX7D		0x72
=20
 #define IMX_DDR_TYPE_LPDDR2		1
@@ -171,6 +172,11 @@ static inline bool cpu_is_imx6ul(void)
 	return __mxc_cpu_type =3D=3D MXC_CPU_IMX6UL;
 }
=20
+static inline bool cpu_is_imx6ull(void)
+{
+	return __mxc_cpu_type =3D=3D MXC_CPU_IMX6ULL;
+}
+
 static inline bool cpu_is_imx6q(void)
 {
 	return __mxc_cpu_type =3D=3D MXC_CPU_IMX6Q;
--=20
2.14.1
