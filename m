Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243400-2-13304544936844709963
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
    1523243400; b=eNo4yIhl+qQ48JnnNJ2OaM/xKUr0NsvV6/ix2r8yREMYNLBPKv
    DDwaOK50hQ8ZODFukx1SoWalObpewQr6zjM6B4OSJfGT2/nMZvXuvem+aKfb5kia
    fQy/GqSJnsjqzNV0n9nGBewc6pccTPRuoqWma5wsoKB/jPXvvbWLhNKBBKvQKnBH
    Tv95lO4m2W2cNh18fQPn3lrnY+/a/+t+f/BUtFjfyKaC1APSShyKKWuPTaStSqcp
    R6H4fMSfhbUQLO/S9JTeMrWGdBO6WdQtomTWR/jHaq1PxfmiYkpQqcyRGiHvpIxo
    E7nD0cpvgpHA6YaeY6lt9BQ6kfDHHsKZ93XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243400; bh=5b91y7owPB
    xcL6wZuvPs3MlQGRvFwMxyC7tHm+/K4h0=; b=d2G2xhHN/ngwxGMQDQdsLgBwXs
    J4CORK3Yu0AHwoDZ/f68GzPIB/lxL92XDjKjAmpame7ZgVRFBD+lY91hyBADpB8k
    fNUtyRmTFQgnwHmQoaIlIwnevX0eFw02yvY9cdBNe+omM4HnzI687vQEpEI694RZ
    gBMSzXuDlss80T0pyQ1xZOh/aTahvMPsbI7W1RIONRp8R5GVitH+HtYn6V90OE4I
    JULzrBAMYQOdQ9y9MF9O6AYSkLS8IQKW/79HkOgqMbXlcy82fGuz7Ko/UB5gOrs+
    xn8K0PmNvCAI4lbWQJWWXs5sM2oCSveAQihuu5scAL/d4gxnCgqErLvEVDig==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bcZsF6FV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bcZsF6FV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOn256wvvJvJflX6ftitUfb2K3K5nFuny8Tqt7L98Tvz8EezpbtuDm3Hjneu7oEx069Hl804SZ5DpPksupbXkYCjia7nioYNjhnf21Cy9sWaj7B9P15Z
    vWKWn2oNukQygO7MH43+xMXtfpOnonuJhRvM4z9lvMMnp0+HhM6bIcYDDVcBg8GyYPCz7j4y+yPImJZ33WHB6mALon8ptDJRQdHugyAjGZU8uJuTabaQgatY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gXLdhW2jAAAA:8 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=98M8BWyZpLcfewlxYQQA:9 a=uLeawkheiNOiJFPd:21
    a=yCE3bErIF824xLa6:21 a=wPNLvfGTeEIA:10 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754477AbeDIDJY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:09:24 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755068AbeDIAYd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 088/161] ntb_transport: Fix bug with
 max_mw_size parameter
Thread-Topic: [PATCH AUTOSEL for 4.14 088/161] ntb_transport: Fix bug with
 max_mw_size parameter
Thread-Index: AQHTz5ihYFB4NEzZrUOsBE9sl0gmEg==
Date: Mon, 9 Apr 2018 00:20:58 +0000
Message-ID: <20180409001936.162706-88-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:OZq1A2WE0rMx3Xn1L/NVsty3o6DfRMFmuyXrarzH+agNoIc5xVRZQLpAluXp/S0ApcZ9KUAkvgUusV5kGASv2Bxbcw9kv+Lrq8Fyi2EHFF15J20Jfs1eVdusH85W7mNma9gigb27dKZYsgrO1FNnqM0PC4Cwh5hICoHK30kTB8nuEym3WVM3YYA/QhcoBqFfsaMAxQ4/pNrDmH2wvVH0dhO8SKrV/DBNjbtQDlGl7G7ik78I7h2wQVwQ5j6JnCyw;20:9GBPmcFdF1a7uDPKOIM7TYkhYaGptDZsfE4w5hJwoNlrwx2Svy/XKRV8w+Qkfstq2ik3INfm4FkEPCc7Hz9lMxkkacWB4XBP2i45zaYDxi8j4mtkqLYZJuOkwnmG0OpO/lvc7Ftm9Dnodbh9hiDKLZ85pgz7in2PqwMS7xTk+v0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72cabd42-d414-4211-3795-08d59db042c3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984195816536546A0AF2688FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(56004941905204)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Y4AO6mwF7RT15hQmhjFE5NnbRtGP1PSxWTk1Lc3qq7OnOeHqWRiG1AVWm+YJ28jUwyUXYly18/gbnbMNTPl4yKk2pENRnLu6mh+Sr2NGexwPm/AXgKQa77kw1uaPkLRqpZgkoI25Tqutct31J3QyuNMQ5pzb5aa24KtBtcQcwpljvoq7Gk3S69p83nbIO2iKSzsLv9rY/PCR/WDkbP7uvTffz5re9Dd6KR37Wk3+GDCK9xIxJ3792XlR6Jwec2MmGgUgks18UV52MZ/sqoy7iRA+lWenYDQGLYAJ5845fGGhVE9xpG4qzP0m/DIzr1lOeddGDJRZ2Icc6z0nENS4cz9ACrKMOFhy8npf8E0UrZ9pwM2JQJqTLhp/9rTP4cnoMVWAMuWc7+0prHjaU2mF8ocCqVfnT+nOwa0Se2PmR6A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cabd42-d414-4211-3795-08d59db042c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:58.4408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit cbd27448faff4843ac4b66cc71445a10623ff48d ]

When using the max_mw_size parameter of ntb_transport to limit the size of
the Memory windows, communication cannot be established and the queues
freeze.

This is because the mw_size that's reported to the peer is correctly
limited but the size used locally is not. So the MW is initialized
with a buffer smaller than the window but the TX side is using the
full window. This means the TX side will be writing to a region of the
window that points nowhere.

This is easily fixed by applying the same limit to tx_size in
ntb_transport_init_queue().

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ntb/ntb_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f58d8e305323..18339b7e88a4 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -998,6 +998,9 @@ static int ntb_transport_init_queue(struct ntb_transpor=
t_ctx *nt,
 	mw_base =3D nt->mw_vec[mw_num].phys_addr;
 	mw_size =3D nt->mw_vec[mw_num].phys_size;
=20
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size =3D max_mw_size;
+
 	tx_size =3D (unsigned int)mw_size / num_qps_mw;
 	qp_offset =3D tx_size * (qp_num / mw_count);
=20
--=20
2.15.1
