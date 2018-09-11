Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8EEC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37E520854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rtQ5M7VY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37E520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeIKNHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:07:17 -0400
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com ([104.47.41.76]:61664
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbeIKNHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X83tFnz5P9hizSJyB7awFK++AbBxII6IHjbsa5i7JeY=;
 b=rtQ5M7VYXhu96PAoihVh0j3VIjz8cyLfrL6IeOiKajtG3bmer2eZ3HXmIuscbJXZcWgRF0Ele7eQBFJpz8Ex66/7AwTlVUDqfNJT0e5FyZ5FC/hxISAnnxPVup5NOPRbU91Lmxr8BRoxcRLi0wILh9quF4ennzuwn3qPPS+o4js=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0884.namprd02.prod.outlook.com (10.160.154.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 11 Sep 2018 08:07:10 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1143.010; Tue, 11 Sep 2018
 08:07:09 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>, Michal Simek <michals@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Thread-Topic: [PATCH v3 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Thread-Index: AQHURTd6gQs0hQ3Au06kiXaejJde5qTp/+6AgACiMUA=
Date:   Tue, 11 Sep 2018 08:07:09 +0000
Message-ID: <BN3PR0201MB09934721CEEE6E9F3316644CA7040@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536165747-6405-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180910203059.GA7055@bogus>
In-Reply-To: <20180910203059.GA7055@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0884;6:8SkTgEs7ewHa4VawAtde/3LyO92MB0azBN8DX/3JY/1FxWfip6gDNAzEEVVeAxyKz6h4u5xVBbRmGVg62PEzRZcADxg9BYIpb0L23Xsu0n1/eYNR9Bgw91hW+pSh3gNZ2cjA5vmYN/Y4dTla+0FNldtD9PVx26xh8S780HOldkr7HHsuynMU+R5BLXDyliDinMZhqyh1XZU896yZiV3pAuxGPsk16AuKIqZ9nPtJ4qzU4B6bwy2kClctdfTRBHliwlnPgEbJAsTXwOcUROP2quYJi6O10Mq0OKffpOVMpqXfETsDBYIh4pNUVWMHfnwrzjVuTtX1xUr9sDU4DZoJQcKocVGR7ZgCs4/Tguq5YfNNl+klGDNRKCDWCdN3wuXqkzL3peTAdJePsy+suUstE4dz0OW9FDKoabr7heNE8UeIXEoGyE+ry0Dm4WMPT0m6OP+7ODX4MH8J91zvNp5mNw==;5:KcAgTA6wipv6O6MLaN5gihCdkxtRJPg672kZSTwEH7XNIJwnDC+qGJwRYrpS2X8qpLmxjsjlQ9OJg74DVCPG6B+9lhp1ecb3wNGL2+WtSi/mTqVVQ2dYwtrYMYoAtiDgxXWBxgLSJtQ03e/OPKAPxKhgVV9Ye4qKryCp6SeMZO0=;7:RuyGF8UtNyKS/b9jbkW0w/lr+TeIRCYKb3tHibhoSg1E9N2PfcZq3TIcrV6p9oN9rvXKOwl1tHrj/aLblh+0DhBIyRfH3FaK6fflexGzEwLOuEOSPMfP5ixfYAQvbgAm0vauTrXn2JP1vh3yETT2a7JsHR/gBFFhlMyAQ24P78EF2mHTGKXQflRYlkgC87tPwQ8f0pt5FqKE5ZVJQAJdVXzQ8veWycYqLi6R6Ao/Jb0s3+ceYmz/YmcxPX92YOix
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: e99e1772-18b7-410b-4f43-08d617bd928e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0884;
x-ms-traffictypediagnostic: BN3PR0201MB0884:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB0884718283D00E89398B7D3DA7040@BN3PR0201MB0884.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BN3PR0201MB0884;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0884;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(396003)(39860400002)(199004)(189003)(81156014)(81166006)(8936002)(66066001)(25786009)(8676002)(2900100001)(229853002)(7696005)(6246003)(99286004)(97736004)(6916009)(316002)(14454004)(6116002)(3846002)(55016002)(4326008)(575784001)(5660300001)(68736007)(6506007)(86362001)(478600001)(5250100002)(2906002)(305945005)(7736002)(186003)(486006)(102836004)(54906003)(6436002)(39060400002)(256004)(106356001)(14444005)(76176011)(105586002)(74316002)(11346002)(446003)(476003)(33656002)(53936002)(9686003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0884;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iPLVEeT4dixZBoc9Yl04dgUfcjdE4I+n/z7UaH5vLIJXFNqSZGs4U8/Im+mZNbvu8Wb+SKt1hf9TYO/njp9WARxsFYngZuSIQcSaxVdepovyaDhUNGZ+Z8YnwgEkKQvUajgpjeKA37maeYWq+ClkxG/4Tfsxrq+7waI4X0M7Kgj7B7ckJs8+83wlOzrvF3hzv7bZrvNmqtxhf6fZlUAqep68E0N1bVLTGAzpRTl8NHLju/duqDrI03cFIt4MIHfLIUfMEbmES38VbC/TPFBEdX55ErHcAG1hPXE008gMRx0fm/0SerRiMI/kydPAmQ3ONv6IeYhGwvvYfBMa7G8lnwXa6qVBfPTN4bQrsmrSz4E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99e1772-18b7-410b-4f43-08d617bd928e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 08:07:09.2610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks a lot for reviewing this code, please find my comments inline

>> +This binding describes a ZynqMP PHY device that is used to control
>> +ZynqMP High Speed Gigabit Transceiver(GT). ZynqMP PS GTR provides
>> +four lanes and are used by USB, SATA, PCIE, Display port and Ethernet S=
GMMI
>controllers.
>> +
>> +Phy provider node
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Required properties:
>> +- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
>> +
>> +- reg           : Address and length of register sets for each device i=
n
>> +                  "reg-names"
>> +
>> +- reg-names     : The names of the register addresses corresponding to =
the
>> +		  registers filled in "reg":
>> +			- serdes: SERDES block register set
>> +			- siou: SIOU block register set
>> +
>> +Optional properties:
>> +- xlnx,tx_termination_fix : Include this for fixing functional issue
>> +with the
>
>s/_/-/
>

Will fix this in next series of the patch

>> +		  TX termination resistance in GT, which can be out of spec for
>> +		  the XCZU9EG silicon version. This property is not required for
>> +		  "xlnx,zynqmp-psgtr-v1.1"
>> +
>> +Required nodes	:  A sub-node is required for each lane the controller
>> +		   provides.
>> +
>> +Phy sub-nodes
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Required properties:
>> +lane0:
>
>lane0 or lane@0? If you need or care about numbering then add a reg proper=
ty.
>

Thanks for correcting,  Will change this to lane@0 and resend the patches

>> +- #phy-cells	: Should be 4
>> +
>> +lane1:
>> +- #phy-cells	: Should be 4
>> +
>> +lane2:
>> +- #phy-cells	: Should be 4
>> +
>> +lane3:
>> +- #phy-cells	: Should be 4
>> +
>> +Example:
>> +	zynqmp_phy: phy@fd400000 {
>> +		compatible =3D "xlnx,zynqmp-psgtr-v1.1";
>> +		status =3D "okay";
>> +		reg =3D <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>;
>> +		reg-names =3D "serdes", "siou";
>> +
>> +		lane0: lane@0 {
>> +			#phy-cells =3D <4>;
>> +		};
>> +		lane1: lane@1 {
>> +			#phy-cells =3D <4>;
>> +		};
>> +		lane2: lane@2 {
>> +			#phy-cells =3D <4>;
>> +		};
>> +		lane3: lane@3 {
>> +			#phy-cells =3D <4>;
>> +		};
>> +	};
>> +
>> +Specifying phy control of devices
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Device nodes should specify the configuration required in their "phys"
>> +property, containing a phandle to the phy port node and a device type.
>> +
>> +phys =3D <PHANDLE CONTROLLER_TYPE CONTROLLER_INSTANCE LANE_NUM
>> +LANE_FREQ>;
>> +
>> +PHANDLE                 =3D &lane0 or &lane1 or &lane2 or &lane3
>> +CONTROLLER_TYPE         =3D PHY_TYPE_PCIE or PHY_TYPE_SATA or PHY_TYPE_=
USB
>> +			  or PHY_TYPE_DP or PHY_TYPE_SGMII
>> +CONTROLLER_INSTANCE     =3D Depends on controller type used, can be any=
 of
>> +				PHY_TYPE_PCIE : 0 or 1 or 2 or 3
>> +				PHY_TYPE_SATA : 0 or 1
>> +				PHY_TYPE_USB  : 0 or 1
>> +				PHY_TYPE_DP   : 0 or 1
>> +				PHY_TYPE_SGMII: 0 or 1 or 2 or 3
>> +LANE_NUM                =3D Depends on which lane clock is used as ref =
clk, can be
>> +			  0 or 1 or 2 or 3
>
>I'm not really clear about what this is.
>

ZynqMP phy has a feature that each individual lane (among the 4 lanes) can =
have its own PLL
reference  clock or share the clock generated from other lanes. For example=
=20

Lane 0 can use its own ref clock for PLL: in this case LANE_NUM =3D 0
Lane0 can use Lane 3's ref clock for PLL: in this case  LANE_NUM =3D 3

Maybe I should change the name LANE_NUM to LANE_REF_CLK to give more readab=
ility. Please
correct me if wrong. =20

>> +LANE_FREQ               =3D Frequency that controller can operate, can =
be any of
>> +
>19.2Mhz,20Mhz,24Mhz,26Mhz,27Mhz,28.4Mhz,40Mhz,52Mhz,
>> +			  100Mhz,108Mhz,125Mhz,135Mhz,150Mhz
>
>This can't be implied by the mode/type? I wouldn't expect any frequency ca=
n be used
>for each mode.
>

Yes you are correct, not all frequencies are supported by all protocols, bu=
t each protocol supports
a limited set of multiple reference clock frequencies. For example USB3.0 p=
rotocol can operate with
26, 52 & 100 MHZ. Providing any other frequency would make the phy fail to =
lock the PLL and error
would be generated by the driver. As you suggested, I will add more details=
 regarding the frequencies
supported by different protocols in the next series of the patch.=20
 =20
>> +
>> +Example:
>> +
>> +#include <dt-bindings/phy/phy.h>
>> +
>> +	usb@fe200000 {
>> +		...
>> +		phys	  =3D <&lane2 PHY_TYPE_USB3 0 2 2600000>;
>> +		...
>> +	};
>> +
>> +	ahci@fd0c0000 {
>> +		...
>> +		phys	  =3D <&lane3 PHY_TYPE_SATA 1 1 125000000>;
>> +		...
>> +	};
>
>What if you are doing multiple lanes for 1 device? That would be more usef=
ul 2nd
>example if that's supported.
>

Will add the multi lane example in the next series of the patch.

Thanks,
Anurag Kumar Vulisha

>> --
>> 2.1.1
>>
