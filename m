Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245974-2-7963215468700527829
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
    1523245973; b=ZF6p2BkddWH+3sPzN6lJ7w2OUnevGP0CHgbYqup1VKendScl62
    kGLsQvKjYyA+RgqaiWRo3fg9U09BHf/V29bNykBlIKPOrbmPFI/CGYaqErjT6JD+
    2AluOX2yNR4N35AxBUQqOztBIZPOU5rRP8kDFaKptU2/f4ltsv4YPl8YqU4e11AL
    1kJCjMzkYhVRozTZwigOpFEzXSewNoWm3/BLMYkEkPY3pU5x/OlzaSbMLh/+hSMA
    1vX4/vN/Qge0b/6NttvaBKg5EsN6AIG76dtpVuPoQWNpfhYId6vGAfEd3LdKOdeQ
    ShpFbvZhOi5tuUB9zBBo/c3VtFh78CbgcFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245973; bh=1hPLuWxeDR
    jI3cPsoiaBBnZUxr3gmtyv/5Bj4MrTvJY=; b=oKt8pdqzbsqR3ezDV7/8uGOzBt
    m77+Am29hVghEFutB3Yjnz6khrSrvhH5DHVL0Yen9nwhAlxK3xbvuFx0A9+51So3
    nAONVVbCGHcua4qO+0O+E7VrdUDWc3jU9JKTlrmUOmjN+/JbireU0zSfgwAzTiLl
    Fo/6dBbgwYA+6PFuAoysnsH3vpmmozrnsA4aOZHZrtNBKhNcATFEdmVM+KSgsny/
    VADYcvNcit9zqPAvWE0Db2MJgCk7rJaE9U6Pn9lsIWR3/XUrj6BU+kWgGM6fTBOM
    hLsm1SUi/w3zPCoTmEQqSRZTjEBidpWWVRrYmnSr6aKqDRuze7XcoZWn83tw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VEtdzqrc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VEtdzqrc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOQ0SfiHkzg7wSuuIiqwo4qzzmVZjS0/Mv7REqoQvla2YOhtkVUIaVdCOMWCwkzM0J68+4kSE1nxdIzdV8E9RBnttP2PRVefYpoEAwGAwhyMjs73ZIMU
    YeXQupkdgLbVxC5Z2/mZFxIAh0U5Qkpp4cY2j2DpR1DM+niznGRNEZvDxop6DljD5EM7dzTPwEKsNVU7XGGO6aynJC/khXlJXtgCxEODW/8Hnzd4Q+J1cMny
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=2uGYnLLpohv7CEnstOAA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeDIDwt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:52:49 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:11088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753989AbeDIATY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 099/189] i40e: fix reported mask for ntuple
 filters
Thread-Topic: [PATCH AUTOSEL for 4.15 099/189] i40e: fix reported mask for
 ntuple filters
Thread-Index: AQHTz5g6VWkOSmki70+jRbxC+rGBxw==
Date: Mon, 9 Apr 2018 00:18:04 +0000
Message-ID: <20180409001637.162453-99-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:ZoiM4LVQYDkz3tmTrVAgSozV3X9naaoLyk+CPRH1fJlMDk66MdHDhjDapdbxCgQGX8SBVajq7+7D4oIrO7z/IfEFEvyoz2MfxxtlmK20sZ8C5d872nXcq9EIqsdoolcEIQlxLuPSahVbS1pO24MH6W6pgcJv5s8/P/T+9EDTCO+HkN+kKBDlzymt5uR5BqlTbcUkhy6Q0fSIC5EfwXzx4fKsKGP/6IIUqJSkVQYXLMFYeXEodj5VHvOO97GKJR7L;20:RcdHr+cpMhHnrWeDMYFlsA7G/CffikuI2zBkuCHqhQyCL9Bey8DhhIZjV7gDpseXodAitKzfM8PTsj6/XCHED+JbPaRNfReA7EHR4hoGmSskQ0Ke0Tu91iDKnA63o2cCUG9btPzTeyksWg7ExiZBtOKO0jpvzzRvRc4OceooOcQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b4359dd-119f-4f81-71d9-08d59daf89b0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063D097C1D03BC25A3AED53FBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(575784001)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: K3pB9OQAkvWMclzlGOoeExq2QCALN6eSHKKvN/X1nHnLsPREIx9W5opB8YZR+oT7vUzzbJaQKJQAzxYoAUXvlWZXCWoZSa5m+vkYQZwzkFeeckOsPxl4A/T/s9d27sohJFMyJHl8jO42dV6LKCeUSBDF1S04iNP7P+6f0vfdAJfLr8XomwDqDRXc1j4OnyUMNdtN/xEg8TSFPUR/RiU2vIzHJgu3EWWHKNSGazwpT7XV9vejQdVWeoUTB6v23sYQrjK7HAyzIRPAzi0jt3mdWcDveN/rmJtlbjIrTDUJr7QBjQs1FXTQGVJ9VjmZNhDpZos7TwjISBjGWeVTo99Y7N+/qzAlhlISWiDItvEmh1npEkUw7dTCSIANn++JTaYxGFCBSd2Qp8NaKF5witWOU1dVhwoT9rsIc/HRrpGA3m8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4359dd-119f-4f81-71d9-08d59daf89b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:04.5691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 40339af33c703bacb336493157d43c86a8bf2fed ]

In commit 36777d9fa24c ("i40e: check current configured input set when
adding ntuple filters") some code was added to report the input set
mask for a given filter when reporting it to the user.

This code is necessary so that the reported filter correctly displays
that it is or is not masking certain fields.

Unfortunately the code was incorrect. Development error accidentally
swapped the mask values for the IPv4 addresses with the L4 port numbers.
The port numbers are only 16bits wide while IPv4 addresses are 32 bits.
Unfortunately we assigned only 16 bits to the IPv4 address masks.
Additionally we assigned 32bit value 0xFFFFFFF to the TCP port numbers.
This second part does not matter as the value would be truncated to
16bits regardless, but it is unnecessary.

Fix the reported masks to properly report that the entire field is
masked.

Fixes: 36777d9fa24c ("i40e: check current configured input set when adding =
ntuple filters")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/e=
thernet/intel/i40e/i40e_ethtool.c
index 28daf7e7ccbe..040e0dc6cb7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2740,16 +2740,16 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_=
pf *pf,
=20
 no_input_set:
 	if (input_set & I40E_L3_SRC_MASK)
-		fsp->m_u.tcp_ip4_spec.ip4src =3D htonl(0xFFFF);
+		fsp->m_u.tcp_ip4_spec.ip4src =3D htonl(0xFFFFFFFF);
=20
 	if (input_set & I40E_L3_DST_MASK)
-		fsp->m_u.tcp_ip4_spec.ip4dst =3D htonl(0xFFFF);
+		fsp->m_u.tcp_ip4_spec.ip4dst =3D htonl(0xFFFFFFFF);
=20
 	if (input_set & I40E_L4_SRC_MASK)
-		fsp->m_u.tcp_ip4_spec.psrc =3D htons(0xFFFFFFFF);
+		fsp->m_u.tcp_ip4_spec.psrc =3D htons(0xFFFF);
=20
 	if (input_set & I40E_L4_DST_MASK)
-		fsp->m_u.tcp_ip4_spec.pdst =3D htons(0xFFFFFFFF);
+		fsp->m_u.tcp_ip4_spec.pdst =3D htons(0xFFFF);
=20
 	if (rule->dest_ctl =3D=3D I40E_FILTER_PROGRAM_DESC_DEST_DROP_PACKET)
 		fsp->ring_cookie =3D RX_CLS_FLOW_DISC;
--=20
2.15.1
