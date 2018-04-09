Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243456-2-15953322694161020462
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
    1523243456; b=EI1qpr9OtbTfIbddf/iveYhv+0fDA89E49cfddU/Z9eHQycS72
    cJgzPu/GyGISjaFIyOI6zVdQIaKoqeXf14oltJ6s8Qt/kYoP7ggzZCO78hXbefV+
    6/aMonCZvAAXd3VsyWE1YjWXZ/dlsfjFjtLptw+DXz0dusyWCuHks5HD6wPyz37u
    0jKbgHEJ4Tpe/pg5t1mgAIvG5HKVLjBspuDrfIcv85QzyshVQQFtUnhyQ76OA+Jv
    hJWsPrl+vyvoAv+mX0iS9eJgybr5J/1MYjuKMwuT1LhuNLxgp0JjJOsdOo0IiPix
    XiD5BUZn8VhRI3VCYo6wa+mRCUdIdMxJNtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243456; bh=ZVGCG9HflT
    K1KnUqLeYhA3wMze/DAKC11nTUoVWTveU=; b=vueQYBs8Rx+/xgRTxe2LuBYInD
    oRqHpzotKyCIEpOWIMXLj2xzsLsFHxrvASoQS2/w2hq2fyRjDRnYfItBXaessjDZ
    lZOcjv6OapbF1YHLJXNxJYNtVmVQv65cypmbxE3zdeb6fRylW/byvsSnjLdQbg74
    THafqUrCm53KgWgWIbUMtGE2uBv6pEiW0efdu1hSVsdR7urzBdWXE2DV/6fPK8xK
    b1kaCJ6by2xvRBLSkRctYxATa1uTEmBtBjBtgTuavrkMzZ+DoFqRS8mlD96pLYXj
    UIcc1MFURN++qjjCfH8RsE/kWN+AMrvpTSIZemuBSoEGpIGclT8Ymw43D3fQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jk875YNJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jk875YNJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOOJ4o/+fhriujlLlfxmKIeFzIzEeVXto7tUy0pRSIspmjPC2/pFB5OWSKqB5MU+TFA1coxDTGhBIXRd/ZL3MM+FcO6zwChptSX7hpx+zF3ZXnxXWrHh
    KFheRNvhnlVTLH/kXcht3yMIapFB95R+cuMlovDiZ94sBlZNzN/fnYE8e9pu+y2TKsbCWkAxST1EAvF5Ws/YlwEATnxyKEqTvTzA/QWhfLNKbPorXJvFHpIv
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=2uGYnLLpohv7CEnstOAA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755000AbeDIDKx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:10:53 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755043AbeDIAY3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 083/161] i40e: fix reported mask for ntuple
 filters
Thread-Topic: [PATCH AUTOSEL for 4.14 083/161] i40e: fix reported mask for
 ntuple filters
Thread-Index: AQHTz5ifk1Ml8NB5ok2/Egn8FTd5Vw==
Date: Mon, 9 Apr 2018 00:20:54 +0000
Message-ID: <20180409001936.162706-83-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:aHZ9Jwr+HJOGAAOe5LaPjtfK7UGNFu8psCK6oPIjo4lTLMUJnlyxq9Of19O7eVAgmb7Zc7sBf7KO/Yktezbj6pgK+No3sN0wFlSR5A0XdNctv47gzYKYZ27F3Yz86quA/rRkLPTLPJevq/SxdtntE080glErACeTQ241/RjYiNdqbFTN6MIFAo/RKlNwTF2NrfnsFbgJirOR+VY0uLCuXEQeZ4LFClRTLDPoT2L03N6b8fZI0nVXg0LRy3KGx3RQ;20:7DqUL3CT2EIvEdaupsuht1hL1DHMqr50zpqEHa55AR1+D7LZlkFB38zm2zWl+bGLderaNr5UEvkZFIwX6L6SrP2YCsMWuAH8V3COz8Ad60BdLjZ5Tvpd2pjxucGZI6foNAvMwqGIpWfZUCKCFqk39HZHHn7pj3x8hoqCNmtVRwo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: be9d5c05-9fd6-485c-fe95-08d59db040e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984B82AD475A25A89D7E027FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 9D8l7hIqj2yPkHLrk0RLEc3gl201AJyZgA7ZmoAhkh+m2L6ppx6NCR2ElSANKy6sPB19+ij1bXPPybNn1906j8EUgH4n4CX3yTE/fHsvqJoRsNyyH9lae/KwSGxu+xeyr1wFX/TMngyilqCQh4W2mq0b3IPqbTJUKLLQWIsj7z1FgEwCWSu/+mW4OKtTA0Zlg5X7Hp7dfG8i8ruU1GY5mzrmpMBCBj78GJ1JcqV76s+m2ghtwEmQmgz0sPWTZHo+jVd499TcT9CVxBrZWtCaUn0f4/6HF3MHAC5WmQ16iSLIBhDQyw77nxIkkp0E4W7Zv4jConXP8TWC2myKeMWeGVr0SeSlqKSs961z0pfdo7+9JEZ+waBXil3p2JswqNaYQgG6BNq8ofa9EyLJE4ZQ/zH6MoFOJ4dsVA45dwmEQUI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9d5c05-9fd6-485c-fe95-08d59db040e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:54.0971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index fc27ba5caa55..ef22793d6a03 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2588,16 +2588,16 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_=
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
