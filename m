Return-Path: <ruxandra.radulescu@nxp.com>
X-Google-Smtp-Source: AIpwx49jPkXN6PTFGgLywcI6M+u5B3WEHxQu/TB656wXdmpjOcuzBsWU2jU12tRYMhr2Tcq3k/yQ
ARC-Seal: i=1; a=rsa-sha256; t=1522942535; cv=none;
        d=google.com; s=arc-20160816;
        b=kSX6I7uYWrHvTGlz9nUWe9Kv2nA24/WfvxRQFhmt4mUCWAl9w2Xk9jmZ3Wi6kbvSc4
         U+6PBQcyoc75nDiivZLQlPMiaFHge+nxKMjzJoiNDR+b5URzqFgl8mzst0FTi+i5Vo2d
         Fn14MFAFDs47OVbgPcHA4xztkoc28rOgGFKIk8gTU+GzMUZKcJUQIXVwwzIHwVShwS69
         3B15Qub5CE3IPdncljfbcSD5Yia3WVO3BZWwvfJpDRs8nO9CvTQlIRSkNMkGLtvCRwIV
         UZoEn33geE60ZMU+a7EJjvRhc7H4llbY5SveP2s9SU1YqQIJEfMN8PoAqqu4nW1nt9ey
         V6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=+BqzBy6OwHwkN1eCmWK6xmSWT/26zJoLV7VpFHyPlxA=;
        b=vasLx1qLJXA2ilGc+U8WDxTFZV0mxZ9Jh35TCmMZwKrIHhy9CsqbQjVKUhtPEpwzIa
         QVNrXYvBsHwUeQv0ISFguDe15JHMHJDs3CuEXH5SWzvaHzrdpsvdCbwN8H8poO4CkdNd
         byAhM7j3V/64ACwGsfcq938cGUugc5jkVjf2tcg6rZpUTVEXLkQcViDXZWklaScAuVjM
         5WU4y3gezwUtsGN6z39ZeHA4kBxHMfEFOaw2JdmRMqUsZzrSvAdEtrm1qzqnE9Hh+eIb
         oQZYvJ7B2nqZIDzCA5k5isIv0C97T9preeAYCbupqHs6k+y+ApX9zvhN0lKR4vAYrsYe
         pgRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=kWoDT22x;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 104.47.2.78 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=kWoDT22x;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 104.47.2.78 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC: Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, gregkh <gregkh@linuxfoundation.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Razvan Stefanescu
	<razvan.stefanescu@nxp.com>, Roy Pledge <roy.pledge@nxp.com>, Networking
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0sudEnGBN96Ui0dxEjD14606PfBFwAgAa39ICAABVLAIAJ+AgAgAATBYCAACYwgIAAnIoAgAFtPoCAABWtAIAACAcAgAAI5QCAACA4gIAAC0QAgAACvEA=
Date: Thu, 5 Apr 2018 15:35:30 +0000
Message-ID: <HE1PR0402MB2700E32234735AC12C18BB8F94BB0@HE1PR0402MB2700.eurprd04.prod.outlook.com>
References: <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch> <5AC5FAA8.80409@nxp.com>
 <20180405114736.GA12178@lunn.ch> <5AC61393.7090509@nxp.com>
 <20180405124810.GE12178@lunn.ch> <5AC63610.4000504@nxp.com>
 <20180405152348.GC32663@lunn.ch>
In-Reply-To: <20180405152348.GC32663@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0402MB2844;7:qoVbA6KszeKA2ONM8QIk8oGF2vUriHrdgawoxq6h+3h/+dnsBpYjHSxeOZVbYbDv8T8+DReQbZ1vByN08kqp0K7SrfMpxNaPjc0cc6uvkeJlhe5OJPPqfYib/Ds1iriFKic4x6uaqdzB7WHmWTZnO5p/kDUM4rHCzP6gwAxjhfmM7eylIcSpX7koqfwUJoPwic1EnMpOGRZI/Vx6ZRQu+b5OugnrRzNBoyu8LuK95UJAYw/Uo6FbpIlEcU2kkIPn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af6e7b75-2b20-449c-e973-08d59b0add83
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB2844;
x-ms-traffictypediagnostic: HE1PR0402MB2844:
x-microsoft-antispam-prvs: <HE1PR0402MB2844750F953534D787711E8694BB0@HE1PR0402MB2844.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0402MB2844;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB2844;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(39860400002)(366004)(189003)(199004)(13464003)(3280700002)(81166006)(59450400001)(68736007)(53936002)(7696005)(9686003)(39060400002)(6246003)(4326008)(6306002)(25786009)(14454004)(99286004)(55016002)(97736004)(229853002)(66066001)(2906002)(6636002)(2900100001)(110136005)(305945005)(316002)(81156014)(33656002)(6506007)(106356001)(5660300001)(8676002)(53546011)(6436002)(186003)(11346002)(5250100002)(966005)(54906003)(26005)(76176011)(7736002)(6116002)(3660700001)(102836004)(3846002)(8936002)(446003)(478600001)(486006)(74316002)(86362001)(105586002)(93886005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB2844;H:HE1PR0402MB2700.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1D+AJJiMqSynxK+5neTMJy4EoBHjoDQ8gsbcT+9GY1VY6gyM3NoXbLKl78/Pgvj0GGcm16TJ7Evj3J2skhnQ6HrYIbUd+KXXwb+vBJIZV68omz3QcNxBVqOuhYkp2aRt6EBe7mErdvrMGqC3m5W5uvugq96bgaX4PQ6/R40pILDiu+bg521Bo2K9JO2sNb5zutAfjO2SFqSaEAMhkNdOROmhwd4XgnRas7R70qkxSDp3mCKalljJ8xKwnTMvPs/bpb12yOxZhrvBPN1JYmOR0yH8Q4QBTZUSOAXTf/XxjUz1STfjBedLX/CHkhxYb+JAk3efRMlLImPS2eMmDG6RilNlexQnaNkF6pp6IL4bd3I2U/7BbXV/UtWrvAatVM0m5X9Lp+JqLhDZk/Wtm9q4oyg/JTRANExsxqDRX+VNIAA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6e7b75-2b20-449c-e973-08d59b0add83
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 15:35:30.8524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2844
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596920992186840486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Thursday, April 5, 2018 6:24 PM
> To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Stuart Yoder <stuyoder@gmail.com>; Arnd Bergmann <arnd@arndb.de>;
> Ioana Ciornei <ioana.ciornei@nxp.com>; gregkh
> <gregkh@linuxfoundation.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Ruxandra Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Razvan Stefanescu
> <razvan.stefanescu@nxp.com>; Roy Pledge <roy.pledge@nxp.com>;
> Networking <netdev@vger.kernel.org>
> Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
>=20
> On Thu, Apr 05, 2018 at 02:43:29PM +0000, Laurentiu Tudor wrote:
> > Hi Andrew,
> >
> > On 04/05/2018 03:48 PM, Andrew Lunn wrote:
> > >>> Hi Laurentiu
> > >>>
> > >>> So i can use switchdev without it? I can modprobe the switchdev
> > >>> driver, all the physical interfaces will appear, and i can use ip a=
ddr
> > >>> add etc. I do not need to use a user space tool at all in order to =
use
> > >>> the network functionality?
> > >>
> > >> Absolutely!
> > >
> > > Great.
> > >
> > > Then the easiest way forwards is to simply drop the IOCTL code for th=
e
> > > moment. Get the basic support for the hardware into the kernel
> > > first. Then come back later to look at dynamic behaviour which needs
> > > some form of configuration.
> >
> > Hmm, not sure I understand. We already have a fully functional ethernet
> > driver [1] and a switch driver [2] ...
>=20
> In staging, the tree of crap. You want to get it out of there and into
> the main tree. But that effort is being side lined by the discussion
> around this IOCTL call.  The best way forward is to to accept Greg is
> not going to take this patchset at the moment, and move on. As you
> said, it is not needed for the Ethernet and switchdev driver.
>=20
> What needs to happen before the Ethernet driver can be reviewed for
> moving out of staging?

Hi Andrew,

We're waiting for the DPIO driver (which we depend on) to be moved
out of staging first, it's currently under review:
https://lkml.org/lkml/2018/3/27/1086

Ioana
