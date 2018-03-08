Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485804-2-3785412400617763016
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
    t=1520485803; b=Px6RPRO0o9W4ql0GbhAP297E9Qva75yCIDOgHxlgDmI4gQ/
    mL6zqrA4trUmB57lCsBG/K/Q3j+Nuhsk6wHy1mxk0Pb3IU2m9FmynN+hOLcjN/Kr
    rZRTusobK7OGKEFW0SyJSBbzaRxxxr28B0QRgfsT+1Ai0X585rv2soe81+hyw+oc
    dwztfG7KpFYRjDV9oAR0Sy+IyXDDgQSGjsqCIR1ColTmjQJoIk+gkEOGMIAaCmk5
    AhYzC5Ij8UtKLyMXs79xrOm/kTORW4/xYdmBjjosfqlWHBsAsYu+mVTRkJZnmyz4
    jeUMmv1L3pjoN6jMiVU1A5MAMKnDh+zKq2m7eTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485803; bh=sIEwV5
    XP2a4h++4vnlY1Ek0cYp6Kh5Llw/b1zDQ1gBQ=; b=JgPSBcbfw02eJXx//5TxiI
    xcQePMs/X+bbBqu1g8jxdOH6uixc0T6OCzJ8Wo36dfe1MGiRNxKvlGTZmZ60Syds
    PMgxQBJ9f6Nc0JhjL6XLGM7+DwU8CY6GG5vM9CnsuqGqcl2pUgW5oyInV7+D3mec
    MOa6np1UFFCmDDSF3kKEm27SN/MYaS0WnPqIQmjUSmUFa5HG7RkWQCDKB/mVW+DM
    F4T/T6R4e2++MwaGA55oMzP+/aoVPWcBNs0ec/CMYHLEIZHxiosGJE9a3BqMwiTv
    ahrWoy+iuum1Nef3I3SgPq/wwA7i4Wm3T7eKlp5oJUYIza5iDCtcDGtfoAnNzSQA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XpoRVTyo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XpoRVTyo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965760AbeCHFJ7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:09:59 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:61856
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755361AbeCHFJE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:09:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 29/53] qlcnic: fix unchecked return value
Thread-Topic: [PATCH AUTOSEL for 3.18 29/53] qlcnic: fix unchecked return
 value
Thread-Index: AQHTtprGR3yrUskuAUiPX0Rh9QLpew==
Date: Thu, 8 Mar 2018 05:03:19 +0000
Message-ID: <20180308050230.8876-29-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:3jIZV8mcw7wGx6X4eFe4Tc476Dasa46wJdrexzneyymbIz3k2GMspJo8z++/3MvTqMKxrA5W9zEvAb2sffFU/IhIR+9+BVeQUqAiNvxWMLCbdyshiIB+4/29aIDjGEseZWJjXF3ODaAtXpIInJPCy5VvJQJd9ZAnSZDK/FQAD9BV8skMJfvDpeVovUxGmDt6IMBsPW9R6DO8ovlog8Ft4ISU6S89+kD/19Q/CS7S5+irAAl3QSjbcba6/k6VfTP1;20:YCYDXetNDDqK+3YYxxQtd3apvVvRgRHtwDm6K6F3kmCIu5ZF80YE/vSpZO7NVNZmvRDr52byR+U8JDJ3pRNiVOLb7pryHpl7EM4bA4A9Cjoym7tuyb2oHrV2IRKVIBHrAQbpelC7Jw7rl7HcST8re/8kvM4xztn7bjZBeJZe9v0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29748c1e-3ede-462f-5418-08d584b2b465
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030EEC316D073D0B5D12F8DFBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(59450400001)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hhjYM6NQt6/gRvglcbxbROSUvnMx5F/PpFVsOoa2NpN5fLruCIX6LmhJwGE3sxEJI/QPxx78tZ/ppHjqI++X+jwdsNFZUnxNymVXTjnEJv6/NqKXYjPT1CXwC/xm0X+n3hc1BBJ0DkrDKJWMdwYgXqCTCJn/VSxvZZpUvVZLK7WtjzNJiOcmmJ+YE7/FpF6iFjEYxDRDND/lgdC8apo5OcJgHKcq+lqdn+G2wCR8cpWBH5J0Ll4B2PwlTaWdzpTDacybc6+1Ohlefz1SdVvDMNqWTwTwoTBuC1uAfoN9XIswf82ZV/vpdbbjEZpGRy90KAcOHj8kohze4exat/HG2g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29748c1e-3ede-462f-5418-08d584b2b465
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:19.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 91ec701a553cb3de470fd471c6fefe3ad1125455 ]

Function pci_find_ext_capability() may return 0, which is an invalid
address. In function qlcnic_sriov_virtid_fn(), its return value is used
without validation. This may result in invalid memory access bugs. This
patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/dri=
vers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 1659c804f1d5..44e3cef336bd 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -126,6 +126,8 @@ static int qlcnic_sriov_virtid_fn(struct qlcnic_adapter=
 *adapter, int vf_id)
 		return 0;
=20
 	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
+	if (!pos)
+		return 0;
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
=20
--=20
2.14.1
