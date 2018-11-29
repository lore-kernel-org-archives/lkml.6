Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3325C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FC52145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="odrMKzll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FC52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbeK3EBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:01:40 -0500
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:5837
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730114AbeK3EBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2en5NhdPVkfTib48s5mieL0/620FhC0MGqGs0cq0/c=;
 b=odrMKzll6XnLR+a1reFaEczxamOvveGFipn6poLArrO520XyrVkiYz7X8E1Yy7wIKxVzbKbuGJ0u5HQypPP+RBskDKVnTbJPSq5LsqgKsaraw2xII+HDCJQeU7VdMtJb/RKcDOM963llTJ/7ISH1xhEy2tCJp0g4sEuKDDTPHUY=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3599.eurprd04.prod.outlook.com (52.134.5.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Thu, 29 Nov 2018 16:55:36 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%9]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 16:55:36 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v3 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Index: AQHUgOdDaPiLexuoCUeDRyxH1kY+eaVY4AQAgAAPQtCAAPNRAIANI/fQ
Date:   Thu, 29 Nov 2018 16:55:35 +0000
Message-ID: <VI1PR0402MB280049E1094B93A0891684A7E0D20@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
 <1542728371-6972-3-git-send-email-ioana.ciornei@nxp.com>
 <20181120164850.GC27531@kroah.com>
 <VI1PR0402MB2800989D7FB9856EA9D2A083E0D90@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <20181121081418.GD8162@kroah.com>
In-Reply-To: <20181121081418.GD8162@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3599;6:UUMs0mi/jQig8IpUhWKOMpm2DnTzbA/zV5YYzLcsSiMCwix3REcLbhi7bpkA3JuO9UApN/mRm1mmeqQNU8L6S+c/ueez2O47Rlwhw1y1Xh4PYzETaM1kIG3Pwb4N2AIq64S2nb6ydiihFdHAx9psjhwb683uYcVECIpQsKRZdksqCSKa0Ir1RnNQsswtEcSQ5EfE+pJUdP8Y1o8YVgWd4zwdW7gbvw4D2FDJ8vrivxJC/iNYj/xwS9Y0N5gxWQl01EoJjve+yGxlnkog7eKw4DidAqTN3HkmeIBN3+aydgawoIImsQgiOnCwhWx8sGHvOuOnsPvdXCbutezgUIHCI+WHSOb/9Mue6ZpvW6B/MotmN/MBV1dd4Mop305azN/xLR2uDe2au8LVQHmruggZ6GgkwIDSTjlOf28/k/5yP7MzNaBRdwKkn5f3lbAVem0aMBVYbaNrj98AhsyI7YsRng==;5:u/bpQ4mUu9XHt05mIXzyaxwuXWSio+3jHA+McbQx30j0PNXDlX/u2nCKiX41UOop1i2PwCIUPh6nPVDAZdQcNrUvBIEt+Y8zWWOH3yekWygTOJ6YMKnUhJWTiiU7HlZMxaGOSRL/lXYYTMmaEqf8tKSUiKSkDuhbZSC1ulfRZEE=;7:6LEa0aHY1AJdP5gvtlnrzC4CkpKcv64CYBI+nMMtaVUY8mXSGz29yWdWtUKMPuVFbYrEYRpAjt19gAJ80iEtzxNkUPubWzx/Bhw5vbLo6CgYp+OF3yO2rjNlvyn+HhN7AWfwJfsTPA5v2t/pf8Zc2w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b2f010db-496d-473b-e930-08d6561b7bc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3599;
x-ms-traffictypediagnostic: VI1PR0402MB3599:
x-microsoft-antispam-prvs: <VI1PR0402MB3599D00DF08AD125D13DE219E0D20@VI1PR0402MB3599.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3599;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3599;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(346002)(376002)(199004)(189003)(3846002)(6116002)(2501003)(478600001)(53936002)(4326008)(14454004)(106356001)(105586002)(11346002)(446003)(486006)(54906003)(2351001)(68736007)(476003)(25786009)(8936002)(81166006)(6246003)(5660300001)(256004)(66066001)(14444005)(305945005)(2906002)(55016002)(74316002)(9686003)(5640700003)(1730700003)(81156014)(8676002)(7736002)(186003)(99286004)(93886005)(71190400001)(316002)(71200400001)(6436002)(6916009)(7696005)(229853002)(33656002)(102836004)(97736004)(6506007)(44832011)(26005)(76176011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3599;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qfuWDgdfzgaa8niC/GymM2iXneghVIz+D7QH9WSi9hvG3WY9bOpgFdEQxKMtirV3NxiuMMnTib2azo0X9mkM3/Ve80uM8+P0XT61PRHpSG1Wv2pifBdkTd4cRpAtXAYHW7f63rvsKN+uagZj5VLm5SEFOgsoGqEwF+I6fsR5UhQZScREB416QSnVKN6xmUrW7vrUPbWhiXj6wWK6+Z3abFWUiGuTWSa8NH8vDZgqA7nfKUeqC8Pe4h92BzAaI78SNdBXpi+yYVZWzBrBVpiHmJDavgEZWSBf0WcmOOTM65AVZ2QhwkVIqTi0LORa4LJ4dvw7Ol/jqhS6Bg6TCX1bfBS/upLp9QKumEoxcmp9hv4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f010db-496d-473b-e930-08d6561b7bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 16:55:35.8877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add fsl-mc userspace support
>=20
> On Tue, Nov 20, 2018 at 05:59:26PM +0000, Ioana Ciornei wrote:
> > > > +static int fsl_mc_uapi_send_command(unsigned long arg,
> > > > +				    struct fsl_mc_io *mc_io)
> > > > +{
> > > > +	struct fsl_mc_command mc_cmd;
> > > > +	int error;
> > > > +
> > > > +	error =3D copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_c=
md));
> > > > +	if (error)
> > > > +		return -EFAULT;
> > > > +
> > > > +	error =3D mc_send_command(mc_io, &mc_cmd);
> > > > +	if (error)
> > > > +		return error;
> > > > +
> > > > +	error =3D copy_to_user((void __user *)arg, &mc_cmd, sizeof(mc_cmd=
));
> > > > +	if (error)
> > > > +		return -EFAULT;
> > > > +
> > > > +	return 0;
> > > > +}
> > >
> > > I know you said that "the firmware will properly verify the command"
> > > already, but given that I used to be a firmware developer a long
> > > time ago, I can almost guarantee that this will cause problems in the=
 future.
> > >
> > > Want to make a friendly bet about this?
> > >
> > > What is the odds that your firmware api/interface has been properly
> > > fuzzed such that all possible combinations of bad commands will
> > > really not do horrible things to the hardware/system?
> > >
> > > Are you all willing to bet the system intregrity on this?  If so,
> > > ok, it's your systems
> > > :)
> > >
> > > Personally, I think you need to add a "known whitelist" and do some
> > > sort of sanity checking here.
> > >
> >
> > I can add a whitelist on the command ids that can be received from
> > userspace but leave the parameter parsing to the firmware to process
> > and interpret depending on the current system settings.
> >
> > Would that be a viable option from your point of view?
>=20
> That might be a good start.  Again, how well have you tested this firmwar=
e
> interface can handle invalid data?  Are you willing to bet your system in=
tegrity on
> it?  :)
>=20

We understand your concerns regarding the integrity of the MC firmware.

Each command has validation checks inside the MC and we are currently doing=
 extensive testing with fuzzed commands from user space.
We'll come back with a v4 on this once our tests are complete and we are co=
nfident our firmware is robust enough.

Ioana C
