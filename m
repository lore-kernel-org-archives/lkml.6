Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517682879-3-277462116263577476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682878; b=OdcyKMnyfFqn6A8OmKHYEyuMvWtvRm/e9M2NdQOJCS5FIRp
    c2ek/bl5n3UaapQyzXpFQa8gE/K448oAKvwtCxInzepgCow+cPI1n1cC595BqZWj
    HUDrvNFQqr0kt35rfGN60XLA9al+SejjEk9GolZii6NxRx47DwnTfGyXnJxG7JOC
    PMroxo3xUMCoV+EqTHGKN9L7kr/klGWM+oh8aj22lD6B12iEAPPgCirijqJ8jwMz
    8C2MKJDzF7R8yGTKnFA/QKwilw7xQBVjIG2pU8XHwrKpkaqhMk8iGZlNV8suEJkd
    AZ1/H4ThT6qnNpygjXaIDnhiLGT1siNiVgbDhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682878; bh=sWsjgb
    cMlFZ458+B3FstuKkaXI6qNfiYqt7SM+DRCAI=; b=r4i/3a+NDv6c8tj7So/Brz
    ABsm/0bFP0jl/N9l8pLQZ1OsuAdRTKS9y/VXX3PqWj58GbHPBY95Rib7sSB33d+4
    YttrCSHVwsQqXX74DzGEMOx/rq70CJcbCoWjYCdE5X2VkRmyTObgcw8xzAR0QZss
    vN/Zb858Q6LLG1LkJBFP5ILumTRI5XqTazjiTQfjNkidauIbPr+ZG7V9CfGzf2Yr
    NF1Inosgdtf+T+HDdJoVDaRGTZeDP2Ww+n9B4+AG8Z8xBRFHnaIuYUqlLcMTnfab
    Qnr3XLHdAZxqxzFxdpEmGKk5AdURo2SNYlYXcVMUDCuxQOh9cwJKnM0+BWKZplZA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cgm0CB1S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cgm0CB1S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeBCSeb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:31 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:4928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752400AbeBCSEV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hangbin Liu <liuhangbin@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 058/110] netfilter: nf_tables: fix potential
 NULL-ptr deref in nf_tables_dump_obj_done()
Thread-Topic: [PATCH AUTOSEL for 4.14 058/110] netfilter: nf_tables: fix
 potential NULL-ptr deref in nf_tables_dump_obj_done()
Thread-Index: AQHTnRjw66h77yRu60iAOM96oxXgVg==
Date: Sat, 3 Feb 2018 18:00:56 +0000
Message-ID: <20180203180015.29073-58-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:3cQF8y85l6XRQD1nJ1k7hJbLWVZnzItzQfILIWn3ETSIDWlqSG3hyRRvu1ndVLgdA/IVXNBrXStlDXGbSFeDjMYnr6w3yn9qJzrQK/+qNcZOkztwkWS6jxjboIB5cQZrfHmsArm7Dw9DuM35pg4a6dsOglibMCe/65O6l6BkzwfsCCYtNNU0dIyCg6Kn2yXF6XVU4mPVHciE3aVpuaDsjxYBYN8Ta9JvqXP29pmFPnDArWGsTmoRVB/2K/Ji5cR2
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8a4a913-a299-48bb-9317-08d56b3027bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB10926B74898C6EA4BD0249C8FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(6506007)(76176011)(6346003)(10090500001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(39060400002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: IQdmFwN7Ln/CqxZXUfGaZN4fDhRZ9c2qA1+W4/eYwD7a2Mpo7EyuEfARkPHx96yZHIZPIxnb7Pvgf1vfzo+Qug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a4a913-a299-48bb-9317-08d56b3027bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:56.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 8bea728dce8972e534e6b99fd550f7b5cc3864e8 ]

If there is no NFTA_OBJ_TABLE and NFTA_OBJ_TYPE, the c.data will be NULL in
nf_tables_getobj(). So before free filter->table in nf_tables_dump_obj_done=
(),
we need to check if filter is NULL first.

Fixes: e46abbcc05aa ("netfilter: nf_tables: Allow table names of up to 255 =
chars")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/nf_tables_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ce49946f755e..5b504aa653f5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4596,8 +4596,10 @@ static int nf_tables_dump_obj_done(struct netlink_ca=
llback *cb)
 {
 	struct nft_obj_filter *filter =3D cb->data;
=20
-	kfree(filter->table);
-	kfree(filter);
+	if (filter) {
+		kfree(filter->table);
+		kfree(filter);
+	}
=20
 	return 0;
 }
--=20
2.11.0
