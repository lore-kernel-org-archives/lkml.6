Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123249-2-3591014025194095451
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
    t=1520123249; b=jtusGUYATvXqS4D0PrMqBmMUv1IveOe/Sbri3aCUFbwVkUm
    pu4slTDwmT77j5O5d02qkU4aPFfZ3taA2JBhSNywAP5RmKr4Zh3PFHoBXrkbesyi
    Fa4UoAxLtIHPamnHfqKypI0nypoEAdLq/t/GoFkKUmBSVKjQZY1vnRQuba+jY/3D
    uPBYlHWm9stupi++n9Z33OTHH9hhANzZGlQNKWuaQrYzVb2q9yqxw9/xogRSxJpy
    0RUjztDVkmz1dfYnJlxmdFUWBjS6pSQS+WV9hss3dLCApdcWnBGnc+XPHQkZpaVJ
    DSrela+tfaP7Sa2C2Mq+cgfiZORKk4jypmz2YGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123249; bh=ILnzR/
    MtQA46YPdXkmNUscGw0l/HiUihb1SxT5+m0Jw=; b=T+dLRzHAzszgE4a1/cQ74P
    AWK7WQwmmY3Zg0V2n56ZdLup+JY6chl+NDQ2RM4eKAwtwDQg6JSCaL7LEgmIHey9
    rMlocjy0FixkZ4nC9koNZcf780XIlKtbcEQAvfariKOj3fZI9vN5jRBLRpGZV+LE
    Wb6x7HgeIFNmcGG/fa0yrOj1ZaVRMOhajzMxeTp3ogglo4jpfW2Id5oVwVvMm6Wd
    5KCr7JK6jxe1CSYsNaHEoIaWf7njiOA3O+3hKnsrpUvLCCBJVzEO3LB5S6rsvg/B
    KnUdyFtEJmet83WFUyMo0b27He05DxovMFNXDUStOrp6+SHphO1q4OMDaEL3EncQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fnX6cyQJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fnX6cyQJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933102AbeCCW2J (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:28:09 -0500
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:19475
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933049AbeCCW2G (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 06/84] iwlwifi: mvm: rs: don't override the
 rate history in the search cycle
Thread-Topic: [PATCH AUTOSEL for 4.14 06/84] iwlwifi: mvm: rs: don't override
 the rate history in the search cycle
Thread-Index: AQHTsz6dW6A+Cfjsnke2+K7wGIS/tQ==
Date: Sat, 3 Mar 2018 22:26:03 +0000
Message-ID: <20180303222518.26271-6-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:r4AgUD+9LEmDTOB5QffjzI5rkdiZTv1dp7W2P/MUXVVgxZ/jEx6cyhp+FarR8BqVAB6OZe9FsExm1EOYTyxkFJiQNReWeWnUB+TNhGWw7k6XxpRX0TsOktWNb3DV+S8eMezpoi+Eol6dRHIjk61O6e0R7JlI9K3EDzaSKXfiPrPFF1giEwzMg4fmGX0sos8cf89frh4t2Lk+QFv4JxrQtYXsAcDTh5DLsgtvupj47u1NjnyKpoEJQVgWhsT8i4TX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99965a53-1f36-4403-d2af-08d581560593
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10670CBD1D0A5F7F01F73018FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(575784001)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: oTNie4BvHFR5f2nYdwX0oc2GDVd3tN5BMh7s777YN2PE2uvI+8MROwocRLiTRczDfv/foTnLr87EIEtIX+Ie27MlEJVlmLsiKz9g67GWLyppdrY5jsVjUrbbEPP6KnM9zPhq3QTItY5EQh9WYlWAAqGV6EDBQboUdV0gTyRH4sA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99965a53-1f36-4403-d2af-08d581560593
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:03.6035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index 0fe723ca844e..d22cef7381ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1881,12 +1881,10 @@ static int rs_switch_to_column(struct iwl_mvm *mvm,
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
