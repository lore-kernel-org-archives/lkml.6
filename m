Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118110-2-16295487813932278008
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
    t=1520118110; b=rQuENItCcXV2J9aPrM6rkxlyXowWRIC1ZYTi+H3UWoRsJgb
    RxbvrpwbyLNsP3rLjhnO08S/zlPdqH4p7EPZrYh12JwvJVpKh/iNbzrPtEMuxNZk
    vwwmVqewjkVWLG1kIjfBgQyrjXus2R5TgFLvEisnVZDssCx4f+xvI29NxHZeENWv
    4M0rG8pfNEoYgJdx0ZEO11ImGcgmSX4HEPgbmzISy6JVRHNS93PB+aTI+E+876h8
    bRPLKZCLvN9sL4TyN3/emLrV1jdMWZBdIRBut0lKOAQqd9BcQHpeY/PFRFPa47V1
    1Pjnf2CWEIBqx7F5AP+7KoI2ER5CaBrNEWJ5low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118110; bh=/HzYxu
    7LIHG3ZYUm5enB5OAa6fQU7YMsKC+7hvGAWMs=; b=BTv6RnKj/Rz+Hzl0vzG+DH
    Pxpo4WFKCeK7s34GjUWzjzfch4nETfreLFisrvHrBFpvIUBQxUukEdNkPdR5uk5x
    Y4M7UYUaxwbXRkRQ53xKlNj3k7TFpkqB03RfbnwiMM2lwK78+wvrVFE0roDF1xY/
    7nsgKxLpKheHN4lH7Oaw9ng8YTGGPDHInWDMXqA/2vQ4+z2XZyFZTVhnvrxtCkca
    tZYpKV6R4aTSku0fsfRs++uJwcY7R7r6GqIxBBGwZdqtwfn8E26R+PVUwDPIi2wd
    kqVipkWSSnMPfbdeVG9p73vz2AjE8VLAKB/ap8xv3WIft9GlgSxyP9fPqr8GtwPg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZPhRnpEA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZPhRnpEA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934396AbeCCXB3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:01:29 -0500
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:62430
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934538AbeCCWkt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 098/115] cpufreq: Fix governor module removal
 race
Thread-Topic: [PATCH AUTOSEL for 4.4 098/115] cpufreq: Fix governor module
 removal race
Thread-Index: AQHTsz9q/+NVm2rJhUSAUXKPw4mbfA==
Date: Sat, 3 Mar 2018 22:31:47 +0000
Message-ID: <20180303223010.27106-98-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;6:2rzOMsICwkoegKYRwTPVA09lFfLK97E96cBfHymJEHhDZSAZY2m6LGW2F+kb4WzqSsNJy/U8lc8dEugnapJmIfHVCDWR1xlCodGv1W8RQEF2wjJx5WYr95afkR+j3hWsbuW3qXrf8j0Z0FfSe3eZOxqpFNdMrv5qctDnw62/9tMUE0mk9fW2hi9JnT4ehZAkBVS1dFDbkFkEds1TkFoOol8PqGjDgUAiaDyPbOAKQv0cboexZJBCYAh6nHlwG+j76bJxrfZa+3mAdkOHfvhxvBFO2a7Hasg3mf/PgvwaZHVmYHWB6lqyqFajEXyD+xfioHL8ORnrRdlXM5KclTMWnClB8L1msNziFrmYBjHkRdGIU3Ls9045+hsL8SKobTTX;5:rxDUMqnIetAcUjez+juaIJ8PV+65dHiB0kUoBqiYM+oASaHsTnvppV7cCafdLiiNXm6y/epY3K0prijKShQ2njQXzqT6e0cat/LeFlgpI84tuEsQJyIZAmR0d3RACmM9dJhrbuEo5SghHW7JG9n0eglM4na9ngxQ8qOoo9aEhok=;24:dffuOQ4HET1nAUhoz2l1/FYvij1c8Laq1ojUolc45E7BNocVnAypaywgtPZeQ4dWAGkA+1NtTlUNbFv6mFOHh/izifnPgn7GNpOtpDqah2k=;7:rLsv1SzyC8oyNDCw1N9JceF9c6nmYTLhxwt+NlH4qIGwOWAzVK6TONfp+lR2cpj1rWjF1urtIOZAurVd/GMwyVj36eJSLSgtFuRU3W/mTlKvHzENLc/HfufPXtNAxMJagRNDq6A+KOOePhMIdbT2stt/k0KEb81bEQIXmYyv8oJSmr/iwSD40hglWXfC/ISieY4/GHwg48xY3Nk9G1ktMrbgjJAxgDO4BkzLeHsww8LoM0ejE7Nk2I9Ln+0NuG0r
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04f5e271-ef0a-404c-b802-08d58157cde2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09394D4097F6578678CD65B1FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(575784001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: WhGkcJuuEu8dW/z9nHQfdO2NfAH3qRML/hnagKjE7NsHKc6FaXysNfKUePCBRNiFyfPXmSP/zB8aNSZMPMV+4cTF7e3ODuHtahku59tnG6xXjrzDq4t0y/ZUq+u5kDGdpSJAo+I8J1dFbjhtNbxZI83r4nUM1EelkpX0x3dbd3Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f5e271-ef0a-404c-b802-08d58157cde2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:47.9801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit a8b149d32b663c1a4105273295184b78f53d33cf ]

It is possible to remove a cpufreq governor module after
cpufreq_parse_governor() has returned success in
store_scaling_governor() and before cpufreq_set_policy()
acquires a reference to it, because the governor list is
not protected during that period and nothing prevents the
governor from being unregistered then.

Prevent that from happening by acquiring an extra reference
to the governor module temporarily in cpufreq_parse_governor(),
under cpufreq_governor_mutex, and dropping it in
store_scaling_governor(), when cpufreq_set_policy() returns.

Note that the second cpufreq_parse_governor() call site is fine,
because it only cares about the policy member of new_policy.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/cpufreq/cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ebed319657e7..c0fb6f12f547 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -551,6 +551,8 @@ static int cpufreq_parse_governor(char *str_governor, u=
nsigned int *policy,
 			*governor =3D t;
 			err =3D 0;
 		}
+		if (t && !try_module_get(t->owner))
+			t =3D NULL;
=20
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -669,6 +671,10 @@ static ssize_t store_scaling_governor(struct cpufreq_p=
olicy *policy,
 		return -EINVAL;
=20
 	ret =3D cpufreq_set_policy(policy, &new_policy);
+
+	if (new_policy.governor)
+		module_put(new_policy.governor->owner);
+
 	return ret ? ret : count;
 }
=20
--=20
2.14.1
