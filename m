Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498770-2-7649138643943655497
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498769; b=O3XDHlJrPHOcASpGpSVlK/qKSIVxYJTfURYzp3RBqEjQ5Tt
    XUXrdtJl26H312O26I/KxTqZJDvwzqhBYWe5uO2RvBBW9KUp37hEuROkj6qdR0WH
    UTsZqH2zluC+9BU2OCM1FxSfOawN+2FhGJnXI2u/Bo7sXejHQ1t2azNY438SmAVZ
    kMfb7kSmxvfokCKgPQUodyxhgvU4WHRNzWNM4I8scK+9GUHfFKrJ3ZTyM/DXdn7a
    PPNcNDCmLP5poVxSAnpxkgPaNe2Z8a3tg5rMh6EJTelEPCVyISkjsXOV5bpgV35h
    d9VhtOb81JNCsZ7sg3JOeIDJjzsPg5mKGj1bOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521498769; bh=aKll4pwe6X9b6iz9GDf1n1uM43KUySQOWmERKf
    IaggA=; b=f9hZJDhlMFMJMnlnVuD5ZOHaIQgOis65t97IlwQP1QdNtEzksCWpnS
    x9pXB+4pjFXB+CMB/K0FTaYYF9F+i7uj3RZclAupQq4kffTWuUGFxtdMndjVx9X8
    ikVSwGrTvEnFeTEUhljqHcDfAev6uwN6o2Hr/SBrOAkkwVZKya6Rmz+Lj7STZf5g
    GfepAkbs+urfHewqwPyniNWNxKal0O6QR712HAX0BVXyROQ/w41gFAEKPatxtEAt
    c0OfrytKIF9+/XtORplOa4ku2JeNtI2IE7CVubnvImWn0Ki35W/pQyd4baFQhSXn
    SCYHm2xVajyfLtvXoH/PGKXyA+pwJncg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dHGfhRbz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleekudenucevlhhushhtvghrufhiiigvpeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dHGfhRbz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleekudenucevlhhushhtvghrufhiiigvpeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972444AbeCSWcW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:32:22 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:41792
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933568AbeCSPsN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?SmVybmVqIMWga3JhYmVj?= <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 034/124] clk: sunxi-ng: a83t: Add M divider
 to TCON1 clock
Thread-Topic: [PATCH AUTOSEL for 4.15 034/124] clk: sunxi-ng: a83t: Add M
 divider to TCON1 clock
Thread-Index: AQHTv5mZFxnkZnYIbUqCnWIh67T0rQ==
Date: Mon, 19 Mar 2018 15:47:34 +0000
Message-ID: <20180319154645.11350-34-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:fnAj5QODN2S6VJ4H0jZxjDeljYtQ5x89Y/CJ5nlEPmwEfU/3twrDL14w/NvKDsFldYpSsadwG8AwIuasXd/CuR/J9r3KGmmgwAk7iLSoaVRkVsUm/oEMwlxRl4lCotK839Dnsm2x+ULpVs8cbNheFnU+0r3rqSBZpUl7jVFSRdWZyrzT6PPvgg2E8Yb9kHtje/52vYgkp1Q9VRP+suFXDcDClCimmjacVujZl1FA12VIReByqD/iXAIoOMwfdvfI;20:wVs3VzkXb5UfKPtVCV3P/0sghGt3IkUpc26RVVepj6MNgDHOS1m/3VNljhoum2tdxaOcNqzime6xXgiHSEp9nrsjWSIybeUjooLi/XiJTt4pTcN5HgWgRwz/qvHFJxGUOims8U7m+cHDtzF06ZUZRNi1pC+QQ4bhIe5vBBirHdk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfae1b0b-ec0d-4119-d08a-08d58db0ccd0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030E59B01E7682EBED32634FBD40@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(6486002)(5250100002)(478600001)(86612001)(102836004)(1076002)(97736004)(575784001)(99286004)(72206003)(6436002)(2906002)(107886003)(66066001)(10090500001)(81166006)(6116002)(81156014)(305945005)(8676002)(86362001)(7736002)(68736007)(54906003)(110136005)(26005)(3846002)(105586002)(3280700002)(316002)(53936002)(8936002)(186003)(76176011)(2900100001)(6506007)(36756003)(10290500003)(2950100002)(22452003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Vpu0wT5eAxlYdnebDvZqnEbLT/l/vVxqisJaw8t5Jy4RcGQwY04nwJ13d3oY9HqmghZhWDOqa1Ufvm7JJC0hOjShV2Te23y7EW+T5GHVwsqNJZiWLsOWbhddf1tWUjVf9MDUO7vN9b8zxmk/Pvnd9gYVXFuYvPjeErwlImqnFsgyFEwwsQZ1k8oZSY5vBqbOkV4E3VsipvIude4vaXAF5wFtr3tbwdiqGOKqclFEiXp4M3NCQMvKobWWMPY8RytZ/yCi2s+p3c58pNRZ7vTTE1eBSZamg2qsIHbnKFP5mDo35WrncdIMXEO6thj6k/vtvnuQ10poSkiG4K23D+gThw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A076ACC1BBEE394492905F94FEB9862B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfae1b0b-ec0d-4119-d08a-08d58db0ccd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:34.3418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmVybmVqIMWga3JhYmVjIDxqZXJuZWouc2tyYWJlY0BzaW9sLm5ldD4NCg0KWyBVcHN0
cmVhbSBjb21taXQgN2RiYzdmNWY0OTA0Y2ZkZGMxOTlhZjE3MWVhMDk1NDkwYTQzNGYxNSBdDQoN
ClRDT04xIGFsc28gaGFzIE0gZGl2aWRlciwgY29udHJhcnkgdG8gVENPTjAuIEFuZCB0aGUgbXV4
IGlzIG9ubHkNCjIgYml0cyB3aWRlLCBpbnN0ZWFkIG9mIDMuDQoNCkZpeGVzOiAwNTM1OWJlMTE3
NmIgKCJjbGs6IHN1bnhpLW5nOiBBZGQgZHJpdmVyIGZvciBBODNUIENDVSIpDQpTaWduZWQtb2Zm
LWJ5OiBKZXJuZWogU2tyYWJlYyA8amVybmVqLnNrcmFiZWNAc2lvbC5uZXQ+DQpbd2Vuc0Bjc2ll
Lm9yZzogQWRkIGRlc2NyaXB0aW9uIGFib3V0IG11eCB3aWR0aCBkaWZmZXJlbmNlXQ0KU2lnbmVk
LW9mZi1ieTogQ2hlbi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPg0KU2lnbmVkLW9mZi1ieTogU2Fz
aGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9j
bGsvc3VueGktbmcvY2N1LXN1bjhpLWE4M3QuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay9zdW54aS1uZy9jY3Utc3VuOGktYTgzdC5jIGIvZHJpdmVycy9jbGsvc3VueGktbmcvY2N1LXN1
bjhpLWE4M3QuYw0KaW5kZXggNWNlZGNkMGQ4YmU4Li5hZWFmYTdhNGZmZjUgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2Nsay9zdW54aS1uZy9jY3Utc3VuOGktYTgzdC5jDQorKysgYi9kcml2ZXJzL2Ns
ay9zdW54aS1uZy9jY3Utc3VuOGktYTgzdC5jDQpAQCAtNDkzLDggKzQ5Myw4IEBAIHN0YXRpYyBT
VU5YSV9DQ1VfTVVYX1dJVEhfR0FURSh0Y29uMF9jbGssICJ0Y29uMCIsIHRjb24wX3BhcmVudHMs
DQogCQkJCSAweDExOCwgMjQsIDMsIEJJVCgzMSksIENMS19TRVRfUkFURV9QQVJFTlQpOw0KIA0K
IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdGNvbjFfcGFyZW50c1tdID0geyAicGxsLXZpZGVv
MSIgfTsNCi1zdGF0aWMgU1VOWElfQ0NVX01VWF9XSVRIX0dBVEUodGNvbjFfY2xrLCAidGNvbjEi
LCB0Y29uMV9wYXJlbnRzLA0KLQkJCQkgMHgxMWMsIDI0LCAzLCBCSVQoMzEpLCBDTEtfU0VUX1JB
VEVfUEFSRU5UKTsNCitzdGF0aWMgU1VOWElfQ0NVX01fV0lUSF9NVVhfR0FURSh0Y29uMV9jbGss
ICJ0Y29uMSIsIHRjb24xX3BhcmVudHMsDQorCQkJCSAweDExYywgMCwgNCwgMjQsIDIsIEJJVCgz
MSksIENMS19TRVRfUkFURV9QQVJFTlQpOw0KIA0KIHN0YXRpYyBTVU5YSV9DQ1VfR0FURShjc2lf
bWlzY19jbGssICJjc2ktbWlzYyIsICJvc2MyNE0iLCAweDEzMCwgQklUKDE2KSwgMCk7DQogDQot
LSANCjIuMTQuMQ0K
