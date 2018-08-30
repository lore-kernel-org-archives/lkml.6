Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7579FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CD320645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="LHULN1qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CD320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeH3McJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:32:09 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:18079 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727688AbeH3McI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:32:08 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 30 Aug 2018 17:31:05 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 9EDBD866F8;
        Thu, 30 Aug 2018 17:31:05 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,306,1531753200"; 
   d="scan'208";a="291056169"
Received: from mail-os2jpn01lp0152.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.152])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2018 17:31:03 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UirDQkwhjpBEeCUFhZPJdrdz6G4yp5jCfmCdXXjn+tQ=;
 b=LHULN1qXiJ9bXtfF0UrDTvyYjUAxHNspZn3+gCkvfolvnQPdDWLkrjVP3P4phTGJ2NLJlgElXR+1yBQCOlXNGhNXcheKeeZU+us9hngZezJqynIOw5+gV/QmpD09WEvqc+e6Dm6wLl3P7A57Dnsoec3eK78mtBFkazn9NOzOhKc=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB0334.jpnprd01.prod.outlook.com (10.161.133.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Thu, 30 Aug 2018 08:31:00 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb%4]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 08:31:00 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 1/2] clk: Add of_clk_get_by_name_optional() function
Thread-Topic: [PATCH v4 1/2] clk: Add of_clk_get_by_name_optional() function
Thread-Index: AQHUKMec3KUQcPGA60W10ctOf+LYP6TXJNuAgAD/sTA=
Date:   Thu, 30 Aug 2018 08:30:59 +0000
Message-ID: <TY1PR01MB176960BEDC23EA64095EF6F2F5080@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1533039060-18779-1-git-send-email-phil.edworthy@renesas.com>
 <1533039060-18779-2-git-send-email-phil.edworthy@renesas.com>
 <20180829171039.GD11447@smile.fi.intel.com>
In-Reply-To: <20180829171039.GD11447@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0334;20:8t8L7rW2AKMi2ELVzz3rrlq4LBWo2CsaopoJ0Erf2cOMqqfhHBwzuaDqknKmNiHxcfRHqc2yD7E33EnHpHE9vKfXe7O1V9qO6GP3CbtQeFsGstdghVXXaVy0vYqyq5QNUQ2vGvOyI0fR02+EuJtGa8VPMmxw3sYorZir2LYUygM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4eaca412-80dc-4dc7-5dc2-08d60e52ea56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0334;
x-ms-traffictypediagnostic: TY1PR01MB0334:
x-microsoft-antispam-prvs: <TY1PR01MB03343AE8E52A887129C48693F5080@TY1PR01MB0334.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:TY1PR01MB0334;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0334;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39860400002)(51914003)(189003)(199004)(7736002)(256004)(6916009)(446003)(305945005)(14444005)(66066001)(11346002)(74316002)(229853002)(476003)(76176011)(9686003)(5250100002)(55016002)(7696005)(53936002)(6436002)(8676002)(2906002)(8936002)(486006)(81156014)(81166006)(4326008)(25786009)(97736004)(33656002)(44832011)(316002)(54906003)(6246003)(99286004)(105586002)(106356001)(26005)(6506007)(53546011)(2900100001)(478600001)(186003)(6116002)(3846002)(14454004)(102836004)(5660300001)(86362001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0334;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1ffoV1tO+s54atRTslE1HQKZ7r9irelruxLOKChhjdfY3DKumXxDtm1a0OhSoQU5Pcdw1sbP2uotcgBy/EDo35sLhZgZAbyKsQWMLKYNaHgTGuH+OxZHYf2qTd5Lslwkw84txLJOjbQjO+UleQZ/sPlP6661a+igzS42TGWrU8RsxITD9jUaKeOwjHWP9MXmEn+3qw3mga/Xv0Znn1faVf/WltLhbZjkSPZDwXLatEWXBQehdceWlwgsXEu6FFQbBTymeENJa976JEtZmX/1K8g5HLKIvZ5wFKP5UWcxtrBFxGxSHTV1dxd2bFRA4T8YARPnHWcgMCvNIxteWlENSnICLmDuekBvC5yBZCP08HE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaca412-80dc-4dc7-5dc2-08d60e52ea56
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 08:30:59.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 29 August 2018 18:11 Andy Shevchenko wrote:
> On Tue, Jul 31, 2018 at 01:10:59PM +0100, Phil Edworthy wrote:
> > Quite a few drivers get an optional clock, e.g. a clock required
> > to access peripheral's registers that is always enabled on some
> > devices.
> >
> > This function behaves the same as of_clk_get_by_name() except that
> > it will return NULL instead of -ENOENT.
>=20
> > +		if (optional && (index =3D=3D -EINVAL || index =3D=3D -ENODATA ||
> > +		    PTR_ERR(clk) =3D=3D -ENOENT)) {
>=20
> A nit: I would rather rearrange this to be
>=20
> if (optional &&
>     (... || ... || ...)) {
>=20
> (disregard 80 characters limit for second line)

Thanks for the review. I'm not particularly happy with the patch as is, it'=
s
pretty messy. I was in rush trying to get things done before holidays - alw=
ays
a mistake.
Would you mind if I sent a v5 that I feel is somewhat clearer?

Thanks
Phil
