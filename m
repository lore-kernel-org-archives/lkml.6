Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244762-2-13992867683018521547
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
    1523244761; b=rcJ9fWBkzBRB3X/PPHE+BbEJQuUuCVI2tKTHbdByecwt/0n+cQ
    9QZNSBROcxFW9VcvkCn19To5KvtAsdGsi1IwSCDjAXWHLN2aRqMk2TJm0hE2Znny
    UWTlOZzAVrCc0CtAcQKW6Dw+ZQhjcc3Y6/6S4zdvupaBlKa7deEXIRVcm+IZ98ub
    qkGuPn/zZDf6E9yTjLSPQYv8ywYbhLz7h7q8MNWNCX3OZ0fmJ/gykiB3oqsmol+X
    iDIW5tuAZaGhPgQw8mbVujC8XjJodAFRop84KG/8/87r+uI0QTulGmo7NvOKKx2X
    ZeZ8PAhtVjk8llDiC9N+f3HLX2LyZ2uVnc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244761; bh=ySXGmQZRDs
    vFjApi+4/6jbRmr7Tf9gJ1HvCoySl2bvY=; b=gdbKQBjKn/4SJ+Y4NMDqx3Y4ks
    k6k7H1Wr20DsVshWJ8cazk1inNhNs+TcrDmcXS6Kw8reuWYF9QsCZ/Jtp79rjXT+
    yN7TB94miGMUlkaaVg1ecAKRDuRJdIYtiqTFTU5YHZT0XRteHmihfRd3099fSOJd
    XnodLVre5A0PKGLVagkDH3tfQQv//JpiiKMAtZLzNZUKPi0zcYELO7utNdYjqJT8
    RroFe6ANg4kD55u1dJNVh2E3cyYgGanjMdQWKh6ouBebe+XYP33A37qUyMMo349Q
    A7HYs4mWiCVnburB0KdupdqO4/CYruc/7dd9IhMTb4DMvKN1FXByJyvr4idw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kMggU/lh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kMggU/lh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKNnaOaBg/DlDQZMJd447L0DYkiah9luB/6AQLvjEzujdc8I63kqRObMA4ba7oN3A1lpdreGrEaBG1KwthMhD1y4TFREzVan7S2c7FP2tY+VQKMEn/1b
    mjcmk2tGJxBIonpeuytheD0nOH5A9CGiu3IPIhvN0uuMmczQMbbajIqvzH5ggPT10ZrIa5a7hTvtByOYntDEQaIuGClnocrMJSc6gcL+WSS66cX4Ei7+Mbps
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=YYT5pQeFF-k4n34kXHQA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbeDIDcc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:32:32 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:54803
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754368AbeDIAVX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 179/189] ACPI / EC: Restore polling during
 noirq suspend/resume phases
Thread-Topic: [PATCH AUTOSEL for 4.15 179/189] ACPI / EC: Restore polling
 during noirq suspend/resume phases
Thread-Index: AQHTz5hhchY+FbTpc0uWp8GaH+0Rsg==
Date: Mon, 9 Apr 2018 00:19:10 +0000
Message-ID: <20180409001637.162453-179-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:ccIOBbD5AWJYWHP/+wTeVq9cn8FFa/Xz7ZtZxOy13N+qGKqJexMp0QAXWX+7d398JO4T/VzSpigcOPwgyzo3wj3mtl1sI0y7L65Pgaq1Y14XZ89fnBuQ8tDISDpk4GX6nyO5dZTM68DCS8joBPNSGgi+8LVnV6DRmwkK5S0CX+0fkA/ykK7T7ddTm5Oe9WpRxYVrwdRZTSS7ojieFINgagBFPXAdoaqjJYL8OfGRF6xnp9Xwg/F4BQ043/1pBgFV;20:ug3FRjo0yKs2Jj1NxN0sidxN8mxfJcaUzfy6fEeQHvOi7wnfTOFin2VFeX/hgyrHTXIf939aNLd0yJT0kjVVhHMPTMa9KShvKqLJdrkSvvLj1l4RDjRC5QYSKjUeiS3ix3su4lOxC6tXr7eWWiKF/dCLwZjJ16WNlBMbT67pOZ4=
X-MS-Office365-Filtering-Correlation-Id: 7a90548e-5c38-4d34-076e-08d59dafcebd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125E124517233407F83D9F2FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(966005)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(6306002)(3660700001)(316002)(54906003)(110136005)(15650500001)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NZWyQ0D9ODMc8dGi3C6OhtqfwZfyljK+gX1iF+a906Yi7sZx4mRan5KJBM+UKqybkym4wTWfEicpp/ry7X92jGFF4D5GtNz5S/Nfukvl2h0P/ICZLjvv8sFpIgZVm8w6IcHOfAyt8AP0Ml9hZEljEpF87UXY+YFPbOI+RhhqtzEwFaGLDigCZUWmYhMHx+T4C62e3l6+QSVBMHW/evqGPep77I63Ii5hQRmnddaMSFYgeGNS6C0/zE1MJ7GZJFFxVqIfyq0Q1IZoH3xmCRE9AgacgCNhLrJoAqPlBtqV6LQ9ur84h7IqjJrik6TQ/IF+ImvZnvubcIYfWxiSye/8LsoMe8M/xvLmg9IeGRI26k1+8Aw2dnJpRM07IU9ut8YlZS+sxQMXKEZgyqkEw+wKdb7Otp6UKfh67Sl6PVq4KfI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a90548e-5c38-4d34-076e-08d59dafcebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:10.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 0252c9b9af3d..0ed52a06a224 100644
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
