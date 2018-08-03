Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EAAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3301621771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ilvQ5EJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3301621771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeHCQnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:43:23 -0400
Received: from mail-bn3nam01on0050.outbound.protection.outlook.com ([104.47.33.50]:39484
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732219AbeHCQnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coxWkSNveGDgeEAUiLce3EkHCqTtqG/jW9H9FORaNhE=;
 b=ilvQ5EJNJaKZyInEKXgiTN76VZ1tYoi/3Vmn+A5nbPztluwV8NLzxqPI/MaTTG6qLM+fkGPWzbkNd8cJMx1cSnRbRuF0A5aUc4fmefIAUDQpw0q/Suh2wdtP8/NvoJvOcpN5Q0gTiVbEmlzwhCCOzQt3xF2TwJLu1Yr+KMz5cUc=
Received: from BYAPR07MB4485.namprd07.prod.outlook.com (52.135.225.16) by
 BYAPR07MB5189.namprd07.prod.outlook.com (20.176.254.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 14:46:41 +0000
Received: from BYAPR07MB4485.namprd07.prod.outlook.com
 ([fe80::4df4:f48:a9c5:1147]) by BYAPR07MB4485.namprd07.prod.outlook.com
 ([fe80::4df4:f48:a9c5:1147%5]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 14:46:40 +0000
From:   Scott Telford <stelford@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Damian Kos <dkos@cadence.com>
Subject: RE: [PATCH v2] phy: Add driver for Cadence MHDP DisplayPort SD0801
 PHY
Thread-Topic: [PATCH v2] phy: Add driver for Cadence MHDP DisplayPort SD0801
 PHY
Thread-Index: AQHUICccKaADsroHokyTDcJ0ll5zd6SdxFYAgBBsLaA=
Date:   Fri, 3 Aug 2018 14:46:39 +0000
Message-ID: <BYAPR07MB44854DCEA5537DA2D20DC7F0CF230@BYAPR07MB4485.namprd07.prod.outlook.com>
References: <201807191323.JVEjlMdZ%fengguang.wu@intel.com>
 <1532090477-15559-1-git-send-email-stelford@cadence.com>
 <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
In-Reply-To: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3RlbGZvcmRcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0wZDdlNGQ4Yi05NzJjLTExZTgtYjdjYS01ODkxY2Y3N2FjOTRcYW1lLXRlc3RcMGQ3ZTRkOGQtOTcyYy0xMWU4LWI3Y2EtNTg5MWNmNzdhYzk0Ym9keS50eHQiIHN6PSIyNzU0IiB0PSIxMzE3Nzc4MTIxMDU2OTY1MzkiIGg9Inlld0ZoMlJ3UTJ4dzVKeEhrbHo1bjRMWStlcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stelford@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5189;20:GT7cX8SuUPMt/sSotYm8RxzLrKjDlAxxcsIh+1Uv0RZ8grt9Oc/pGgJV+lwaWd7AF7j1gmOUS0vKIbx1l9s6kk7qvrGcjtWFZv6oURouvRAG2oFMjmPgVEv2nzQ5ugT96mDJUVyoPhHnmT/N7VHuhBygTPRPlNogww50r6LOSatTjJ34S2e9esQ3DERkuugJDKdQ90DPC5D7yS//6Gj0lVsufr44k1GC07VrZQeDlvGWdQOGJl+ySdJRS2+6pduK
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(13464003)(199004)(189003)(36092001)(110136005)(7736002)(476003)(74316002)(8936002)(81166006)(68736007)(8676002)(305945005)(81156014)(66066001)(486006)(446003)(102836004)(7696005)(76176011)(316002)(99286004)(53546011)(6636002)(256004)(6506007)(5660300001)(11346002)(3846002)(575784001)(6246003)(33656002)(5250100002)(186003)(106356001)(97736004)(53936002)(6116002)(25786009)(2501003)(2906002)(26005)(14454004)(2900100001)(105586002)(2201001)(6436002)(86362001)(9686003)(55016002)(229853002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5189;H:BYAPR07MB4485.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 5cdd18a9-7c90-4282-4944-08d5f94fec0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5189;
x-ms-traffictypediagnostic: BYAPR07MB5189:
x-microsoft-antispam-prvs: <BYAPR07MB51899588B4B5210EE5AC77D7CF230@BYAPR07MB5189.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(258649278758335)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5189;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5189;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eJECGO2qJtr0ngMGz5OUPVHECZd3T/zDOf6XLGtTw3MOcbDGG0dNvT7q+UXcB8YGMH0n3OTtK69YHPeI1ezfSX+2Q9hUzukB2GBkZ9t+FDRGO24QumjpRe2ICYIBcKqfIg8i0pRsq0009RhLf9IYertJY8P2UxCmGuk57BMS4ZemvLKnKoAWiOF456Dv1cllQ5wXBEJJ4cOFd2u3+V8y5v7x2oSzD8lr/LEWQtIyfDuNhG2EeiYlvUXjga7v8aQBDBJFXnfAyXJMUWa9qTWSmE/p4CJisvPrAp5Rs0oXEqyTHK5Sq964oXv0rGpyXSOsqwIWns41kLKPsjIOV11808BALc28oP1buSMN9/BIkvc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdd18a9-7c90-4282-4944-08d5f94fec0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 14:46:39.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: 24 July 2018 04:57
> To: Scott Telford <stelford@cadence.com>; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; Damian Kos <dkos@cadence.com>
> Subject: Re: [PATCH v2] phy: Add driver for Cadence MHDP DisplayPort
> SD0801 PHY
>=20
[..]
> > +static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy
> *cdns_phy)
> > +{
> > +	/* refclock registers - assumes 25 MHz refclock */
> > +	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
> > +	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM0_PLLPRE_TMR);
> > +	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM0_PLLLOCK_TMR);
> > +	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM1_PLLPRE_TMR);
> > +	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM1_PLLLOCK_TMR);
> > +	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_INIT_TMR);
> > +	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_ITER_TMR);
> > +	writel(0x0019, cdns_phy->sd_base + CMN_IBCAL_INIT_TMR);
> > +	writel(0x001E, cdns_phy->sd_base + CMN_TXPUCAL_INIT_TMR);
> > +	writel(0x0006, cdns_phy->sd_base + CMN_TXPUCAL_ITER_TMR);
> > +	writel(0x001E, cdns_phy->sd_base + CMN_TXPDCAL_INIT_TMR);
> > +	writel(0x0006, cdns_phy->sd_base + CMN_TXPDCAL_ITER_TMR);
> > +	writel(0x02EE, cdns_phy->sd_base + CMN_RXCAL_INIT_TMR);
> > +	writel(0x0006, cdns_phy->sd_base + CMN_RXCAL_ITER_TMR);
> > +	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_INIT_TMR);
> > +	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_ITER_TMR);
> > +	writel(0x000E, cdns_phy->sd_base + CMN_SD_CAL_REFTIM_START);
> > +	writel(0x012B, cdns_phy->sd_base + CMN_SD_CAL_PLLCNT_START);
> > +	/* PLL registers */
> > +	writel(0x0409, cdns_phy->sd_base +
> CMN_PDIAG_PLL0_CP_PADJ_M0);
> > +	writel(0x1001, cdns_phy->sd_base +
> CMN_PDIAG_PLL0_CP_IADJ_M0);
> > +	writel(0x0F08, cdns_phy->sd_base +
> CMN_PDIAG_PLL0_FILT_PADJ_M0);
> > +	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_DSM_DIAG_M0);
> > +	writel(0x00FA, cdns_phy->sd_base +
> CMN_PLL0_VCOCAL_INIT_TMR);
> > +	writel(0x0004, cdns_phy->sd_base +
> CMN_PLL0_VCOCAL_ITER_TMR);
> > +	writel(0x00FA, cdns_phy->sd_base +
> CMN_PLL1_VCOCAL_INIT_TMR);
> > +	writel(0x0004, cdns_phy->sd_base +
> CMN_PLL1_VCOCAL_ITER_TMR);
> > +	writel(0x0318, cdns_phy->sd_base +
> CMN_PLL0_VCOCAL_REFTIM_START);
>=20
> Are these values that are written just calibration data or are they bitfi=
elds
> for a specific setting. If they are not calibration data, then macros sho=
uld be
> added.=20

These are calibration values.

I will post a new revision addressing your other comments shortly.

Regards,
Scott.
