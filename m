Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELt4crnRuSAOWUUKBSjgLPjf3Rvgdccj5oa9xf3F/7X7Q+ng13aY/1srJ59z1seos5nphrXc
ARC-Seal: i=1; a=rsa-sha256; t=1521836031; cv=none;
        d=google.com; s=arc-20160816;
        b=Sz4IsoX45UGgr0vEg8D4bGE0yYU3y4TbPkoGIPQJYW/zYIjizGdKPGnLHXWZWoWd3n
         3m/H83p31mjzA8S2Pbi2YXf767iLJdnmWFrxKzRsdCcdvbjbz3f8ZLTJ0kChminLg0lM
         sRVHP99MKagBWIzZEGUweIB2wYU6lfArgNLLthZ8GdP91hvm8jIOSE5cWOa9GsIvhVEX
         VSdogHYAH/benyqqbAvpQgkYAeqMfq3y5VyKhqQD7j5IELzfTiWBD058HZu6vF+8K6Ot
         Q3RR/POXEM5qXjXi0J7bF0ivr3Nr8N1/SGwY8Hfw9jUiMG2gaeRe6sug5wD1jZD6DuD+
         eR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=0CnR5moVd6P+diYsPrSnaYS+C/yWTG4av2N6kOS2cGY=;
        b=sDd8Vr3FJ9ZPA5pWIrb+WltOqwcC+WYAOVwHWrF5W5AQH0zaPy/52ROHLQR/AGoMLe
         xccD6Cebvs7W97mq0ImwiyMckt8rgN+2+PfcumDCKn14A5RFIxjbYdyODRLN78Ev0bex
         PWU9oupZJiOgdYr/HxeJtdWw9TAY8XxsCu+xgvLEsgs9dBri9VKuYaJdtYKd6Fuyatrn
         2xvlIG5w43Vgq6Z+VvkwZNphdWwvnSw8KPPP1SJzfqlfMDZSWQOVWabc/GCahJ4DP16p
         PkhUzgcZjItTiSduk5dpzAODG826GtpMgRmzFNIPaR75/YEmz1fiDpa+g3j3exDeuYw2
         Asww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=gLYofYla;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.58 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=gLYofYla;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.58 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, "arnd@arndb.de"
	<arnd@arndb.de>, Razvan Stefanescu <razvan.stefanescu@nxp.com>, Roy Pledge
	<roy.pledge@nxp.com>
Subject: RE: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0rRbeSymdCeEiXdPiYqeyzd6Pd9tsAgAABPBCAAAU0gIAAQptA
Date: Fri, 23 Mar 2018 20:13:47 +0000
Message-ID: <HE1PR04MB3212D27A5E02EE73FCB378DAE0A80@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <20180323154654.GA382@kroah.com>
 <HE1PR04MB32123F0FF506534B11A1CE5BE0A80@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <20180323160957.GA3113@kroah.com>
In-Reply-To: <20180323160957.GA3113@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-originating-ip: [188.26.254.159]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1353;7:RQGuWcVLEtbBvpojEf5Bi4+uVU5I4vtjEN5yabyMrGzzZRg0+Fc8QncOh+FDOdJGLvGXGrxzAgnLcCQUJLkSaZMf905OpHngzEFTyS/fP24whQ6xBo0wDX4MwmRye3IPAU0IzzgMcrRHm0CEa76x964gI2DFE7zY3LsvY4AWph8IfO1R96do6jwKGYUziF0QUMjhE7e8b1QP/vwhjRxr3x7eMPt1vQp9xnKkGyQDrn1UT9+vRe5HHxsNMbqHAFDo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8eb48af4-63c4-471d-e8be-08d590fa9620
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1353;
x-ms-traffictypediagnostic: HE1PR04MB1353:
x-microsoft-antispam-prvs: <HE1PR04MB1353ABCEA6874866C7734D30E0A80@HE1PR04MB1353.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR04MB1353;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1353;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(39860400002)(396003)(366004)(199004)(189003)(5250100002)(3846002)(6116002)(66066001)(68736007)(74316002)(305945005)(7736002)(3660700001)(39060400002)(53936002)(3280700002)(6246003)(2906002)(4326008)(86362001)(446003)(14454004)(7696005)(5660300001)(11346002)(76176011)(99286004)(59450400001)(6506007)(478600001)(25786009)(54906003)(33656002)(93886005)(316002)(2900100001)(6916009)(8676002)(81156014)(8936002)(186003)(81166006)(229853002)(106356001)(105586002)(9686003)(6436002)(55016002)(102836004)(26005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1353;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: IPvpDm7aTexxc0wCADll/QOQHCWi3usSwjYvg/nt9mVqa8xwUimhDOF+BIToJUzObxvMJ/zoXMzDyvaaV0cMOhMS/VhSTAiKYgZ6gen6xdGStkenRWVj6ciigM42rWKRT9QOJaRXtNWJYI4pgqRt4G8gedQGW1nVsPBg9JdBsXeHlPDN95Fa8JmcohlJhPsq4s7LA3ZDsX8plp8jbnRVcw8K0ofwpRtsp4Wx9Ca2p2r6E+f/Fl89FY8uWLxKnhquo/HYcwHyQOFXMDTngm1dAvXbByCRmU2nU3RYrC8R7sofYbxkBMhTTogpumftvibeuPNulyWVqfJ+zLOWGR6bpQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb48af4-63c4-471d-e8be-08d590fa9620
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 20:13:47.5881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1353
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1595760738748697195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> >
> > >
> > > On Fri, Mar 23, 2018 at 10:38:56AM -0500, Ioana Ciornei wrote:
> > > > +#include "fsl-mc-private.h"
> > > > +
> > > > +#define FSL_MC_BUS_MAX_MINORS	1
> > >
> > > As you only need/want one character device here, why not just use
> > > the misc device api?  It's much simpler, and handles all of the
> > > housekeeping for you correctly.  It also means I don't have to audit
> > > all of your chardev code to verify it is correct :)
> >
> > I have considered the misc device api but the fsl-mc bus, since it is
> > a platform driver, is probing before the misc char driver.
>=20
> How?  The misc code is just "core code" there's nothing to "probe" here.
> Is this an init-call ordering issue somehow?  A platform driver probe sho=
uld be
> after the misc core is initialized.  And if not, you can always defer you=
r probe.

Sorry for the previous improper wording. I have tested again using the misc=
 device api and indeed the devices on the fsl-mc bus are probing before the=
 misc core is initialized but I am able to complete the misc registration d=
eferring the probe the first time.

I will update the patch set and send a new version.

Ioana C


>=20
> thanks,
>=20
> greg k-h
