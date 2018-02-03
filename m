Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683579-2-7111972660237098978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683579; b=XWPVmrJ5D9dc/jIzUFgDH4CT0nMirkrEsY2Asqr8BdXD9RI
    4FO9g3DsQ86wFFU5NEmDh+5wLkqceCrk7gTBoZessvWFhYRxeNYNTRg1J1etbxrj
    Y6Ix6y1HkQi6s+xeUhU/CAyLO+4qP5BDnyyjo/xhrZkiDMaH4kDPIjai2Y5OR82X
    KoQmcMqw1S30laavkNaNIUNT93KbxNXgfiQpsgh54WGGCVhx1IMpZNEIeT7qXv8W
    qN9WdwilKBrdOzeNteRi+uFv6Ma6YRDuif6Y0TyRKbLyWOctzCoc3ROalobZlQTg
    kWfTGT5akUYFwbIa7MTH3fsY2643e9qxv6CHOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683579; bh=zAW/GP
    IxEE6VCsQY+oIhXeXxjr60TITWOlfpxgh7HIk=; b=Hvdhc4CTJGP90uc5vdsEBD
    zJkhdcxNcg37fdVIIBlQhADLxN68Ca4N7jjlzV+aJmUJ85ltfRMI7z7UhNIOQWKu
    yykB5Y/XnxvjDz7OWwkfTjDKVOZx3UH+cBnHmThdracr02eGQ1gaBcpIXb05Y0RL
    YwHSLt7VSHZU7nqGT7AAMW5hjnHBw8Wsk8d5NUda6gvhLe2r1mCNuMNrzgD+WKpT
    olphnSiMadnDaddFkKnA+/KaktxtWdtVmMPsqkDKIv+0ICLLmIcP86TsZT1wKSkR
    udRp/9p9oXGMgyaZVDhB3UzD+8hpAr2WNyaaYBOLngtmDbgA13ahVw9eeiZCzhZg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RWElolb+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RWElolb+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755223AbeBCSqM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:12 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:4928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753068AbeBCSCR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 046/110] netfilter: nf_tables: fix chain
 filter in nf_tables_dump_rules()
Thread-Topic: [PATCH AUTOSEL for 4.14 046/110] netfilter: nf_tables: fix chain
 filter in nf_tables_dump_rules()
Thread-Index: AQHTnRjtVCSBtka3T0OhrA0lnbR4oQ==
Date: Sat, 3 Feb 2018 18:00:50 +0000
Message-ID: <20180203180015.29073-46-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;6:ag5KB+Bws7LXrovZvnRvGx5RxLskoXwoaite5brV7gv81UkUY3b1C8nr8P1GvBmVUQlMgYJxlwH9G6oMwQmQxxXOe0hHeI4qzk6b3V/wxVkEQ01D2UbRj64Ep4pDkqbmXlHZ574vbc1QBCyjhzABIIlNuFrAaL8Ux4Y8sSpTzINXpD0I/+975QfCKIsXjgNld66ydSK2g3SqjblT5Z5YHwhrAWPHn6oQqtHlBxwyalUtjIvcaa3lSNjpu/dlLR/zQhFh1EGk9pa8L2ZxPTdCaBHbhnfnIBZSJA9WZv2bWgztOc7N30fYVUVAZv09IX3fWCWxFOzphjv3LTwbhyvvHzXS7R8tzp9yrpVceH7jayhrpzTjMDqKTukx8CY8Uj5L;5:VZdCp6w7nZf4aZr4SCkpJDBiMU4Oxq10uFxYXiBb4PqaLL+xLYlF2eAG28QX/nqjxBW0b4soyLRT6i+72GNDtMTLScqshT0qGuikVz7158IqO8eN6z1lig4sb7BYQKsg4ccu8eJ+iWSzeIc0kppwYFI/3h6SKHyIBuDRxcnFKIQ=;24:jmg1nUss9DuNkrNvnUk3YXohyM7wBVepb2MflEo9XP6wNpKWg/KJKXc3kxYJ0tSkgtMse32AdyDh2ETKbGONnRF+3kVXSA6Mm8pqI7lBNqw=;7:4U6vPwh+yc5tL8c34d5uc0fffQ4HY5e14YYR5PfmjbZo33znLTJqbA706PW5gPFrOaDpMP+nuDgP7ZJHLaq6ooXS0uRh4ab39ffsQHIo9uhjC4UlZ9AmC/tW3GWuR9/l8JPe9trxRfK3SSSehPAt6+2HYW+6kC9pRRDCQHhwipP4R0+uYS2IjVsvhNeccbLcWpxszH25rrMjjq7QtKBGu91CL44Vv2I0UlSYPzfzdhQMNkSmS8ijFXSbrP1xPF07
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6662b8b2-8256-4881-99d2-08d56b3023f4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB10927C65EE930DBE6064F915FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: bPahcEO6wYOBkysWSXidvSNzQUM8Cl3b+n9b9sLrYLM66SZEuP9th/Qqgtdd82jlZ6NeaYfKGBlSG8ebOWF8tA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6662b8b2-8256-4881-99d2-08d56b3023f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:50.5659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 24c0df82ef7919e4d10cf2e4e65d368eb2e8ea21 ]

ctx->chain may be null now that we have very large object names,
so we cannot check for ctx->chain[0] here.

Fixes: b7263e071aba7 ("netfilter: nf_tables: Allow table names of up to 255=
 chars")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 64e1ee091225..ce49946f755e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2072,7 +2072,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 				continue;
=20
 			list_for_each_entry_rcu(chain, &table->chains, list) {
-				if (ctx && ctx->chain[0] &&
+				if (ctx && ctx->chain &&
 				    strcmp(ctx->chain, chain->name) !=3D 0)
 					continue;
=20
--=20
2.11.0
