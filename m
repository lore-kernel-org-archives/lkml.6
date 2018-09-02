Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFEDC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1AE20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DtqS05bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1AE20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeIBRTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:39 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbeIBRTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXZP6ws4yup2Gi3GkG8TLGugPap83OTQcc4ZNNeclH8=;
 b=DtqS05bRtyhMhXhkjyn8ba04HiG4aq9vanGJwAS9WS6wSXnLiSOqIE7myhyLh9OLv4so1Tt1jq1g7wwiE0tugIlnI4FHc9TcfF6Extncw2wxfOOX+LizGxrerNGooKBkmI5UOD4B0RvIMWZZPMT5ckFTTXpW0C2j9IBA4mbJHjs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 027/131] gpu: ipu-v3: default to id 0 on missing
 OF alias
Thread-Topic: [PATCH AUTOSEL 4.18 027/131] gpu: ipu-v3: default to id 0 on
 missing OF alias
Thread-Index: AQHUQr1ZfSG0jnMpC0G+TvnUC7u3sw==
Date:   Sun, 2 Sep 2018 13:03:32 +0000
Message-ID: <20180902064601.183036-27-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:Wf+5oH4Wnh19svnawCzNxtWqnjXVmVg9rnXylCZOQHbbt1sP6C8O2QsXV0E/lyefeS5GpUF3v59US33JLZ64byTQ6uY7wQipQHRb916abqfQ5wrX2mSoJ84IZ8OZgdD3jaZsE+2wQQMRExKBEzTmtIBI73hPk2LqxvCdy7zwtFYzkwtqMvsVbTXgB3PcLyPftluC3b8gzWnCX6IaVbCE90aHg9bKnfz0WyE0uxRgr1+Ex/CJoTqj3hyN0PlBfJJHGwapAV0H+2eXafyMlLnRhySErmcDsLRitHBduhTauyWvf72kLxG3+t2YWkm2yiC5i3y2s2pC6PKX7ncHhzbkfoHoOSNw9YKVLANJVWwIxIJTv7I7+DBxcDLXPYCxFPm+mHNFOC4Va6QI51bmSTHDGRexsu4irUrbQDz4/rVmjGGR/sWpucvJrT0yQ3TMpf+MBfx2jddxzxijHXcM8C4fYA==;5:YzEZqmr3gCDAZ6l5SsQ2SZ8G0p3ocxbtc+205QWkqzyHuelr2aU4c0MjG/s1VWe90OlXXLF7yQc9h6AC/PmyWP/FVIjgYqRPAp0t9gM55uvJFfhnEysfCtM8EWKwD3/AfN4lSIfBfVZRghc34kM31EYgKYnUu1rorOYvgB+lGtA=;7:qyEb9zOT3bcRhJAlgTQ0U6/y2lnFbIj9ZibdHKjUcYJrWAk1ZvmrzezQZfVYDp7ba+SppVuwkfboHDVWVFUYjcmCqyK2U1mXjKO1UZB26h52tsdjqZ82Rq5dbSL0/sGZKJxmy2LtCp89Hu4+65812oeuLfZo2b5rSa5fcvj27pFa14fogt4PLUfOvKLyfCheJXHuSfL9EBOAP/qtDhRVkkJbXd3InG5ODPVae77S10CoWsNrziu9wrELahr9dpOa
x-ms-office365-filtering-correlation-id: 92f6a8b7-6926-41da-8521-08d610d47c5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150F7DA062D1938F1C6E3FBFB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: O1do7U7qWsywWowkF+M0MjnzdbNo+jxVq+HlUWWnc25dAYv8J38ka1+eUTWwIvv+oi0PhoqjdoBlcf8n42ANkcodB/UGXfhjxmNJyeRcpJG8TMI8Pg/qwBNm2jvn/OBVPyd4ljlIbOT9WBFlc7UW2gy6TfhCqar3lZ+6ei0ZXXPbJv1IrjpiVtagqhwquux1KWnmadQIE+PoPXOOYd6F3wTvLzAx4o3iCBbShI5Up93KJEZ/JRSugJbd0V53MjN+rhKX3chmPQkUw1k2P4iLVh3zFNg+xW3a4G7BQuYz3MBXQ3AYqBs7+y09DXn9mCvWdg7SDbiF/0ddv2xyu/ZsxH2NE3cYX3mAWcdWnmUz60Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f6a8b7-6926-41da-8521-08d610d47c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:32.3110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

[ Upstream commit 2d87e6c1b99c402360fdfe19ce4f579ab2f96adf ]

This is better than storing -ENODEV in the id number. This fixes SoCs
with only one IPU that don't specify an IPU alias in the device tree.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-commo=
n.c
index 48685cddbad1..c73bd003f845 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1401,6 +1401,8 @@ static int ipu_probe(struct platform_device *pdev)
 		return -ENODEV;
=20
 	ipu->id =3D of_alias_get_id(np, "ipu");
+	if (ipu->id < 0)
+		ipu->id =3D 0;
=20
 	if (of_device_is_compatible(np, "fsl,imx6qp-ipu") &&
 	    IS_ENABLED(CONFIG_DRM)) {
--=20
2.17.1
