Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AF2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACF12087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h/cuyjOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACF12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH2FG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:06:28 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:6324
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725723AbeH2FG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA1i2lC9ZESOKjAOB6/9bJ9nkj6ESStfA/0dcYBLSmk=;
 b=h/cuyjOH6ip67KZT3NoybFU5BP++1YFOpZfrkl2LceSo0MW/7W62WHt5iij2kH3SOL/+t4AJvXuRoBKh40g2VIYHOwzMmJ6bD7H/V5aFy1GNKUiHPXMSNt+F9YZvt50a5sa1SuSouCsOJQ6SkuJRDrbhOmkf22SL+m2BKDUE0Ds=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.70.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 01:12:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 01:12:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
Thread-Topic: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
Thread-Index: AQHUCfNqgHerPL2lL02bDQWxnzpjF6SLArkAgEtTOzA=
Date:   Wed, 29 Aug 2018 01:12:04 +0000
Message-ID: <DB3PR0402MB39163FACD5AE40052010B390F5090@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
 <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
 <20180712025203.GQ6959@dragon>
In-Reply-To: <20180712025203.GQ6959@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3724;6:eEZHhFTjfbrlZUTuVJ/fuAqizdK44dr/q4Rhz9YmfdhStHqJ98soNMimqhQSYfWb5c+yNbzgXgZgJnxnzwxi4fgJ0RyX/EvDfI4I9HB3ICo0A9qbiay8x+uwk5n9pc6T/FwMPEE/ggyQYzW/6eOUgqrGIJehjpX2tzROQD3JFC+3XR+QrNmHFjZkRTzZXNeYuGbGKrIGdI2Soqd483Z+1lS8AZLslxX0EDEftjo8OTpprPndNra0X/FkB8j+KEpYpdTzlZ7RjxLVEukVPsUupkQizVhc2gGxbqqYHAGZj3YFQA8NOBEDfsoYdYDjNNGUDma6zzWVyOW3x90vTJIOpNDIb7wKO93Kw910+dRwsR/EaV/7zi0gjhQykJtQZ3r/AIHblLgYARc69KYtNxemwonZRNYaCZGNDBdet5AgeEewz2PPu4hcf2PCAn8QLxw8W8ku9vDlQSyZ2XlnRQgj9Q==;5:0cZ6oW6x7GQlr2b5QJQ788sPPO8atJv2FYGrRe7fL9e1QMT+oqTfGx/nHyjqaF8lP5q/+BjQDH/IZdO4V42RDS2aZTqLG62JEcxW++I22LdL1mKHo/fhsYQSMkNh2S9qh9bj8ZOIPWP4ejU4pEtmhGcOEZSt124m7FcAhICV8Mw=;7:V7TA8yvOAtmFRaQIgM8KkjjPEPDYD8yUdS8Q0MUjFIB8PtrlkuAYGU702uxElCMdAsEQQHNqIO9mpLYpPKVHb+vohLx/kYLZkRcAz5llNtupAFyGsNxCHqQFyicOibXHOODq6NxS6R9McfVyxv1MfI3EUk5YhxItlinF+B9eYjp3/26/uYnD87wzdEqA4W4RGUn0xrh6rvfYnYMw9GPg7Dy1CjAmTZzEqNa8U1cuSU/NZg1tCQ9mb49FEHSrzTb5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e2330c12-7b3f-47fd-dc08-08d60d4c6f0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-antispam-prvs: <DB3PR0402MB372478D28D453FE56C63D6BAF5090@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:DB3PR0402MB3724;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3724;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(136003)(13464003)(189003)(199004)(446003)(8936002)(6436002)(53936002)(476003)(2900100001)(229853002)(7696005)(66066001)(105586002)(106356001)(55016002)(5250100002)(33656002)(81166006)(74316002)(81156014)(25786009)(2906002)(486006)(8676002)(7416002)(68736007)(54906003)(14454004)(3846002)(478600001)(6506007)(102836004)(26005)(186003)(316002)(7736002)(305945005)(6916009)(53546011)(97736004)(44832011)(6246003)(4326008)(11346002)(86362001)(9686003)(76176011)(6116002)(256004)(5660300001)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z4m+zbRxMTrt7v0yCl2rtMS/iRv6X5Mid+JkThKTDMSrZysI5HOZjjSVasOaRrgTi/KwKXBF+GJL2V9fgvKs6DYP4nsOjZklM3mSE3HMkS7mhksUFidRlfN5OFwizSeo5xUKQEUHMXiSkN21P9vGK2jYUUtg0SHmY2gKm5I0U4mr7meGjKPdUsZk/hPTL7B8JCkt9PzmRXp1mPf2JEvmAUo6TwAII8DOtFPOeD+vT/xEn8J9t1B7e3S+nL14Dt4K85DGn6S4zDQjZLTvawECsgTkIaLqj4uOFVvT83gwTnl1KKH4EwDfcmwE3y7mSKP5F3GixkHreWi0oE6GgFksN44Fmrx4c61pwJENiY4eUcE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2330c12-7b3f-47fd-dc08-08d60d4c6f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 01:12:05.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn
	I saw v4.19-rc1 is created, can you please apply this patch?

Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Thursday, July 12, 2018 10:52 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: s.hauer@pengutronix.de; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> mturquette@baylibre.com; sboyd@kernel.org; A.s. Dong
> <aisheng.dong@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-clk@vger.kernel.org
> Subject: Re: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
>=20
> On Fri, Jun 22, 2018 at 02:32:34PM +0800, Anson Huang wrote:
> > i.MX6SLL has GPIO clock gates in CCM CCGR, add clock property for GPIO
> > driver to make sure all GPIO banks work as expected.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>=20
> I tried to create a topic branch for this patch with dependent clk branch=
 merged
> in.  But it turns out to be difficult and not worth the effort, because t=
oo many
> imx6sll patches need to be moved out from imx/dt branch, and some imx6sll
> changes are mixed with other SoCs.
> Let's apply this in next cycle.  Ping me when 4.19-rc1 is available.
>=20
> Shawn
