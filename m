Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119993-2-9313327133304022103
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
    t=1520119992; b=tx3EMC6GjA0Vo7Zesm2B232GhjRLxaJ2sFMl7NjBf63fdEI
    ipi5vMuMJ2lW/pnn/jVYL+70TaBrTLTH/+sHeng1La3Q8JKmJWEHXm+xYLnn9Joj
    rNjq9qxBoLW1jLK0cIM2InXxjtK0mBUWfvSb1pncp6+cIydSqS8prf4QOab5yUIO
    fGCwvvH0ZZBBwe3jSHZU2Xkof9Y4qZDkCyE0MOvK9ehWuTxuicV0sIIF9lT/yB0Y
    SX2yBYmjGJOOUsH4Vgplvep6PofsXu1F44c+BvC4qnoJzMSwjo2HPamLdiCqTQuy
    QDu1X7ainEH8YoPkPq3zZfejb4aUMPkLgSjCYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119992; bh=z/AQBb
    AddX9lvPX9lHRjYsybISOjtxCDtW+/PtDV8C0=; b=D7AyakrtHqVhD7JxjrwCK7
    gDEqSsvdbBg5dbUZrAXRjp5Sa0JGLZUE2Nl11dOw0DzwgaxeSXTExcgBd9DmGTwU
    atPbEwcNo+CiXgwZ0Hfsrb2X8N/sdEwpwKqqPLZ0WCIFvvUTuMLqJJg2063MQi0X
    4p6Cx9Km4ahvFdKPJ6IQqCfM1/sU8pg+Eg/kCga5OkD7vljunu+XUp8I5wORu/tj
    x7K5cWTNgXRlHwLVYiR2kMvx+0EXLTs1TPAOh19zFaEMrOnVKH8EaEEnw5UkemPc
    52uYhN+O/7o6ifrZzxL7RiYytHEq97dVLkMeqyuzT8jcTxKp7LrU9P1XsbUuC3bQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A6JHQmOS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A6JHQmOS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934415AbeCCXcX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:32:23 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:7707
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934514AbeCCWgJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 174/219] iwlwifi: mvm: rs: don't override the
 rate history in the search cycle
Thread-Topic: [PATCH AUTOSEL for 4.9 174/219] iwlwifi: mvm: rs: don't override
 the rate history in the search cycle
Thread-Index: AQHTsz8d6wynHi0R5EChhowQcLgQww==
Date: Sat, 3 Mar 2018 22:29:38 +0000
Message-ID: <20180303222716.26640-174-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:Vll7U/NHHj8pk2oj5KqfjM4l7yw4uDf7UtkIXZV4uV1V9jaJaairz5KisK6ovvIq1UB9WsKNzumtGoLA1zHoIBORx/SUuB94QMhlyUkIKWcaq/goKiklxatNPrvYgQSlG8kCJq7qHcHX8RnAlQexxGewqBI1hmfD/gjfUdyWWwhd/pTt5xnslVntdq8qE8/Q9MRBLQNp9DO/bUtsSN4hLLR8OEgBMI5i2NmNj2afIjx4vydlPN/MQrk3XtgO4aIG
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0204ac4e-951d-4004-fb23-08d581572731
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020EABA17BA596979C64311FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(6666003)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: kpsDDp6Fc1+ljnRqvigAlhOAjE/NV9ekTpPGUMEt2lfORM06dOcuoJdZUgiOqx5x4D3MeYA8h9Hlj9Qgq7dEEMlCmUHJ4P9USLz6FMCFfcAgic72iGbFVbCEYn9qZwow/+ttvFA3NqVGl9IdTQTUnNITEs1iX4bTEzMPmRml0zA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0204ac4e-951d-4004-fb23-08d581572731
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:38.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
index 227c5ed9cbe6..0aea476ebf50 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1867,12 +1867,10 @@ static int rs_switch_to_column(struct iwl_mvm *mvm,
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
