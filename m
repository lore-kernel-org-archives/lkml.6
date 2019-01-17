Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1641C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617C120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oGBUwRgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfAQHBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:01:25 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:23899
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfAQHBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZaoQ9wUvyob7tKXWWWOQ9eoJwx3v1FVrzl0Q5QagC4=;
 b=oGBUwRgQNfawWJQfDMGB7oQnP47CgX+BLKxDd9mroZ1vm692eweZiOceu1kYA6S4O9jSk7wtOkhXjTHIF5s9vMTfVSlUsrFO5+HuL+MUWUYj3aJVp6QeqFNlwEPzFUPMTkXRQHcdKljs9iHkSqJpHfUJ3MMicEAGCnyMUxsoGyY=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB6079.eurprd04.prod.outlook.com (20.179.25.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Thu, 17 Jan 2019 07:01:21 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::482:b606:281d:ebf5]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::482:b606:281d:ebf5%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 07:01:21 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: usb: ci-hdrc-usb2: add property
 power-active-high
Thread-Topic: [PATCH v3 1/2] dt-bindings: usb: ci-hdrc-usb2: add property
 power-active-high
Thread-Index: AQHUrYw/5wxJwf4f10q/6GCCK3hl76WzB9Qw
Date:   Thu, 17 Jan 2019 07:01:21 +0000
Message-ID: <VI1PR04MB5327656AD22454B054CE0AD08B830@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190116105103.28842-2-philipp.puschmann@emlix.com>
 <20190116111133.31326-1-philipp.puschmann@emlix.com>
In-Reply-To: <20190116111133.31326-1-philipp.puschmann@emlix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6079;6:XKseI1LaHssg0kE0LoRQzFLteRPRN6Byo7h9gsHW07k3iGvhXyLYM4I/cabeOomUy0Irb7+eJIG3Uz9N49IFHS69w0z6TaLB0pUPWnIpZ5jb5ZkNab3h1+AfoLen+nXIPvrdUblw/Er2C3LD7Z6kKkqbEug5cPZ2AzDOs/VOchPmLTN/UaNLBH1c/3vpEYIK+MLAsKhXKpgeyf+9SNRF0EW/vRofpY0c22N8Q4qPVvZzUZmCYsk99SL6Y1ylrj7d8fYhV9AS2dVtXtqTs1kjTrhv1usCvfKGqg5ZKoW7jrwYkPAv2gWuLeSZ5EXD7HdabMNs+/ZO4EuABR7oRSLaHUjJcg1esDVu7f+MH8E16dmZpwKnq4K3aqW/Icw7Y+zoluymfMCGZv7r76B5VAckx1KUcHNiQahrmgNaP1WIwZloNttavnzpj+koXl9kPSPwem76pYMiXhTZznwZufwMSA==;5:/yKEEnWMRFOY64g4SscBmLo6sMa8JWlXZKel/3CL6bfVIVuvlQ+/Ckfi9mAyEIZIF0lfaIZjMHMRdJkFhx597Nk9iqGcj5un7TzIFcYar/eTA+B8j5g/P+MSpAhO50RT1gnmEuATQD9pCMgAIb05WzfQ7bxTdY4tPsU6n/4eKb52/TRW+IFdhpL99IzODUKI3zQgC1MhKRd40z1AxWWc9g==;7:21g8j16D2IwfDa5PmIJ7oVPSOLLP4CNz2yiuJMPcczCKIC3FiY031PGo06pgd24GJG+R2CMoUiSB5Mbza9CHPvE9eJ/8ritAKHTALh5dAQ1qVV9Rh49uZlvIAENC29KvIEC36TEqGHkx910QYNHDlw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d057ece7-a8dd-4423-cf86-08d67c499636
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6079;
x-ms-traffictypediagnostic: VI1PR04MB6079:
x-microsoft-antispam-prvs: <VI1PR04MB6079A4B49E263A877C5757A68B830@VI1PR04MB6079.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(86362001)(229853002)(97736004)(186003)(76176011)(102836004)(7696005)(26005)(6506007)(110136005)(25786009)(106356001)(54906003)(105586002)(476003)(14454004)(33656002)(44832011)(8676002)(81156014)(81166006)(8936002)(256004)(55016002)(486006)(6436002)(305945005)(11346002)(446003)(7736002)(68736007)(66066001)(5660300001)(74316002)(3846002)(6116002)(478600001)(99286004)(9686003)(316002)(4326008)(53936002)(71200400001)(2501003)(71190400001)(6246003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6079;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O23uvCG5UPruyLAexNL52cd41cULBVT+DkM1jyOUiapAuDBNd9/Pa0UIFd0Y1MOx5u2G4sDCdEQBYaodQJvVFhFhmVcvcXQDpgWywG+xuAqdbhsZ8Nl9PU3w6KWJXTHJjgpNNtECeARtwvfKdDHjyoaSZSizvdB8DIWwlIaoylhfRmpptYEAAZUw93PGVLnJWsSP2dBhYWcBs4hdTijOx1WYZRzjbH6Crn/SHj2ab/MRRHmnMjZ5NdMIBaieABl5T/NvDHOhR603fnWW2CiSTZISIFV8cW6SJZX8usm6R5U6X8Q1omvYp+s/rwZ5jcgpDn119DjOZrtkFLkK4sZlQlzBWlIlwbnd04DmfXgWWyZf5/S1QmtSynSBlqhqvECS88xObl93ijnzMNZI2KbiGrTRYGOu8hL93F4bugQueWI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d057ece7-a8dd-4423-cf86-08d67c499636
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 07:01:21.3124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> The i.MX6q/dl USB controller may drive the usb power line directly, but t=
he polarity
> depends on the board. Reset state of the polarity is low-active so add th=
is property
> to allow it to be high-active.
>=20

As far as I know, most of i.mx USB controllers (except imx28/23, but they d=
on't have non-core registers)
work like this, and most of them are low active for PP default. Would you j=
ust use "i.mx" at
both your code and your comment?

Peter

> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> ---
> Changes in v3: add description
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> index adae82385dd6..8696e3eff6e7 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> @@ -93,6 +93,7 @@ i.mx specific properties
>  - over-current-active-low: over current signal polarity is active low.
>  - over-current-active-high: over current signal polarity is active high.
>    It's recommended to specify the over current polarity.
> +- power-active-high: power signal polarity is high active (only for
> +imx6q/dl)
>  - external-vbus-divider: enables off-chip resistor divider for Vbus
>=20
>  Example:
> --
> 2.20.1

