Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeCJQ5t (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 11:57:49 -0500
Received: from mx0a-00272701.pphosted.com ([67.231.145.144]:43698 "EHLO
        mx0a-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750946AbeCJQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 11:57:47 -0500
From: "French, Nicholas A." <naf@ou.edu>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
CC: "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: ivtv: use arch_phys_wc_add() and require PAT disabled
Thread-Topic: ivtv: use arch_phys_wc_add() and require PAT disabled
Thread-Index: AQHTsXBOQGvUe478EUWv+ObGTFYl4qO7oBEAgAgWYqaAAXQ9gIAAhKi/gAATUYCAAAJIgIAADbrRgAPguAA=
Date: Sat, 10 Mar 2018 16:57:41 +0000
Message-ID: <MWHPR03MB30402C0F8B8F457F5F760412D3DD0@MWHPR03MB3040.namprd03.prod.outlook.com>
References: <DM5PR03MB3035EE1AFCEE298AFB15AC46D3C60@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180301171936.GU14069@wotan.suse.de>
 <DM5PR03MB303587F12D7E56B951730A76D3D90@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180307190205.GA14069@wotan.suse.de>
 <DM5PR03MB30352350D588A81D2D02BE93D3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180308040601.GQ14069@wotan.suse.de>,<20180308041411.GR14069@wotan.suse.de>,<DM5PR03MB3035CCBF9718D7E42B35357FD3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
In-Reply-To: <DM5PR03MB3035CCBF9718D7E42B35357FD3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.185.212.125]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR03MB2441;7:mcbZMfJnw9YX45GXq1Xl9FZimYVd6yo9lDrOLakn8uE0lsBElWB+DvijPURs9xw72fLhehLKiaOYTOTGKNzx021LxcbnYvmHK8/74FOn3bx+bObBK23WK2AkDXs7WdlJD6Rbcv3erf8aXjY9+f6Nnjp9bKsdzCZh7emfyQ+CGjfv6BJKsyh+jO70dJAvr1MWgRhuGAf86xknzVzyCHg/V9XmU9ksU//BOKurmIf9ewO8hgnGl96nHvK6+7L0XTZb;20:lD6KgvyyNj8wwoRQoGcjQLSyXGbIDHhCRW9e/xSGnDYeSc6Z2upBRe4Y22L8XTW2TlNffc+haWUqLhD340rDPz25mdNuZlxUB+u4EhuSBxO4IQmbHuEcDuAN8zTMNkmVnHLc9mHg2xLHsjnEt/sky68hF7r9gQK6Fhq1HHqzTko=
x-ms-office365-filtering-correlation-id: 5f694164-2d53-46bb-ad5a-08d586a809ca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2441;
x-ms-traffictypediagnostic: DM5PR03MB2441:
x-microsoft-antispam-prvs: <DM5PR03MB2441F733E2F98873E7D83863D3DD0@DM5PR03MB2441.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR03MB2441;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2441;
x-forefront-prvs: 06070568C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(376002)(346002)(39860400002)(199004)(189003)(76176011)(5660300001)(478600001)(106356001)(4326008)(25786009)(6486002)(14454004)(3846002)(6116002)(575784001)(186003)(102836004)(86362001)(229853002)(26005)(6506007)(59450400001)(2900100001)(786003)(316002)(93886005)(6306002)(9686003)(6512007)(110136005)(7736002)(53936002)(6246003)(2950100002)(8936002)(75432002)(6436002)(66066001)(8676002)(3660700001)(74316002)(5250100002)(88552002)(2906002)(97736004)(99286004)(54906003)(81166006)(81156014)(3280700002)(305945005)(68736007)(33656002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR03MB2441;H:DM5PR03MB3035.namprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: CHXicSaSfUDAhsOPv7tvrsJRH/AY1aWueHWrOJohfiOTFaU4wT1veHU0xldPZrCw5aahSIlhOlQby+FEX3rqZqUAtI9Z0QMCjcpetVD03XfG6VGuVgAl8vRypc2SrH+p5NV6jjP05IIU0XTKxO+E2CujsE1TcNlO5lJubkqF7Uv2Z1E01xz7vLXcnRbOuVud8LA8UMlc2xAtBkOVoY5S7iJqz5qSwL7Aza0KdGZDkErsfJH83OJB6KFQDR+/T/EXSlVGDB2kGS8FGQ+DD5leGPtoeJkOeSkPFLSbd5OnBBnBahFqzLKW4AKKghwmiX0T3MqumMs3lHdQE7e9g8VIlw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: ou.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f694164-2d53-46bb-ad5a-08d586a809ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2018 16:57:41.7511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9c7de09d-9034-44c1-b462-c464fece204a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2441
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803100205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2AGvvFO017931

On Wed, Mar 07, 2018 at 11:23:09PM -0600, French, Nicholas A. wrote:
> On Thu, Mar 08, 2018 at 04:14:11AM +0000, Luis R. Rodriguez wrote:
> > On Thu, Mar 08, 2018 at 04:06:01AM +0000, Luis R. Rodriguez wrote:
> > > On Thu, Mar 08, 2018 at 03:16:29AM +0000, French, Nicholas A. wrote:
> > > >
> > > > Ah, I see. So my proposed ioremap_wc call was only "working" by aliasing the
> > > > ioremap_nocache()'d mem area and not actually using write combining at all.
> > >
> > > There are some debugging PAT toys out there I think but I haven't played with
> > > them yet or I forgot how to to confirm or deny this sort of effort, but
> > > likeley.
> >
> >  In fact come to think of it I believe some neurons are telling me that if
> >  two type does not match we'd get an error?

I can confirm that my original suggested patch just aliases to ivtv-driver's nocache mapping:
$ sudo modprobe ivtvfb
$ sudo dmesg
...
x86/PAT: Overlap at 0xd5000000-0xd5800000
x86/PAT: reserve_memtype added [mem 0xd5510000-0xd56b0fff], track uncached-minus, req write-combining, ret uncached-minus
ivtvfb0: Framebuffer at 0xd5510000, mapped to 0x00000000c6a7ed52, size 1665k
...
$ sudo cat /sys/kernel/debug/x86/pat_memtype_list | grep 0xd5
uncached-minus @ 0xd5000000-0xd5800000
uncached-minus @ 0xd5510000-0xd56b1000

So nix that.

> > No what if the framebuffer driver is just requested as a secondary step
> > after firmware loading?
>
> Its a possibility. The decoder firmware gets loaded at the beginning of the decoder
> memory range and we know its length, so its possible to ioremap_nocache enough
> room for the firmware only on init and then ioremap the remaining non-firmware
> decoder memory areas appropriately after the firmware load succeeds...

I looked in more detail, and this would be "hard" due to the way the rest of the
decoder offsets are determined by either making firmware calls or scanning the
decoder memory range for magic bytes and other mess.

I think some smart guy named mcgrof apparently came to the same conclusion 
in a really old email chain I found [https://lists.gt.net/linux/kernel/2387536]:
"The ivtv case is the *worst* example we can expect where the firmware
hides from us the exact ranges for write-combining, that we should somehow
just hope no one will ever do again."
:-)

> Perhaps the easy answer is to change the fatal is-pat-enabled check to just a
> warning like "you have PAT enabled, so wc is disabled for the framebuffer.
> if you want wc, use the nopat parameter"?

I like this idea more and more. I haven't experience any problems running
with PAT-enabled and no write-combining on the framebuffer. Any objections?

- Nick
