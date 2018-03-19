Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497307-2-3532335295810402034
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497306; b=v3HZihUb2JmeACO1UWIwd4glid1TIeieE4HKBVptaQVPDUt
    YGoZ38ycV6q2FuNA75Qwk06+aouC2SdTNmyxtPkBMpu7W1Ijvgld3DUX1stlpZX9
    3wJTnVAggwMqC8pjRkp2pw5vRmuAR3k1Yoc1pOJM3XRXSAxJvywTQysSrpUsslXK
    S9whOSmfkEIFBBNeqMGLOi1TrN7p4zISh4aov5pXtVcA6B5VTrmso48RSTn+wd3x
    l87nBNw/cAmVpSSILaUU0GyZjLwTL+UX9+GSHFgfmuRjyeFBjt68H9mOk0XolmFs
    ++FiKXr9PnYyXOglYnEOUZeNn/RLdX6/JZzO8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521497306; bh=ziFQBceyX+7wX9d1hW+KOa3eMR/QQtb0zeGCFi
    Q6tiE=; b=YJVa7cDSFz/jsJ7n9Bl/trB0XKtJ0iNhGKsQwMhsYmxFyGbs2AlwGE
    Eo8XaJdzEqitmy+Tqu8GOouz1p0vE3EjavHeU85tFUD1Dd95IILs+agWtofMZpAx
    X9UFCSZSOBr8uyOXgsuXEYY12BweaR3iihLLl/S3fWp0X5sxjl+LkscAD5Nvcn8g
    7UEw68Wb0usGnKHJILiHKSH8OdSlUf9YxLrrCqgEVo9/1IzM346c5SHzb6U4AitD
    /p4GuMLv5f+KnT3J7mpIhRoq6hUbHJXl7WqEQ7mt+F7Wtb2i/CE3zzfAqbzt03sL
    39jzqdWonmJkjB+UVp1RxiYYnWNmTAjg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gv4PFUtM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektddtfeenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gv4PFUtM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtsgertddttdejnecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektddtfeenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934113AbeCSWHk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:07:40 -0400
Received: from mail-co1nam03on0099.outbound.protection.outlook.com ([104.47.40.99]:16428
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934337AbeCSPzA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?SmVybmVqIMWga3JhYmVj?= <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 26/97] clk: sunxi-ng: a83t: Add M divider to
 TCON1 clock
Thread-Topic: [PATCH AUTOSEL for 4.14 26/97] clk: sunxi-ng: a83t: Add M
 divider to TCON1 clock
Thread-Index: AQHTv5qhFC6LwJ3jnkCnRbWcaqJ7kQ==
Date: Mon, 19 Mar 2018 15:54:58 +0000
Message-ID: <20180319155411.12348-26-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:NriHaJpKyidHB+ZmnAmAVC1zGMU8Ozv/+tSALZJ2FORflqrHv1o0PCGUO3C92kCdWaF3mqP1JkPfZ1bVakOEvNyF4nqpbXTVcKlcuEsvXW2+8nDk1Tu0xIHR5mVD8Rod3cOoavuku9ZsRrzz4gp7Vi2fL34KCDLxWLBglQE5Kflzy0H5bdnphpL4TvbkoWNsMz3gI7ZSEwjns/zvNAkLvVO0cqxymWa/6Np01RqR68mODekJ9k1WfxlpWV0jnr1/;20:MTIJOxlGyH6Z3sfHDNEWGZ06zU7swVE90VycV/wBQBkoPm6M99Fw72duD7+Q68+T2cc7ZXaDYlwW0x2U3mpvQQtkrd5PDRlxTax6hOsur9bBORZwMXATl80yFAGIp2t/fvg1KrT7zaFabqe6qHKdN1cmcvCyqp56sSloaUTCtFs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c2664a9-a9cd-40e4-fc2c-08d58db1c493
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0982B5D5391605BCD9DB8EAEFBD40@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 119cZn/mJzOT+xMfui5UIT7bdt+C66OjgvZvOxB09KrWuSYv5bH6b0gYzetR4MX+D/1IaJfLm1x+XkDE5wWY/FeR+IQPgZFzRRO5d5mLQs855fK75PrOUeOS0bzl6f8QTL65Bc2XlXgfao/9455ifGNGnIQg892JGlVQaUchR9iptLq6CFQDufFo602YXX395baOH6V1WW/ASWveGmSs+YPJEM4Y2knUF9o6Xeug0h8Tu4KX7hc2OhrcaDHWzK8PnAPzvP6rwRIGgMAZYddIES+Ye0gB2FDQ1T96cMnBhnRRpW3K7kZwZX15M4ZokymY1l6wckOB8fIEiUMdA4yo/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F53DCD3BA77994BADBF7824478AA011@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2664a9-a9cd-40e4-fc2c-08d58db1c493
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:58.8412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
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
bjhpLWE4M3QuYw0KaW5kZXggZjgyMDMxMTVhNmJjLi5jMTAxNjBkN2E1NTYgMTAwNjQ0DQotLS0g
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
