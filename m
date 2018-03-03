Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123881-2-7012894748282389941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123881; b=A3GMoIGXOEFDjRaiG8V5XmxSWQGE4SI5AW6Bngq3PVKC9w3
    RkKcIq22eX5jlPVfjvsbkigG1d/3AtYnQ9ZjGB9D6ld0uzVdoFQueBnso47jvY7P
    G6Y/jcAM3iJxNUHaGQWv1QNwAphMg0ut3iyeEl7erVOKJjAw/oUnH0ysa4OvLxlL
    7H87KcdngpgufHE1xG0YZa07tXSWpRlFeP/cso4+CDa7/Ii/lEs9+jNtXYhNRAwn
    tbOwBY9JAUPQ7uRYeF1CJQJoQQwTW9lv0pablOnQK3LEalLIlbNlOhEpsKonF0Sf
    9c7KaTvrv30/jts0N2m0KlYh3kJwQUO5HZilekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123881; bh=tKeNzt
    v8NMafHTue2R+vOFabmudm1dGAI/BnZFxk7Co=; b=ESrzdDAbyOyphhOoNpB6sh
    xXezIwH5vdjA1en9zvizSuVjP/XnpDifwUhZJsYUiQ2hnhYwePbSeOP6Nz7ywb7n
    XUF8oeKqsT/tSEMi2Pirk3jfm4elVCIOexNXDNwiYR3jGqtuFRKPII2XFUnYbYwI
    4yBaqfNEECY/XWNMYET8wCC7wc9gJM4WF1FzomDCVnihLn6jwhPxiysjPSu66G/n
    rN12GT2tST/8U1d4dVC+zPyc1kKQzMfnwsSAzf91iwDyv6MFkplqMgZdKKWpaM14
    QNRxAwIVH9Xf5zTK2tqxyl6ATokbo0TR/TZXzXtSuY5N8lXSy53vjY0TtEgFjnmg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DjjNdFQf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DjjNdFQf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeCDAhp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:37:45 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:53740
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932793AbeCCW06 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 067/102] bnxt_en: Uninitialized variable in
 bnxt_tc_parse_actions()
Thread-Topic: [PATCH AUTOSEL for 4.15 067/102] bnxt_en: Uninitialized variable
 in bnxt_tc_parse_actions()
Thread-Index: AQHTsz5w2viDg5HHTEC9EpkKntkVHw==
Date: Sat, 3 Mar 2018 22:24:48 +0000
Message-ID: <20180303222318.26006-67-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:hGY3oPNNOiasIgAU6usg2DzcmJGaDiVirlMMWAFxJ2gzX+BW5FO02j6EG4wnecSwHOnIcgwZri0EkBXfPk2xVM7tSHfXFeYtwzADzSH23JwwTca/It/kcmugVbRtatp7nRRhE50duT/ZApJ+lxQ9VJNNfojYl/eI4a/XxRhH9B9shy/BgzX+z+pbYTE2mi0DaPOhYGi8wYJGnn/WDse/30PKTCP/C/UvFgevD6dWrH/NvuTkt1H+MOwKAilbCQff
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a668604-d075-430f-fe74-08d58155dcd4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0640684CA657080B206A9DFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: t6/6tu9QS5+nTyi/i60Fvf7Axp5aKnerT1AIGNeBpdgzMnX0Rm4RD8J8XNI1dxpvZ3XjOFNnuExUrPmEgXuT/LyB8QId7N8i9QWnZGif2zxJn19KyY76UP+A7JD7UdWBNQH2MUAp/tASjhWqhB726VdMwBIMxoAas5x44c3OfSE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a668604-d075-430f-fe74-08d58155dcd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:48.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 92425c40676d498efccae6fecdb8f8e4dcf7e4a4 ]

Smatch warns that:

    drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c:160 bnxt_tc_parse_actions(=
)
    error: uninitialized symbol 'rc'.

"rc" is either uninitialized or set to zero here so we can just remove
the check.

Fixes: 8c95f773b4a3 ("bnxt_en: add support for Flower based vxlan encap/dec=
ap offload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/eth=
ernet/broadcom/bnxt/bnxt_tc.c
index d8fee26cd45e..aa484d72f38c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -148,9 +148,6 @@ static int bnxt_tc_parse_actions(struct bnxt *bp,
 		}
 	}
=20
-	if (rc)
-		return rc;
-
 	if (actions->flags & BNXT_TC_ACTION_FLAG_FWD) {
 		if (actions->flags & BNXT_TC_ACTION_FLAG_TUNNEL_ENCAP) {
 			/* dst_fid is PF's fid */
@@ -164,7 +161,7 @@ static int bnxt_tc_parse_actions(struct bnxt *bp,
 		}
 	}
=20
-	return rc;
+	return 0;
 }
=20
 #define GET_KEY(flow_cmd, key_type)					\
--=20
2.14.1
