Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124049-2-2532323908994818312
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
    t=1520124049; b=eDk/wtq31QSbmCpdyvNjBjTtsw2ZhH+nD1f3GFQu26LTavU
    /JYW5KFihYIA/hc/IL+Mt+tVWQJd11g1j+eWTfEmelNYdPOcv1M8YMCGqneNcUe6
    s7j5PqDy4vDLIxDThAyBU1FzrvIpAwUNy6orxculpBtY4LWmzTmeRSWx0Ep2NFfF
    47vm2TGDvfdkoYQwtXH9q9SM81Nx3hKfXYdfET65afiewNXi+P90nW1gAY8OASzk
    vhWhAsrgakBZcncvmPNX+XdnSxEyquuHbklFzJCgiW5h++NgdN0Pjk5U1wrguVg3
    hmmUaIlxvnkXYyMrQTiThDKvQaP+56I/mwMXO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124049; bh=idcvlA
    0eC5ALfoL1//FNEQLvt7/K4FdNvILBo3Xl9mM=; b=FZ7cmcdHrk95p6YmR3j2XY
    RvrTPQme8nhlXIitydMsczsekLt/t/qVIefUJAZoIE6W+iBXmLJJEuLovok+O75O
    Jh8QCrHje/MLr4LXdL7vdMh/fKzhoT4EG08ldD9IMwKuOfWDwAmWtfm2+0QXTb1z
    p/UhsAgkQZWOTX6qeFOWxhVPoRmVix13yOZ4xZo7rEdqX4NyBaMmx0sIbAbCHPY5
    jGrfSt5E4QtDxLF/11sGW2Cpa6oiKVp9pwbU3OdxhTChWtsOmdkwpj9A11tf0rCB
    HpNtYi+1w31PPng+VPrSBYHzN9jHvbvAyOvd2ICrXS2BkbZ+ARGAcLuodEDa4Glw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d6tjqYat x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d6tjqYat x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeCCW0W (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:22 -0500
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:35904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932639AbeCCW0T (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 051/102] cpufreq: Fix governor module removal
 race
Thread-Topic: [PATCH AUTOSEL for 4.15 051/102] cpufreq: Fix governor module
 removal race
Thread-Index: AQHTsz5qk4OB7D4gp0y/F4X+P/r3aA==
Date: Sat, 3 Mar 2018 22:24:38 +0000
Message-ID: <20180303222318.26006-51-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:ZYmayg40oZoZMS1dX5LXsOLBtl0JcpWKqjXT5YibAj1wG5PG36+3mdDWeUHQQopB3qI2yO/9TSone9Gue4dRfjRNCumuZDic5DZCf8i5XJVKVUNgf5lQUvluh3eQOgzDgUO3UUPXi7wQ4JlxxbJAu6y+JfumjRT4/uAwsx49rj0Tdgm6izFzJmhET7Mn/7ZXLexS2muYoaMiVXdRCvpSiF68vFAf0mk0uqSMIdA/OUVx4Q7Nnt6O3qT19tps2Jn+sROQ5ilGC+BmorVAPLYC7Gxae+GBDAojCe0VVhdnPe1HoHHk9jr5+OxurqcV8yHCbvA/fZJYV5haIZR0kaSl34VSixyoTb63dEZ5em+ZELPeLyYPwP20diLcFHiPjhIO;5:1xCF3sqDZAovoI5lsch/SPlSs3FB7MN8tzWiVsSho7EbgCGbgC2c1E/Wb44jatq2O3hU3i/CWftFNdtFcKqNgtf6RP4zUsxSgoc6nN85bhlWZj71dAxy5DOkjmyCKxJdoQsqsmK1M/cTD9WL3m8oM7NOd9jOYvam+jjzyOq5QNM=;24:GJ1IGJGx0VD5/D5328njsG+DJAI0SbfJHJBD/Z1cM7Amrdub+Dy4CaOl9/tKEn41q237Qj2QJJU6QrVM/YywTPN8p0sIIjFYNDyOx3c16eg=;7:T86HE+zCW4yQYnNq8QdtVFwU22TliCFiSTYSnSN8OJn2eIE93DEHuAJxg3+GZnRhqLOd6iBqVz8rZxXFS1HTCmudXsxDkKvUQd2yXenmh96FZXquTxhPSKttgXjGb+pT7HgtzHKRQzIJoW0j6YmmhRrkx33CMNymKZRZKdG81JPF7I8b/RaMVSP0fYdifwcaSgfamMxgtr5SFnNK0Vlh1hU7lyF4UFjemv6RJu1C2wUtU1vhdcI5eNR07LLpnlty
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd30dca8-0062-45fa-f889-08d58155c41a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09702B2CD77B274994A17B3AFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: HdZCCMZEi5dyNZAzKJKhOkMpAwQXyz5mqsqTOL0BM6/q3hYzfDXw1GbrQ3JQ32Pz/SDqqHR/5D5Ls9B1TK21w9lMYT8GO8x3yNyPC3RNOZZ7WYdC0zHqXKmcxv/21BkJJdRh1muo8FlWlHvBArhFDPY4AHi9mTJVc0xLrVWxUyc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd30dca8-0062-45fa-f889-08d58155c41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:38.5878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 41d148af7748..d6a3038a128d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -637,6 +637,8 @@ static int cpufreq_parse_governor(char *str_governor, u=
nsigned int *policy,
 			*governor =3D t;
 			err =3D 0;
 		}
+		if (t && !try_module_get(t->owner))
+			t =3D NULL;
=20
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -765,6 +767,10 @@ static ssize_t store_scaling_governor(struct cpufreq_p=
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
