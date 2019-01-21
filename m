Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D90AC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2441D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="klgLpV+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfAUQRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:17:01 -0500
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:32373
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729413AbfAUQRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uizGjkXIxTwjtjswE6yvlXWKBq2xjTKYQpgJ2jnp/OY=;
 b=klgLpV+e3o+KO2gCv+s5MgcbjxfRhrPzGZNF7yVSreiAO2NyRC33DQUBpIadl4JbMXxTF4dOC8WZ7INZSbbFc29ha7hjOmy6O80B5s/AhXrAjxKKtIS1VFCL8AE3tKe3qK4HAtKj39oeSU8J1eAttjStVji2KZh2r5MQbV6cgXU=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5470.eurprd04.prod.outlook.com (20.178.121.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 16:16:55 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%6]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 16:16:55 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Olof Johansson <olof@lixom.net>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] kbuild: Add wilddt function instead of listing dtbs
Thread-Topic: [PATCH 0/3] kbuild: Add wilddt function instead of listing dtbs
Thread-Index: AQHUpr+U4MlukrPd1USdyY3EAbizyw==
Date:   Mon, 21 Jan 2019 16:16:55 +0000
Message-ID: <VI1PR04MB553355D6D5EBC2604E1AD256EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <cover.1546888138.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5470;6:b7yX7nxbEpoWScQobg+7SRGJutV1AeU5JayfRnmATICPYaHTq63jU82nSatqdx5Tn8CzmyFtqNuKWg/trwnwjG1pNnKBQ/DY85h5em9gzIPIq9AaleRSmKOroMBuZEpWQMlLkinlGBBCdMq62rCDCbB8eoaWB9wz44F0c/L8aDHFIN4Pek8R9CXufz1AaUT+vVGrcp7JnbERLQVoCR9+f/qO5XnsIHAvCVYqgdG9yRyQy4PniXvQl6ax5bgWNhGd4Nhu0l7WMo+2PKvZw/3C4/YKVAkJLHRK8fMu323eFbfqnwmCgoZcL6ngAR0uicoa8DaInvSD5mog3cUocGOo0sD4xnNJYZPut5v+260HEEJDRRa6bl57G93yTkpslFmcblLhew2gRXWQ7ktgl4QI822HMPHFYf3HJ7FKOg2DWydIzp9A3CSa4IByDDhWmiGWNjKwba7XafP2qwyAEUiNug==;5:7E+nBDcYQPBd/QRZcfDraS0EBly0Tb2u0EhSkrJCviGrBOg6NfTDV4CfhiaIO70hXwkUY9yXAN6DsqyVnxpSFw5mqwZaYvjhacrj3IzV3FMq+f2BQtgXVNWHaa/oGWdufMNqn8EIbAfgiiYERQ9d2IdpgivNFt9aL1kQQa459+ciBndNlBz8T8fZIHNzMayuDe8hETcBbAb4J3kGsGwFVg==;7:6IuhHh4J15rs+lP4rRFhF/ypo0f2xAEj8rKVwcN+p/tWILCcGGH0H4/Micp9Tdyua5thTC9o8Kj6vzQedYRM1A6JhF6d1SUz3ViZx3th1gikuv6TuLutoeFRkBjd3P9r+W9arE7bpZPhTLjmTFjBYQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 50cd8a25-2976-4c56-ce34-08d67fbbdcac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5470;
x-ms-traffictypediagnostic: VI1PR04MB5470:
x-microsoft-antispam-prvs: <VI1PR04MB5470FF2473EC640CF1782113EE9F0@VI1PR04MB5470.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(6506007)(305945005)(6116002)(9686003)(53936002)(7736002)(26005)(33656002)(186003)(55016002)(97736004)(6436002)(102836004)(8676002)(53546011)(68736007)(7416002)(3846002)(110136005)(74316002)(4744005)(6306002)(99286004)(54906003)(2906002)(8936002)(229853002)(76176011)(7696005)(25786009)(81156014)(81166006)(316002)(6246003)(71200400001)(66066001)(71190400001)(44832011)(4326008)(105586002)(446003)(478600001)(486006)(86362001)(476003)(14454004)(14444005)(966005)(256004)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5470;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2a0oTUZJIx2yLqexAtrrGfVWj8vWWLX5+mYp+Ge0EeR7mp59fAFo20LeNDAm58Xie4w9sx06+CcDZVf4jxu2C/3BpU35YVkGajTXTe/PKCOQz/+mwjSa4+iIwttgPDiKzLMB175+Vdr8OHLAECWrStXIBi0+tGeeowl6mf6bglhMLkLDgvbpeD3eOPSvfRdR2songuanVcUfom+PUyYlHRdZgNTxLYJ+pO0TsbCmyHVvWerBRzH78nVxxYhmq9YPKJQtfz5HkZuqoUgULqU8Ofe3PVjg0MN5wOqSlOoaLQK8Oanoz2S/O/zdZtB+g8U6osvk0v3Fv3Wxk1YzPkBBpEe5HFDMKyYngRnRl3sYIfzxA3YzXYlPSPOz1OlxhXb23QAEo3VYhFBu5MZuHJydJ0Mha9p66i8Z1YaIquzRZhw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cd8a25-2976-4c56-ce34-08d67fbbdcac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 16:16:55.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/2019 9:31 PM, Leonard Crestez wrote:=0A=
> The dts makefiles go through a lot of pointless churn when boards are=0A=
> added. Many SOCs (such as imx) have very simple naming conventions for=0A=
> all boards using a certain chip and board listings can be easily=0A=
> collapsed using wildcards.=0A=
> =0A=
> Add a "wilddt" function and use it for imx6/7/8 and layerscape. This can=
=0A=
> be applied to many other soc families later.=0A=
> =0A=
> Previously sent as RFC: https://lore.kernel.org/patchwork/patch/1022737/=
=0A=
=0A=
Any feedback? This should be reviewed by kbuild and arm-soc=0A=
=0A=
I think this is a worthwhile cleanup, are there any corner cases or more =
=0A=
exotic setup I should try in order to validate this series?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
