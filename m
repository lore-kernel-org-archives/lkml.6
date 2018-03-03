Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124624-2-3843663754082590545
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
    t=1520124623; b=eDdfD14GSWbQcYuS3/kFN93VQJxXg4Rpfiv4FxRub+IiuWv
    BB4AERCf4gWrXhvxrMqLRqsBtGiZfeUTn6ZbiNz3xrBjHWT7RxIvO3c9w9R4Q410
    PfswbfqWSWVqmBdQYcVwAxOpOjjtFHKIJbX1Si3CUMQCPseeF3V4QofKy/t2VuKi
    SHSCUzda+clcYP3qsIsqGXYYUOFMi8DrY++i4Wu3zEPmsfGSN5WkgCoHMZ4io7Ky
    NZF2e9zpGUHsqRTnyg1gMABQjECoNaNwehsxCfJgUAYGdSB12GAZwDk7LfmWgu35
    qMIKHZMOJOo30K81f8qP0KrzgSe/ExiSkWOpe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124623; bh=cwpe2i
    /5JwP5YkEPGyDodCdTIHpSX2vi7SMc70ofF/k=; b=Rhwr5S03/fjcG2inAmA+fh
    XFWKrM728t5l8ysmaNNGYqHZFco1psT8J7aIS/uogSmBANtcfSxMgsNU6CFqUJoc
    PwgH2r17mrzCUyYdwKPJMB8nfbFNF7Pvc8vBKe5q2m3Fy6lSIVbXKjxMIUJOI7cl
    FBsLFswx3HZCl0NT+La/bGfRoDs0aYAGPB1tVRNdFqVrvcH3xqDPoUyZ3LI17SE4
    mHjdO5QAXRzUiuLrye/5YOdtQVSlxOF5ddBexTcZOIUk8ytvHoci/6G4UF2zC6Wn
    yfq9xR4p6SnElIr65JOTHdf+vTLMymFymOOFY3SUE8ANm2Vvzaxw33lAT1P4UHJQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QxjKyG8J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QxjKyG8J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeCDAuU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:50:20 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:48048
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932199AbeCCWYU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 010/102] iwlwifi: mvm: rs: don't override the
 rate history in the search cycle
Thread-Topic: [PATCH AUTOSEL for 4.15 010/102] iwlwifi: mvm: rs: don't
 override the rate history in the search cycle
Thread-Index: AQHTsz5cjzoqVlGzCUK7xoLCFhurxQ==
Date: Sat, 3 Mar 2018 22:24:14 +0000
Message-ID: <20180303222318.26006-10-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;6:61hkKoownonzuwVljvVISWh+INm7ghm7qCWLnwmDp5mD3b6JuTBHiJo6aUlJbOW6q9PX+0zoJLMJ82k9nhk4lrQpHmBb1frEp3zyAbsThrjEUuv3smeADuDT1apR1n51OoWR2QkOAc9LnOJBboxXJmsGwssfwIs6bntSyTHM/nzSQ8uua/S6FZb4Y0qR68CZLVRhwymutOJdRn8a8rvx8y6rZSe7SjdllHyw00pWdLbsLRSCb89/GFpI79Fh34Sazfp1I3GuAvI6K2OXXs/JymidPKPo7vdxTQyygc1T9rvi+OjeWgjTnW5WDdfl6q7cnYKDV5fi1XSzNr7IcxPs4HEyr/VrmHK7H3hXM8gY3PbNFoXRxPZYFJ83Oz5YyND9;5:yo7fYcsNncLarWCb00/erswU1MhFw4wM98EgWwUMDIRPfuaYkLNBxv84cdf2t7x78++MaSrKZkV9xqPf6T0C5ZD5scxXRE8LXz9ujXsbhPDsa7DxXFBc4Svcba6H9gE3ZWMW7DIhvMkumGlccSwCxBDJOUIs1nHhNGnkZtIcKvg=;24:TCdx0qXifD8Iy+niz1zXL3DuCAv2yy/Nhjp1Sr/wyh2dJ2GhAWlVkdKwjgCS2y9Y9pUHf8hjN/ac9PZwNqUVrltym8570I3NKO7T0rtmOyE=;7:gCg5/lppUWRowt7MDqTcpnEX05zzz8e+AmEwN6p4gi/Y3I9Qk8JrfwLOlqsHffKxRFZn2ybyknCBV9ZK9xMOic26loxddO+YaUBKIPFYoaOYIwUpDiJs1Er+t0BJVAPFKZuJf5FM/ByPfzWH+bQTCuKk/s/5ixTi7K5YugLW4xXSWMaxVtaUbzI3DQ77ySP3ayNirmhxQXVjDQJIB1FDvLMFagD7HnP9fK9YX8R5rCaIGhx78BfE1fpwwmE3MOx4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e5c4ddd-cd24-4623-4f9e-08d5815581d0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10368DF7C9D0A8973D4CA670FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(575784001)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: t7H/Vszi7k2OXV1HIL4q9Z2wQtxIrpo2I/IFg7DYOdXIP7/I68lqCPs/tr9Hi2HT7aI0mFLKj2ziiEHDb/ohf80w9ROIqt+62CfAu/u3431HArkj/2n+sNt7YKD8jlAlnd3frHys9sdnIOhsciF28a+zQPIQLPPj48OHVvrlUIE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5c4ddd-cd24-4623-4f9e-08d5815581d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:14.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 992172e3aec19e5b0ea5b757ba40a146b9282d1e ]

When we are in a search cycle, we try different combinations
of parameters. Those combinations are called 'columns'.
When we switch to a new column, we first need to check if
this column has a suitable rate, if not, we can't try it.
This means we must not erase the statistics we gathered
for the previous column until we are sure that we are
indeed switching column.

The code that tries to switch to a new column first sets
a whole bunch of things for the new column, and only then
checks that we can find suitable rates in that column.
While doing that, the code mistakenly erased the rate
statistics. This code was right until
struct iwl_scale_tbl_info grew up for TPC.

Fix this to make sure we don't erase the rate statistics
until we are sure that we can indeed switch to the new
column.

Note that this bug is really harmless since it causes a
change in the behavior only when we can't find any rate
in the new column which should really not happen. In the
case we do find a suitable we reset the rate statistics
a few lines later anyway.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wire=
less/intel/iwlwifi/mvm/rs.c
index c69515ed72df..fbfa5eafcc93 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1877,12 +1877,10 @@ static int rs_switch_to_column(struct iwl_mvm *mvm,
 	struct rs_rate *rate =3D &search_tbl->rate;
 	const struct rs_tx_column *column =3D &rs_tx_columns[col_id];
 	const struct rs_tx_column *curr_column =3D &rs_tx_columns[tbl->column];
-	u32 sz =3D (sizeof(struct iwl_scale_tbl_info) -
-		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_COUNT));
 	unsigned long rate_mask =3D 0;
 	u32 rate_idx =3D 0;
=20
-	memcpy(search_tbl, tbl, sz);
+	memcpy(search_tbl, tbl, offsetof(struct iwl_scale_tbl_info, win));
=20
 	rate->sgi =3D column->sgi;
 	rate->ant =3D column->ant;
--=20
2.14.1
