Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480760-5-12206928296980939148
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
    t=1521480760; b=dz2BN008v3AGtSIMDB1W86rNW/CXGZ3zWo5+r9/0JLEeoTz
    xrjpaqU2iaFnWO3yxr44zqP+XQy2Vi0Q706+E6xa2GbVHVCLmjw/VmjHGw/IsTw0
    Ds4myzFz2saOh2a9h4UYx9omJBmKFFW8S1iDS85Ty/o92akkZHfYg0NoeGQmwyoN
    3EiZYYFVI0jpbPCfX9ziIUNdrrW6JRsgY+P4oPLJaEjL7tpLlb9iXqlnGQ9xqnbw
    xIrqG21tlJHIRbqgluaS13ANtCwTS3a3cyJBPj9s0xYQTkViswrsS7dzfTzbtglx
    mp9Erlsf1uC+Er+5GxA6G/e71wBqdT4rRliNV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480760; bh=fVKowD
    vAMNDeM8sicGW1vy7Mu0Vu5E2ZaGnWc7t2Djw=; b=BrkKK5W4v5WwOmeIKt+i0n
    B2LHb1AgeC6rv8++eSexf+eghMRu7+7IarLrvavhsBx+kr2SFiaJK37rQzTAnp6Q
    7lVHw5WCiojbhWCVoHJQB6HPRD4V/uy8YJWmC/SFbE513xu9pRcfvJgHvAyChil7
    oU2Q9p7x2Z7cp2nEYNzkBkifuI3MtfEui+g9d1Uta1b3C2Su1tVmJQogCfVLCRcA
    lLwZW/UIzFH3EmA6H814uYiq/P92KQTsrNGDIK8GhrBZB+dS9sZg8QkcGvW2WB0S
    Jjrug2v3mlSSzXB9XonFjnYW6ym5df1u3ByoQitQd66JO5jF/CJ+3PZN1dkJTN+Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B6BbrcUC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheduheenucevlhhushhtvghrufhiiigvpeekud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B6BbrcUC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheduheenucevlhhushhtvghrufhiiigvpeekud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966050AbeCSRbZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:31:25 -0400
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:10656
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966039AbeCSQG7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 023/167] netxen_nic: set rcode to the return
 status from the call to netxen_issue_cmd
Thread-Topic: [PATCH AUTOSEL for 4.4 023/167] netxen_nic: set rcode to the
 return status from the call to netxen_issue_cmd
Thread-Index: AQHTv5wmhVQKMOmLI0eI4hA1KZ85ow==
Date: Mon, 19 Mar 2018 16:05:49 +0000
Message-ID: <20180319160513.16384-23-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:3s56nniVdtgLrkY0w0rN3O6RgS5mHbUJ9Qs0XIVMmp71TUOP01xiEpNAh18WK0JaYG2hFkxj2kRG/Hyej0pp3OBSavyU4ngfqgtdqYkmgDAME0CziBXTYZzaQwBpX3VUlMgn6oWY6N6CcSAK8IP8kX6e7xg07ezPeW5mdzH5qiJYKH8TpRNPqCqoSuvt8wMU6odLQ+2hLfgZH1YTTZUPJL3lPDwBF19W8YUwy3ajurrzMFZFDfUiwt/Pm79wnsM8;20:6mNHkhL493TqQNVd6wA6dSSmjSRZkOKV7eZe1xHfS1/uNPYS+HXRvy47wPdJpczIfDv3fbaU9tcWAZExHE7I44b2Fwwgr+g349DfpCuiurML0LiNrkVavot679mh3qweOK/FMQcPCMKL8qX8y0l1Q5HLlYAOkpOzhaqMhjJ+OgM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e40c98c-4fa5-46e4-6b49-08d58db36d77
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1093D74B381EC318B594FB51FBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(76176011)(107886003)(2950100002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qfjvmqbMxOmCDR5vsv60COlS/WHmTvfZdK7iDbQPPSl5ldr8C7RzX66+gDg2ROczYq4rpwESgiCkzy/FojxiJgjv0CBND7eMrc/ENdYnGa7E7W1zJhEPyRwBnA1AN/yj2l+Qh4+7tcRsg1mZDi+aLnVbJbEiAufB4IT8eMgJE5Vg/PT/EsnsZlnWMLKqEO7GsH5bWqX9LY0bnduhjUz6KiX+weKGlCqX2qjDUOcDLTI8Ebq3HY3hTlePO3o8ShjR1amdduKzg92m2SH7rDG48TuoRP60h2VWn/HvA4mMzH/bLvvJA0zYyvEYCwVrMweFSp7uVEcDC3WX1N4kDwQcIw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e40c98c-4fa5-46e4-6b49-08d58db36d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:49.9330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 0fe20fafd1791f993806d417048213ec57b81045 ]

Currently rcode is being initialized to NX_RCODE_SUCCESS and later it
is checked to see if it is not NX_RCODE_SUCCESS which is never true. It
appears that there is an unintentional missing assignment of rcode from
the return of the call to netxen_issue_cmd() that was dropped in
an earlier fix, so add it in.

Detected by CoverityScan, CID#401900 ("Logically dead code")

Fixes: 2dcd5d95ad6b2 ("netxen_nic: fix cdrp race condition")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c b/drivers/=
net/ethernet/qlogic/netxen/netxen_nic_ctx.c
index b8d5270359cd..e30676515529 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
@@ -247,7 +247,7 @@ nx_fw_cmd_set_mtu(struct netxen_adapter *adapter, int m=
tu)
 	cmd.req.arg3 =3D 0;
=20
 	if (recv_ctx->state =3D=3D NX_HOST_CTX_STATE_ACTIVE)
-		netxen_issue_cmd(adapter, &cmd);
+		rcode =3D netxen_issue_cmd(adapter, &cmd);
=20
 	if (rcode !=3D NX_RCODE_SUCCESS)
 		return -EIO;
--=20
2.14.1
