Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E36C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C75218E0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NHA8UPSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfADRup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:50:45 -0500
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:52110
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727786AbfADRul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ycRanE1PLC28Kv5AjRGhHR3Ni2r+ij468A0lieghZk=;
 b=NHA8UPSF2+ZoOxhqQVzh0zhtVPBEywzudQqivaNOwd02JlpUBsDPWk5vjE7NYK8ocThuwjpp0liJy2WFRJG7haASUltdtaJwBej7wzdHdXJE7Z6FzQVc5CkJrK8iDAxsqvLqp5voINJjwYfK9FGbY52rjHrqZHOLYruEEGu/m1k=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3389.eurprd04.prod.outlook.com (52.134.1.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 4 Jan 2019 17:50:37 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9%7]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 17:50:37 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Thread-Topic: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Thread-Index: AQHUmUIzLDDB55qxuECeWDzF4+LHLKWeFHgAgAFZMBA=
Date:   Fri, 4 Jan 2019 17:50:37 +0000
Message-ID: <VI1PR0402MB280090CC66E990AD6E82F52FE08E0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
 <20190103203250.GA18731@bogus>
In-Reply-To: <20190103203250.GA18731@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3389;6:ygxncry4yY4OR9JzpbzbqjgZxtjgZ/s5fTwgKAYYKsavNT7RriJN2qdxRHCAZ4rGgxPFtfxWCd4P7Qy7MlsSugbLth6jwsDBRSU+EKlFwvFJrb2uNykmKVkp8LTMu+emVW1fF/m+bCi+phlU7GzDVUZ7xNj57SDmdaJuzLifiG8T1Vm/1sGfNl9hAQh2KT8yDjZCZn3670uHJXZffxbG26Sl4kR2BbEw40sStPLSr3X3kzSC2KrfnSooWsh6bJKesgy2GDA//xyINaiXfLrNYObLvONSpI7XdHNGvy/r+XIg4F4OsC96CLfoec9x8tWRM1eiew3LXL8IQcWERIC0pdhE0HOItkXOHOEqrF9n5YgiAZe/hiRt0Cp7jBrHgiwm8VTV4eBJ1ygatCgrADeffq7ka2M0yXZRcEeTw+tHEoRE4vbYfTGPcZ+RmcM1IOW1UjMVqUxTkLuJFWTqI3KvVA==;5:ooVnbf8T2EdYVejegfI+Paz097TrrQUWVVOSshcZOePRgWq4FFZj8sJDFjWeJUARk8548EBNkRPM6ZoVnzja39v19nst1uWix4nIVcC0N1xUHLebtnGPUAMxK+gyBHauxdNMfmED8Kaj3LU8hCx1YnrRG+t6P2WXIMayKuvW108=;7:bJqM7BNbk+HStP1jjIdwM/kZkc973Bd8xw0r+ZalhM+NpsS+n/D/DUYENAMY2TQ//AbmMffF1i2epBmde9+ljvf6XkZOKIbfy9Q6hRnStpoKiHxrULnJSLYjyrEHPhAvOGMpR/y32Ggscs9KNjNWvA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d579e93b-544b-4446-664c-08d6726d2262
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3389;
x-ms-traffictypediagnostic: VI1PR0402MB3389:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR0402MB3389AB9060FABCD0AAD7E3F5E08E0@VI1PR0402MB3389.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3389;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3389;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(106356001)(316002)(478600001)(54906003)(71190400001)(71200400001)(14454004)(6116002)(66066001)(105586002)(7736002)(305945005)(3846002)(68736007)(256004)(486006)(25786009)(5660300001)(9686003)(6916009)(44832011)(74316002)(97736004)(7696005)(2906002)(76176011)(6436002)(4326008)(86362001)(33656002)(99286004)(446003)(476003)(6246003)(229853002)(102836004)(26005)(6506007)(186003)(53936002)(11346002)(81166006)(81156014)(8676002)(55016002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3389;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WpDelCzYVOvF1nOEtm+Pp2RjCHhzxzltFXXhcSk0MeXSmlWkpskDhqII76iCoxRvrBA4tq+17Rtwf6W+Dk+xLPgfAbJjmb+huQH7tWffWhVUEwvndYzBJXWjxxSqGIc/cN0GYXSTK/HSU7z4TWgie1r3q6lscKA6vr+YMDllGgmvBs/CD7MR9n9q7cn4d0lkQ7XpNivZ+r1CbzvTeU+HQJEZ4bOsnuF/gK96jnxoxSgp7comn5MvmYPXX0uW2Q5v6VtuvN0p8ToHrm9ChtjH+gbG8HX6OFtM6+Mth348OUQAH66cpQ0ztPX4cTt087Jd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d579e93b-544b-4446-664c-08d6726d2262
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 17:50:37.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
>=20
> On Fri, Dec 21, 2018 at 03:31:11PM +0000, Ioana Ciornei wrote:
> > This patch adds a devicetree binding documentation for FSL's DPAA2
> > console.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/misc/dpaa2-console.txt | 11
> +++++++++++
> >  MAINTAINERS                                              |  1 +
> >  2 files changed, 12 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/misc/dpaa2-console.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> > b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> > new file mode 100644
> > index 0000000..f4e16b1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> > @@ -0,0 +1,11 @@
> > +DPAA2 console support
> > +
> > +Required properties:
> > +
> > +    - compatible
> > +        Value type: <string>
> > +        Definition: Must be "dpaa2-console".
> > +    - reg
> > +        Value type: <prop-encoded-array>
> > +        Definition: A standard property.  Specifies the region where t=
he MCFBA
> > +                    (MC firmware base address) register can be found.
>=20
> What's the relationship between MCFBA and the console?

The console is basically a log buffer of the MC firmware, and is found at a=
 known offset compared to the firmware image's runtime base address.

> The binding should describe the h/w block or firmware interface not the f=
eature you want to
> implement. Are there other functions provided by the MC firmware?

The MC firmware manages all hardware resources related to networking or any=
 other accelerators.
Any interaction with the firmware is made through commands put in memory ma=
pped regions.
The fsl-mc bus driver is the one that already manages this interaction with=
 the MC.

Ioana

>=20
> Rob
