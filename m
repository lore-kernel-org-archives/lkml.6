Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245992-2-16059846696731608897
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
    1523245992; b=c8DWAMaan/MCvZfWew4BR5o/kckvbFE6TOxRw7/oiJHjRWDUUG
    bAiHf6aI8Bkxp3s7RNmL1Ghawn5XM0mid1sv2hbrI/KgIz5euVnVfx8efNeo7YZc
    do6PAmDqOUTYmyiLLwg1/eN1Se/SqCN6Kp/NOkwMM+gMrcbomQ0cLCrEf8Ulxxvd
    XPV9/mRd76+l7D/68cYeTRf7tF+3CDH6e2CCy1Z6xcECfqpULmy3YUhe02rupr3k
    W/Nnoi9MlQZkK9lEfUgfL9F72dVGOVX3L/wJ6h+b5Iop3gX55ohiMuHg5i/nN0cI
    xihrgi1WMjvQO9BVahqc5kiKcbgP8eaX8DWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245992; bh=1yMyLhpp3C
    aL6Hm9l7kThX7o8Iii/NjgX6Ej01JGXfQ=; b=vIImr/KlNCtqxDimfoXcHS1bUv
    RqQMgwGYolKp8g0GQjrGuTlkz6Y4LAzeTCkxRKGRh8InA+5C+YUkHPtHDQWT0BSP
    w4oSxptv8glPdIZ6Awj40B7Us2rIrTA07cXidWwikdj0PfLnyM9zGYM2UphilUoQ
    x7tQ99XeBuxtElKWME914++dXtmRZ6fYpdqMITeND9IYvBmwxFC/2gx+HcmoTHT1
    Px1hP7T3VpKx9rel91CZC6WoRJ/Hx1ksXCc8k3GVDMg0fk8uJCQyDR3rs8TlVMEj
    9gL+8R0lgQlmOlt/zun5IvyeqK99lG9K41DePPeLgQ7a3RGuoEnE4kxQEwiQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ipaDNzPk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ipaDNzPk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfETif3ffm6XCQIYa2Iq/+dAbOtcDZ/f3qZ/vaKbk5hsnYJojlh07WfiT75egoiyIS5up5gkxoeTDW/Ma4t6leGjWZgMjRH+w33wsndgTQFuQG5SV1iO1
    UxCb1FeRtAax29QCGpjzt9h3Qn7+J1JSm9tEudt2Eud/DuKpH0cr3L8KcN6HTM2WA60V+hd+X4fXdNX5y8SppOtiQOnOLLbwvnvXCP1OV9cDqGt1bR75BOR8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=d3BLV84IBhtaMhsBMrsA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754341AbeDIDww (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:52:52 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753960AbeDIATX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 098/189] i40e: program fragmented IPv4 filter
 input set
Thread-Topic: [PATCH AUTOSEL for 4.15 098/189] i40e: program fragmented IPv4
 filter input set
Thread-Index: AQHTz5g5C66xvQlTWUeh8figI22L0w==
Date: Mon, 9 Apr 2018 00:18:03 +0000
Message-ID: <20180409001637.162453-98-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:UOoglZrKMkhjRsOI8tX/sQYOgLNZFSSp+apY09KcOeO+Rj0o20sIFcv+5aogPwgneetkiSMaVk8O8EhUVCTZtppcuKu4RkefFCyc4wWelhfC0wBkSSkihqJaCGpCZ+Ex+BfrfTI/3W9yr0FTm0fHiOWVwMM+nOakfvwAn8nsU/TZmASa7lAv6/OLHrHc3aZruXmBa2hep19k639fALnwbKe6miQDlYRvSahZ8//7BCY3KJV8FqzgFsa+j9aNlphN;20:dvKUHyGiCCrhQ/8yOvCa/6hfS2+r1zpX6LF1TCAMRB5IUiL3XB2zapeaKK38G9b98PM+RnC96LnUit1aLfMcaJKJXNgKmB/pb2TXKQzMnvq82ZCT8uQU5wmpCREkA1bf0kIXD5ioWqPQ450jhpAOfuMqRTAvzba0X1OWPxK4tLY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1369659-4e0d-4aaa-6451-08d59daf8940
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106397AE6CCBD082ED954A8AFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 9hqED28jAA+l+OJ15CpxuSfSIPWb+3bwjST4/bKqfXiHphpVdtfm7H7o8AJ3tRqeRc7u2E8GEd7SjA4fGPbjeXIpV8/n8XgFnIb2goj1vpDvXAIeirmQcMmBxF8fTb9hU/BTZ7/cUX/XAtPvc+MzLUqWnLpZ4d5U0lmmu5SinevTQp0Dj+FdMs2RDbORF6+bPoNhsRmxljk/LRSc/62U9M/C0ETJSYwPUJj0qbPibtc4eURGO0dfRDdT2N4yz7d5n3qIKQUZlRwZgas+uzd8SxPvrKLGcUZGM51Bia4Z7ZxvgbZ+fkokJ0PAKyxhOjszkZ3uwS6H4JBATL8JbdadjO2WLO6AN1e+LzwBYdbSped9Wh8vGoKESIEwj2Ug/19hPHjg2xCyvZDi1SZiIqK0zmHwJpNyC+lGjBL013wGWlo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1369659-4e0d-4aaa-6451-08d59daf8940
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:03.8504
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

[ Upstream commit 02b4016bfe43d2d5ed043be7ffa56cda6a4d1100 ]

When implementing support for IP_USER_FLOW filters, we correctly
programmed a filter for both the non fragmented IPv4/Other filter, as
well as the fragmented IPv4 filters. However, we did not properly
program the input set for fragmented IPv4 PCTYPE. This meant that the
filters would almost certainly not match, unless the user specified all
of the flow types.

Add support to program the fragmented IPv4 filter input set. Since we
always program these filters together, we'll assume that the two input
sets must match, and will thus always program the input sets to the same
value.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/e=
thernet/intel/i40e/i40e_ethtool.c
index 5f6cf7212d4f..28daf7e7ccbe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3800,6 +3800,16 @@ static int i40e_check_fdir_input_set(struct i40e_vsi=
 *vsi,
=20
 	i40e_write_fd_input_set(pf, index, new_mask);
=20
+	/* IP_USER_FLOW filters match both IPv4/Other and IPv4/Fragmented
+	 * frames. If we're programming the input set for IPv4/Other, we also
+	 * need to program the IPv4/Fragmented input set. Since we don't have
+	 * separate support, we'll always assume and enforce that the two flow
+	 * types must have matching input sets.
+	 */
+	if (index =3D=3D I40E_FILTER_PCTYPE_NONF_IPV4_OTHER)
+		i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_FRAG_IPV4,
+					new_mask);
+
 	/* Add the new offset and update table, if necessary */
 	if (new_flex_offset) {
 		err =3D i40e_add_flex_offset(&pf->l4_flex_pit_list, src_offset,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_main.c
index 973bad818e81..2d9a50c82141 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7744,6 +7744,9 @@ static void i40e_fdir_filter_exit(struct i40e_pf *pf)
 	/* Reprogram the default input set for Other/IPv4 */
 	i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_NONF_IPV4_OTHER,
 				I40E_L3_SRC_MASK | I40E_L3_DST_MASK);
+
+	i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_FRAG_IPV4,
+				I40E_L3_SRC_MASK | I40E_L3_DST_MASK);
 }
=20
 /**
--=20
2.15.1
