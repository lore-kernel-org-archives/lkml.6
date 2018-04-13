Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AIpwx49u7WCpl59gd0UJa8mERPGjkn7D49tTXrJuQpF/EUuy0fQ16e8jU7b5EIdqch3zFTpDIgCR
ARC-Seal: i=1; a=rsa-sha256; t=1523648403; cv=none;
        d=google.com; s=arc-20160816;
        b=xZoOxIQIeLDVCw5nGnL5ZxXN8BVlu4BXfN9cNtHGS19yVVkhFkePAAxrgtX7BbQgEe
         886c45Faw9fPgbpo7n6tBibcC1wRrn2ytMujCkh9yJEN2hoQmvmUsSwcMoFgBDawuiNK
         UiHKumf4Ejy9p30KPl3OVW8jrdVHmcNAG0EAzFP8cOUpxYfO9oMOoOuZyLoB+RN0FtJE
         52K6Wc6rvOxU9A82peTN5URUCsBi1pW6gFC1lYBrREgCz1Ix5syhDkArgrnKy8U+Q48C
         Q9rX4+m5WwU/inRh672Q7lUGtVY6bxGUpTkFZleT8QIsFQb2fxJ3cSydCZ5/jG4rO725
         Dyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=eywU1g7NcrnOT9Fd3YWu7FtuAzbB2hsH6bR2ghEx7cQ=;
        b=Vs9//jABwzlyOlPPBr2ilYOQubBOtWMGALAVR6B3OkghJeQZ01q8ONiSoXV1A1qLue
         +gqekKJEZjSUYWXAL3dzVXpTAgyBpGhiOjxFYSn1KAHu1m7EwvNpUA7FscrI7EhzImh+
         8HCisX1i2eKiV1wcI1JLf9r7h/xcN25d+BFZRomaF3z+6rmYxig4EK7hpT1Jxt4MGDu4
         MAKaal+g/2nrVjIdhzUzowyFAnxb1PX8eub5jA0fhDvo10NMe68WV4aVYDsjqU3mJHrx
         U0a0Sl9wgmkQtLkENsKr9l6/fkmCL/Z1WuHyWFeJQ/Efld/XG8NxB6gc7WZ+yS/qQ6+a
         XDBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=R6ODcHjl;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 104.47.1.75 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=R6ODcHjl;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 104.47.1.75 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: Darren Hart <dvhart@infradead.org>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych
	<michaelsh@mellanox.com>, "ivecera@redhat.com" <ivecera@redhat.com>
Subject: RE: [PATCH v1 3/7] platform/mellanox: mlxreg-hotplug: add extra cycle
 for hotplug work queue
Thread-Topic: [PATCH v1 3/7] platform/mellanox: mlxreg-hotplug: add extra
 cycle for hotplug work queue
Thread-Index: AQHTxaJ9jcxUGivJukCx+Rgxm0SdpKP/AtwAgAAt+tA=
Date: Fri, 13 Apr 2018 19:39:58 +0000
Message-ID: <AM6PR0502MB375228AB04E73AAD6560BEAFA2B30@AM6PR0502MB3752.eurprd05.prod.outlook.com>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
 <1522144927-56512-4-git-send-email-vadimp@mellanox.com>
 <20180413164710.GE27560@fury>
In-Reply-To: <20180413164710.GE27560@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-originating-ip: [46.120.54.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0502MB3621;7:JsaGtJpOk/Oof2PQjDERthZvEAKWez90WEUorV9EJ0xKcnw45UKmt70GlB3qZppSgK6GqLMq+OIUwAmk7VP+ObgBzO+vMfo464l1qiji/qWD1tGvEqtxxxJvdScRoPbDHpHS+DaDvntRDg/sN97iHxOmC8HNoa5bVzShviScb3aXulYPCUekBSYp7vC7lI+MUK/c8hxD67i5H08FK25r7QURqCG+mVxozTfSrJuZk28lzfstozk201AQA9RpctdV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR0502MB3621;
x-ms-traffictypediagnostic: AM6PR0502MB3621:
x-microsoft-antispam-prvs: <AM6PR0502MB3621704D509C282264A9F42BA2B30@AM6PR0502MB3621.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM6PR0502MB3621;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0502MB3621;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(39860400002)(376002)(346002)(13464003)(189003)(199004)(26005)(106356001)(3280700002)(4326008)(446003)(97736004)(76176011)(25786009)(68736007)(7696005)(14454004)(486006)(8676002)(8936002)(81156014)(5660300001)(11346002)(229853002)(305945005)(3660700001)(81166006)(6916009)(476003)(74316002)(7736002)(39060400002)(55016002)(33656002)(9686003)(86362001)(99286004)(53936002)(6246003)(2900100001)(105586002)(186003)(5250100002)(478600001)(66066001)(2906002)(316002)(102836004)(6436002)(53546011)(59450400001)(6116002)(3846002)(6506007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0502MB3621;H:AM6PR0502MB3752.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 5BqA3IdrvlZ9igN+EVFi/bNlm08JtmlT4p7PVZbq9nmGrtm7uA4UyBYXPcShb1yUDbcbUm79dRcs2H0uM/J3o3pSG3QdFOu/06aa1zS1OtRH62Cb8n5a018CvHPKiM9qU7IIFB5VAp8FqoCDaYnyp5nItQxig7oGkqZAAmkajInfQXl46GsrH5nExkJIuiID
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: afa59193-bb82-4a9a-1ec3-08d5a1765779
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa59193-bb82-4a9a-1ec3-08d5a1765779
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 19:39:58.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3621
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077329932393819?=
X-GMAIL-MSGID: =?utf-8?q?1597661148303692436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, April 13, 2018 7:47 PM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: andy.shevchenko@gmail.com; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; jiri@resnull=
i.us;
> Michael Shych <michaelsh@mellanox.com>; ivecera@redhat.com
> Subject: Re: [PATCH v1 3/7] platform/mellanox: mlxreg-hotplug: add extra =
cycle
> for hotplug work queue
>=20
> On Tue, Mar 27, 2018 at 10:02:03AM +0000, Vadim Pasternak wrote:
> > It adds missed logic for signal acknowledge, by adding an extra run
> > for work queue in case a signal is received, but no specific signal
> > assertion is detected. Such case theoretically can happen for example
> > in case several units are removed or inserted at the same time. In
> > this situation acknowledge for some signal can be missed at signal top
> > aggreagation status level.
>=20
> Why can they be missed? What does "signal top aggregation status level"
> mean? I'm asking to confirm that we are fixing this at the right place, a=
nd not
> just applying a suboptimal bandaid by running the workqueue more.
>=20

Hi Darren,

Thank for review.

It could happen within the next flow:

The signal routing flow is as following (f.e. for of FANi removing):
 - FAN status and event registers related bit is changed;
 -- intermediate aggregation status register is changed;
 --- top aggregation status register is changed;
 ---- interrupt routed to CPU and interrupt handler is invoked.

When interrupt handler is invoked it follows the next simple logic (f.e
FAN3 is removed):
 (a1) mask top aggregation interrupt mask register;
 (a2) read top aggregation interrupt status register and test to which
      underling group belongs a signal (FANs in this case and is changed
	  from 0xff to 0xfb and 0xfb is saved as a last status value);
   (b1) mask FANs interrupt mask register;
   (b2) read FANs status register and test which FAN has been changed (FAN3=
 in
        this example);
     (c1) perform relevant action;
              <--------------- (FAN2 is removed at this point)
   (b3) clear FANs interrupt event register to acknowledge FAN3 signal;
   (b4) unmask FANs interrupt mask register
 (a3) unmask top aggregation interrupt mask register;
=20
 An interrupt handler is invoked, since FAN2 interrupt is not acknowledge.
 It should set top aggregation interrupt status register bit 6 (0xfb).
 In step (a2)
 (a2) read top aggregation interrupt and comparing it with saved value does=
n't
      show change (same 0xfb) and after (a2) execution jumps to (a3) and
	  signal leaved unhandled.

> ...
>=20
> >
> > Fixes: 1f976f6978bf ("platform/x86: Move Mellanox platform hotplug
> > driver to platform/mellanox")
>=20
> You didn't mention above how this commit caused this - how did moving the
> driver create this problem?=20

Actually I should reference to=20
07b89c2b2a5e ("platform/x86: Introduce support for Mellanox hotplug driver"=
)
which was initial driver commit, before it has been relocated.=20

Does this need to go to stable? I'm assuming not as
> you've called it theoretical - not something you've observed in practice?
>=20

It's not necessary to go to stable.

> ...
>=20
> >  static int mlxreg_hotplug_device_create(struct
> > mlxreg_hotplug_priv_data *priv, @@ -410,6 +413,18 @@ static void
> mlxreg_hotplug_work_handler(struct work_struct *work)
> >  	aggr_asserted =3D priv->aggr_cache ^ regval;
> >  	priv->aggr_cache =3D regval;
> >
> > +	/*
> > +	 * Handler is invoked, but no assertion is detected at top aggregatio=
n
> > +	 * status level. Set aggr_asserted to mask value to allow handler ext=
ra
> > +	 * run over all relevant signals to recover any missed signal.
> > +	 */
> > +	if (priv->not_asserted =3D=3D MLXREG_HOTPLUG_NOT_ASSERT) {
> > +		priv->not_asserted =3D 0;
> > +		aggr_asserted =3D pdata->mask;
> > +	}
> > +	if (!aggr_asserted)
>=20
> We seem to check aggr_asserted in several places in this routine now.
> Looks like something we could simplify. If you check it here, can you dro=
p the
> check lower in the routine? Can you remove it from the for loop if condit=
ional
> entirely? Please consider how to simplify.

OK, will review this code.

>=20
> --
> Darren Hart
> VMware Open Source Technology Center
