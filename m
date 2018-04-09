Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244214-2-12169108502530541056
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
    1523244214; b=bvfBillmtT2g8DyVqAxoQUBSwPomO7Yv7s7WIwwJb7vDT6IBcu
    CoExLQ1xDk0IeFSbtbUFda6rXxoI95FLlRfBarl37kRs7uGMJGveioJCRI5ZuIhd
    +gzngGW955IVwsoXmAH84Nm7mKwOAdOcke5Vgwhe6m3167tXc1Tk+Xmqa2zw5x9q
    S4RLgBb7DtThw80OuGAYseF05wYPWetxJVYHjyVVgsLn8hNOlw0IB29+2Lk6sJU/
    1cZrM/+KAYYGf92UHqF7R3wpYIj8vi9G+undK3lZ8DOwFpeFDi8+JoJRCSVTfLoy
    y3gSLahZyGJMC8th+aQWLs7AdZllH5iyu60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244214; bh=M9CE1Q1nfa
    CweWI3pv9lgFRNPKfOwSy32PZihRdstbw=; b=ln+3xlBkQJ2515BggJKr3acOfT
    oCjmgqLjp/v7vDoegNaaFqZ51iUH5Xn7AdLE/pbJkGY90xBGwId2vi77qcxoeDDN
    iH2rz/hyno9uc+DkKNjCQmbab1Fucc0Q1gBqlhubA6XxlNNPj1GfZF2KzPocI0Ts
    CST6+BaUMeMobIOri+Vsk6CCVFPJNTT2q4f9X0DCf4Tr1mFXQAosyzkzY8MD2hxF
    JlSfQBS5eqQV3gxyt8V7R88WNX8VomT/TrfRqprhrEpA9fdutiMbX/YT4J4qEwLk
    ObWk/xBKgtlvMJe0lE3rrPopisDa2ZhxTqAe5T5v0d1HB/29xlahJDhotTYQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jnln0Yri x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jnln0Yri x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEMj4ED22jCI8C31WVPr/JSbjBrBhq7usLIr6x09slxZCzQ+uLxatt/FE2JnlcC5bIa0QEq5IoQ5dcAhz5/GjCyOJArkQD4zjZBTKvWEyfrKx8FsuFU5
    j0hi0BrXmDIDc44ixrfrjpZOhcyeW/4kVK58dsA6ip70V1gbMgT9SpKB1Clkauj5pZXpNFYk7G/AC1RmPbR8MwaapdlImVfL0Y9l6Roq/0PtLswxPvbKD3OR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=RW_g7ExWAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8
    a=1C7F8m05DB2dRtyQP74A:9 a=wPNLvfGTeEIA:10 a=UQnFI0IN6KXBP4Chuhxn:22
    a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeDIDXa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:23:30 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754740AbeDIAWw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jan Chochol <jan@chochol.info>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 040/161] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Topic: [PATCH AUTOSEL for 4.14 040/161] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Index: AQHTz5iJbNzBDdhMIUieuUBkWzZEFg==
Date: Mon, 9 Apr 2018 00:20:17 +0000
Message-ID: <20180409001936.162706-40-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:Xkoo+a1/bJebFMb5Sd86nz9+JxZOuBPwJN1wXfa4o281QCvy6MiAfFn687239F5wL8Nz/afj7KGBFcKVtdCdq9isqYzmza4PNOf7YnZltHWw+o8Xs7iPIJrYlnoX6b0kN1+u8gCQ2gTvv8JFi1aIaKlL5s9H68HuUAAPlsAwEg6cN2WPp/Jc6boZswga6jzjUJEgw9/gCAmujgbCXB6fF3uyFC3F3UPVSKD+QcTY6OXtlEPQGZWyc3gUvtCDMCm/;20:nLbR/FEDR3312xYZvwpVYY6+3DLY8ct/Gpmdx9kjbGsOgWy4kcFSsjrLDT/N+0YLZeJfUCb95W41gEorMiTeFjJynyynPO2OtlJW1dZVntfOCLudC/gxaAaWuHUCBuxJfcrnNYpszZE4VgP2I+emCiHbp4B5CNhfGAv37YbQZ54=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c4cd13b-0a62-4f71-fdf1-08d59db00763
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101471A09442069B8463DBD4FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ibrCri+PLY//oSvmsY84pqp2g/wQbZKM1CVk/i4bpBaKRlVXFx8NIs2i900/0hTqIch/P4y4icNkin3O+/3+TovQNiGjfyk9L2ZMMWOHJ+SxWC0dnK7cZXkb3/VZmEdVeWdUf+keT1Vsu9MAd6/j/6RvgawJXFDdBKpmi3AtfDNVEAgAooTiYFGPrhY7ERH2mkv+qt8DRWnDvuaKyM4ES9dXNqJ7oGH3oUw7r9tzHEMYjKHjwzJrC+foSs2WTkcFs1YJP1x/APpWQ/TlxA3zYb/lZO+q5EiA9a1GN6ZNUNHGPkNRuJUQ4eIfqIZsCeQAdLljAPwlcC6+gVBrJlFN1gQbqurFwFo8K2RLB9UL36LE/e6TUoeR9x3tiXW0a4ngR2ReB3Q5ufKPDF85++m3dtXcAJK4oPkTVb8qSusAfFs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4cd13b-0a62-4f71-fdf1-08d59db00763
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:17.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jan Chochol <jan@chochol.info>

[ Upstream commit cbebc6ef4fc830f4040d4140bf53484812d5d5d9 ]

Since commit 57e62324e469 ("NFS: Store the legacy idmapper result in the
keyring") nfs_idmap_cache_timeout changed units from jiffies to seconds.
Unfortunately sysctl interface was not updated accordingly.

As a effect updating /proc/sys/fs/nfs/idmap_cache_timeout with some
value will incorrectly multiply this value by HZ.
Also reading /proc/sys/fs/nfs/idmap_cache_timeout will show real value
divided by HZ.

Fixes: 57e62324e469 ("NFS: Store the legacy idmapper result in the keyring"=
)
Signed-off-by: Jan Chochol <jan@chochol.info>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/nfs4sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
index 0d91d84e5822..c394e4447100 100644
--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -32,7 +32,7 @@ static struct ctl_table nfs4_cb_sysctls[] =3D {
 		.data =3D &nfs_idmap_cache_timeout,
 		.maxlen =3D sizeof(int),
 		.mode =3D 0644,
-		.proc_handler =3D proc_dointvec_jiffies,
+		.proc_handler =3D proc_dointvec,
 	},
 	{ }
 };
--=20
2.15.1
