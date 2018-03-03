Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119564-2-15764162438414598771
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
    t=1520119563; b=dccbcZpjpfYghKEnZjTUbhd4qFXj75fkk6EZh+KcA2wqXKf
    XWHlAhoMk8jvGoKWPwaeVxpZp4TyrIf2FqzJYowClj2FBe4PSZpZG8CTDnVfZRGT
    x+tvqj1xvrN8AaMR0hD5QFwp5dlSkLcoma1G1OIUt0bNBoMx61fI2FUfGR0t9Noe
    tOg8f99/8o0sJN8IEBWDwQGOKbeipDHWdr1hXj1CZyufjm6PN6C4uoNUA4NK2kuc
    VLI7Jt/4QpHwV3mrAdQD5SkCxPECzeknZDrrOyrKXbCTcaT+qcxqXPvRnnWKGRn4
    arPUyOn95biIgw5Gs9bLxqsawiZC2sp9LreQjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119563; bh=2WAVcs
    5a9co9kwX7ksp8c3dNvJ1CBH6pU+G2GuyprP0=; b=tZ14HB8p/U+CVu4AZ0kby8
    CEXgIcvMPjTlMj+KvDeOsQZjueUoc0HF/R82iinfKd/lcd9i0yNhvV4Z9lQBVNRD
    NxxJ1vcjX6qn9g4b+iz80cEWe7+QB+7I9SdgYRABURhFK0ooQz7ctvPKn2f/HTin
    V/kt6gpILu7BWYHifQDMAzH/cPECqkbQLjt02LsdD33OVI4i1cM9/GItnEqbJTiE
    Wvh/imPV8R4VVs4NxV6l6HM8YjZD/ozL3+LSidcrNm8JH5btC4wpo8tYJzXCjSQP
    KqO7zc8PKuAEf+BSTkeBqzIrL1aNQ6QRaJtUK3EHJFerQYvFaL0rsYVPGgeihCVg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XlDmuQqr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XlDmuQqr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934396AbeCCX0A (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:26:00 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:28821
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934672AbeCCWhI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 194/219] cpufreq: Fix governor module removal
 race
Thread-Topic: [PATCH AUTOSEL for 4.9 194/219] cpufreq: Fix governor module
 removal race
Thread-Index: AQHTsz8kQv6za/uZVkSayogvYyToRQ==
Date: Sat, 3 Mar 2018 22:29:49 +0000
Message-ID: <20180303222716.26640-194-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;6:C2a/eyJZAOVdTzeFhhcH6+UezWzg2k3NDoxzmHRxx3tkS0jTW8efZ9e9LYjd++KuG9J6l0dlVD+FPJDY1qNAXE4eDClKzNOQQREM1FkLsCR3HhfrYekh35ke5fj2Cnjia+QMe7EulVkLAoYYY8lN7Rf2HNm+GqpeDXU8DpBJErQdfiqipao2YJA2HUwS26/uo6XVFpq/VmTlvYD0FwqUFKxbhuVS1eaeYfBptbKnlRo677bwtZqX5qN2JFMpgOZYz+ipTUaC6L7uJ26Xfcrx0NbghY/g7MAWwlw4X3TNjsUap9/0AH+O5igd5pC3hf1QRM1lRXOptEknVtz04uDTl0lngCK6D1cSxtoed5pS+buO4sn/MclmoIg5U8ukp0bM;5:yGDKd6WslZG8dZhv5pEbIprkp0gQy5spK1UErrmJx1Sau2rdpGEO0KRR7KoMK8uvhYURcGAlPpb+dZlUpBVq6dapyc0WdOK4su8NnHsYrlgdxR/p2M8dpZ1dNhMqAAySO+wxBcaetC17GHMdPtlQUeDlwJEhZJVuChsTMVmbdSg=;24:aQagPg0nDUZ6VqYCoAtpH2dgojZGtioTifjEUKe7xSt3qDBwcaVEnjC2xJXQ0UtNbP4qnybGqtgs38YGx64V3hFq9Zhwv3AftGG/ri4fudQ=;7:OGnZ+xUZ96IJ1TQR7Qm38YNfm/vk3MyTJ75W53On17Msxm+dLDaXkIIUYk1g4OTHhDktlK9akEEnq5CvuB2h1HaJipT68oT/BM9JqKHYBmFzaxyHTQf4eBGJS1HiOPstT+Fne6ZVbyBed+Z3tTD8/o8ZfLiKwiMHXopLJ+XOhrn9fngYBnAn+gv24i+XTP9GZI7E4O1QB6yY8HKBTeRo1RjokKztcyIJL4f7Q4/YNXz6OK/NUhH/AmvnsoNuHxtE
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27c0902a-f62b-4a68-fb37-08d58157416b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB09699C52853491D24CC9B281FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(575784001)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: nG2hqfTc41RXmIWrgEs2vedTYdYtIZUDTL8N/u0AuOLQahDVTQduh+yEMbS9TOfjV/E/8LZ4fykO38AAOOpH7zonZzHG2tCwgnJWsIwOu0fHGQvRmCW5N1pbhon6y/PxZfAC9VP7cayJ8I1ayj5urHETOmC1A7K9st7LTWkBjww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c0902a-f62b-4a68-fb37-08d58157416b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:49.7133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
index 35e34c0e0429..94d42448d403 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -605,6 +605,8 @@ static int cpufreq_parse_governor(char *str_governor, u=
nsigned int *policy,
 			*governor =3D t;
 			err =3D 0;
 		}
+		if (t && !try_module_get(t->owner))
+			t =3D NULL;
=20
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -723,6 +725,10 @@ static ssize_t store_scaling_governor(struct cpufreq_p=
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
