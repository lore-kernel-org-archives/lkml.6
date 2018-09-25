Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07A2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C892086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mARsYAj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C892086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeIZC2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:28:50 -0400
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:43136
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbeIZC2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTtKwM2oi5y81M7hNBWu092cCD/HMikYl5OBRQtBVPk=;
 b=mARsYAj6aKm0eleMQoSdEtJ6zQVC7UMLmKoegi2oI5cpnZyC3eJGZppjd+//ykUc8wf9a+PakiKqh2xNzvDEJPE1rufg23bLF7sMg88UVbgL1kFCkjXpb2rOwHqCAR26hYUPpi9uPmtrW7WCezS9+FshjFs2JgK+xWciJzomxa8=
Received: from AMSPR04MB503.eurprd04.prod.outlook.com (10.242.107.152) by
 AMSPR04MB407.eurprd04.prod.outlook.com (10.242.106.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 25 Sep 2018 20:19:30 +0000
Received: from AMSPR04MB503.eurprd04.prod.outlook.com
 ([fe80::d081:5636:5890:c63c]) by AMSPR04MB503.eurprd04.prod.outlook.com
 ([fe80::d081:5636:5890:c63c%6]) with mapi id 15.20.1164.024; Tue, 25 Sep 2018
 20:19:30 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Olof Johansson <olof@lixom.net>
CC:     "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [GIT PULL] fixes for soc/fsl drivers for v4.19
Thread-Topic: [GIT PULL] fixes for soc/fsl drivers for v4.19
Thread-Index: AQHUVQyZOI3dq9kqMUmLRUdfbGzBTKUBb6Zw
Date:   Tue, 25 Sep 2018 20:19:29 +0000
Message-ID: <AMSPR04MB503EAF5EF985E25D87190AA8F160@AMSPR04MB503.eurprd04.prod.outlook.com>
References: <20180924221954.30473-1-leoyang.li@nxp.com>
 <20180925194757.pp3jiltu36ih2wfo@localhost>
In-Reply-To: <20180925194757.pp3jiltu36ih2wfo@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AMSPR04MB407;6:ZJKGVmNg3vTaOcOxcp19ETJ3aYh3ivpa0EMcGRd7rXTpNXeaaFNIGc1+bA+Z2WC2khU3M8LNujIqdtU0WFfxdJi8gGWLfE6Ou+kc4se1CzfxvRGyuw51VzVLCj0Xd9bWBHQM2+rQ0E2su+70LqId6mWMJOasOtk+vOiLw06Ycak3VmJCQG9aHaQPMsIi1/VSOPWBwx5+VhPq3iKM8KyQDQQmUgjkzxNbFn9oWey3waYSAzY2/XjVDH+vDFhpWBOPKPe253j5Uaqk+VmOVC0LJcQzfNQ19MoeyuMVHryysMVROBSPVBguFUbOyVoAiwqzuxQp39Nvfo3VK9faaq28IsQbq2EeOrXRIOE5a0ge+Zvd0nN8O6vlUGpfe/XrQ5K+JFPSLuHyiNyV5i2p9TkmVCZXjitoxU7QWjciHrqNdJbYTIdpe1UqAId82oQ718IqwA6NBIdVW+xMx+ayjui+Ng==;5:Ra1RDzbe07jkwl1pjYisJdNKVYew0rvXvsBQOf6aNIYsS3uFw91oX1t6srgc1e/AKBiL+UeRZ+fnCog7G/HEkaI3cncTtPElQBOWOCGmOt025ciL47+MMgYEmzZbQdoHs5cSkVmRvGfTlmBQiuGte9KFRpsNUBXs49mrKgnkNgk=;7:P/CnonHB5a/i6/0AAnjI4p4D9dgiOr5yEIUVVrgRgW2hcp/xy1HjgM24SWOemSXl2hEGLRS8st+eiE+nfTVzeXN35ZWMTCV3ZL6qFdHAx7KSK7TTC0q8cz2Hjt6qwvcVlN5mtdfuE/p65HenPSvZgGq35Tizh9byPQgX0IkkBYFzrqp9LGLDaENaeQ+9MzQIO6qjMLyfm04huNZCxE5V68xQ+ZRGZTEcUnI6J7EEIsvAMpFBSV6iXB6VUlGqPjGs
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 323c3d0a-35b4-4a7f-0f48-08d623243303
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AMSPR04MB407;
x-ms-traffictypediagnostic: AMSPR04MB407:
x-microsoft-antispam-prvs: <AMSPR04MB40747636DEEC84C07A6FD898F160@AMSPR04MB407.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(84791874153150)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:AMSPR04MB407;BCL:0;PCL:0;RULEID:;SRVR:AMSPR04MB407;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(13464003)(189003)(199004)(51914003)(11346002)(5660300001)(86362001)(53546011)(478600001)(6506007)(6246003)(7696005)(3846002)(6116002)(575784001)(97736004)(68736007)(229853002)(2906002)(71190400001)(486006)(102836004)(34290500001)(446003)(71200400001)(26005)(256004)(186003)(81166006)(6916009)(476003)(33656002)(8936002)(305945005)(7736002)(8676002)(316002)(81156014)(55016002)(14454004)(5250100002)(54906003)(6436002)(66066001)(25786009)(106356001)(105586002)(74316002)(4326008)(99286004)(9686003)(76176011)(14444005)(53936002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR04MB407;H:AMSPR04MB503.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KL5pZ7zt/GmUp1+2DSzNRrFctvzQ0uAgsa+Bfe6iMp740QtXCKL5I6pdsPCs3Fg0MqnB8ZquVlEle0hWw9Z5oaUVITjhbCNk6tNlu1QlVBaJFsLkutItksintK4RIMCU/trC3NmpUSIN9wyYEyPIjdQeR8rUidYQa1wYbXy/pnijpAM74ulNBhnac+ya48uVu4E6kD6wMmwKpxwqfvCbzmYHkWSPGq7DcldKTYXzoQF2WXSnfQb8p+KiU4dHMJenfM2H8sln0USN5DdMmiRlf4l6M/ihUtiPNckCRpf8ok5U18QN/GaqwUefA4nVHkyCr1UFl8wOpSP/4Fui61nQwSpIsPVzCEzot3S+Xc25+SQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323c3d0a-35b4-4a7f-0f48-08d623243303
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 20:19:29.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR04MB407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Olof Johansson <olof@lixom.net>
> Sent: Tuesday, September 25, 2018 2:48 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: arm@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; shawnguo@kernel.org
> Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v4.19
>=20
> Hi,
>=20
> On Mon, Sep 24, 2018 at 05:19:54PM -0500, Li Yang wrote:
> > Hi arm-soc maintainers,
> >
> > Please pull soc/fsl drivers fixes for v4.19.
> >
> > Regards,
> > Leo
> >
> >
> > The following changes since commit
> 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> >
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git
> > tags/soc-fsl-fix-v4.19
> >
> > for you to fetch changes up to
> 3cb31b634052ed458922e0c8e2b4b093d7fb60b9:
> >
> >   soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()
> > (2018-09-17 16:01:46 -0500)
> >
> > ----------------------------------------------------------------
> > NXP/FSL SoC driver fixes for v4.19
> >
> > - Fix crash of qman_portal by deferring its probe if qman is not
> > probed
> > - Fix NULL pointer dereference by adding more checks in qman_portal
> > - Fix copy/paste bug in ucc_get_tdm_sync_shift()
>=20
> Good summary, thanks!
>=20
> However:
>=20
> > Alexandre Belloni (2):
> >       soc: fsl: qbman: qman_portal: defer probing when qman is not
> > available
>=20
> I think this fix has issues, I replied on the patch. Let me know if you w=
ant me to
> cherry-pick the other two fixes for now.

Thanks for the review.  Please help to cherry-pick the other two.  I will w=
ork with the patch author for an update for the first one.

Regards,
Leo
