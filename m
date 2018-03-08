Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520493126-2-16969236712264767328
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520493126; b=oXiiHPHfQfOAki2l32TUY0buyH93Cwfn+1z7ZXuquRteHZ2
    lWWZ/5b0uuFrqmBFWwIDU6cw1by0ZWJyGXfFJAmh9xw070+N/nsyvzTvryQtBeOG
    XZoXHju/lxe+QqVB1BRAUvkHD/gImY46Em/sjo9j25sEN3hPDQxX8CETtAR80Tpm
    knRFtzRHA//B+9JxA1I3u9WYx4ceOwJC/hIxwCARl4YISLDvgZatJyXFa6SQ1o7/
    TW5lF3b939hlpDYEL66/pWPRKOw7r55JxoKb06ps+offafh2zU1hic8IWwT2Ltit
    wy16HeiNG8QVKa6hx7nL0WeQD1+mYLVSvO93PqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520493126; bh=CfDgM3
    ffS9q7yBULnRbax/VLYMGu2rMpaIoCQ0XLERk=; b=l1DhRUvzyipxIF69D3M5Vp
    gb3Wqo2T24lYr3fd6WOr39yxu1EPys0sOZF0jFWLlVUvHjNorqI+ch2zxq6LUIFn
    UuOX6xluhGNqOKRfj1d+MLAEoaBosxJBc/7JiXcb7WBe+Vj9OK9D4Tq1NzKW5UzL
    xKVEaVcTXiZ59ZiJZg2Hs3TMfyD+3D1Y296i4WUlB3HFPz1w9039wTKeMf4MH3D4
    LPbbg6jWDhX+GUvbYXqg/LLMaiDC2X00zpXiWL9VxSqI/UP0znC+ZzIBboyYFyvI
    gBvKWJS60lwWc+66z/IIsJRys5lML7XUnWtLnjJTEWyEZjF0NfmW/wv8APaKMTiQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HoTBueVF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HoTBueVF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935349AbeCHHMC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:12:02 -0500
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:43489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754570AbeCHE4G (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 05/78] cpufreq: longhaul: Revert
 transition_delay_us to 200 ms
Thread-Topic: [PATCH AUTOSEL for 4.15 05/78] cpufreq: longhaul: Revert
 transition_delay_us to 200 ms
Thread-Index: AQHTtpnC15Q2pQr73EOLjEfb/UlP1A==
Date: Thu, 8 Mar 2018 04:56:02 +0000
Message-ID: <20180308045525.7662-5-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:gMesZOXg2XIcOQu5Cg9OwS8I41Nl7vL14YyqczR81Dbso5kvIg9qNvYYv3ESIOj3/ti/B/WAzmYE+YIxEx5FWBgz2Ooo+F5/wjdxqgaZHPrh/t7b/KQXBC1GRhdf0k60VRAywv91JKExWNZPLx9LxamAxsmUoOUPOQd/ZIwCj2s/YDbnir8c/2kGs/BXwhpuRV1DgRTZc1HIJn5IuLYZwMECTL9pv0HYbEbz+efVh9djf0TzqQGns4+IcB2bonP1;20:bAdt6KtAXWUr7v19jZvlHcZJv50L1dt4v+T3854ldDXbfZmbuODm0xC84nTCEmB0piTZP07SZAdICGj8hWW4t9UiTAD+qiNd6grte8q/r1gmRB/Fd58WoCF4EpuJq4BsOx2c9Jc0bwEu8je/3ao7js7VLYD7N1bPSr9TLBtPV6E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7baa002-fb92-4849-0bcf-08d584b0e4b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09023B9D87CF0BAF7838F50FFBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: zfXIZlMLugOIqUD7Wi9/pTzMZ+xiWf6J7+C31FPRvLRB2hbYKQYykeqxcwEvXJWLe9Mdf7h5hLCnvIwv7pXFJwsLTsXx5V0cWzMj4XW16m6RRCI/S9vtwWE2cpiVzYBuYZVBufIugDWaYJWQrLDYK3kvSMYwrpgVRGrchVcNaayfeqM6JERSziZb/iRHJgtGlQUJLcNYAX5KTLPV481ffOrGrXOE3+8wNtaJF22XhA4JZ81UdVy+ZaHshWkrkhgqOxbshMz7B03IKPtpgslgS+Tx7R7swhm2zBk4GYsB/KoCZnGq+RwrZ1os4UaNgFbaNGY2ZXaCM9GyyNQqGrgSSw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7baa002-fb92-4849-0bcf-08d584b0e4b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:02.7368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 1d0d064307cbfd8546841f6e9d94d02c55e45e1e ]

The commit e948bc8fbee0 ("cpufreq: Cap the default transition delay
value to 10 ms") caused a regression on EPIA-M min-ITX computer where
shutdown or reboot hangs occasionally with a print message like:

longhaul: Warning: Timeout while waiting for idle PCI bus
cpufreq: __target_index: Failed to change cpu frequency: -16

This probably happens because the cpufreq governor tries to change the
frequency of the CPU faster than allowed by the hardware.

Before the above commit, the default transition delay was set to 200 ms
for a transition_latency of 200000 ns. Lets revert back to that
transition delay value to fix it. Note that several other transition
delay values were tested like 20 ms and 30 ms and none of them have
resolved system hang issue completely.

Fixes: e948bc8fbee0 (cpufreq: Cap the default transition delay value to 10 =
ms)
Reported-by: Meelis Roos <mroos@linux.ee>
Suggested-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/cpufreq/longhaul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index d5e27bc7585a..859a62ea6120 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -894,7 +894,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *pol=
icy)
 	if ((longhaul_version !=3D TYPE_LONGHAUL_V1) && (scale_voltage !=3D 0))
 		longhaul_setup_voltagescaling();
=20
-	policy->cpuinfo.transition_latency =3D 200000;	/* nsec */
+	policy->transition_delay_us =3D 200000;	/* usec */
=20
 	return cpufreq_table_validate_and_show(policy, longhaul_table);
 }
--=20
2.14.1
