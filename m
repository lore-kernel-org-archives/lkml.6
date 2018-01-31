Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeAaFwc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 00:52:32 -0500
Received: from mail-by2nam01on0055.outbound.protection.outlook.com ([104.47.34.55]:19746
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751677AbeAaFwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 00:52:30 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: Michal Hocko <mhocko@kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Topic: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Index: AQHTmNtYoBUw/9kRPkGbswRNbnupYaOLC3EAgAClcwCAAFzmgIAAEfKAgAAV3oCAAAQIgIAAIG6AgAEekqA=
Date: Wed, 31 Jan 2018 05:52:26 +0000
Message-ID: <MWHPR1201MB0127ECADF14022B0A383081EFDFB0@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
 <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <20180130075553.GM21609@dhcp22.suse.cz>
 <9060281e-62dd-8775-2903-339ff836b436@amd.com>
 <20180130101823.GX21609@dhcp22.suse.cz>
 <7d5ce7ab-d16d-36bc-7953-e1da2db350bf@amd.com>
 <20180130122853.GC21609@dhcp22.suse.cz>
In-Reply-To: <20180130122853.GC21609@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB2559;7:jcrC8MpkwYm3iW30VtZO61sMXpAy9u8boW1ZybYFBNZa70vuGEjTGE7OWbFrgT9+loJErMu3wyaihMTc2GlVtsTNMXeat9RPzL69UkfXyO/9nByiFnRKzF3FnaHk86DRbOhuo5X9rZkaMrX8Z/xSW+CIVizWQbSBwgG8Jxo9hh4Jnx8F6hk779aOZqZM7Xol8q08sWtnI1xeqVUl1F4H/As+rawBiuJ0NRI4QRUFGOMWqvJHprz+VkvGuO0uAmpe;20:v5DsjRY8tB+8OnAeWzltne2eSyw28G8DocD8dAfdw9cnwRyl/jobzE5NZ4XL8ECqkDFuyIHIT7/M/jQY8VDO2n7eqq31xj/Kpw1mlFa65o1ogIeINjGBOb91AijIYEZEXaQTGNQipSamYj7F+XC3oN0oXb9AGqgbXkKxDRD0rqwpS85xOFBsVhMHD7ByYeylpFoqig09A5FQIViaoWkeoxTPoF/2YM0U7osMtIUeMD46yxiffG/W41R+KOZgjE1m
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(396003)(39380400002)(377424004)(13464003)(189003)(199004)(86362001)(3280700002)(54906003)(105586002)(110136005)(26005)(6246003)(14454004)(97736004)(93886005)(186003)(316002)(3660700001)(7696005)(59450400001)(4326008)(77096007)(72206003)(99286004)(478600001)(76176011)(25786009)(66066001)(102836004)(106356001)(55016002)(2906002)(53546011)(6506007)(2900100001)(6116002)(7736002)(305945005)(74316002)(3846002)(8676002)(8936002)(81156014)(81166006)(6636002)(9686003)(2950100002)(33656002)(5660300001)(53936002)(68736007)(229853002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2559;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48bf06e1-62b5-49ab-6b8c-08d5686ecec6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB2559;
x-ms-traffictypediagnostic: MWHPR1201MB2559:
x-microsoft-antispam-prvs: <MWHPR1201MB2559EFEC6CC7B84AEB4987F4FDFB0@MWHPR1201MB2559.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR1201MB2559;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2559;
x-forefront-prvs: 056929CBB8
x-microsoft-antispam-message-info: GnK71ZnkSoDUoRSEhs9AlX06l8Nl6S5X5QoaXLxrewFYMKEj65AhdjXN8us3jAXwRugqTlUJ8xYGMf2E7T7oLg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bf06e1-62b5-49ab-6b8c-08d5686ecec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2018 05:52:26.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2559
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0V5qadA004169

	I do think you should completely ignore the size of the swap space. IMHO you should forbid further allocations when your current 	buffer storage cannot be reclaimed. So you need some form of feedback mechanism that would tell you: "Your buffers have 	grown too much". If you cannot do that then simply assume that you cannot swap at all rather than rely on having some portion 	of it for yourself. 

If we assume the swap cache size is zero always, that is overkill for GTT size actually user can get. And not make sense as well I think.

	There are many other users of memory outside of your subsystem. Any scaling based on the 50% of resource belonging to me is 	simply broken.

And that is only a threshold to avoid  overuse  rather than really reserved to TTM at the start. In addition, for most cases TTM only uses a little or not use swap disk at all. Only special test case use more or probably that is intentional.


Thanks
Roger(Hongbo.He)

-----Original Message-----
From: Michal Hocko [mailto:mhocko@kernel.org] 
Sent: Tuesday, January 30, 2018 8:29 PM
To: Koenig, Christian <Christian.Koenig@amd.com>
Cc: He, Roger <Hongbo.He@amd.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages

On Tue 30-01-18 11:32:49, Christian König wrote:
> Am 30.01.2018 um 11:18 schrieb Michal Hocko:
> > On Tue 30-01-18 10:00:07, Christian König wrote:
> > > Am 30.01.2018 um 08:55 schrieb Michal Hocko:
> > > > On Tue 30-01-18 02:56:51, He, Roger wrote:
> > > > > Hi Michal:
> > > > > 
> > > > > We need a API to tell TTM module the system totally has how 
> > > > > many swap cache.  Then TTM module can use it to restrict how 
> > > > > many the swap cache it can use to prevent triggering OOM.  For 
> > > > > Now we set the threshold of swap size TTM used as 1/2 * total 
> > > > > size and leave the rest for others use.
> > > > Why do you so much memory? Are you going to use TB of memory on 
> > > > large systems? What about memory hotplug when the memory is added/released?
> > > For graphics and compute applications on GPUs it isn't unusual to 
> > > use large amounts of system memory.
> > > 
> > > Our standard policy in TTM is to allow 50% of system memory to be 
> > > pinned for use with GPUs (the hardware can't do page faults).
> > > 
> > > When that limit is exceeded (or the shrinker callbacks tell us to 
> > > make room) we wait for any GPU work to finish and copy buffer 
> > > content into a shmem file.
> > > 
> > > This copy into a shmem file can easily trigger the OOM killer if 
> > > there isn't any swap space left and that is something we want to avoid.
> > > 
> > > So what we want to do is to apply this 50% rule to swap space as 
> > > well and deny allocation of buffer objects when it is exceeded.
> > How does that help when the rest of the system might eat swap?
> 
> Well it doesn't, but that is not the problem here.
> 
> When an application keeps calling malloc() it sooner or later is 
> confronted with an OOM killer.
> 
> But when it keeps for example allocating OpenGL textures the 
> expectation is that this sooner or later starts to fail because we run 
> out of memory and not trigger the OOM killer.

There is nothing like running out of memory and not triggering the OOM killer. You can make a _particular_ allocation to bail out without the oom killer. Just use __GFP_NORETRY. But that doesn't make much difference when you have already depleted your memory and live with the bare remainings. Any desperate soul trying to get its memory will simply trigger the OOM.

> So what we do is to allow the application to use all of video memory + 
> a certain amount of system memory + swap space as last resort fallback (e.g.
> when you Alt+Tab from your full screen game back to your browser).
> 
> The problem we try to solve is that we haven't limited the use of swap 
> space somehow.

I do think you should completely ignore the size of the swap space. IMHO you should forbid further allocations when your current buffer storage cannot be reclaimed. So you need some form of feedback mechanism that would tell you: "Your buffers have grown too much". If you cannot do that then simply assume that you cannot swap at all rather than rely on having some portion of it for yourself. There are many other users of memory outside of your subsystem. Any scaling based on the 50% of resource belonging to me is simply broken.
--
Michal Hocko
SUSE Labs
