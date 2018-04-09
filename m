Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523242359-2-12006983624842121660
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242358; b=H+rukUHW5CwBVWgUKttdZ9lQ9q8kzurHLl0zaz112knNr58u7t
    NyEGNO0iBACUBCu721Zb7jmQo+QHerc7jtV0uhdyyY8RXTKZxDtSXfgwhdOKYqeD
    RNNQChFirwunmQulGD7U+V5Q4aFLarsL8MMmerqAHUTaIcD8+w1APyDRHCI2zq40
    CshNIyLSTpDutU5LNo6dZmbhBMErlTS994Mkkni25uUtSB8wB3AWKXNteNJZ09Iy
    wUgb2cPRc9nXKspPWpzqk7yPUhObbsB6/FkeQ6mJLBxSqgnmImEOsuZi+GQGlDYJ
    +TigA8hM9QFdGvrrQu7UjT/0tTPBXJH1gPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242358; bh=CgGN1tm4HX
    eivXXeBMHNQUWEWw+hNCj1Cudq+NXtuyA=; b=Zw1X1C5HWiIT/v76TjvNp/kD9F
    fQF/0q+YasQfMvfxituqMbp5yKcux1rDawp4P+CLk23dRbf8uoCLFFNqY4wztLhy
    fp3MSxLtJ7lx74/b3Q7GJwNDfl326lCfJJ/XelwPVFr8VU+7KFmqiTZXcCndU8qz
    bGEWYm4vrRCS3fXWsJT/Gv4flAECkGcOTGDjEkFaT/1LWcLgiq+5WQ731JZN+fkw
    dfqxicpdBmk2qIspbQH+44f17/TK2lXvvPr3SMCmr6F9rW1qdxJp5YQu4FFPArBa
    uwY+NjLgcNDqsx7bCrjMBYyqgwKBu0O5EZ9gX1f1E9ohSdHqL3oRYJnnwSfw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SZDp2StQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SZDp2StQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEL5jUavfQlwFY40LPw4PlMDZj864lNCXuJIZTTV7jqAw8A1eOxyHEsKo8mjOG7a8POUIOn7e97TbCK3ORA+texTns63fRXNIc2xrGy+UZsMfTAbD+i4
    DMeeypr8spGropYaNSfLWDaXwlVnGeb1whOrhPFVcb2ykyWqEhdiaVjgwP8L9XLMXF/u1yi49wvjud0nFBEKz58PxsC5JxrVLkP8njXYpGcNVPMVXv/FLt/W
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=YYT5pQeFF-k4n34kXHQA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755415AbeDICwV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:52:21 -0400
Received: from mail-sn1nam02on0138.outbound.protection.outlook.com ([104.47.36.138]:42256
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755339AbeDIA0b (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 151/161] ACPI / EC: Restore polling during
 noirq suspend/resume phases
Thread-Topic: [PATCH AUTOSEL for 4.14 151/161] ACPI / EC: Restore polling
 during noirq suspend/resume phases
Thread-Index: AQHTz5jEP27F740jn02iEhpkyjg/UQ==
Date: Mon, 9 Apr 2018 00:21:56 +0000
Message-ID: <20180409001936.162706-151-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:v2xhOEQyV04SP3pQUdG5pSFRDoOR4nUccQbdlivP/nZ4YzVSz+xF2em2Q/wq2l32gbKrFIOWJsPjP/Nlf8CPBc4V8O6mgpKWgk0hD91TNdWbwrHL9ngiNuC6GympvEufx4jvriVswQpyOapm941T1QtSpegLlRqAQ+gUB/VqQDGFunx/jkqsdihZSLRfWiDE6zBm7V1W8oiZ5aRBc+6v4nONnT1kPrHviPASwp2YzEnAxUD8bThXa8kOzFrph/ss;20:vkOXeQHoIZjMdWLyMr2MNonpwwCUxtwACsbmiA0YmqtaJloDY7PzaEVKuPCyci5pCjPKrp2gYLlpl5jU6fUIwGu7d4CtxsgsDdxElmF8n1kmia6sDwL2ueUVb3paB2CFzlsReUA2d5/vYfCobPEq7o+gW6689V1lZ3MDl7Rzef0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b1e08c5-6add-4de8-8d75-08d59db08587
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725E47CA2C72F332BECD4DAFBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(6306002)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(15650500001)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hYdrAelBv+/RJs4TgHBaalgzF8ZWywDU4D06LtDdsKw2DuY56Bit6qZhwuM/bsfoEEbZSMGaC51x+Gv4kqnzxuXA46b/CHBuY7f5qVdgLD9a3HuZzng6GMsmZYGgmZ5T6QcLDPGwJMgXPTvfRGhfK1b1M+EAG3KnbGew1UeA5PPFzuHp6vxi58s1G9DOF4aeslCzoFNSFN1bOmwburQ1xKin79SHfnN9D3y57yWgg1DG1JMHQ1NWgwoTHUUBfefdYuAMpYlgLHEtLpIx1Tx3W8L6u++ndd00ybb5iuEXR6QsF1K2BczGxdkOXC7f5z2bEQI6I+ZY3A2273JVw985i7/FNai1pyKAW0lws5dNUETLWSqqtrsQlaUdk0kcXsvDvf2P7Uuc0a4UrwN7FrqnBHXld/WTcHma23CBZi2pcnM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1e08c5-6add-4de8-8d75-08d59db08587
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:56.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 3cd091a773936c54344a519f7ee1379ccb620bee ]

Commit 662591461c4b (ACPI / EC: Drop EC noirq hooks to fix a
regression) modified the ACPI EC driver so that it doesn't switch
over to busy polling mode during noirq stages of system suspend and
resume in an attempt to fix an issue resulting from that behavior.

However, that modification introduced a system resume regression on
Thinkpad X240, so make the EC driver switch over to the polling mode
during noirq stages of system suspend and resume again, which
effectively reverts the problematic commit.

Fixes: 662591461c4b (ACPI / EC: Drop EC noirq hooks to fix a regression)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D197863
Reported-by: Markus Demleitner <m@tfiu.de>
Tested-by: Markus Demleitner <m@tfiu.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/ec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index df842465634a..fedbcfd45b67 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1927,6 +1927,9 @@ static int acpi_ec_suspend_noirq(struct device *dev)
 	    ec->reference_count >=3D 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
=20
+	if (acpi_sleep_no_ec_events())
+		acpi_ec_enter_noirq(ec);
+
 	return 0;
 }
=20
@@ -1934,6 +1937,9 @@ static int acpi_ec_resume_noirq(struct device *dev)
 {
 	struct acpi_ec *ec =3D acpi_driver_data(to_acpi_device(dev));
=20
+	if (acpi_sleep_no_ec_events())
+		acpi_ec_leave_noirq(ec);
+
 	if (ec_no_wakeup && test_bit(EC_FLAGS_STARTED, &ec->flags) &&
 	    ec->reference_count >=3D 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
--=20
2.15.1
