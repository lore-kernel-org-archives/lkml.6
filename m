Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A0C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850DF20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="M+wwfHKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850DF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933411AbeFUMlq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:41:46 -0400
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com ([104.47.32.58]:11472
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932845AbeFUMln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHiGNLKpnQ5fK1JojuzREvJIw7IV3JpPHhkvM5CIc6E=;
 b=M+wwfHKps9kzYVUNbqrJzNco+6YxmXPpZ1FIleeB78ydpC/OpicCSPw1ZqgBhLUmtWobmqX+4A2DNfP3odQZOCuYtlLXGehpDDRB4+O9PGXXM6z/8DHpRCGwHrpldFe+0np0whQ0rtnLlS3RIkIg7x2QCMHcs2S6es0NNq2sBGc=
Received: from SN6PR02MB4959.namprd02.prod.outlook.com (52.135.116.89) by
 SN6PR02MB4911.namprd02.prod.outlook.com (52.135.116.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Thu, 21 Jun 2018 12:41:37 +0000
Received: from SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::5ce3:b22c:d455:b4b3]) by SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::5ce3:b22c:d455:b4b3%3]) with mapi id 15.20.0863.021; Thu, 21 Jun 2018
 12:41:37 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "stefan.krsmanovic@aggios.com" <stefan.krsmanovic@aggios.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [RFC PATCH 2/3] dt: bindings: Add SD tap value properties details
Thread-Topic: [RFC PATCH 2/3] dt: bindings: Add SD tap value properties
 details
Thread-Index: AQHT/ljCOWMm6mea1E24HkqfE8N0sKRUvsKAgBX8p0A=
Date:   Thu, 21 Jun 2018 12:41:37 +0000
Message-ID: <SN6PR02MB49591B89BEB8DB28710023ABC1760@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
 <1528373500-24663-2-git-send-email-manish.narani@xilinx.com>
 <20180607124743.fqo7f7nxonn2k3b5@lakrids.cambridge.arm.com>
In-Reply-To: <20180607124743.fqo7f7nxonn2k3b5@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4911;7:XM5e1JGstLowr0OumInbf4Nb6thK7kmSeYEE451cLNAePgjF/9ig4twKaL/zMaM9eTNI5njYLbZy/xTOv6TSIXnIMmeZxLTyAmXHsGb7fPzTsDdcqLMcR1p0wwlbwY+oMWH+OtYmqyJO3M5xKqcExRaHZKuy/bev4A7258rKLM6XYNSKGIzncjjURyCWDy8P/YAztnnTEo7vxYYUIGZZyuNRzF33UqGTMnqovTgY8ahc2cH4SHyjuVdOWtbIa5/h
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 53c5cda0-530e-4342-e3d8-08d5d774543f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4911;
x-ms-traffictypediagnostic: SN6PR02MB4911:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB4911B6E4B247C137DC6F9DDCC1760@SN6PR02MB4911.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4911;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4911;
x-forefront-prvs: 07106EF9B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(39860400002)(39380400002)(189003)(13464003)(199004)(3280700002)(7736002)(33656002)(6506007)(3660700001)(186003)(8676002)(81156014)(53936002)(59450400001)(76176011)(6916009)(102836004)(97736004)(7696005)(6116002)(3846002)(72206003)(478600001)(2900100001)(105586002)(106356001)(4326008)(26005)(9686003)(53546011)(55236004)(25786009)(6246003)(2906002)(68736007)(305945005)(6436002)(14454004)(5250100002)(55016002)(8936002)(446003)(11346002)(66066001)(99286004)(476003)(486006)(54906003)(81166006)(316002)(5660300001)(7416002)(86362001)(229853002)(74316002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4911;H:SN6PR02MB4959.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0cIjwH/okCX49B9uecuXV2KDz/VRuy4+F1NW1f1HZuaIq2h8roF1f1yy0fjK0XwTG2+J6hKH2A9ky/rbv4wRt9ATFXFSosaxG+MKwbxgJcVKN3gQhQAkww5NUqYk1GRjaxRoUPvasg7ZHnsPgm+ZweNa1orj/PXvTZItkPD88wRWLgPVjwOAQQ4HYmpwHX9Wg7zSbvmkEOdCQoLgQO7v8moS+UeLJb0tLVXXM0FveMW/b/1YmeaqtdYWePWHqWBrgRxmzM364aw/vNq2ch3CUH1mdm6MwjrPTWs6inyuV5fuQud0YbqPd/hu9CIJfCXhwN8lrNJH3dDD7xyIsSjMBA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c5cda0-530e-4342-e3d8-08d5d774543f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2018 12:41:37.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Thursday, June 7, 2018 6:18 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: robh+dt@kernel.org; catalin.marinas@arm.com; will.deacon@arm.com;
> mdf@kernel.org; stefan.krsmanovic@aggios.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> mmc@vger.kernel.org; devicetree@vger.kernel.org; adrian.hunter@intel.com;
> michal.simek@xilinx.com; ulf.hansson@linaro.org
> Subject: Re: [RFC PATCH 2/3] dt: bindings: Add SD tap value properties de=
tails
>=20
> On Thu, Jun 07, 2018 at 05:41:39PM +0530, Manish Narani wrote:
> > This patch adds details of SD tap value properties in device tree.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 26
> ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > index 60481bf..0e08877 100644
> > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > @@ -15,6 +15,8 @@ Required Properties:
> >      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
> >      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
> >        For this device it is strongly suggested to include arasan,soc-c=
tl-syscon.
> > +    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP Arasan SDHCI 8.9a PHY
> > +      For this device it is strongly suggested to include arasan,soc-c=
tl-syscon.
> >    - reg: From mmc bindings: Register location and length.
> >    - clocks: From clock bindings: Handles to clock inputs.
> >    - clock-names: From clock bindings: Tuple including "clk_xin" and "c=
lk_ahb"
> > @@ -26,6 +28,30 @@ Required Properties for "arasan,sdhci-5.1":
> >    - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
> >    - phy-names:  MUST be "phy_arasan".
> >
> > +Required Properties for "xlnx,zynqmp-8.9a":
> > +  - xlnx,mio_bank: The value will be 0/1/2 depending on MIO bank selec=
tion.
>=20
> For all of these properties, please s/_/-/, folowing the usual property n=
ame
> conventions.
I will correct this in the next version.
>=20
> It's not clear to me why you need this property. The code in patch 3 only=
 seems
> to use this to determine which properties to read, choosing between <prop=
>_b0
> or <prop>_b2. I don't see why you dont have the base <prop> alone...
The property 'xlnx,mio_bank' will be different for various ZynqMP varients.=
 So different ZynqMP dts files may have different values for 'xlnx,mio_bank=
'. That's why I am maintaining _b0 and _b2 as different values
>=20
> Is this a HW detail, or configuration that you prefer?
These are SD tap values which are generally used for configuring taps in SD=
. Keeping it in device tree makes it User Configurable without changing the=
 driver code.
>=20
> > +  - xlnx,device_id: Unique Id of the device, value will be 0/1.
>=20
> What's this used for?
This used to identify the controller ID between two SD controllers present =
on ZynqMP.
>=20
> > +  - xlnx,itap_delay_sd_hsd: Input Tap Delay for SD HS.
>=20
> What unit at hese delays in?
The tap values don't have specific units. They are generally a fraction of =
the clock cycle.
For the SD frequency of -
200 MHz: 30 Input taps are available
100 MHz: 60 Input taps are available
50 MHz: 120 Input taps are available
200 MHz: 8 Output taps are available
100 MHz: 15 Output taps are available
50 MHz: 30 Output taps are available

Thanks,
Manish
>=20
> Please follow the conventions in
> Documentation/devicetree/bindings/property-units.txt.
>=20
> > +  - xlnx,itap_delay_sdr25: Input Tap Delay for SDR25.
> > +  - xlnx,itap_delay_sdr50: Input Tap Delay for SDR50.
> > +  - xlnx,itap_delay_sdr104_b0: Input Tap Delay for SDR104.
> > +  - xlnx,itap_delay_sdr104_b2: Input Tap Delay for SDR104.
>=20
> As above, Given you have to specify the bank, I don't see why you need mu=
ltiple
> properties.
>=20
> Thanks,
> Mark.
>=20
> > +  - xlnx,itap_delay_sd_ddr50: Input Tap Delay for SD DDR50.
> > +  - xlnx,itap_delay_mmc_hsd: Input Tap Delay for MMC HS.
> > +  - xlnx,itap_delay_mmc_ddr50: Input Tap Delay for MMC DDR50.
> > +  - xlnx,itap_delay_mmc_hs200_b0: Input Tap Delay for MMC HS200.
> > +  - xlnx,itap_delay_mmc_hs200_b2: Input Tap Delay for MMC HS200.
> > +  - xlnx,otap_delay_sd_hsd: Output Tap Delay for SD HS.
> > +  - xlnx,otap_delay_sdr25: Output Tap Delay for SDR25.
> > +  - xlnx,otap_delay_sdr50: Output Tap Delay for SDR50.
> > +  - xlnx,otap_delay_sdr104_b0: Output Tap Delay for SDR104.
> > +  - xlnx,otap_delay_sdr104_b2: Output Tap Delay for SDR104.
> > +  - xlnx,otap_delay_sd_ddr50: Output Tap Delay for DDR50.
> > +  - xlnx,otap_delay_mmc_hsd: Output Tap Delay for MMC HS.
> > +  - xlnx,otap_delay_mmc_ddr50: Output Tap Delay for MMC DDR50.
> > +  - xlnx,otap_delay_mmc_hs200_b0: Output Tap Delay for MMC HS200.
> > +  - xlnx,otap_delay_mmc_hs200_b2: Output Tap Delay for MMC HS200.
> > +
> >  Optional Properties:
> >    - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/sy=
scon.txt)
> >      used to access core corecfg registers.  Offsets of registers in
> > this
> > --
> > 2.7.4

