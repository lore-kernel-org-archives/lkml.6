Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491575-2-17510918945559960778
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
    t=1520491575; b=YJKvqMOXnyVcoede2Wo/LJbbF959qeyBUbONHpPutCOMDwg
    eYJILa+dUvKN4uNTPU+JtRvGgJK8A9zmVUAbSOWYm92hxFaCG8UzalOZ2s6KqJw3
    dxTbMU+MmOkag4zCAH8eZ0xJdFBpmntyA+7Y997j9fGUofpwO0ZJoEXTKYt9lBiT
    vZrAejEYfs54hW3QcpVr+uljsIfJdmtQU7ypCSWr8lNgrsfmN7INWh/CB9OoQFtL
    WBMwS8PE4NdtUC18fpGLXIA1AYuq0OD26NKaICIdLXmWYV+miu/EwQ5rEdExEn+K
    41cjclt1ILJUNUMIRnNUa3mMjls7ssGmbPkssYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491575; bh=CfDgM3
    ffS9q7yBULnRbax/VLYMGu2rMpaIoCQ0XLERk=; b=wmAiD5AOUY1eVBxJxltMg7
    HuV9lhxe+vnYu6CPJD/esZYy8u80utuYjx13lgVnDRdDJ3vRpm2xQpz+Z4d8EFkd
    K0DHZ+d6YS7citJ6+q6rg2n59ek12ZMgIh5SK0jPbb6UIyc3+rI9MK33sRkyfuHb
    UxeUtCPeJTyZyKbGY1G+VscxZfJofCI2nBI5AKGMw8Ltz4SfNiOzDRn8pDGgLrcc
    50UglHXzfnIT38rmVV/V8Ah6Yr0Gue4ZCU8CyqtRxV0ekUqWnz+pKGwO7l2w+X+V
    kt1+RfcsjERBinnhUyV3L8r5hOa6QuAXCEhD0qB7SOlP5GL5Z7IIIJS21DZkIPug
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BbjpEOKm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BbjpEOKm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965137AbeCHE6Y (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:24 -0500
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:48736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965035AbeCHE6L (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 03/67] cpufreq: longhaul: Revert
 transition_delay_us to 200 ms
Thread-Topic: [PATCH AUTOSEL for 4.14 03/67] cpufreq: longhaul: Revert
 transition_delay_us to 200 ms
Thread-Index: AQHTtpn3xwfsJ23HnECNJ1fyWoAn9g==
Date: Thu, 8 Mar 2018 04:57:32 +0000
Message-ID: <20180308045641.7814-3-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:N4PYFMpu9ITjk6/t1gnmGQc4xxbKSZDw5DuWVxyDSD+npIczUNZVHNcUo7P73B55iN4QP5tbsdFeBeadVwavjexWzgD/NyXOWSqIvv+7ur5pNg2LOsEsmCha7WAmjfoL3lckWL6BUxzmW+qGQ8DLmIfNbz6fmKy3H+uf2BqcaRa1WnlgFHlBU+tnuZeMN0dFwh74bhkKNfGfbOAteXgiINQ2Q4jR92n0B+MFLK4azz2fojBw/AIty/6toupAlpg0;20:+4+czdFM67MiSJP4knfm4H8IXM8RobjsAOmP5PC15TE4eqRmadP4YiMzs8yVwqSOviQgYCi3ViF7U47EVJJDnw4gw6ENViDmRY8CfrWiD/AWcy+QB1SHua+Tqbesya73GSAeAxmKUIoleNDe9nNaIirax+qvgisaPG0Ji0pxK+w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42561d2a-962c-46bd-fa82-08d584b12c56
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB093669B04CAF4CBD7A1D1248FBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(575784001)(6506007)(59450400001)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Xj9vew7cdAxHvl1Ip2T5B17PJ7wvabevldEJcG6qctlvmRHdYUo27XMsq10FhU9r9oBk9/DJUnDOub+0wPUfBPejLzj/88UMK7PppcA1wIcj2os9MANbWp4qATlKSTSPxuWYJrxCBe6mriUa3EGepAvKvWL9x9FzOsFQr6M9KU8mIeVNAwJuJ4QWJsIuuXmVFyrP8iamyvj6/YDC51OSkKgEfUPHhyOt/ScLojLUENdNXBlQcEXnYiXTkDgrHCJU6kQCEGiPsMF0TldfeB+CzQP0buk7C4bJs4EzNvEsoEolDaZsxp4KB1WCawYDBbtprj0xGtsN/PX50NiTX+d5FQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42561d2a-962c-46bd-fa82-08d584b12c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:32.6726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
