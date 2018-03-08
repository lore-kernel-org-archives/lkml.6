Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966799AbeCHFXe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 00:23:34 -0500
Received: from mx0a-00272701.pphosted.com ([67.231.145.144]:52580 "EHLO
        mx0a-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966464AbeCHFXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 00:23:14 -0500
From: "French, Nicholas A." <naf@ou.edu>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
CC: "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: ivtv: use arch_phys_wc_add() and require PAT disabled
Thread-Topic: ivtv: use arch_phys_wc_add() and require PAT disabled
Thread-Index: AQHTsXBOQGvUe478EUWv+ObGTFYl4qO7oBEAgAgWYqaAAXQ9gIAAhKi/gAATUYCAAAJIgIAADbrR
Date: Thu, 8 Mar 2018 05:23:09 +0000
Message-ID: <DM5PR03MB3035CCBF9718D7E42B35357FD3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
References: <DM5PR03MB3035EE1AFCEE298AFB15AC46D3C60@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180301171936.GU14069@wotan.suse.de>
 <DM5PR03MB303587F12D7E56B951730A76D3D90@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180307190205.GA14069@wotan.suse.de>
 <DM5PR03MB30352350D588A81D2D02BE93D3DF0@DM5PR03MB3035.namprd03.prod.outlook.com>
 <20180308040601.GQ14069@wotan.suse.de>,<20180308041411.GR14069@wotan.suse.de>
In-Reply-To: <20180308041411.GR14069@wotan.suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.185.212.125]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR03MB2940;7:LWSEYzvrtgmEqX0Gu1dD1DenXVRR2JZtPt/C72n82f8AgGxrkckOk35y/GXZLmeX/nxomFbdZ7Ut5cAGlY+s94JkeS+IGRsOCbs22Rn7rAwOndpaTFZVaq3zyutLrCNv1qE+0UKBJ56m/X/17ForjowPybbSoQI4TDq1B8ThUwNwFXhLKuuKbPpdLQBXOZTHVOh9U6iHUg+juXYmVpaWoY54XhOw0M0gcjnXzzn1mt0QHUVXFA4U4Z5xkSZOQPXC;20:ny6mUx7Mo376JSI03Hf52nGcuXSfs/DunooTRgUA/BzLSRaGbMNMhNA8hxaiN9oQhvtK/6We/cr/GyANTKFDRjsMHjHF0a5oFebD+v0NGeBW3GrDlU8/YbnwXjK4rXz2evMM6/opGLj8Szgq69739L37cqa1NwA4A/eFqXZIXAY=
x-ms-office365-filtering-correlation-id: 28aad507-a663-4f5d-ebf3-08d584b4ae60
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2940;
x-ms-traffictypediagnostic: DM5PR03MB2940:
x-microsoft-antispam-prvs: <DM5PR03MB29400E7F42F3DB90D0C8869AD3DF0@DM5PR03MB2940.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR03MB2940;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2940;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(3280700002)(33656002)(4326008)(68736007)(7696005)(86362001)(2900100001)(966005)(5660300001)(76176011)(7736002)(305945005)(110136005)(54906003)(316002)(2950100002)(478600001)(88552002)(3660700001)(229853002)(14454004)(74316002)(2906002)(3846002)(6116002)(75432002)(97736004)(102836004)(26005)(25786009)(106356001)(66066001)(93886005)(186003)(99286004)(6506007)(55016002)(59450400001)(53936002)(786003)(9686003)(8936002)(6306002)(6436002)(8676002)(81156014)(81166006)(5250100002)(105586002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR03MB2940;H:DM5PR03MB3035.namprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zUTLhzChocjx/3AtI5OB6ntQHUW8njIJydZYjgTmUAjXiWH8ZbLqKIdjfxbsLWpFObrWcZD4CYGKxfcwPEFgPUd5zUBSdLNBA0EP88IOlvEYp0Zp5p04mEsekQ+VwcdQ0AUmIWrriElOgdif6o0BZB63t+pHKU29Sfn6SKG/KVNIxrI/PeZCzU6wIzMjiY94LwTeP52w2TZ/LqZ3NabjV238/ZvgaWa9nftyx6o5cvkrYtcYqGUnblUKMnr7OpiqYcCIrCQRr65P/L+051r5y3QwxHLXNhJEcbE/PBSlI1ceqP7yTW0eDId9V5sBD/Sw5jx+LQYqF0HDmiOW+gZ9Rw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: ou.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aad507-a663-4f5d-ebf3-08d584b4ae60
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:23:09.6266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9c7de09d-9034-44c1-b462-c464fece204a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2940
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803080067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w285NfEn010944

On Thu, Mar 08, 2018 at 04:14:11AM +0000, Luis R. Rodriguez wrote:
> On Thu, Mar 08, 2018 at 04:06:01AM +0000, Luis R. Rodriguez wrote:
>  > On Thu, Mar 08, 2018 at 03:16:29AM +0000, French, Nicholas A. wrote:
> > > 
>  > > Ah, I see. So my proposed ioremap_wc call was only "working" by aliasing the
>  > > ioremap_nocache()'d mem area and not actually using write combining at all.
>  > 
>  > There are some debugging PAT toys out there I think but I haven't played with
>  > them yet or I forgot how to to confirm or deny this sort of effort, but
>  > likeley.
> 
>  In fact come to think of it I believe some neurons are telling me that if
>  two type does not match we'd get an error?

I based my guess on some text i read in "PATting Linux" [1]:
"ioremap interfaces will succeed if there is an existing,
more lenient mapping. Example: If there is an existing
uncached mapping to a physical range, any request for
write-back or write-combine mapping will succeed, but
will eventually map the memory as uncached"

But I will try to get some debugpat going to confirm.

[1] = https://www.kernel.org/doc/ols/2008/ols2008v2-pages-135-144.pdf

> > So unless there is a io-re-remap to change the caching status of a subset of
> > the decoder's memory once we find out what the framebuffer offset is inside
> > the original iremap_nocache'd area, then its a no go for write combining to
> > the framebuffer with PAT.
> 
> No what if the framebuffer driver is just requested as a secondary step
> after firmware loading?

Its a possibility. The decoder firmware gets loaded at the beginning of the decoder
memory range and we know its length, so its possible to ioremap_nocache enough 
room for the firmware only on init and then ioremap the remaining non-firmware
decoder memory areas appropriately after the firmware load succeeds...
 
> > > On the other hand, it works fine for me with a nocache'd framebuffer. It's
> > > certainly better for me personally to have a nocache framebuffer with
> > > PAT-enabled than the framebuffer completely disabled with PAT-enabled, but I
> > > don't think I would even propose to rollback the x86 nopat requirement in
> > > general. Apparently the throngs of people using this super-popular driver
> > > feature haven't complained in the last couple years, so maybe its OK for me
> > > to just patch the pat-enabled guard out and deal with a nocache'd
> > > framebuffer.
> > 
> > Nope, best you add a feature to just let you disable wc stuff, to enable
> > life with PAT.

I'm not sure I understand what you mean.

Perhaps the easy answer is to change the fatal is-pat-enabled check to just a
warning like "you have PAT enabled, so wc is disabled for the framebuffer. 
if you want wc, use the nopat parameter"?

- Nick
