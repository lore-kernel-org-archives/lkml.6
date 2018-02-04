Return-Path: <prvs=566751c09=Stanislav.Nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x224Bk1IgJXa7G5S8f6QsSbt6pLwTNr4Ngct+INa40OX1wis8Cqvfrm/4Cem49pKAHLJ8wCYq
ARC-Seal: i=1; a=rsa-sha256; t=1517749753; cv=none;
        d=google.com; s=arc-20160816;
        b=U6vy89WXTahva/mY6Vach7l1Kf7UVaBA58cLUGF8dVuY3Crg3yzwkNjlhRgHEk7K+q
         OurhyEUf/sJFS8TWX7yZnu1Kfmn6+h0Yj0oHhQhMSKTzx2iDGy3kZL0R5ed7xPL9sLKQ
         6Er3KjRb3VsRnMWTwVIkI/wPJ7+HFpYM+gx3b3BKH3fBuNqp2Ns3Lsm40DeU+/axu1kh
         8/i6wpF3N9MxxtJl7g9qVwmJdmKQ1+q/gb7K4w8zzWSlomxsCncpsI0aCU9YHdW6JmCR
         hoLiTH7qPbfzOEzt81Mc0X5yg6UVRxOtWJgRbsQ7fsIZ7Ub63TpJHMlxVgBUlE7b6W4R
         WuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:wdcipoutbound:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Wfofd0tfaahTb59tSKDqhneSbQoq+Q34qqq9Xcb3u0U=;
        b=xSJa75coJYfkp7vhCqS2DY66K6RltEfGw4DgDFQx9ygMp+MSRli7KYLvGzcVYnP1ln
         cDatUHy/j5KhuzMCPQLKcZVXihiT6nkU/W5S2LV4tHlahYcs9mHZ0sTfHSnHNrB5HQlH
         EcB/xby/D2jps9gGTfwsYQBwGm7Pg/Wr+8kP3nVz2DORwJMVZCFgT6QQlap/kvX1XdYw
         6pOFxtMvnOfcf5pRXHfmhF3ejTo10wofokgygUlhY8kEHfx9u+ubNGn6pTdx09jwn+rl
         qKeyTMyCQgUtl6ZVNTNbnnCdl+z5K4radgC6tydIaMT87FcdUXUmiEqrRX9Vx4D6heEC
         OzHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=kSMBpbMf;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=KkL4H4dr;
       spf=pass (google.com: domain of prvs=566751c09=stanislav.nijnikov@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=566751c09=Stanislav.Nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=kSMBpbMf;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=KkL4H4dr;
       spf=pass (google.com: domain of prvs=566751c09=stanislav.nijnikov@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=566751c09=Stanislav.Nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,458,1511798400";
   d="scan'208";a="70645011"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, Alex Lemberg
	<Alex.Lemberg@wdc.com>
Subject: RE: [PATCH v4 01/10] ufs: sysfs: attribute group for existing sysfs
 entries.
Thread-Topic: [PATCH v4 01/10] ufs: sysfs: attribute group for existing sysfs
 entries.
Thread-Index: AQHTm3fxo1n5KlULckmz1QORVYth36OPxRSAgARmIJCAAAalgIAABxiA
Date: Sun, 4 Feb 2018 13:09:09 +0000
Message-ID: <DM2PR0401MB0975383CF11F3932BB5DA77E9AFF0@DM2PR0401MB0975.namprd04.prod.outlook.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
 <1517501746-19075-2-git-send-email-stanislav.nijnikov@wdc.com>
 <20180201165923.GA12838@kroah.com>
 <DM2PR0401MB097509D74E03449B0FA616249AFF0@DM2PR0401MB0975.namprd04.prod.outlook.com>
 <20180204123343.GA940@kroah.com>
In-Reply-To: <20180204123343.GA940@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0401MB1391;7:sDFp3EGzKPIPsx7+AvrwwlSMLbYpvB5TXxoh+c1E7/UUBnAgdRAr5M6idaC+jFEVaKn6xT5kPJgSPR7p1RFvpvrlKXmE/JC3wB3T8V6buv9J8i9OiWyJQd9Ll4IarolFYEMXWWG32SOcbVCA+i8p0RHFp+IB45dsMOpy79sqJDqo2zFle9u+GgYY3KmXN88w3sLE873qQ6ZGs2xxDp0EhXBUIgRaA6Q1uNiXt2HXF7ZqNBNEJ+avqDl+N70OCgrl;20:VKP2DCZo3O8muncUhVqgahUCkdenZ7T3S4XSYzQmXaGwe1pp5vv8P/Dr8xvkx3AbJkPZ2+aIajtHJUXwQCiQKK3R27WRFZE8NSnKs2tAwS0yfZIZvSso6y9GGjMSbkvmWlR0ExaKLRG/Rzner4L6tqEl4HB35LBF805VZ9+r4Ys=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95c33611-3d75-45ce-b67b-08d56bd07ab7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM2PR0401MB1391;
x-ms-traffictypediagnostic: DM2PR0401MB1391:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM2PR0401MB139186A52E002030FAA090049AFF0@DM2PR0401MB1391.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR0401MB1391;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0401MB1391;
x-forefront-prvs: 05739BA1B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(39380400002)(396003)(13464003)(199004)(189003)(99286004)(5660300001)(59450400001)(2900100001)(6436002)(55016002)(9686003)(53546011)(97736004)(53936002)(26005)(8936002)(2906002)(66066001)(8676002)(81166006)(81156014)(3660700001)(3280700002)(316002)(102836004)(6916009)(72206003)(2950100002)(54906003)(6506007)(14454004)(68736007)(76176011)(7696005)(478600001)(105586002)(106356001)(229853002)(186003)(93886005)(86362001)(3846002)(6116002)(5250100002)(4326008)(6246003)(74316002)(305945005)(25786009)(33656002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR0401MB1391;H:DM2PR0401MB0975.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: d/WV7oeR3YofJjjFK6cGUnk+7H7Ao+nlas04uwfPdRaJqj4cpvftOcW+rSJFy0IWoPH72XgIP2Gu4+s/3fsxPA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c33611-3d75-45ce-b67b-08d56bd07ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2018 13:09:09.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0401MB1391
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215918423132169?=
X-GMAIL-MSGID: =?utf-8?q?1591475966047368052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Sunday, February 4, 2018 2:34 PM
> To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> jaegeuk@kernel.org; Alex Lemberg <Alex.Lemberg@wdc.com>
> Subject: Re: [PATCH v4 01/10] ufs: sysfs: attribute group for existing sy=
sfs
> entries.
>=20
> On Sun, Feb 04, 2018 at 12:29:06PM +0000, Stanislav Nijnikov wrote:
> > > > +	curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > > > +			     "\nAll available Runtime PM levels info:\n");
> > > > +	for (lvl =3D UFS_PM_LVL_0; lvl < UFS_PM_LVL_MAX; lvl++)
> > > > +		curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > > > +				     "\tRuntime PM level [%d] =3D> dev_state
> > > [%s] link_state [%s]\n",
> > > > +				    lvl,
> > > > +				    ufschd_ufs_dev_pwr_mode_to_string(
> > > > +					ufs_pm_lvl_states[lvl].dev_state),
> > > > +				    ufschd_uic_link_state_to_string(
> > > > +					ufs_pm_lvl_states[lvl].link_state));
> > > > +
> > >
> > > sysfs if "one value per file", not "random text that someone has to
> > > parse per file" please.
> > >
> > > Huge hint, if you ever care about checking the size of the sysfs
> > > buffer you are writing into, you are doing something really really wr=
ong.
> > >
> > Hi Greg
> > It's the existing code, added by:
> > commit 09690d5a6ae1b7e4cb5ac429c311b99d09352c12
> > Author: subhashj@codeaurora.org <subhashj@codeaurora.org>
> > Date:   Thu Dec 22 18:41:00 2016 -0800
> >
> >     scsi: ufs: provide sysfs attribute to select the PM level
> >
> >     This patch provides the sysfs attribute to choose the power managem=
ent
> >     level for UFS runtime and system suspend.
> >
> >     Reviewed-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> >     Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> >     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> >
> > I just moved it to an another file and changed the sysfs entries
> > creation by Jaegeuk Kim' request. At the moment the entry shows the PM
> > level, the device state, the link state and all possible PM levels. Do =
you
> want me to change it?
>=20
> Ah, you are just moving this code around.  Ok, that's fine for this patch=
, but
> please fix it up as part of this patch series because this isn't an accep=
table
> sysfs file at all.  If it were documented that would be a lot more obviou=
s as to
> just how wrong it was :(
>=20
> And, as it wasn't documented, you can change it as it's obvious no one us=
ed it
> :)
>=20
> thanks,
>=20
> greg k-h
=20
Can I fix these entries not in this patchset? As long as I know they are us=
ed and I
would prefer that change of the existing sysfs entries behavior be related =
to a
separate patch.

Regards.
Stanislav.
