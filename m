Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489445-2-10805970814266367679
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489444; b=rxn6Idl3nH1ILVX+RdY55X6r+OXJSB/3GS+Ma00eKjF0WVI
    bkbXZFJinA+S5nXXUl2HFna2rB79ttyFr756e5gH0BWQfKlfa/K9J76jZI9ZnqTU
    /vv+kEA+EZUqmdHozFGkJuIwsrOe6CcKdp+yzC/XOOiuTKqcvTfUpaqkalsvIEVy
    4FbNJlBw2kNcS/IPtbcMZrjobMGhpDrWlVYCHB55aj9gplmrFjbg+pWw1yZesvxN
    53xGMTzd5tgttM35TqKmeYCJxwVpLqlP4/vhUdzffKIxm9z4oNUm4YVtW8lideF0
    AuGVYncEMUAELKQrkgXuTIreiNMQcSSzpFSgHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489444; bh=OwzmtU
    5MSLVj7rbJwScdcdLuOcBNFb5fwFEpWBfeZ+I=; b=ebYDfRrLk2cDcjawqI/EHV
    c7MRdYsunEPWNat1zQHYXbqe1klkzkuIcz+CK4KoMpQxwj2hF49L0VNAjpFxLWps
    TBlnc/g9f1Bg6qbig4nkYHZoLRnEEZvk7iQn3smk8TzeC+B5dbxCGY6YQZ05TH7L
    VEsBsT2R45GudxEbx1leT5IRpJcU4Wr0MtnSXG4epQ3QjUXxqbaFDAU3Ia7MeSEP
    1xO+FRmle6rV4cCxWSoE4hq37F0I/Fr3eZg2nPGZDATjMbPMm5ow5dhPrMxEyQ3E
    kncgJW1cqu2Pf+1rA7cUizPTGGRUmtTuWJgpimIE+GiFIS4H1XXjWIRvI+TwHhcg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G6H1RvYP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G6H1RvYP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeCHGK3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:10:29 -0500
Received: from mail-dm3nam03on0116.outbound.protection.outlook.com ([104.47.41.116]:61650
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965769AbeCHFBl (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:41 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 081/190] qlcnic: fix unchecked return value
Thread-Topic: [PATCH AUTOSEL for 4.9 081/190] qlcnic: fix unchecked return
 value
Thread-Index: AQHTtpo8FLnpJ43NBkKY/0JaEGlmDA==
Date: Thu, 8 Mar 2018 04:59:27 +0000
Message-ID: <20180308045810.8041-81-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:b7Tm/8ysX4HfalvZh4ZNsM81yfrOuWyHubzbUXqRohxt4yQjc4mKSmPKHF+WI03s1q4DB309bse+DCWJp/S5mueGoEejwOgw74MVCliy9XgqTcTCbLH1IbNd36NVV5MbT8MnG/BkXbtwClCPN54900USmiO9kKk4UQ1vy3xIjwcaPYmiwWuaHfe+RQ79FlW/rb0P9R99usgfURuebU5geSiZEYGTsysiDAqQhhP3Cs8TZlbkerAh2vArdn81MvF9;20:pcP6E7eapZbQ1rtaNZfxw2rTd5YHXd8zhhrmRKIn8NJcbOaM8w5ajc5ywTIv8fVVD6gMBRnbxyutLtRZc9eGl4J/2ppuXTP04kdbpaBmFZ1+1TkuSv3bRJinvg/WO/RVrt+/P03Pm7NpqPjXgYsqYaY0XSjDt/8Ki9Bd13JtKuM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2cc5b31-3840-4114-d52e-08d584b1a6f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090193B23AF43AF6B7C8379CFBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(59450400001)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jdadPWJmPNaSfZSet62a1xEJXpuz0nIFTH2YQtvJMr0frzaZZuyxH/wRcZ3Ew22KWKxEeo2ia816spSFnw1U6XN9zfLzZtg7a8zlJATftStBM3bhqg3AzMVQTmzNpjFcBbjYDw5rdxL/5OBI108Vn8T+LgbaY9K6CN1nH3yMcAKhV8raWCIGfJ1f+l4+n5GlUKszgU7hdV0vxxpCiaiOOD7PJAVaHn3sUsi8u/9AhICMtmyuLu21hrPWUTW6J7N9nPXRJ4ejJFm88xN8KPIj0o00yD7U7LA01UgAPx6hTwjPkbsj6YeGCUI/7C9BxDQy+1unoLMPL+GHt3LpBS1voQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cc5b31-3840-4114-d52e-08d584b1a6f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:27.5554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index d7107055ec60..2f656f395f39 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -128,6 +128,8 @@ static int qlcnic_sriov_virtid_fn(struct qlcnic_adapter=
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
