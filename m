Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234526-2-5415875300053431905
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
    1523234525; b=tZCljvgyyQTxd4uTB8eKLXgyHvK/TnTGkQGWBRc/EmAmizGmVH
    CyCetDTnAKM31sUWB5wkoRWslJqV/nKnApAn7KnupAvU9xn7tNsQSQNM3Bo5eQej
    d9XchxV3pmxj96Fm6K3/4Bia+otLp+gCVBqBYrOlSUrny3c6YAJ6qtBbtHabRnqj
    j6FwM2Mr44QexJBi52IQNzixAX4k6Gzf1n48BoJKyAZf98N0/7sUV+mSBEMpCT+Y
    U8dkf97ELhX/mBpLbqHMJXYN8CfJlW0aWg8SrmW1wKrHurNi6GWkm1rgj8f6ex+x
    y/HyP1D2r3HseWuDbt9hgo+En15nPMg0wEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234525; bh=jF9sPzO750
    84/hBSTa4R8vufVSKr6Nc7AIIrRBCN0I4=; b=uMjSZa++xfNVugcoTKwP4OTCUq
    ucxowAAow/+lZj9C0Qdj2i8Iyd+k/ncP4R+4MGyZGqkvvRBj0X2QhDcESYBBFsta
    LojHG7tSTxsuDiFVVDbSUgs2+F7+0bWc506sHYGbIalUxYxBX2xxf/cWUgwN8Olf
    +rfiOX3akjAEgy9H3chjHHt9wRTySB6THLIM4YQ/PmRs7g6+LiQsRgizaJHMckgO
    XoISOtiNtq+CksPcdd6oM3/XO58qGkd0BVt5UprPslcisCwc95NibcMwdOa9igMc
    lT5v975NgmtdCdnl7GAI2x+fAWQ/ocb1SMBzVoJcL6mcskQO+Els3dIhWmVg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kfsqdSNt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kfsqdSNt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGlAzUpPFrleFzOkEvDFsvxBEiwhTCO2yNc0WJhNdHJMMQKiMZcBN2uRTzw8oG8p3wVHqNNYGVKVL59r9CzAu6JHGDXmEphlnKlLGvDi/vlWxpe9C58u
    8BPqhjKA4vwGWH1P01OYuSS6w6cuji8wAxO2Y/4NbVWd4crEOk4TvyVJq059FHdBg7YCYO79SHw3MIOeOe6FN5EJpUsJ8S96KQc+CPbAzGOWpy+uaAyF5XYL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=K6fn2rewBBjh1KMvdOcA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756338AbeDIAls (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:41:48 -0400
Received: from mail-sn1nam02on0109.outbound.protection.outlook.com ([104.47.36.109]:10733
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756571AbeDIAlo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 079/101] HID: roccat: prevent an out of
 bounds read in kovaplus_profile_activated()
Thread-Topic: [PATCH AUTOSEL for 3.18 079/101] HID: roccat: prevent an out of
 bounds read in kovaplus_profile_activated()
Thread-Index: AQHTz5uEDLXNoR7txU2uDAuogFWQsA==
Date: Mon, 9 Apr 2018 00:41:38 +0000
Message-ID: <20180409004042.164920-29-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:903mIYPi5Gpli13m1MMQ6H8ywPytXjA+fG7GycwQs/ksgfFRQQU7+8d/n8Wchjm4PieYXiGZkAt4qcpuYgX83i1l91YmSvH5PkL1ecWj27OzgkUz61YyzDzriganuhekGPi2CyFaTCxhW/di8OJGiN8Hgc44rtBGCtw6zx/eG/B1YJn/XEz2idl+gmzG42UHYErt/YD6f7JS1IOpkGK/5lBifCSOWXUVNXychxn75fn5KIKqtm+vhQ3y1Q4N2Lsv;20:ESISEWajVDnAh9FbCFqq6bSO4ashoVYoWw9Wz1IMUXQgj8NF8x9oqXodTQib0X1mtFHBZtCOlVS+cstOnotzXGGU5l0HMJlXlrXZlab4mWhO3PVeVxPlKt53ZEPIOSQmqyfZZshUKh/HTBkZxDAn6wKn1pPP5A1zQLSnNhbhrz0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a698e618-00dc-43a7-ce0b-08d59db2a927
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10621F0E7026E0DC77A33360FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rDzSvWErUeaEJT1vbFObNf/7H9eUgdJbQXaFDoB5Wna/ucjjEFmF8nu49F4E1gyU6Wi40X6bucAoOog0JyZ/s0AW/NBWSjOdapLmevc9slyRpKbitAH7yqcMS19jbKW67PTM6/+mXYwjpF3UCm3zhRfLEsNlzIfGLbE6C1dMofcFi2KTygeEfI1ZR0Au16EAdlWZMFMxCw16MCtldXMW03WhHAEuLHOzvx4PPzH5IYfAkat8+vIZ09rRIg5IH+W0+ehsZhYHW57YiIS7sclneuIe248tgHhbLdx9lXw33mBwVykE20M5R9QM4jKBCdqitMfGyERH8uOsQ1A0NN25PjbkLMrMBke83sU9wWtq6B6s9EzkA2asdjQX2gvaH3EGnSK/UuLYjTCr4vB7P3NWs32HN11uLEI2aFiJA+z3pWk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a698e618-00dc-43a7-ce0b-08d59db2a927
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:38.1740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7ad81482cad67cbe1ec808490d1ddfc420c42008 ]

We get the "new_profile_index" value from the mouse device when we're
handling raw events.  Smatch taints it as untrusted data and complains
that we need a bounds check.  This seems like a reasonable warning
otherwise there is a small read beyond the end of the array.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kov=
aplus.c
index 966047711fbf..1073c0d1fae5 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(uint value)
 static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
 		uint new_profile_index)
 {
+	if (new_profile_index >=3D ARRAY_SIZE(kovaplus->profile_settings))
+		return;
 	kovaplus->actual_profile =3D new_profile_index;
 	kovaplus->actual_cpi =3D kovaplus->profile_settings[new_profile_index].cp=
i_startup_level;
 	kovaplus->actual_x_sensitivity =3D kovaplus->profile_settings[new_profile=
_index].sensitivity_x;
--=20
2.15.1
