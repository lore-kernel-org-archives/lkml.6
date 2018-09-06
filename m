Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5888C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E63206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="w0FXDv7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E63206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeIFSSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:18:18 -0400
Received: from mail-bn3nam01on0078.outbound.protection.outlook.com ([104.47.33.78]:61437
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729479AbeIFSSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1K0Sm7zR0JfOZ04H/r66je1AjvR89g7GM9cc5BD2eE=;
 b=w0FXDv7yS0f8J40FT45BAZHiLfziiFfojWCgp3TQowfPezXkvBn5HQsnH6jMlzcqJWr48Tu8xfnSvHdfbidUt+1sZkhiS/VNDSDzBKJZxol/mbrJQ1AXMAJOFSPkdLzHgRuhMV0Z/e1sCr1QHQYyDg4YsBqFCcGHCUgEAmBDe9Q=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 6 Sep 2018 13:42:30 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644%3]) with mapi id 15.20.1080.020; Thu, 6 Sep 2018
 13:42:30 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnaud.pouliquen@st.com" <arnaud.pouliquen@st.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "freeman.liu@spreadtrum.com" <freeman.liu@spreadtrum.com>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Thread-Topic: [PATCH 1/3] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Thread-Index: AQHUQEtsDmMzaAGBmkCOIU+zzvF3yKTfWaKAgAPwijA=
Date:   Thu, 6 Sep 2018 13:42:30 +0000
Message-ID: <DM6PR02MB52274964865A3F7CE1A8889AC1010@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
 <1535624539-7839-2-git-send-email-manish.narani@xilinx.com>
 <5b8e8a6c.1c69fb81.21d7a.5b20@mx.google.com>
In-Reply-To: <5b8e8a6c.1c69fb81.21d7a.5b20@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB5227;6:zcfAT8Yt+STMSbXf/7MvSyrq2mv/rJkocBJPE33L3TQ8KU8Z7GXT5sOx4FRZ48VE6X4gqub9CRNeYW1URknhJvLiZgtI+vVk7ijKCaj/x+tqJl9rdDKO/k+LJzKgpJRqTZJgylVZQ7DRwOGXz4wez2MxT0gjFKHbKu2j6iGs85qhwKZeh7PfMyqdToUCeroCpK3lnqyqjQduHy0tlfWEAMuxa8FgzNYRj4vNIeszlgTkhjP15iKD3RZl9Oye9TkMw2WAm+SUGMfUAzTNja0Nr5RQE6LOhCSsQSWb7EO23vH0DHHO0TIrJI+hmCbJPomG1FryTrpBCHa4JuGYFRumx47NLkxiW7gI3Rc8eXP6t6FCfD/gp6A6WaQNKGPPD7uT1g7BaJFrjO33CoeGxAC2rA5c9wh+PgHyXysdpRUk3HrUBBdChoJkoExAFJ406D1qvdAdrPvFu3Q0JSlzcTAcTg==;5:6jixrLsoGyr6tQy8kdstDgcelXDmPWsqv2BfRJQcY9CeLLwbyp8wp4U9nfYiloQnPRr8/wLjp/dZBAT3GrshUCPNesBTcODVICbqRSM2z03tOehUwBr8vuNsn0ZliFyQ0bhs4msrPDziyilBrp/CG/8jTWFyHsfrhUYn1ufYFUk=;7:vAoRWBjkSK7WVBrcVySzmgJOtq7bNeLZk28EsrpH2w8cTtRNZ5nb4go+BUsD6rEZhmF/iM64tUrE+AHdam75LVF/OB6W0vXijMd681qnVBk3+BIlMSR+zYJpSo2x2bNaBS8dpW2dLCh2y5PaaiUBAclGUvGWyW95Wr3SfuGRW3PG3OhPhlWP1QIPMq64mVQHqyzBHGOXq4u4eoxBTl1V/Wtobxi27CMFREeBTn+sLHuaZkNkPE8QyPglNRNXMtCQ
x-ms-office365-filtering-correlation-id: efdd4879-290c-4d28-531f-08d613fe97b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB5227;
x-ms-traffictypediagnostic: DM6PR02MB5227:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB5227678C94994FDA5CCE09C0C1010@DM6PR02MB5227.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(105169848403564);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6PR02MB5227;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5227;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(376002)(346002)(51914003)(199004)(189003)(8936002)(6116002)(105586002)(14444005)(55016002)(9686003)(26005)(5250100002)(25786009)(256004)(68736007)(66066001)(229853002)(3846002)(97736004)(106356001)(2900100001)(53546011)(6506007)(102836004)(186003)(316002)(53936002)(6436002)(8676002)(86362001)(305945005)(6916009)(7736002)(74316002)(486006)(72206003)(478600001)(81166006)(81156014)(99286004)(2906002)(39060400002)(54906003)(7416002)(4326008)(14454004)(5660300001)(6246003)(446003)(33656002)(11346002)(476003)(7696005)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5227;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dYRei/VJIIod9kk+BoT4GewiZaMfpBK7pbI8PItPc6HIgcIGcaVDAoY1fyItUd9WcFbfmPymaPMMWlA8GeAUNmgUD3xLb1CF/dioy+VV5m7JrDtfEg4uTfLUTVslz2rH2QyYKoxftMvZXcOacF4q5NlIfFdO/qlMr6Bnk9sZgs6zNfbtwUe7sRaNdQynKCRuocd8kieqwWW5WTxVfj83Uw84uf92fqAzEn4vQvei+4ShEenwDhQkx3wjl0fqaA62NRW6mX+YKFVRpglNyxqSsuR1ZmftRjLKM7wBMY/bCh0UHoFzQsQiKREJJAL9A3e+DHG2KZVz1wtfTV1sTnS0bvoF/cOWsLjlCBrqb/JfB2E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdd4879-290c-4d28-531f-08d613fe97b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 13:42:30.4976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review. Please see my comments inline.

> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, September 4, 2018 6:48 AM
> To: Manish Narani <MNARANI@xilinx.com>
>=20
> On Thu, Aug 30, 2018 at 03:52:17PM +0530, Manish Narani wrote:
> > Xilinx AMS have several ADC channels that can be used for measurement
> > of different voltages and temperatures. Document the same in the bindin=
gs.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/iio/adc/xilinx-ams.txt     | 159
> +++++++++++++++++++++
> >  1 file changed, 159 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> > b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> > new file mode 100644
> > index 0000000..8cc96f0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> > +AMS device tree subnode:
> > +	- compatible: Should be "xlnx,zynqmp-ams-ps" or "xlnx,zynqmp-ams-pl"
> > +	- reg:  Register space for PS or PL
>=20
> Please split each child node into its own section.

Okay. I will update this in v2.

>=20
> > +
> > +Optional properties:
> > +
> > +Following optional property only valid for PL.
>=20
> property or...

It should be node.  I will update this in v2.

>=20
> > +	- xlnx,ext-channels: List of external channels that are connected to =
the
> > +	                     AMS PL module.
> > +
> > +	  The child nodes of this node represent the external channels which
> > +are
>=20
> node?
>=20
> > +	  connected to the AMS Module. If the property is not present
> > +	  no external channels will be assumed to be connected.
> > +
> > +	  Each child node represents one channel and has the following
> > +	  properties:
> > +		Required properties:
> > +			* reg: Pair of pins the channel is connected to.
> > +				0: VP/VN
> > +				1: VUSER0
> > +				2: VUSER1
> > +				3: VUSER3
> > +				4: VUSER4
> > +				5: VAUXP[0]/VAUXN[0]
> > +				6: VAUXP[1]/VAUXN[1]
> > +				...
> > +				20: VAUXP[15]/VAUXN[15]
> > +			  Note each channel number should only be used at
> most
> > +			  once.
> > +		Optional properties:
> > +			* xlnx,bipolar: If set the channel is used in bipolar
> > +			  mode.
> > +
> > +
> > +Example:
> > +	xilinx_ams: ams@ffa50000 {
> > +		compatible =3D "xlnx,zynqmp-ams";
> > +		interrupt-parent =3D <&gic>;
> > +		interrupts =3D <0 56 4>;
> > +		interrupt-names =3D "ams-irq";
> > +		clocks =3D <&clkc 70>;
> > +		reg =3D <0x0 0xffa50000 0x0 0x800>;
> > +		reg-names =3D "ams-base";
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
>=20
> There's no need for 64-bits of addresses and sizes here. Use ranges.

Okay.

> > +
> > +		ams_ps: ams_ps@ffa50800 {
> > +			compatible =3D "xlnx,zynqmp-ams-ps";
> > +			reg =3D <0x0 0xffa50800 0x0 0x400>;
> > +		};
> > +
> > +		ams_pl: ams_pl@ffa50c00 {
> > +			compatible =3D "xlnx,zynqmp-ams-pl";
> > +			reg =3D <0x0 0xffa50c00 0x0 0x400>;
> > +			xlnx,ext-channels {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				channel@0 {
> > +					reg =3D <0>;
> > +					xlnx,bipolar;
> > +				};
> > +				channel@1 {
> > +					reg =3D <1>;
> > +				};
> > +				channel@8 {
> > +					reg =3D <8>;
> > +					xlnx,bipolar;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +AMS Channels Details:
> > +
> > +Sysmon Block	|Channel|			Details
> 			|Measurement
> > +		 Number
> 			 Type
> > +----------------------------------------------------------------------=
-----------------------------
> ------
> > +AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.
> 		|Voltage
> > +		|1	|Battery voltage measurement, VCC_PSBATT.
> 		|Voltage
> > +		|2	|PL Internal voltage measurement, VCCINT.
> 		|Voltage
> > +		|3	|Block RAM voltage measurement, VCCBRAM.
> 		|Voltage
> > +		|4	|PL Aux voltage measurement, VCCAUX.
> 		|Voltage
> > +		|5	|Voltage measurement for six DDR I/O PLLs,
> VCC_PSDDR_PLL.	|Voltage
> > +		|6	|VCC_PSINTFP_DDR voltage measurement.
> 			|Voltage
> > +----------------------------------------------------------------------=
-----------------------------
> ------
> > +PS Sysmon	|7	|LPD temperature measurement.
> 			|Temperature
> > +		|8	|FPD Temperature Measurment (REMOTE).
> 			|Temperature
> > +		|9	|VCC PS LPD voltage measurement (supply1).
> 		|Voltage
> > +		|10	|VCC PS FPD voltage measurement (supply2).
> 		|Voltage
> > +		|11	|PS Aux voltage reference (supply3).
> 		|Voltage
> > +		|12	|DDR I/O VCC voltage measurement.
> 		|Voltage
> > +		|13	|PS IO Bank 503 voltage measurement (supply5).
> 			|Voltage
> > +		|14	|PS IO Bank 500 voltage measurement (supply6).
> 			|Voltage
> > +		|15	|VCCO_PSIO1 voltage measurement.
> 		|Voltage
> > +		|16	|VCCO_PSIO2 voltage measurement.
> 		|Voltage
> > +		|17	|VCC_PS_GTR voltage measurement
> (VPS_MGTRAVCC).			|Voltage
> > +		|18	|VTT_PS_GTR voltage measurement
> (VPS_MGTRAVTT).			|Voltage
> > +		|19	|VCC_PSADC voltage measurement.
> 			|Voltage
> > +----------------------------------------------------------------------=
-----------------------------
> ------
> > +PL Sysmon	|20	|PL Temperature measurement.
> 			|Temperature
> > +		|21	|PL Internal Voltage Voltage measurement, VCCINT.
> 		|Voltage
> > +		|22	|PL Auxiliary Voltage measurement, VCCAUX.
> 		|Voltage
> > +		|23	|ADC Reference P+ Voltage measurement.
> 			|Voltage
> > +		|24	|ADC Reference N- Voltage measurement.
> 			|Voltage
> > +		|25	|PL Block RAM Voltage measurement, VCCBRAM.
> 			|Voltage
> > +		|26	|LPD Internal Voltage measurement, VCC_PSINTLP
> (supply4).	|Voltage
> > +		|27	|FPD Internal Voltage measurement, VCC_PSINTFP
> (supply5).	|Voltage
> > +		|28	|PS Auxiliary Voltage measurement (supply6).
> 		|Voltage
> > +		|29	|PL VCCADC Voltage measurement (vccams).
> 		|Voltage
> > +		|30	|Differencial analog input signal Voltage measurment.
> 		|Voltage
> > +		|31	|VUser0 Voltage measurement (supply7).
> 			|Voltage
> > +		|32	|VUser1 Voltage measurement (supply8).
> 			|Voltage
> > +		|33	|VUser2 Voltage measurement (supply9).
> 			|Voltage
> > +		|34	|VUser3 Voltage measurement (supply10).
> 			|Voltage
> > +		|35	|Auxiliary ch 0 Voltage measurement (VAux0).
> 		|Voltage
> > +		|36	|Auxiliary ch 1 Voltage measurement (VAux1).
> 		|Voltage
> > +		|37	|Auxiliary ch 2 Voltage measurement (VAux2).
> 		|Voltage
> > +		|38	|Auxiliary ch 3 Voltage measurement (VAux3).
> 		|Voltage
> > +		|39	|Auxiliary ch 4 Voltage measurement (VAux4).
> 		|Voltage
> > +		|40	|Auxiliary ch 5 Voltage measurement (VAux5).
> 		|Voltage
> > +		|41	|Auxiliary ch 6 Voltage measurement (VAux6).
> 		|Voltage
> > +		|42	|Auxiliary ch 7 Voltage measurement (VAux7).
> 		|Voltage
> > +		|43	|Auxiliary ch 8 Voltage measurement (VAux8).
> 		|Voltage
> > +		|44	|Auxiliary ch 9 Voltage measurement (VAux9).
> 		|Voltage
> > +		|45	|Auxiliary ch 10 Voltage measurement (VAux10).
> 			|Voltage
> > +		|46	|Auxiliary ch 11 Voltage measurement (VAux11).
> 			|Voltage
> > +		|47	|Auxiliary ch 12 Voltage measurement (VAux12).
> 			|Voltage
> > +		|48	|Auxiliary ch 13 Voltage measurement (VAux13).
> 			|Voltage
> > +		|49	|Auxiliary ch 14 Voltage measurement (VAux14).
> 			|Voltage
> > +		|50	|Auxiliary ch 15 Voltage measurement (VAux15).
> 			|Voltage
> > +---------------------------------------------------------------------
> > +------------------------------------
> > --
> > 2.1.1
> >

Thanks,
Manish Narani
