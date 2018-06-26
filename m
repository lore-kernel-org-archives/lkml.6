Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E03C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B7E265AD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dokDTdMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B7E265AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeFZHBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:01:02 -0400
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:47904
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751181AbeFZHA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTQmAe5efPgkFvtbCwCl7+kMvVGcttEkkF+u8cLqOSg=;
 b=dokDTdMUL8pwOtQvm9ob7SlKGuFhfTlCv2nVVgvghWuCA3JEA6WlP00UIae8vDM5lre9xQAfjwbNVe2DP5HHsFwSeT6zpdyPPDA+z/Iyjkhjnqg3H8HK9EyeB9qjx2nr7vI50wBzfXWAtRyrqn9iycFPZV34/0ebWesCCBTDDBo=
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) by
 AM6PR04MB4679.eurprd04.prod.outlook.com (20.177.39.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Tue, 26 Jun 2018 07:00:56 +0000
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::db7:da35:1a5c:d7e7]) by AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::db7:da35:1a5c:d7e7%5]) with mapi id 15.20.0884.024; Tue, 26 Jun 2018
 07:00:56 +0000
From:   Madalin-cristian Bucur <madalin.bucur@nxp.com>
To:     David Miller <davem@davemloft.net>,
        "bas@daedalean.ai" <bas@daedalean.ai>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fman: don't set node on dpaa-ethernet platform device
Thread-Topic: [PATCH] fman: don't set node on dpaa-ethernet platform device
Thread-Index: AQHUCVT3W+RjeCsJ3kGTssDKpidIkKRtEAMAgAUTbLA=
Date:   Tue, 26 Jun 2018 07:00:56 +0000
Message-ID: <AM6PR04MB40085FE9AED3D8698FF505B6EC490@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <20180621114222.8326-1-bas@daedalean.ai>
 <20180623.102724.1590504977410505871.davem@davemloft.net>
In-Reply-To: <20180623.102724.1590504977410505871.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4679;7:Ih4qCLyZoCAHzIgOg8zxo7fvDkEWz/CuYnoPw5ERUe5noxWVHmELOO0CnEFoj5YOsaKUiNmPlui2RxyWZDGGMbSxKELmNXJjnAnfwRev0nHOl0QkATLLkGUZYGA0dh/ZH031+hZtX3Rn7P07Joe8iWb+IRCVVNRjsB8C/mEoULDH+DtoM714rXYDw95MPEvIa7L319QJX738v+RH4qrYoMMceq7XrN8DgV7v24OuflErfxKqmDChrhSczvP+Prvv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d51aca80-c092-426f-7d5c-08d5db32907f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4679;
x-ms-traffictypediagnostic: AM6PR04MB4679:
x-microsoft-antispam-prvs: <AM6PR04MB4679A7BA3059B2629F93E885EC490@AM6PR04MB4679.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4679;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4679;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(13464003)(189003)(199004)(478600001)(14454004)(256004)(66066001)(5660300001)(2501003)(5250100002)(8936002)(446003)(11346002)(486006)(81156014)(81166006)(8676002)(476003)(102836004)(3846002)(6116002)(76176011)(316002)(186003)(86362001)(26005)(575784001)(110136005)(7696005)(54906003)(53546011)(6506007)(9686003)(6246003)(68736007)(6436002)(2900100001)(55016002)(229853002)(99286004)(25786009)(53936002)(97736004)(74316002)(2906002)(105586002)(33656002)(305945005)(7736002)(106356001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4679;H:AM6PR04MB4008.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UWTJ0FoAQ1nUbsgvJct0EYcumFmiwpcZ3XzPMHcXPepLJixccVMJqZbZvQGpHU8TqdRFvupaswTSvRZH+yJSwKKjjSzVoWcPnX4OOodnX9ZH9SsCOzithGwjs2LOHnrBX2LUTG2G1xBmk0+pZ8VVH9ug+vwnCXX1BVBkO4z8QIQGutm5hl2yYgC2p7MFZmf8sZ2Bq4oc9Jznzs3rdXk4kyW23rtMgS1OsybG0DiSz5xOpSetayr3PGXjuQRziahJfCkVC+slKkKj18R0hHbndImPOta2v2YPoP0Sl658jqHbwbWkFNYYKWOmQp8TiXgTXlrFBuLl4C31HdncG60XQEjL6rx2SByk4pnnEbqhkzc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51aca80-c092-426f-7d5c-08d5db32907f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 07:00:56.0764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Saturday, June 23, 2018 4:27 AM
> To: bas@daedalean.ai
> Cc: netdev@vger.kernel.org; Madalin-cristian Bucur <madalin.bucur@nxp.com=
>;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] fman: don't set node on dpaa-ethernet platform devic=
e
>=20
> From: Bas Vermeulen <bas@daedalean.ai>
> Date: Thu, 21 Jun 2018 13:42:22 +0200
>=20
> > Setting dev->node to the mac_node in dpaa_eth_add_device during probe
> > causes the mac_probe to be called again for the dpaa-ethernet.* device
> > that was just added.
> >
> > Fix this by not setting dev->node, as it is not needed.
> >
> > Signed-off-by: Bas Vermeulen <bas@daedalean.ai>
>=20
> This patch doesn't apply to the current sources.

Hi,

The line the patch is trying to remove was added in this commit

	commit a1a50c8e4c241a505b7270e1a3c6e50d94e794b1
	Author: Florian Fainelli <f.fainelli@gmail.com>
	Date:   Tue Aug 22 15:24:47 2017 -0700

	    fsl/man: Inherit parent device and of_node

and was already removed in this commit

	commit 48167c9ce0b91c068430345bf039c7be23fa2f3f
	Author: Madalin Bucur <madalin.bucur@nxp.com>
	Date:   Mon Oct 16 21:36:05 2017 +0300

	    fsl/fman: remove of_node

Regards,
Madalin
