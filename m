Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EB3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CFE20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sm1QdQhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CFE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeGSNaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:30:23 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:39072
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727421AbeGSNaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJKjBi1o3J2+3gN+miPFgwVddpvKlG5ue5uWccAyTYA=;
 b=sm1QdQhZDP9wZyYhyluVnBOTB3qRXrJBnh5QfAMMAbR32hZO/+xZEF43YKthejx+CVbC1devfhSpIG1IVtWxFp6yG8TKRMCFQSrm1vCCRyPExH4Q0NINuqwdYD4mmlYbeq5Y2FHtFvxtxLNmArmdPTaOci8YVew6SaG5NsA1ZOY=
Received: from VI1PR04MB4799.eurprd04.prod.outlook.com (20.177.48.220) by
 VI1PR04MB1408.eurprd04.prod.outlook.com (10.163.166.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Thu, 19 Jul 2018 12:47:18 +0000
Received: from VI1PR04MB4799.eurprd04.prod.outlook.com
 ([fe80::3880:d3b8:c118:ba5a]) by VI1PR04MB4799.eurprd04.prod.outlook.com
 ([fe80::3880:d3b8:c118:ba5a%5]) with mapi id 15.20.0973.018; Thu, 19 Jul 2018
 12:47:18 +0000
From:   Camelia Alexandra Groza <camelia.groza@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: phy: use generic clause 45 autonegotiation done
Thread-Topic: [PATCH] net: phy: use generic clause 45 autonegotiation done
Thread-Index: AQHUHpkhRppx3uTn+EqPQRQZK8PlPqSVDQWAgAFxzNA=
Date:   Thu, 19 Jul 2018 12:47:18 +0000
Message-ID: <VI1PR04MB4799F126865F4A5C115D1B16F2520@VI1PR04MB4799.eurprd04.prod.outlook.com>
References: <1531919535-20269-1-git-send-email-camelia.groza@nxp.com>
 <20180718143919.GA10856@lunn.ch>
In-Reply-To: <20180718143919.GA10856@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=camelia.groza@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1408;7:mdUpgOWSl+mq8UbzxD4zVSWnpOYw4kXwLNLx2x2dwng9msBranr1NqwxLykUzl+g6eXqneSxUZX0W1WUZZtRk9sbYt0v8h0TwgCPQ8wFCh0Anhdgara0CignTOGlSycSss+vxlEAsxoE6MI806Hal82mWWymAaxepnwDYQb++ablzQOQjjPfct0rswKnBKYcgam1sGMobR+mC8tCse7G8rzBpn7AR2W4kV1XNR0nmP/XDXDU1pzf4I5L9qYTucGh
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 758787bc-77c0-419e-e6e3-08d5ed75c314
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1408;
x-ms-traffictypediagnostic: VI1PR04MB1408:
x-microsoft-antispam-prvs: <VI1PR04MB1408CD831D80BCC0EE3F515FF2520@VI1PR04MB1408.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1408;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1408;
x-forefront-prvs: 0738AF4208
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(13464003)(14454004)(2906002)(97736004)(6506007)(316002)(3846002)(54906003)(68736007)(6916009)(5250100002)(53546011)(4326008)(186003)(229853002)(26005)(6436002)(6116002)(33656002)(256004)(105586002)(476003)(106356001)(305945005)(55016002)(39060400002)(11346002)(2900100001)(7736002)(8936002)(86362001)(25786009)(53936002)(9686003)(5660300001)(66066001)(8676002)(74316002)(478600001)(446003)(102836004)(486006)(99286004)(7696005)(81156014)(81166006)(76176011)(6246003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1408;H:VI1PR04MB4799.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lZb/uuS7ScXZIxgh+Y3DzgZ4txtgiv4xZt5Y77fOnWqzEgBwaDfuUw2JWXiK/TI9fttsmmhThZsj9pTlzDfQ6jykOCBSsFXK68abRtwVdHn7moVe2a3hStcz9aEskSxAVIByAjTIfbMGvhrOLXZEcnPT729MNg4EfNX2PfooNnDpAmCQ8edKd/aq2Nl/yohrocLOm481SjN3VWarDOln77UHO3TZiUJucpK+X8b7D5rUFFtOQyoN6UmZfyQUU90pBO5cOT3MoTYYcmqhxSK+0rlyz5hkGsdmwMVekvXvggxjkRDFk1SM19kufobnYCjER5wX/J9MRaen+pkchTtB74FGNt6ow8GaXJm09YSia/k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758787bc-77c0-419e-e6e3-08d5ed75c314
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2018 12:47:18.0835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1408
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Wednesday, July 18, 2018 17:39
> To: Camelia Alexandra Groza <camelia.groza@nxp.com>
> Cc: f.fainelli@gmail.com; davem@davemloft.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] net: phy: use generic clause 45 autonegotiation done
>=20
> On Wed, Jul 18, 2018 at 04:12:15PM +0300, Camelia Groza wrote:
> > Only Clause 22 PHYs can use genphy_aneg_done(). Use
> > genphy_c45_aneg_done() for PHYs that implement Clause 45 without the
> > Clause 22 register set.
> >
> > This change follows the model of phy_restart_aneg() which
> > differentiates between the two implementations in a similar way.
>=20
> Hi Camelia
>=20
> What about phy_config_aneg()? I would assume any sort of auto-neg action
> needs to check for c45 without c22, before calling a genphy_ function. Do=
 you
> think it is possible to write a genphy_c45_config_aneg()? If not, we migh=
t
> want to return -EOPNOTSUPP.

Hi Andrew,

Adding Russell to the thread as well, since he wrote the c45 helpers.

Sure, I'll send a v2 with an additional generic phy_config_aneg(). I'll sti=
ck to returning -EOPNOTSUPP for c22-less PHYs for now.

Thanks,
Camelia
