Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F64C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF37208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r/Lxo4j/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF37208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeK3BOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:14:43 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:18784
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726989AbeK3BOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA8aLWEcfva0+I+TNVNnflrQQuqQJhCZ1RHVHc/k76c=;
 b=r/Lxo4j/B5SO2BRyAB3xdFz7Mup6QksV1f7kMpMbz5qe4dixad6/2QgBjqJF4I8jFaCm0tRzrMLhSoIzzpaBOXqnQHdfxXxXcY6Vof27MuxfAd0qg037ByCFFkJSY7mFL3EchOTND80LQxAZoCyYRnXIHtV0d8pswCDI2/PxUKg=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3725.eurprd04.prod.outlook.com (52.134.15.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 29 Nov 2018 14:09:11 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%9]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 14:09:11 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND] bus: fsl-mc: explicitly define the fsl_mc_command
 endianness
Thread-Topic: [PATCH RESEND] bus: fsl-mc: explicitly define the fsl_mc_command
 endianness
Thread-Index: AQHUfNxw+U2RkUGjsUCH4hKpL41br6VkCUGAgALWQzA=
Date:   Thu, 29 Nov 2018 14:09:11 +0000
Message-ID: <VI1PR0402MB2800860831524A38C52620F5E0D20@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1542283916-13101-1-git-send-email-ioana.ciornei@nxp.com>
 <20181127184621.GA18012@kroah.com>
In-Reply-To: <20181127184621.GA18012@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3725;6:nIiomSAO6OdQ3/30TXz+cFZYvcSRO2gk+fSV4lStt7Qz+zhJ2neOne1gxoIWg+cjeHSFM6GpWbg4VAEgK6hYyOCTDZF5+ndu9q+jMBSFqdrEaBceTpQptXGdq5bP+I4+K4R9dIN2Ai1V1QbIU/pGO4Uj4tXvssz24M3OYDihFxBeVxAwwP+cKDj0lInhbyE/iBjfJQokzzY5SD8Eylj4X2oUFxXRDK4gDbpUWTz7y4jymiZsyRXoB7wjQfXcJtoZsactaGsruyoy6fSG89m+U70o+OXlOYIrSF8LRcAe5epdm2N/X2IJnjzDUjNOIl2jn0TrWD7G5hxH1RCzFqb/NOAgY5P0jDKkTLFrwVo3byl5nO0n9gLY6LEhilGcWivGUVxWhVpxQXKumMsBvx6LtO4BLdVf51vqjq/tc3fNitNrQ5PKCv8Wth8TtkPAxp6cOK5wJtdVBYb+dJryW9NmNA==;5:XxdX1n/7KadQRKDkwqmbxjAgw3+ODcXABPE3uByqNhA7w63BZv4GA8AsJqTUc8fTV3NpRcLRoKp5ihI8UGuC/mu53+x13o9TNpbznvxc0MgxcXVKVC92YZ39uvOzpIX4GrxV8I2176KK9lXDvjcayMUMrZb9BEZb5OCUIXRR9Zg=;7:STAwM1bBv4U7Pce1g0y9LX1cal0ZpgvfDupLkBdUhgseqejMtY84t7XhEcBrxQVI6uMlNfihjZ7As3HShIeAbmwqxuizM9KAE8xWkvEE66iXm6KBe7ZITR3UkT7G38tEFcBdtzuft1FEU6ngVqz78Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 431ceb86-1a5d-47e1-75de-08d656043ca0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3725;
x-ms-traffictypediagnostic: VI1PR0402MB3725:
x-microsoft-antispam-prvs: <VI1PR0402MB372512A7DCD9A403F317EFD7E0D20@VI1PR0402MB3725.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231453)(999002)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3725;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3725;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(6436002)(81156014)(11346002)(6916009)(97736004)(5640700003)(55016002)(2501003)(4326008)(305945005)(53936002)(1730700003)(8676002)(256004)(25786009)(99286004)(2906002)(2351001)(7736002)(81166006)(74316002)(33656002)(14454004)(229853002)(6246003)(71190400001)(6506007)(102836004)(476003)(478600001)(446003)(106356001)(5660300001)(8936002)(3846002)(26005)(68736007)(186003)(66066001)(54906003)(105586002)(44832011)(86362001)(76176011)(6116002)(9686003)(71200400001)(7696005)(486006)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3725;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jdl2/0oUSZ+cbJG0kquv7kUTzvEdWOsZnRn8FTVLTqSphYBHtZT4d7PJrbMnToBRvYH8oyFIX3PEswr5z04TNqqOedCPvRLLj5KoXyRlOV2jpL650SgO1Gu+S3+WyQtbVePZBWSFrwJsV7eZ37p+3k5haIGy63uivMu8hi6hd7/V+Ftu+zcNhqsp11a/IQ0Oub9pMLkhcZ7PY2CP7F5JQ4HJLGnVW39vzE3omq+HpCwcRy4T+Y/xMaUSPiC0cK2rtlG0zaLI4W6AU0ypp+YJaoEkMmjvhOHxCzVSekV3iDz4pbzpOIj10UT3xolbth+mgweF+gkNHUlZpYymWo0GUmo629rhksCsaKlhRLOxt/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431ceb86-1a5d-47e1-75de-08d656043ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 14:09:11.5573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Both the header and the command parameters of the fsl_mc_command are
> > 64-bit little-endian words. Use the appropriate type to explicitly
> > specify their endianness.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> >  include/linux/fsl/mc.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> What tree is this made against?  I can't seem to apply it to any of mine =
:(
>=20

This was generated against a clean 4.20-rc1 but I just checked and I could =
apply it on both staging-next and driver-core-next.
Am I missing something?

Ioana

> Any hints?
>=20
> thanks,
>=20
> greg k-h
