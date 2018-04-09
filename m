Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243482-2-2582762463702681695
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
    1523243482; b=XW3cMHh2cf263QJVcxfBLnd1Okxj4Z36ti7BzB33M97gCncrPb
    6YP2+lZM+JL2uKUAxwOYywSMGtSG9sINtOyHmcxKcRdOSbjMQGGjdxUOSclOnZep
    gkb19XGQUZlQBFMVT/lt1n0kIN2xUyZWQDGvxLTz6I2lCwy3Pn0RbNiUtpbsm5z7
    Wla3oeA9lSlAhHcTy9rtE01gqvYWfGgomKIPr7ip8JFkbbQUawzeMpyD6o9TouYb
    bC4QOol8oNXApZp31dTax/ddnSn+TyFhPsgw+SjdEKTKyYCQdDHPa3UHMGtkcZb/
    m5e/4imE5pHCERevlUNM1gw7JyreBMdDwZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243482; bh=HePH618lYi
    UuWId8hmgkjkZN+NK2FoPznN5QOM4Q7EU=; b=NRBmbMKZIomIYIEFWf3QmycXiA
    XL4bNK1YnWzvoq9MfNrnPD+lSBfVzNTzocPh5EPre4yoGBXm0mGdKkIIYXszjctz
    znErZJn8l9WXNmXeRvbsSBhvzL4YlDvPF77IMo0qSOUUonqEP1Z+J+cidwa+vHJG
    /h5LKjIfXQBgdfun4rLEvyIl+VU1zS5O87kCx0AbzPlPPkGB1xAPmm28oZ2kfUq6
    jpSIXMSHHcJ79qxmSV2AolMXudJ8mbg0x58/bpnAun0FFsoOsws1hwCqlNkFjCu2
    CIFKLWv/qv6WSjcVTPJ6l1MZNabSSOhA6BGshiKkj1Opubkf9Rb+xUkG0ACw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ecgl7BCm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ecgl7BCm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI5CH9RBWB4ltnfdsZ3oiSra/cu/6PuV1gNS6jA6WrwvO6AFRY2Gb/XAtbpXTswBdSCvTc3dRGrkYyv9JQcNNCd5JXXTXDS0q5GqzdbtRGSmWdx+40ZW
    a+55/v3WfC9F02a1XmWOYvuovNEoISb5HFgKRcfjdqd5mGBlNaPALbxUkCna68qPBssDXx3elhvvYrIbBR59aM1WT3ov9sgZ58/r3N0wQ8NIs+TyMMDw0V+C
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=d3BLV84IBhtaMhsBMrsA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeDIDLT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:11:19 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755034AbeDIAY2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 082/161] i40e: program fragmented IPv4 filter
 input set
Thread-Topic: [PATCH AUTOSEL for 4.14 082/161] i40e: program fragmented IPv4
 filter input set
Thread-Index: AQHTz5ie7apmLrhhLU+Hre8kqeWstQ==
Date: Mon, 9 Apr 2018 00:20:53 +0000
Message-ID: <20180409001936.162706-82-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:hc6j6QE4lUCGOLENSnSr/W8qVVZdP/iH1P0T7iZ7rjyHrrRIdbyf69NDpVaGhFkwhrm0HuLpARxnG9ZKGVNLwkrznSn1D72vYM92j3Rmr2ELpJjeB8DRDi/H0Q+jYEvzNRbrg6Zd8z+eJe4JhrHsoFK/okxJr1rGFNAja2UM0NioUdxXCYqfVgfunDheSaskwZj6AvBhTbOdqL5sPhxxC7FYnCCbbrGn+qxqL4g/o9S4Dw4USe8qA47lmZzCE1uX;20:il4xc1cCRr9qJ6D1NpBbOaMu2cvzpz29EcYdZYaByAtqfVfWLHgb03y7sq4qp11fJgF23ygyH60ULzjItTtr/Sr0ZzbGrxHQ8a0/Xha7YRZzp+5Tomruhj0Yy2lCVNTrNpXYI+lICky7dp6O4iWoDIG9s1S6b6VjNRkcZcaduIs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd7431c5-3f45-44aa-a070-08d59db04084
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09849F528C5D2226C4687738FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /yuyxOLzkIh4SMnuJ9MgJoKb7rklsSzyThpqC8AVPkGjkrENr2W8WSv5DGVmtZloHl3QyZiIIXTepRp2m0cGfGBOUP7u00zxuijvEMFC08i11XN/l3cyYK/jMYNXjpu2fUn9dffTwKtQBR2lgZnTOFNiBoPZsaLS0ctH4GOzdDBBGlX9k7WsZY/GSilTjjNnYr483gLwHPEHNnEiWyYVNzeF8glfqYWYxIyb/csI5FZ2FmnhILZPSGlwi2RbtF5sfMmso/AIt3YMaKIcKtP0selKxemZd9SsSQrswOuQzWn5YtdeXdOxCndgYVI6xnW/jNxKHw27ns4ZSMM2qoVVzvuPBr5ZgGMv1m/jGBdETTqxQ2xxew5mDh3zQGxEZkIFRsY0jzRrnLOdfUhh4XSPQ4gMlCichaYvVUuqp/4UboA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7431c5-3f45-44aa-a070-08d59db04084
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:53.2221
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
index 05e89864f781..fc27ba5caa55 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3648,6 +3648,16 @@ static int i40e_check_fdir_input_set(struct i40e_vsi=
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
index b1cde1b051a4..d36b799116e4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5828,6 +5828,9 @@ static void i40e_fdir_filter_exit(struct i40e_pf *pf)
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
