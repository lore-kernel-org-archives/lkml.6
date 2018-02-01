Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeBAGN0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 01:13:26 -0500
Received: from mail-by2nam01on0082.outbound.protection.outlook.com ([104.47.34.82]:51424
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750979AbeBAGNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 01:13:25 -0500
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
Thread-Index: AQHTmNtYoBUw/9kRPkGbswRNbnupYaOLC3EAgAClcwCAAFzmgIAAEfKAgAAV3oCAAAQIgIAAIG6AgAEekqCAAZy+UA==
Date: Thu, 1 Feb 2018 06:13:20 +0000
Message-ID: <MWHPR1201MB0127CEE71F679F43BF0D25B6FDFA0@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
 <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <20180130075553.GM21609@dhcp22.suse.cz>
 <9060281e-62dd-8775-2903-339ff836b436@amd.com>
 <20180130101823.GX21609@dhcp22.suse.cz>
 <7d5ce7ab-d16d-36bc-7953-e1da2db350bf@amd.com>
 <20180130122853.GC21609@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0158;7:1b4fVb3QQvbmTXOsCMPbGA3jAHDWG+KwJYpyGYmWw1D5X/3dPAA9BnrKaKzd8E0+0Q6cEvkQRGN7HWh5ARMw1iV/Q+X0/vdjHSxKqAozfPfpFfJb0ewtRM6HyCiIe3/nYmvC3+sToZQR2/NPB01Y28xw532HgaCbPZdn4+BpdJRwgFnzVOXl2ggL/rUt/vpz/DhjyMfSfbARzoDHASlkjxbfUchGOY/d6P6PT6tjbT+gi4n1hgIR1iIUj0OgU8pf;20:edPqweWTLNKIhK2q1JEGP0dAvgV7+WgZcRngtrOYN5dx4UOgMynDuyqGf/pOiurvhohn6q/Xue5Dbf0TKfObp4pl5XccUMfsIB/ykRsVfYNmORA/h8fojYbDFOnVqA1WJRlmpCpqpMsy02J83Wy4J8xNOVYnMU7ANnCY54jRo4xb9YuJUyCtDbD7lNkrfE+IdF2drOJUL22IYGgPIzZ2+8poHa79gNu0bv/qvmwk2YhYq9ngHrso5lfEoXTFKlBp
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(377424004)(13464003)(54906003)(7696005)(6636002)(7736002)(55016002)(9686003)(105586002)(316002)(8936002)(106356001)(81156014)(3846002)(110136005)(8676002)(229853002)(72206003)(77096007)(33656002)(81166006)(478600001)(2906002)(59450400001)(93886005)(68736007)(53936002)(6116002)(3280700002)(86362001)(2900100001)(3660700001)(186003)(4326008)(26005)(97736004)(25786009)(66066001)(14454004)(99286004)(6506007)(74316002)(76176011)(305945005)(53546011)(6436002)(5660300001)(6246003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0158;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 397099ef-9138-4ae7-1866-08d5693ae4ec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB0158;
x-ms-traffictypediagnostic: MWHPR1201MB0158:
x-microsoft-antispam-prvs: <MWHPR1201MB0158471727E0083C6A9DF819FDFA0@MWHPR1201MB0158.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR1201MB0158;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0158;
x-forefront-prvs: 0570F1F193
x-microsoft-antispam-message-info: NOVVrOwDXyr+FqnQrkAfnQEjOKgGqeBJDeBQMLuWadiFxu+S7gXegq6PvhzqP1c39c/0HHaEaxePbfq5j5FVbw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397099ef-9138-4ae7-1866-08d5693ae4ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 06:13:21.0303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w116DZJW003241

Hi Michal:

How about only  
EXPORT_SYMBOL_GPL(total_swap_pages) ?

Thanks
Roger(Hongbo.He)

-----Original Message-----
From: He, Roger 
Sent: Wednesday, January 31, 2018 1:52 PM
To: 'Michal Hocko' <mhocko@kernel.org>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org
Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages

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
