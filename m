Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C402070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="0m43/iV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfBTJaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:30:07 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:11439 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfBTJaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:30:06 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id 9C/35-08332-A1E1D6C5; Wed, 20 Feb 2019 09:30:02 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxTVxjHOb0vvSh3OV5qeNYAH7roEuetlM7
  lqjHx227cxsyybIlhcbdwpXVtqb0F6z6BgYTVbWImznVWGMOpoIKI2oEyRZiCLyBjaIgDC9Vt
  NPVluLps7uVeL7jt2+95/v/znP+TnMMQ3CPazMjBgOz3Sm4LPY90LmNf4s25nsK8k4dZYaDqt
  FHYfbOLEkau9RiEulicFir31FPC9PlOJKRGagzCd517aaHt0REkjIUajcL5h530mvli28w2Wq
  we/pMWP6+4Ropfh38wilW9SUpsb/6AFlOXd5Jia8f3pDjTnrsufT3l8jpKg+9SztihBOUbNAW
  7jzYSFWgMh9A8hsStBFwfipJaweFdBjj0+A6hF1MIdh5LqkU6Q2MBPrl4i9bYhF+D0eiQUTMR
  +A8Cwh/vRSHEMJnYAbHk87qnCLon71I6r4Srd88ZNSbxIvi1ssug2VkswafT5VqbU09OjVerI
  YxMOrbDrmyti3AOPKxseRKAwFkwFq83aAwYQ9PpQULnhfDz1F+U7pehf9sNpPeXwpXr8Vm2wL
  5I7yznwHD99id5QV3kzo43tD0A30Zws6bGMHf29y/Pzc4XoGm7lkzjBAt1Dwp09kGie4LQ52T
  DrUi+PidFQf9gM6VvVQT3I1eMuj8Xmj+KkbppiIC+0SlUi5aE/7ObzkuhoesXWucX4KsvEoTG
  LF4A/Z/FyQZENiPB4XeVOAMeyeXmbXl5vM2Wz9tWrOBt+XlW6X3eYZXL+C2yEuBtVmmLYlW2e
  orcxVavHGhH6iMs9l0IRtFgqKQHPcsYLAvZ8hvuQu4ZR2nxVqekODf4y9yy0oOyGcYC7PJsTy
  G3wC+XyMGNLrf6kudkYDIsJnazJrOKT/IorhJdGkA8c7YxFiE40lvqlc1ZrClHNWHN5CzzPh0
  x9x+GUY45k0VpaWlchk/2e1yB/+vTKItBlkz2DKdOyXB5A09vmlZDGNQQ4b/f00IEpH8lcwVq
  6at4M7Ry9Wq7Yrq4377jubdnmMmqTfsO29860HbsVPW6d9bu4aIm88tnPH0bJ6NJPjVxqbVnp
  DERX7XbZL+94YHPOf/Fn8pTjy9Qr49cXV574jd88JJY0Od4pamwozZ59vj4xOh4Q/hDd3TR4n
  vLvl3bW3evdf+mjoGCb1qSP655NVJqIRWnZFtC+BXpHzx19pAKBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-10.tower-288.messagelabs.com!1550655001!2739843!1
X-Originating-IP: [104.47.13.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30741 invoked from network); 20 Feb 2019 09:30:02 -0000
Received: from mail-he1eur04lp2054.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.54)
  by server-10.tower-288.messagelabs.com with AES256-SHA256 encrypted SMTP; 20 Feb 2019 09:30:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Czv7B1+FCQ7nkHYsimq21dRCzE5EWclfeJSUxrGkl+4=;
 b=0m43/iV8qaWsFn2ENdq8nJRtYZd1GWW1drFNX3lH0fNVFXDsKhaInS0ldpH7UmW3MUYayaluNBw7pU7qlAZCa/iRYChn7Jef222vIm5v78uY/yqF4FIRGvv64col8d7kRanpc0JwLlYoCqFnS8kNCsuCkW7c7oArrOwKUtgMUCE=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1137.EURPRD10.PROD.OUTLOOK.COM (10.169.155.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 09:30:00 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::319b:7815:dc19:5167]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::319b:7815:dc19:5167%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 09:30:00 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: AMD: Configure master codec on all
 playback/capture cases
Thread-Topic: [alsa-devel] [PATCH] ASoC: AMD: Configure master codec on all
 playback/capture cases
Thread-Index: AQHUxPzxizQmdrGlv0Oz0EPwJ2D5p6Xl4p2AgAKQhTA=
Date:   Wed, 20 Feb 2019 09:30:00 +0000
Message-ID: <AM5PR1001MB09948F06C726837F15DFB01C807D0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190215070539.22150-1-akshu.agrawal@amd.com>
 <20190218181807.GF10794@sirena.org.uk>
In-Reply-To: <20190218181807.GF10794@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc9ae372-0df6-4de3-75d8-08d69715fc78
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1137;
x-ms-traffictypediagnostic: AM5PR1001MB1137:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM5PR1001MB1137;23:TX6Q1nQ5RS6uRPRg1N/P78AYAr/RlrYAzp7r/bv?=
 =?us-ascii?Q?uAenjf7vDb3yr48O5iuEyYMrka9If6SLyGM2zYAWBtgvLAzINJB8caCIaeUO?=
 =?us-ascii?Q?YheLuc3x1xjHW+CMBvGo3/lBrerXAqqmd9/rYbYyvgXfc1acQZUJnB1pfgrT?=
 =?us-ascii?Q?SLZAXB0ofCyPkweTf4hnrcyb2/Lbmxn2ndUiuMdamAV0o3OLhRAxjcSfIYWI?=
 =?us-ascii?Q?lyONeIztXfYoS7In8EsnRfN61zIdIvdOIuTZ4fhBpDNVaeMqNwfS9jjbpAAy?=
 =?us-ascii?Q?sJ6/z4KSOidNckVb7zoz+FnXpgE0T6foEA0V308JLaPqDQbU9urAHHaVgko0?=
 =?us-ascii?Q?nPvFrwAP2qWbumZ4Zw744jZqi7FRaDyENP0vvMQ/oCVVHGm93lb+9nCa91Jj?=
 =?us-ascii?Q?ognXoQBpBeJH6qReV2iP3wJqWKaYyACa9x/hrXxWYUdk8z1F16NVaoqrq2jC?=
 =?us-ascii?Q?3gXBGe9BF+/uvkNdST0waOu5fhaR5+9ZZ2g529Znsp1RdwQ+nD51dxakbKiw?=
 =?us-ascii?Q?BhECF7Lazte0J1C9WT1UyNowg1WzC4lU6zEq1r8Mj2VEhSKjknYOg3uDZWIK?=
 =?us-ascii?Q?tQowRB0ayzKLbcfG0WTKC8Li0qyKiYPBWH1u+sUt8LroMEDpmUZLyoJL4wcf?=
 =?us-ascii?Q?iS6neGnURB4RCq03bpnYG45oS1z1Q5fvKUlzy/9S+Ai9kBtpz732tXau4bC8?=
 =?us-ascii?Q?8V9d4w9LjfFlqUnFGy2ZEZbpZR8oWZM8G4GWRCayBH9BlzwnYsEj5dvj4Ndu?=
 =?us-ascii?Q?M61kkyr/8FjXHzPpFzEWg8p3RAcbr6k4wDQ27aDyhgVcsVbITV51I9uxLe86?=
 =?us-ascii?Q?DAGFZC3MPUIgwxUTgEB+pwQ4pi1gOBsyfyT+ORQyCTwn9CRKTExr8xvdalEE?=
 =?us-ascii?Q?2TXxUd+nFQZWNsc6I/Lg3ua4+T0TwTZ2zjGISQfqY2lrRinPaYnbyKjyHkwv?=
 =?us-ascii?Q?YXOTIY938XEJrkdFy45Qc+gWl+cl+jo0tKqunl0IAVP3MU++vbpFEfO15vfZ?=
 =?us-ascii?Q?fXPjiE1TJi1huPZ7CMMJX0Tvbg7vDxEsedyVjP42ZfjYWs8iCx4a9WsB/tZM?=
 =?us-ascii?Q?61L+TG8+vRHZf9EcIi/PL1ew8qpMMuSqSmv9lTXFSO6SyzCIGycHiQN+GFsv?=
 =?us-ascii?Q?2QlULr3184DB4vbnvSNPOFV7FF0HWBQYoflLDisQrYzzQJGeoENzGOLBGUcF?=
 =?us-ascii?Q?2QKGeyQtocFnHJc/stvaasABcUebuFdK9VMKRW0zy8+ULpc4dVkTjuwqZobA?=
 =?us-ascii?Q?f/9Kr0Mh+Nlhm1neccxVQfHXZjgiEuh7TCjVEQ1YDDEUtwO0A0pNssZW5DEh?=
 =?us-ascii?Q?1tUTXSPehBchPAaLpf9urUmk=3D?=
x-microsoft-antispam-prvs: <AM5PR1001MB113729CE4947BCA8B8DBE8F5A77D0@AM5PR1001MB1137.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(110136005)(14444005)(316002)(33656002)(54906003)(7416002)(5660300002)(305945005)(6436002)(7736002)(66066001)(71190400001)(71200400001)(107886003)(2906002)(476003)(106356001)(256004)(486006)(446003)(4326008)(25786009)(105586002)(86362001)(6246003)(11346002)(6116002)(81156014)(8936002)(81166006)(99286004)(97736004)(76176011)(26005)(186003)(7696005)(3846002)(68736007)(6506007)(8676002)(478600001)(72206003)(74316002)(14454004)(229853002)(9686003)(53936002)(55236004)(53546011)(102836004)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1137;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YCQv5/utp8GAvFSuiPkFlIFSBaQbjgWAJHFj5Fxcm5qH49e9mg71StT0Ax4uEtGGs9q2tLGeM2AvpDbTEx13zvps7PChncsPcvZXkpVwyrj3C5aG3SGnPcaS9mMKtgTTyMk/RFq8oo0hAMM5TyyzJvUZlxJQjPyGyJwYBa9q5YlWnGmneZXGKuhy0fGgYbKW2zDR8HKwYE8x/am+OfdnW98yRhljvF0mdkTeoItEff51HRTWj/BHi3a2kESi7eCjDxK0qV+lKTuK68J9i73YkKuziIfHsouWKn8GvLYZr6vPiysgkFsOsDXd3sDtu1i35+AzQj5WGGSZMfR5kKhhjC20+IhiikTgXruRruSelpelCsz5lQiH01IGWboCqu7MynKMPY7PSTJ0JQfiBZDlMcbxLGTjHvAw1tsTQXrxx8w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9ae372-0df6-4de3-75d8-08d69715fc78
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 09:30:00.4213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 February 2019 18:18, Mark Brown wrote:

> On Fri, Feb 15, 2019 at 07:06:15AM +0000, Agrawal, Akshu wrote:
>=20
> > +static static int cz_da7219_hw_params(struct snd_pcm_substream
> *substream,
> > +				    struct snd_pcm_hw_params *params) {
> > +	/* da7219 Codec is clock master so setup as per the needs */
> > +	if (codec_dai->driver->ops->hw_params)
> > +		return codec_dai->driver->ops->hw_params(substream, params,
> > +							 codec_dai);
> > +	return 0;
> > +}
>=20
> No, this is a bad idea - you shouldn't be callings ops in drivers outside=
 of the
> framework, something is going to break on you there.
> Either the drivers or the frameworks are going to get surprised by things=
 getting
> called out of sequence, for example I'd not rely on the fact that the COD=
EC would
> be outputing a clock without active audio.
> This probably means that you're going to have to extend the framework in =
some
> way, or refactor things so that the BCLK is exported as a clock by the CO=
DEC and
> reflect the relationships via the clock API.  I need to think a bit more =
but I think
> the clock API is going to be the the best solution.
>=20
> I also suspect that some work is needed to propagate constraints between =
the
> various DAIs in the system.

So this was a suggestion from my side to avoid the scenario where the syste=
m
starts, the DA7219 codec hasn't yet been used (hw_params() not been called)=
, and
one of the other audio devices is needed for playback/capture. The codec wi=
ll be
at a default DAI configuration rather than the configuration that's require=
d. If
the DA7219 codec had been used first then of course there's no problem and =
the
system runs as expected from then on.

This AMD platform limits all DAIs to 48KHz, 2 channel so the configuration =
is
fixed, as I understand it. DA7219 will output DAI clocks without data so th=
ere's
no problem there. I initially suggested using 'soc_dai_hw_params()' but the
function isn't a global symbol, probably intentionally, so for this more un=
usual
config I felt the above approach might be an option. Absolutely understand =
your
concerns though.

I considered the CCF approach but I'm not 100% confident that the clocking
mechanism of the codec will fit ideally into that framework. There's alread=
y
a clock gate for the DAI clocks, in the driver, but nothing more. The probl=
em
here is that the BCLK rate is intrinsically linked to the WCLK rate, as wel=
l as
the word length, so changing the desired BCLK rate would affect the WCLK ra=
te,
and vice versa. I will take a look again, but if you have any suggestions t=
hen
they'd be greatly received.
