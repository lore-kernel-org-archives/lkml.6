Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122719-2-12567227125141180026
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
    t=1520122719; b=ghAH3I/a6e0MqLSinTAd2+N7u8BLOZ0SvIOK27d7fWhLPFQ
    4GMsFrOebh9XoHvVIxQ+6EgzwcjqjmsTRgD2tBRqEdNUqVRfUDDU834lw+d/HOXu
    wQ2vE0VB3ZQk9taEL5VYL/9Kf6TkFbSosJR8lLRtP1vAsvSIVa182XiGX3uVy+kO
    0ZylEw2ZZrVzQ3uk+xRzmk2eLV34teDBvH56XHQ1GBxn+UKYtebU7kgHpsm9Ih/d
    iXXzpiVlGarXGeNq2JOALRNkRH7OegEbWibUfFHd9iO/G2UC83E6QTxxjOTXcWMG
    ur+eICJtwUZs1lHRrQmpNwtuGrmnAax7CmEVUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122719; bh=3nKsHQ
    n0Oiea72ybHzVw6FT2Pyp3CuqB3nQLp5uui7U=; b=vyLEqjX+p89mb+TbxRyW5p
    Hj1kn2j396SZ1c3Wm6H3SRlYF+euScn0bYbNSzDUZLPcJ0S1eWVGy+LOXDyd6Fv3
    qh7b4Vtws/7wXZNaPBbfqQejRk3YzBvzdPrhaM2+H92pNholi44Y9y+3QpX3JDv4
    w4LNuTw0CkWmTSamICuzdno1Ar0BtvhKrfFb3cE2Cja1WmHR+exmClegeiXHi5kC
    C5268yL1fNdcrTiCsiYhHSFLhBsgpvUbv+21o0zc/vjO02kGk/ZcKmqQiZ+XmFsL
    Azr/cZvWFSdbnhCbCULRvX07Yro4tYF5206yvEih1Zwbg/bnEjIB+DNkIFuvN1zQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HC+4stR3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HC+4stR3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeCCW3J (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:29:09 -0500
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:12224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932402AbeCCW3G (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 39/84] cpufreq: Fix governor module removal
 race
Thread-Topic: [PATCH AUTOSEL for 4.14 39/84] cpufreq: Fix governor module
 removal race
Thread-Index: AQHTsz6oFdNQ6OjqP0+kNvGMOv/yjQ==
Date: Sat, 3 Mar 2018 22:26:22 +0000
Message-ID: <20180303222518.26271-39-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:M0qLy0xbmdTlNSAxgYkr6nQ/YEaGHgs4c6kdeOP4fCk8OldhGFWaomX6GebG1/OHpvFQgg3WBipZ+re48d5QVrOnn6e5mM3t//3cXO4M4hqBqsUQ1Ga3yULRvnxZ3EZjntjXD8BXqte+PFxcqYIYtpeC7Uw4rwekSpb/XPKBH/4sH27tn+2pvBoKcoKbZKII4DYMDSn1l0hZ7ffhRQdc0ekPSK9su6bMmpMQ+BtBQackeqwoW83C6LQhn+SguyIQe5X/qq0qJnU5oJ3qXjMrlRcmC88+6QT5fVBSbmSqB8mXYepkn6XFhat2tL6AxDHJBQgnWpT0JTCnuu1qSAXGaTqbU56YEueKvcB29G2NwikWnk42y8aSm6TFuA1D+8Tc;5:Of85o17VXkOdWj6euANBteStYRz/EnvOpa5gBf2u2Fv0A9PhvX/GBdqOWC9ULAfgt0TKNXaORax9D82JeFujOByiYGMpKX69J6r0T+Zx234u6vCOPQlwMHp2y5u8kF0gS0qBl3ZzDe93AmcULdTeKMX/yjkEzvfPMxY4neilFDY=;24:1Olmn4sDF6f1zW5Vz9Gl17/8yhB4WtgvYEPXnHwfdbivd4Db/b+JWViwACGuYlKOBxwENlgKzrMu5RxNQ3b8pngYTOmzcfId8EYIT31IsJo=;7:ukN5G1B422PR1LrVpcWJnjY1VrtIiVtX59K17qQKpgMKezg1I4ilpOTid/CqS8O4koDB85m4eqwihPZqQh9g+kxnt0QgP+iJvBdSnCCTyn2cmG/iCSPo07yBHGy5BPaW1wBrSBAZ0gsRNoRi+HiLn/ZTzwlt0BbMYv1LfpFdLU2FMAUH6Fp9v+wIYzGCpaV5fxB0mBjg53Jl9wUoQ0cwzLAvCA1bQoMt5+FzY0uj75HbFes2WH794Bbe03YlCDQw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34ae6ecf-1ba0-4850-f37d-08d5815627c8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970DCF1497FFFE05EB160D4FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: cdp/lP9Fo8sSTjJ4VlDVnKbj0PGsgH3WaVoPjnppytRQfOtctMLjGZzUaHVca/vCor9xK5g/8XZyUzvRo7c0Ab2//STODqAXS6ZYvQjOnVOC18Py6wcfBmvHolvp2wHkmu+lhosZpQ9EJv4t9ZDFFmFIlTaUzlE8PsQqmesFnhM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ae6ecf-1ba0-4850-f37d-08d5815627c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:22.3848
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
index ea43b147a7fe..bb1e148ebfd4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -631,6 +631,8 @@ static int cpufreq_parse_governor(char *str_governor, u=
nsigned int *policy,
 			*governor =3D t;
 			err =3D 0;
 		}
+		if (t && !try_module_get(t->owner))
+			t =3D NULL;
=20
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -759,6 +761,10 @@ static ssize_t store_scaling_governor(struct cpufreq_p=
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
