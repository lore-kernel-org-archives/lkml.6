Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66501C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABFF2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TuP2a1tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfBYQQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:16:25 -0500
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:7953
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727684AbfBYQQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4RYgd6cBno/hFbdX+w74tj8rd36wXwZYAM/AbgsnH4=;
 b=TuP2a1tM6vJuIbXNlEtEy6YrIJk9W6RERQKqdOvzgDRU4woV+j9yB6QoGcS+1UZa9WOz2u76vxyhQoO0BFiZ3RnPq5sHaSaHRO/3grI5VLfDpSEnfZHuWoihpQlgQ6iSpjHOu9gZez5RlI6/3g4k0nkiFu2EdGoiz0UcPPetP3M=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB1614.eurprd04.prod.outlook.com (10.164.84.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 16:16:18 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::a8cf:3bab:8af2:57a6]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::a8cf:3bab:8af2:57a6%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:16:18 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 4/4] dt-bindings: net: freescale: enetc: Add
 connection bindings for ENETC ethernet nodes
Thread-Topic: [PATCH net-next v3 4/4] dt-bindings: net: freescale: enetc: Add
 connection bindings for ENETC ethernet nodes
Thread-Index: AQHUyr/uaAqo7/uaj0q5wEq7BxSLEqXseakAgAQ2ffA=
Date:   Mon, 25 Feb 2019 16:16:18 +0000
Message-ID: <VI1PR04MB488025A0352E15A1DE33B2BF967A0@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
 <1550847859-17346-5-git-send-email-claudiu.manoil@nxp.com>
 <20190222233732.GA1518@bogus>
In-Reply-To: <20190222233732.GA1518@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55a0c852-1c19-48a2-d014-08d69b3c9310
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1614;
x-ms-traffictypediagnostic: VI1PR04MB1614:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB1614;23:9qvTDUDdh3fYOBAgfUgXguC8Inqkwhu8ADZLCAir6?=
 =?us-ascii?Q?WryYuyTS8ohwLml92MGxrkhYN7KYgjHxLvj9hsnNSH5zjbV2ZxIOCnzto8yB?=
 =?us-ascii?Q?cM5CtDNsHL5a6rMXaJDBuYGvHoGphky4PrDDDVDo3lMznfhCzsmPYqv9GzzK?=
 =?us-ascii?Q?B4Iu8AFhRNa+FuZNghUDfibCmK9SWiWtNJuTDOxMfup1jRGpGW3M+I5b7qrN?=
 =?us-ascii?Q?3NmuIRBAmp1eNrANzgU/OHQ/5XCOSYTuY+9ObPUSFjs6B5J278gVzVunXOSQ?=
 =?us-ascii?Q?kyi32P6L2oekSd4EX56kdrf38tYxnJRv6LwN5HNS4F9R3WiVB7YnEWU3ta+X?=
 =?us-ascii?Q?20oXv1gR9tgsgXsyzwkPudXyCSbKJmhEflkcpb/6uNyWV/5eYMJsf+GHyIir?=
 =?us-ascii?Q?Yc6gihCVU5gVGVi4eeZwhJvhy/cpCszkcG2FhPAmjBGi9blS7qwn50OF0sTg?=
 =?us-ascii?Q?mlySoOtVcVBsdjG9YDJPVfmJzOjmL6X7PArx8EJYJ71bwo0+W2bDbmOCvqdB?=
 =?us-ascii?Q?qEZF17uYMNjrK3Fl3zyojtLIiugy461PPPAL0Kswxm7v0z41QM5LOZHSeB2t?=
 =?us-ascii?Q?4iGLTX2gSTUGCJ1o6Wujz3BDrBlYRC25VC/3u3n0WUye9EEffQ44XrnOouEx?=
 =?us-ascii?Q?afcRqOhGez3DJjLyTig5ZmwHGZLFIEJS3IW1sifMOxFIYd9phLM3qL/PKU1A?=
 =?us-ascii?Q?/7DoFfLoSDhmITmfaaqsDHre3TphOoaTavDS+75gKFUYFsuY0ZI71o55l2ZX?=
 =?us-ascii?Q?kHtqK0U12dUHfHA2ZF2OuVDqkPfVY4yVVHLKDh+inqT/qu49z4lwz0MA2+v2?=
 =?us-ascii?Q?COlefj6NXsz65yB1MrqSuMNErZqUxHEgodLeehczgDyU2c2CYM7aSodamK2Q?=
 =?us-ascii?Q?SQC1/S77edfWk7dA4bmn4euHlzMbKD3BNNA2qL/DI/lU/Enf8cSAgIpSPH95?=
 =?us-ascii?Q?4YDKOhx+7A0Im6V6wtJFumsMscyZPk3v60ML05dgRXsF6KPTWLim9bKLBuDn?=
 =?us-ascii?Q?aqfpb5MU5Dgacv4o/YywBjlwwULil8oXon1EY6VXgnrqcPCk4k8krIxeQYCn?=
 =?us-ascii?Q?NUyEn5KmV7FByMWwwLtMldyBCx4gw8byfb1/DL7xY50gNaDfL11pJFj9/j04?=
 =?us-ascii?Q?jnNyd040/LRAPis0oxcPjYwqIYEasHele9blEmpAR8uCa9fX8H6bHLnJprfd?=
 =?us-ascii?Q?pNtKtAJtfEFjFarmNzDZjr5Z0VpNRuyCOgK1dhA2iUHU5jPZ/1b/MOH/MR8N?=
 =?us-ascii?Q?RC77PB6aPqcsMwjeFfxXPZStImGxOeqoNtVO+sn?=
x-microsoft-antispam-prvs: <VI1PR04MB1614795D198F4FE1B07E7525967A0@VI1PR04MB1614.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(13464003)(189003)(199004)(446003)(71190400001)(6116002)(476003)(71200400001)(86362001)(81156014)(478600001)(305945005)(11346002)(3846002)(105586002)(8936002)(2906002)(106356001)(256004)(5024004)(81166006)(8676002)(5660300002)(52536013)(7736002)(74316002)(68736007)(486006)(44832011)(66066001)(55016002)(316002)(9686003)(26005)(53936002)(6916009)(186003)(99286004)(7696005)(76176011)(14454004)(6436002)(33656002)(6506007)(97736004)(102836004)(4326008)(6246003)(54906003)(25786009)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1614;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WkFEriVlCS3/gzLkb+zGItnCaQhDicm9i1DDR2fIoa+SHkGw5kaVU8C4DRT5ScS/RI4PgSWai3HUlK1LCWhE8iFLmdnVw0OmTEa8NYrkERpXYAsR+7+gGP/QdkEv9ILzpi1D2SUdRccB2rax1SYIsgV5DNAkLBtdaC/pp85cyyNDAYcat5EuFv+8bR/nZRvvEj4Iq1GIF3MhAmBi8Rc4JbggQDMMiWSxF1+scp9vU/tl6yoTuL8qBz9ePfckc+4PK61E4RuE21lVPx7KOFOiu5GIzSqivrp9GTXy3cyjvRSS4TD+pgaUW0YWpZxbjyhXZh0KgXDrHq9oNa4Wm9vsfx1FUOmIaeET+JelBFydBe3FNvf0z2ku0RMx3txVHua83vLccoqKk9Kytwv1ZlDVW/5Ebcm39U6vwddRWY8ZgkQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a0c852-1c19-48a2-d014-08d69b3c9310
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:16:18.5958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Rob Herring <robh@kernel.org>
>Sent: Saturday, February 23, 2019 1:38 AM
>To: Claudiu Manoil <claudiu.manoil@nxp.com>
>Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; David S =
.
>Miller <davem@davemloft.net>; Alexandru Marginean
><alexandru.marginean@nxp.com>; linux-arm-kernel@lists.infradead.org;
>devicetree@vger.kernel.org; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH net-next v3 4/4] dt-bindings: net: freescale: enetc: A=
dd
>connection bindings for ENETC ethernet nodes
>
>On Fri, Feb 22, 2019 at 05:04:19PM +0200, Claudiu Manoil wrote:
>> Define connection bindings (external PHY connections and internal
>> links) for the ENETC on-chip ethernet controllers.
>>
>> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
>> ---
>> v3 - added this patch to the set
>>
>>  .../devicetree/bindings/net/fsl-enetc.txt          | 109 ++++++++++++++=
+++++++
>>  1 file changed, 109 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/net/fsl-enetc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt
>> b/Documentation/devicetree/bindings/net/fsl-enetc.txt
>> new file mode 100644
>> index 0000000..2fbb998
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/fsl-enetc.txt
>> @@ -0,0 +1,109 @@
>> +* ENETC ethernet nodes - external connection bindings
>> +
>> +The ENETC ethernet controllers are PCIe integrated endpoints (IEPs),
>> +on-chip devices discoverable as standard PCIe endpoints, integrated
>> +into Freescale SoCs.  The ENETC devices are self contained, the
>> +information needed for device initialization is available in hardware
>> +(PCIe ECAM area).  However, depending on board design, their external
>> +connections are configurable.
>> +As usual for SoCs, device tree nodes may be used to define these
>> +external connections.  The rest of the document specifies how
>> +external connections for ENETC ethernet controllers may be defined
>> +via device tree nodes.
>> +
>> +Silicon (SoC) availability (<SoC name>: <SoC DT path/name>)
>> +	- LS1028A: [arch/arm64]	[...]freescale/fsl-ls1028a.dtsi
>
>This doesn't belong in bindings.
>
>> +
>> +
>> +* ENETC nodes
>> +
>> +Defined in the SoC device tree as "pci" child nodes of the
>> +"pci-host-ecam-generic" compatible "pcie" parent node also known as
>> +the Integrated Endpoint Root Complex (IERC) SoC node.
>
>The host controller attachment is also outside the scope of this binding.
>
>> +
>> +Structure - example (LS1028A):
>> +
>> +	pcie@1f0000000 {
>> +		compatible =3D "pci-host-ecam-generic";
>> +		device_type =3D "pci";
>> +		...
>> +		enetc_port0: pci@0,0 {
>
>The node name 'pci' is reserved for bridges. This should match the device =
class if
>possible (ethernet).
>
>> +			reg =3D <0x000000 0 0 0 0>;
>> +		};
>> +		enetc_port1: pci@0,1 {
>> +			reg =3D <0x000100 0 0 0 0>;
>> +		};
>> +		...
>> +	}
>> +
>> +Each ENETC node has a device number and a function number (expressed
>> +by its "reg" property and pci node name, i.e. "pci@0,1" represents
>> +device number 0 and functions number 1).  Only the standard pci "reg"
>> +property is needed here.
>
>There should be a compatible too.
[...]

Ok to simplifying the text and document strictly the enetc device nodes as
"ethernet" nodes, like "ethernet@<dev_no>,<fcn_no>" (i.e ethernet@0,1).
But what would be the compatible string needed for?
The ethernet device driver doesn't need it, probing is done by the pci syst=
em.
Is it ok to use a generic name for the compatible string, like, "fsl,enetc"=
, just
to indicate that the relevant driver is located at ethernet/freescale/enetc=
/
dir in the source code? (under drivers/net, of course)

Thanks.
Claudiu
