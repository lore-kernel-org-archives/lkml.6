Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239446-2-426429948523824143
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
    1523239446; b=WtehJg5JS1GEh70i+lGE41GkFH8lNS5F6mrbHH2gD3XNBiVUpb
    weUpq2QVYR2Kwy6hEgEHR6Nly4GpRGkPjUBxwiJASUwVAGprE7his1PERrmmqpAm
    jq05VrAm3NwcvOM+/HSvaS1mrASfssu2uWFg0aGzLMQaym5H2y86DL7LZmIABXdM
    s+fGuUl+sF6VI2tJIKNvRSA0nWBeX+9EzqUft6gB7LWc0U2hEDiM0UenT6VqaZTE
    WJJmHP7xNR65Az8BmrCIO3NxEfI5aAEm6OcWj7KUE9mSAwDl1epxmw91aOCd+5H6
    OGSAN2+2CA2FtJuHKo2R9+uBiH5wHQIcaBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239446; bh=EtTI/C4wZ0
    VgGrlXFfebPVKjSr2A/v5vLKgx9rJ70nM=; b=kwSo2N6sEQz1O3EumOTFGIulmb
    Z1dFbEit/6mHt/2I0AIfc+UzAY2oqbCF/dtWmQa4qhgvRpzurIF/3Ihsm0ainTob
    6PPdHlb0BcZ+mgBQ5KptHMGQwAvaeNKClHJHHI4ktZIPJ5VwrWoooD0jREpqPC02
    iDQiX3pZ0dHIdRs2KkgymQybcLzUXKqdWp48m6Yi6/58OQ2ZTkiWkteDi69h8EBf
    b8ECTq3pvU9tMQ4W73e3cUt7rvV6bqWDw3DJdDz9iFRmgWIk/r1qLqBZufTMDvry
    vzSvOYtEgxEkVLmricrRh/GBeJr6SUglVrcV9DKdfUJWChiZU8II0bwKEauQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=apmqcHIi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=apmqcHIi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCB4VtZdzho5wF85fLlbCNuE0y8Nq/imQIkJCTLkXPxCmML2/wQMzm17rT5krSKnkWB7YiCEQPIPsozLBE9NaOM/qS1bMz8I8mdGNQltFgQX5JjQAaBh
    h1ezi6OSlnwcJL4Xg/mhw+6PiFI54VKmt/eL1LUTHavUculGKua4izyfkYCMRD5fqkti76N46uUuuCgOulRs66LPnBKKp1yEdy4dAKJ3EphvGsktukIxZ5Dv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=IpJZQVW2AAAA:8 a=7CQSdrXTAAAA:8 a=LpQP-O61AAAA:8
    a=yMhMjlubAAAA:8 a=jW2ZOtHb2Txl5sWXBsAA:9 a=wPNLvfGTeEIA:10
    a=IawgGOuG5U0WyFbmm1f5:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeDICDS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:03:18 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:32931
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756357AbeDIAcE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 190/293] clk: scpi: error when clock fails to
 register
Thread-Topic: [PATCH AUTOSEL for 4.9 190/293] clk: scpi: error when clock
 fails to register
Thread-Index: AQHTz5k/y3OZZQ4X9Um+K//G7zkN7Q==
Date: Mon, 9 Apr 2018 00:25:23 +0000
Message-ID: <20180409002239.163177-190-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:WdC2j7nkqdX2aG8NKPN/APClE1PEco6QbWWJ2JPNhhzbUvHwfYBVh59loQJaaBC5AYVRML1mjTw97OWiFhZB81nEb805OyT+cQEn7cXy+BcXf+V1f7ihLSJHMn3QY8JFCq89pbBt2z23xG6xl+I/6myLOSzc+mnaZ/yEQF6za5C5XpAYdKdrxV7fKnzksllqmFwZ4q9LJ/H2ZA4OhvCJM9rSiAZXmbAAhpeMAatg2JK08R075rwugsw/nvGu1hVu;20:aoZSYGwInTLByTqfAr7WQ5q91mRf+eE0e+t9IzsJG0O5yAjxrkTwKzmzHtm7AyT4FT8pELtVPOqb1s9R9c64Zoy9Zk/B+UhqHD/RI9JCyig++xGvwSDCq4pc6PqdY9nlp0dE54cTlqqVPIf2bcT0TmdJ+I2IKr2xqd68TxQtZlg=
X-MS-Office365-Filtering-Correlation-Id: 399294e3-ae9c-46bc-0f3a-08d59db14f0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112688A9BAD5C08DA9CA4A75FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: NCWlIy8MHdX4vLtKKWWl+kcH01HWVCcK1U2QQFa7Gd/KxFeniKa4KfUUAKfuu6v5bNJK4CIro5PZ5DfIPUYhcmRk6Dymnu26r03sf4ZKcTUkrcxz4E6GRlWQ28luaRc5/C/pGtrjmc2/wTQAquPhUDUckGJUtxj+zT3pD+0SjtBTLUUD4pJeWNHYNDPfXqF800/y1WXNiWGo1wG7awKjGlCDfQpdqdvzYcqjsrJQbXiNSKNH3AqwENvNHsyuuCjzzs6uZRPBmNMcP4oPJ6eQHcrkluQTInkGRmB2XBEvcc0acw0A4R7phX1Gam2ecrK4wVv06g56BXX4SFAFodEYqjDNWvvsc3sZ9fmXrgK2zE/S/6C3MOPDu5Gbts38jWNjWUs0iT4U8bipTLGJrdBog5h+FS4SdpZZj2+DUfhM62A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399294e3-ae9c-46bc-0f3a-08d59db14f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:23.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 2b286b09a048df80fd5f7dfc5057c2837679a1ab ]

Current implementation of scpi_clk_add just print a warning when clock
fails to register but then keep going as if nothing happened. The
provider is then registered with bogus data.

This may latter lead to an Oops in __clk_create_clk when
hlist_add_head(&clk->clks_node, &hw->core->clks) is called.

This patch fixes the issue and errors if a clock fails to register.

Fixes: cd52c2a4b5c4 ("clk: add support for clocks provided by SCP(System Co=
ntrol Processor)")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-scpi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 96d37175d0ad..e44b5ca91fed 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -245,10 +245,12 @@ static int scpi_clk_add(struct device *dev, struct de=
vice_node *np,
 		sclk->id =3D val;
=20
 		err =3D scpi_clk_ops_init(dev, match, sclk, name);
-		if (err)
+		if (err) {
 			dev_err(dev, "failed to register clock '%s'\n", name);
-		else
-			dev_dbg(dev, "Registered clock '%s'\n", name);
+			return err;
+		}
+
+		dev_dbg(dev, "Registered clock '%s'\n", name);
 		clk_data->clk[idx] =3D sclk;
 	}
=20
--=20
2.15.1
