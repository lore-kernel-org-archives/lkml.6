Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E0EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660D521480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QsK4/u+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660D521480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbeIXXBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:01:49 -0400
Received: from mail-he1eur01on0058.outbound.protection.outlook.com ([104.47.0.58]:30432
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727673AbeIXXBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Suizr1FdIlZNt2Q8rrFZ4+Fr2Nb9+jl7EtKbGhLnX1Q=;
 b=QsK4/u+g1Gvugdyv18el+qH05mc9jPqbUauCfTZhUWeWSdog9JyJXtIxZiutrAfDiJkTRASfd8/AFTaXlFudJKfIBKlGRM9tcBEd3PJSxLVx7Gzamt9bh4p6MZOikfamXeQfk7RG8rZ2fJqMjy/qUFe1aPhsbglFpZwCj+t+7YA=
Received: from AMSPR04MB503.eurprd04.prod.outlook.com (10.242.107.152) by
 AMSPR04MB534.eurprd04.prod.outlook.com (10.242.21.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 16:58:40 +0000
Received: from AMSPR04MB503.eurprd04.prod.outlook.com
 ([fe80::51e3:f249:457e:ae0e]) by AMSPR04MB503.eurprd04.prod.outlook.com
 ([fe80::51e3:f249:457e:ae0e%5]) with mapi id 15.20.1143.019; Mon, 24 Sep 2018
 16:58:40 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Olof Johansson <olof@lixom.net>
CC:     "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [GIT PULL] fixes for soc/fsl drivers for v4.19
Thread-Topic: [GIT PULL] fixes for soc/fsl drivers for v4.19
Thread-Index: AQHUUz6BpEntji53skSWc3gk15qqhqT/p3/w
Date:   Mon, 24 Sep 2018 16:58:40 +0000
Message-ID: <AMSPR04MB503FA6EEF013F8F10D6629F8F170@AMSPR04MB503.eurprd04.prod.outlook.com>
References: <20180920165656.31902-1-leoyang.li@nxp.com>
 <20180923123704.r47aywqfhor3ma74@localhost>
In-Reply-To: <20180923123704.r47aywqfhor3ma74@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AMSPR04MB534;6:7MmE8fICbuzAAVQDZASaMWaTo2jonpXeD4XfNavA7CmNfdS3reuWMim8lCieP34u8R9FPoH5HmZqLfsGfVolGsFfOHQeESkTvmsdcRDNmWKf5TETvw4wAzveQXopzzbPL7rTRoX8s6+1qya+E8IHR5ZyzVANBsxkf4dKOALuNrllt15jAeY1sMweg9gMPEueSumKUZu0WZis3qE7Iz7H7mO2kSN//HLb7fE2WiSsWP1BH9CX90K6gXzZQcBL+0w/Zkzdv5FdegjuRcwOm4YEDAt0XojRocudPHNl+xR8cCFbf4GwSs1CRVRvcVgZ7i4h12lHM1HJ2E2VQcOO1QsqRNHj4SawfC6jDMeSQWiRu1TN6ut70EXn8xm7FLVaCzLJw7V8GO5Jkoman15fMb5vNESK74aB18Kcmmhgsp1LvEqvvZzVIs2t4XHUbxpidnScfL7fspAbPd2PIs4VRKZvLA==;5:KJuxAQubE+ixerOLW8Djrcd+CYfCeyJwN6WXOju1V6ZfwN+BY9ut2AHBAQbGyKzJ8Sl0nAdpdu6/Whv4FbI3Msk8FWnXleLThRySHdMd6plu64cjNvm47HR2ABPf64XIpE9tZdkCKC9fzkEZUxsYLRqTJU5teNlDU+mlgoIclME=;7:9sML2OZYJa0KxGSmRLtvuhe9bX/9WHGUB3l7AHP5/cj/XQKHv3GFv+UYEXIIcutd65IzR0du1YvlIOAOYMYcuqPkyA8Xu6G6jA4J97jcl3C/7kteZUHg3V4Avt9mL6tyleNUWkj9XBmixNQMULhGdGq8UDz3PgJ6RjRs639tzDswZtEt/PE0TglK0yMlFSNzG8RVSMFCVoflocpMAQCjA2lKI6SyqjcDmpFIrf79NY2Mccs0DkVb872RiRiuw/+6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3017ddd4-9f55-402b-3633-08d6223efa9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AMSPR04MB534;
x-ms-traffictypediagnostic: AMSPR04MB534:
x-microsoft-antispam-prvs: <AMSPR04MB534B9D06903022AEA23744D8F170@AMSPR04MB534.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(84791874153150)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:AMSPR04MB534;BCL:0;PCL:0;RULEID:;SRVR:AMSPR04MB534;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(13464003)(199004)(189003)(25786009)(2900100001)(4326008)(5250100002)(186003)(6246003)(33656002)(9686003)(476003)(55016002)(53936002)(446003)(6436002)(229853002)(486006)(105586002)(106356001)(14454004)(478600001)(11346002)(6116002)(3846002)(68736007)(102836004)(8676002)(74316002)(53546011)(6506007)(26005)(7736002)(97736004)(8936002)(305945005)(575784001)(86362001)(81166006)(81156014)(14444005)(6916009)(256004)(7696005)(76176011)(66066001)(71200400001)(2906002)(71190400001)(99286004)(5660300001)(316002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR04MB534;H:AMSPR04MB503.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uZmkNR5wzHNyXe25xnD5C6dgmw5+o8+4/6J/ea41RItQ4bha6ET44rZIlP1EspomH1axwtdSRxeliFSabByjfp8BK2nO1ZIdjLwPHd3TTaAoFcDxPnr2pJt7p3mp11PLq09AnUnUYhaOJR3JRXA5nsYkx1UKKG16SlRYoA3ouMN0vRE71ifLEWA9MPD+8FtISQdH8EcW0OCPN988MvOuvEcVuJ9/O75t6DzwOytY/igtWc7Ao217RUeRrhKCNIzx8z0M1VP8OWfecXrjCzIDHKoQocvJASn/AfwkNonj903fTdXP8aquRtQMaex4cTZsbIMZAbRi33NiD0+gkVQPj93CABOT61b++iALF7lHK0g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3017ddd4-9f55-402b-3633-08d6223efa9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 16:58:40.6711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR04MB534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Olof Johansson <olof@lixom.net>
> Sent: Sunday, September 23, 2018 7:37 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: arm@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; shawnguo@kernel.org
> Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v4.19
>=20
> Hi Li,
>=20
> On Thu, Sep 20, 2018 at 11:56:56AM -0500, Li Yang wrote:
> > Hi arm-soc maintainers,
> >
> > Please merge the following fixes for soc/fsl drivers.
> >
> > Regards,
> > Leo
> >
> > The following changes since commit
> 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> >
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git
> > tags/soc-fsl-fixes-for-4.19
> >
> > for you to fetch changes up to
> 3cb31b634052ed458922e0c8e2b4b093d7fb60b9:
> >
> >   soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()
> > (2018-09-17 16:01:46 -0500)
> >
> > ----------------------------------------------------------------
> > soc/fsl fixes for 4.19
>=20
> Please spend a bit of effort on writing up the tag for all pull requests,=
 even
> fixes. For fixes in particular, just as with the patch descriptions we wa=
nt the
> pull request to contain some brief information to what the bug is and why
> the fix is needed.
>=20
> Care to give this another go with a new tag description, please?

Sure.  Will send a new version right away.

