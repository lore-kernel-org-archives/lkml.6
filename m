Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCF5C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFAA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FlOJ4L7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFAA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeIGFOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:30 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728868AbeIGFO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV+sxx/dTVDCfUtroiQvf8XNSfNT/Q9aB42xIlZckkg=;
 b=FlOJ4L7J74AgszSRQfbNfwdSDNHXg/Y7sNKz++xvkNGN9Kq4DCOUWbojBkvrkEEEM4IE9v8RzGp7ydxPMZXeZJoiCiFa1wVp6FFuuCYE1TmJkV4JjfhtJAWFDLwIrcu8AjXY4OcTg/MeaX82s0QnddHoErtQc/wNQ+C8jLCDrEw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 18/88] clk: mvebu: armada-37xx-periph: Fix wrong
 return value in get_parent
Thread-Topic: [PATCH AUTOSEL 4.18 18/88] clk: mvebu: armada-37xx-periph: Fix
 wrong return value in get_parent
Thread-Index: AQHURkLCGWcIKomna0uuV94udRTIJQ==
Date:   Fri, 7 Sep 2018 00:36:05 +0000
Message-ID: <20180907003547.57567-18-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:l7L8JaeAlwxr3l+XSqXQuOb0OYrXiPAXk6BI3n6/QIQNNnuckbLgGighFxPALSlAZJfvJZiCnpjXLnMlC/okqXU/35xqqEOGIZ1yUxdUIc3EDBakzokEOxQK9sR3EnGyWBgElAQ6d25d21WJZzWj3ZdnhWpDoD2j+bK27or6UGO8igXwktz2pro1+EnH2l0qiNx8lsWEWeZKEkpUFUUoeYLercRNMIdiTiKccQpXbZyXnQHQsZCw1dt0K4pKyCGZd+/7Pji+D0QjMGU/q6kG+frCXtbICzUJ5EJgN9sbHfAo6w1ult2UuwZtZ4KInFSP8ZQdbinj8Qf6D6tOgusoOye4Map7QrVTNDaTjB9JnHqS6f+b9iCTF/1IamUhwTLXqiTn/mkwbA4mGU56bQM4JjufTi1fwE+jj84YSyXe/g7OCiUuO8Emzmhv4OUdzXM595YmMdi1fcaY30/5e5LGNQ==;5:TebSH+JVGWqdx1zns3A4PEXGUl15bKbPlYqVSdfZ1zZw7bfNAdmDaaVvMeL+VrBi44cidbbEy6pcDr80iw23gylRfMIIpVgmTclFt3D/i63PTj0ZRf5z8ILKErYX7g4HCW9KA/bLfB37+pNTC/Xd+0av7PdMZGANVhn7WYKexws=;7:+PYeaDuLhP0XQ+FLvuQVxFadkbbNsQrKI2BH3JWl3EsAuiUvjmlwY5/AFxQuYws9/9qLmzXwjMxak0wfftaK8bJSwHxZ02u2eNnpNZogJE7USNy1psA3hsN34e5FfT8Z8YHCZ6ZHwt20o30dyYSltRPTlx4Wzyg2f5B7z85iluWFIDaM3k1I3kV0cid+CvD5Olf1SVxBCLfZZ+i+WKYEpyaMexi08DFEFCEPGMk4sIb617aUfwhoTT762BH1Encn
x-ms-office365-filtering-correlation-id: d328a704-2300-4ae7-1aa4-08d61459e594
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773ECD693CFA9C0EBE1660FFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pALgy2+WXaqjE4/Fc1fl6R0P/xrtpv501gKAO6V1BnrNLF/Cg8dh1afeeiWBdpX++4e+0R1wvAOd00Rv2ex+tP7DuB78sulKmRjgnaYmbocGxkQK+cms+qI8H2Qz1iP9lvSsMUC4mn2tYAcizQTzi+DpfYU9ICvm82+Ezu6Mn/wCUkYuS4rI6QVIWbttKBrXZomvquNvSWKAc7iky/A2QbEVf+c8h2HcvQ5e6lcXeEooJF00V3c3Iz8UpndXp/RWtGc5rUxwcCoI9gQwX9T54KZdFlYP7J7FAXN/VPRULl5f2via//uvCon34LyHy0e5bpwlRrZ6AWJqTiO3b+wfRdNJvUukGn6zK9QDWMl/oWQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d328a704-2300-4ae7-1aa4-08d61459e594
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:05.4226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>

[ Upstream commit 616bf80d381da13fbb392ebff06f46f946e3ee84 ]

The return value of the get_parent operation is a u8, whereas a -EINVAL
was returned. This wrong value was return if the value was bigger that
the number of parent but this case was already handled by the core.

So we can just remove this chunk of code to fix the issue.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 9818a7a4fd10 ("clk: mvebu: armada-37xx-periph: prepare cpu clk to
be used with DVFS")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/arm=
ada-37xx-periph.c
index 44e4e27eddad..6f7637b19738 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -429,9 +429,6 @@ static u8 clk_pm_cpu_get_parent(struct clk_hw *hw)
 		val &=3D pm_cpu->mask_mux;
 	}
=20
-	if (val >=3D num_parents)
-		return -EINVAL;
-
 	return val;
 }
=20
--=20
2.17.1
