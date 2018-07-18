Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8ACECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02EB20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="lENuzHs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02EB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbeGRJ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:58:26 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:61379 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730288AbeGRJ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:58:26 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 18 Jul 2018 18:21:25 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id C024179033;
        Wed, 18 Jul 2018 18:21:25 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,369,1526310000"; 
   d="scan'208";a="285697528"
Received: from mail-ty1jpn01lp0184.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.184])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2018 18:21:26 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjp6bntIWctZ+3vcHA1wxk9mR/aUshOMarD3Sc3aiG8=;
 b=lENuzHs/BSeqPmbBnvYwAdCXZ29J3Wz70p0SPnK/8Jrn9th6R5DDEndZXiwN/q1AomEF33eIsmG2/y9vmeb7KURG2/VHjciP/P3qOWDP0DYpx9+p4x9IMVk/a41cjNah+YLJCWUi4Hv8Hii7ghNpKEgxmrvV0n28TtdUgrdnq9E=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1229.jpnprd01.prod.outlook.com (10.174.226.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 09:21:23 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333%2]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 09:21:22 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Topic: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Index: AQHUHONXv++x9VJe70Gk9EuuSmoVI6STU7qAgAAEdoCAAAK7oIAAHWMAgAAEvbCAAANNgIAAATtQgAE0NICAAAFxsA==
Date:   Wed, 18 Jul 2018 09:21:22 +0000
Message-ID: <TY1PR01MB1769F8867F64CF37CB9D50A3F5530@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
 <20180717120737.bipotpki3yhn6klf@verge.net.au>
 <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
 <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
 <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
 <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20180718091448.fw2y7ea6sk2osi3g@verge.net.au>
In-Reply-To: <20180718091448.fw2y7ea6sk2osi3g@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1229;7:dUBlv2Q9tP/Y8wIGwsnDQVA2WZ8ctfsxWz56nZO0GgdWBTHfn3cYKQEoKe2ixZtDwLoXgoGsIt8qmSBnal3bvhxyw24PLBaNQo3NpN00sFWXgQo9VZ9/FQScIARs+GjC5bV5KuAMzLKXRGt92ZMEMU7dSytgJysMFnElPYUwrA5pmIodtMufZgADjNVWAGFz/afyF63fh8dhk/o38bWudP39QCuyS7SXGBuYxp+/wpc1hzCtzv1OSc/pZW62uH8Z;20:H4NLweYt9X9LLTqJk3SCP9gBUrMFYpzVRu+xMoT4+TbqKTDpnf0+LlIN08EWdiHudcBl0WinC7WZ+ZXnlq/46TGbUV4QQ5iGnTC6TaPdbD3P5plYXNdyszeSV6gHpTxAbgwGSbN23GjVuPYa+3g+pVL9fg+KupNYRa7hrhLxNyI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 789d2335-6ad2-48d4-dada-08d5ec8fd456
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1229;
x-ms-traffictypediagnostic: TY1PR01MB1229:
x-microsoft-antispam-prvs: <TY1PR01MB1229A9E0D69774DCFAEFB45AF5530@TY1PR01MB1229.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1229;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1229;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(7736002)(4326008)(256004)(99286004)(2906002)(86362001)(25786009)(54906003)(66066001)(6436002)(93886005)(55016002)(68736007)(5660300001)(6246003)(478600001)(186003)(26005)(305945005)(53936002)(97736004)(33656002)(53546011)(8676002)(5250100002)(8936002)(9686003)(6506007)(229853002)(76176011)(14454004)(446003)(486006)(2900100001)(316002)(81156014)(102836004)(106356001)(74316002)(11346002)(6116002)(105586002)(6916009)(476003)(3846002)(44832011)(7696005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1229;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FhLRSfx0R0/nCWiLzI6CG+PdbKD3A47Eh1ADCjla2V5hzoh678GKZ2u06E2L8Cg3vlhUsyhURzoc7R65H26EaxUG+dSjqCxaKxDiY0QWSWuhfddqkJd2XXtbmD1E2uuCo6zqrUgrJtZtBQntOTznSgZx2AhOLV+dgpX8aO0/munUV8+4+NkuJcITHFe1TrCcmKZaBCLZ3+OAPDkFMFJ1wPYZ6blMUU2dobeNNWFK//5cNdqT1BcySZxkvFARMuuFA4+iIs4MFFfzqQINQOFTmcHA8b+yJLjSAfADeM+RDNWwT9zOoszk2LGRyB1vGunFUJhADKR6+AWcOL/I0CXDh/QmH3OQZHAlUMzqzqtnjF4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789d2335-6ad2-48d4-dada-08d5ec8fd456
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 09:21:22.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 18 July 2018 10:15 Simon Horman wrote:
> On Tue, Jul 17, 2018 at 02:57:27PM +0000, Phil Edworthy wrote:
> > On 17 July 2018 15:47, Andy Shevchenko wrote:
> > > On Tue, 2018-07-17 at 14:40 +0000, Phil Edworthy wrote:
> > > > On 17 July 2018 15:19, Andy Shevchenko wrote:
> > > > > On Tue, 2018-07-17 at 12:42 +0000, Phil Edworthy wrote:
> > > > >
> > > > > > > While your point sounds valid (don't remember how clk_get()
> > > > > > > is implemented), NULL is also OK to have.
> > > > > >
> > > > > > Ok as in there is no bus clock, right?
> > > > > > So it should be:
> > > > > >  if (!IS_ERR_OR_NULL (dev->busclk))
> > > > >
> > > > > Nope, NULL is no error case for optional clock.
> > > >
> > > > I must be missing something here...
> > >
> > > See how clk_prepare_enable() is implemented.
> > Ok, if busclk is NULL the code can safely call clk_prepare_enable()
> >
> > > > I agree that NULL for an optional clock is not an error. However,
> > > > the code above is now:
> > > > +	if (prepare) {
> > > > +		/* Optional bus clock */
> > >
> > > > +		if (!IS_ERR_OR_NULL(dev->busclk)) {
> > >
> > > Check for NULL is redundant.
> > >
> > > > +			ret =3D clk_prepare_enable(dev->busclk);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +		}
> > > > +
> > > >  		return clk_prepare_enable(dev->clk);
> > > > +	}
> > > >
> > > > So, if you have a valid busclk, it gets enabled, otherwise it is
> > > > left alone.
> > >
> > So the code as sent in the original email is correct (aside from
> > Geert's comments about EPROBE_DEFER handling).
> >
> > Maybe I need some coffee :\
> > Thanks
> > Phil
>=20
> My point is that errors should be treated as errors.
>=20
> In i2c_dw_prepare_clk() the following appears:
>=20
>         if (IS_ERR(dev->clk))
>                 return PTR_ERR(dev->clk);
>=20
> So dev->clk being an error value is treated as an error that is passed up=
 to the
> caller.
>=20
> But in your patch (and the snippet below) dev->busclk is treated as the
> optional clock not being present. Even if the error stored nothing to do =
with
> the clock not being present - f.e.  ENOMEM or as Geert mentioned
> elsewhere, EPROBE_DEFER.
>=20
> Assuming the absense of the optional clock is indicated by ENOENT, in my
> view correct code would include something like:
>=20
> 	...
>=20
> 	if (IS_ERR(dev->clk))
> 		return PTR_ERR(dev->clk);
>=20
> 	if (IS_ERR(dev->buslck) && PTR_ERR(dev->busclk) !=3D -ENOENT)
> 		return PTR_ERR(dev->busclk);
>=20
> 	...

Yes, I completely agree!

Thanks
Phil

