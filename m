Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBAOxs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:53:48 -0500
Received: from mail-bn3nam01on0047.outbound.protection.outlook.com ([104.47.33.47]:17710
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751408AbeBAOxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:53:45 -0500
Authentication-Results: spf=pass (sender IP is 208.19.100.21)
 smtp.mailfrom=microsemi.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=microsemi.com;
From: Don Brace <don.brace@microsemi.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Laurence Oberman <loberman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: RE: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
Thread-Topic: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
Thread-Index: AQHTjs3qJPDyyguhzEycLfUKgVSRx6N2miwAgBk9+ID//+LykA==
Date: Thu, 1 Feb 2018 14:53:35 +0000
Message-ID: <35e74f9ae47b4b5db8ee4bf3a8989e82@microsemi.com>
References: <20180115160345.2611-1-ming.lei@redhat.com>
 <20180115174036.GA20191@infradead.org> <20180116013043.GA3213@ming.t460p>
 <alpine.DEB.2.20.1801161223500.1823@nanos>
 <1516109317.9574.1.camel@redhat.com>
 <a6086631efd54749a298add3d6b9a134@microsemi.com>
 <20180201103651.GA29263@ming.t460p>
In-Reply-To: <20180201103651.GA29263@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.34.7]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:208.19.100.21;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(39380400002)(376002)(2980300002)(438002)(199004)(13464003)(189003)(77096007)(24736004)(336011)(81156014)(68736007)(6116002)(2950100002)(69596002)(93886005)(54906003)(8746002)(59450400001)(316002)(108616005)(229853002)(53416004)(76176011)(5660300001)(81166006)(3846002)(26005)(186003)(8936002)(102836004)(8676002)(106002)(86362001)(6916009)(53546011)(47776003)(2900100001)(106466001)(50466002)(36756003)(4326008)(6246003)(97736004)(53936002)(14454004)(356003)(7736002)(305945005)(2906002)(23756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR02MB136;H:avsrvexchhts1.microsemi.net;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD011;1:y/aaYnR8P6dhB9s9ChvJKXVK7Un2Yty8JvfHuSyA711QZLEhDPlIr2ItXe6SztrDWv+Bk3gMG+4Ky1ixpByIXbtiIhIIO8budhilLSZkdAb/klcl+bnlfHk8z8Ah+GsE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d07bcd1-8432-4efe-414e-08d5698395c1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060)(7193020);SRVR:BN1PR02MB136;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB136;3:m38UwLscH6MzANMN/an7VbwQpmX3ouk+xi72vkFBXmOykyQWfSUwUxCQXjuSfO8omYpZWXE7vQ6D2jnkt6NFPEa2YHothoiziJ7Sm+X5yukShUSUlRPOMB7NUplN2gyYDUtIPmOuI3P9l719ImRGQQvAnr8zLhvFpjaTug8sZCbKmzE6JgbvEm6pBmjTAlMpoX8tq78UMjcwnQEP6WM0Mysg0dAidmgo7a9obEHUHdxeI6Xe30tL4SGTWZO14Wsoc6JF1izoIfQZE8BGfsIKbMo2JmnqfY+fLRQNyDBQ/FufwcPs9qO1Wp1a1k5phakqb6xQskrilDJ/hdy/s1+Hvrh75t5oOSZ0feadhmd0Dc0=;25:3BK28i12sGUeC2Kn/44+b4ZXjJ+xqJPwRdRgRaSMHft5IDw023fR17TRfR0TeUfBO9eEY3viU0qAboD+lKyMokMvUeAgti9WyrG2rOn+IFaDXjLwxHF8S1DuJFhb85oygSxq2tIwFTCaqjCJU1GDFlE4yvmi0z288+/W2zoo3xtyGFibsSdlfwLkB3Xcj/esJBzf0pDH8ihOCvLQaeepbN6Lj46CF88oW3QsfFtP5r6+gpBpKWjxHzO8kGt3tE0M41oA9TO7LaG0b55sSkROWsNiob0yWjecK0DIKO5L2H9bPycPV+ymH8UoM1+pnBpctssGX64NpTcilEnrTLdauQ==
X-MS-TrafficTypeDiagnostic: BN1PR02MB136:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB136;31:RjQNw/VleBzHBHmb6iuExDq2b1PP7INgmtQc969HuTxCKc8P73kqCb4hJA/7csdGv7pYN9WkCwNnkGjwQZlyT61UI31AehuVGzSJwLVR40WrfCt6cls7VcUzhJsIRRNAxFWsoUJHqRj82rf37H8VBFfR9YIYjlazq+qefeJZ89P/nUE0vhasoNl/iz0N+GZiq1QmIhL7zW3CMy0unInf07lBeclVTmyeTZtXQQhcL3w=;20:UyHi4PM3TSYy/LVmVC/SalwB1iT1HK2QvqYClGqs0UmU0ToAr2vewswU7R4/THRwGhpWkh/EMt6Li8LLjZv7j6OO3KxXUEWZvA3PjTxXurGBwt0k4DgHANk2+NFhJq80JTgqmC93Jrtc6rXUuiG6deJ06GO4D3jSc73ScQlgnWxddY8rB2cIsaLsZp8fyq2vFgzdPDM+vHk87hXKnC+pjtZDlZk6xCP1gtsaaGg4MoudXQMgHUvX2GSMSoTW+iJA6DDBLHSMzqHvzON4HSRt7z8B+xKRH81xsLZzW/K1H1MB6/mfHNTVuZky4TfamWDJIZ3PHLpJzvwQRG5XUmuIxuw98HA+FtmMlmd99Wj8dFXwe6RGghSVr0gDsNqZZJgw7pHLVY0+IJeU1HlP8WBzAXNA2qzm95u8imlnfChmp3Sif2Gaf+Mx/mUW0BnDA/T1HePfaTf1vn/brqgpjB6516BQK9swALUMsoFQ/k8vTzcRVkqriEmHBzrXSNTMmNZuL9oBsvB2MIUQkZTI0iD5RPNJ9NiUjPOCXtXDOOFoV8HJ9AOddfozCRpoopBS2dPEKnGiVcvJlKZ0hRm1iK5e9LF9I2GMGmqiogBJhdxYCv0=
X-Microsoft-Antispam-PRVS: <BN1PR02MB1363E7463C902AA8ED01F65E1FA0@BN1PR02MB136.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(9452136761055)(67672495146484)(72170198267865);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231101)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN1PR02MB136;BCL:0;PCL:0;RULEID:;SRVR:BN1PR02MB136;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB136;4:zjzKBepMrUw3hbTIngJu7oYlPTETQu8nyBKvUKFLuOuGxWxEBv00wOFJfXHeJ7HJT5ZOraj2AtSGSauQ+qQvMO1bBkD+NXgzUD7HQObJL6gFPB+A9d0JiRYGC2LJl0x8GbwE0lPZ2cq56RvDJhOKKSjceXb+HqswNWg0aTJ6JY1teAD7rta0WaJLNTL6/PTFK/NQcc/HXKFnQMlJmjJ1SrDhFJzkq1PQyNGjHYxsGoZo3FRqvzOCEUmnLazF5M2oL6doXzLAuyDGu2bpH2zZ9QTL4AX6hqUwu4HdmLz0433//REFNv13SVQGf7jWGYd89i/17bGSEvbTDUYd4iEw97WVzpcVJ+42NFvZjLpvSDSwVOJXB1Sz57fUJBw30Ojc9LPmZObAIQZJ1HCGCES6iCFakaFBmGm+nawH8nafPiQ=
X-Forefront-PRVS: 0570F1F193
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN1PR02MB136;23:Ku7Sk418RwO4+pgR74UIGTBRUqldfPyMWtIzJdBy?=
 =?iso-8859-1?Q?Jr5i6SXke2LR7b72asw5OVDYRb6WwvE5PDxfZDl+fRXnSJVtjcrJMrdRdM?=
 =?iso-8859-1?Q?1NlDSqmbXsIOx+AaAaYPSWZRDTKS3v9P2TQ+y3MYHVAlyl4goMsqWRQtPN?=
 =?iso-8859-1?Q?qW199bi3LKbwyid02AqKzUff9U2OVIZr4AS9cjU4mB6vgVvRR8XKZNi6sX?=
 =?iso-8859-1?Q?Sjsk/gc7ghjaUDVvGxhmBt+G7ueaXq0mfBLzSpcsx3tblL6kNwudkLu/Ll?=
 =?iso-8859-1?Q?vU3EitozTXYO/AOP9Ei1dQXxY7Z5QAhxciSgBrDtsgCwhCyB6J4ZJ18uJX?=
 =?iso-8859-1?Q?N3da+h/km5Y6s16tszWica2WM9k6pqs8Xt1NHXwu4rqUBTa0EBjNQMt7Ra?=
 =?iso-8859-1?Q?zvPIE33d9A1UX8tKf7bQRFqz8BxejEhHh1GwiH0gTWHvEwUDVffAQ++kk9?=
 =?iso-8859-1?Q?HhUhiVlrTFJ2ZGuyZ906tos9EWXQHn0ZgVSsaaU6mLfKjUVpHPnO9fKsoa?=
 =?iso-8859-1?Q?esjxoZYRhYsmqxaEzlmZgt1+bEb0828xMvOVTSJKd5b+XCFTWHq4iI0I7W?=
 =?iso-8859-1?Q?goiAKGnFCDSgX53j+oozKFSEbdBxjx9RJdhi/dXdhw4z5HHkXDoA/BaqHr?=
 =?iso-8859-1?Q?9chIr9Y+tu8YkF1D92DrvO3tqgPtdZGAupu2pa6TyEFQ8sPCrXVELjXKlo?=
 =?iso-8859-1?Q?fyI4DR7NCHt71X7GPZxf6sqW0HRjl1lOlyBcFTbYF1kIIPlNkn16PitBTg?=
 =?iso-8859-1?Q?XAtHb0KvlVj98sMXiS7thJdiUuHzdpmLnXJX+Svq0wxY4xztpqUXUY9Xig?=
 =?iso-8859-1?Q?dhjWh83V8P5DYC/USK2B801gtWc+z0dhCOpGN3OhBadzQRSoKWqGjEY19T?=
 =?iso-8859-1?Q?rpcytWmUNW86joAixVRlrpIUKz44p+EB91HFNSVMAmqtodhSuLKlvrVX6P?=
 =?iso-8859-1?Q?5G6eaAiYTRGKVSvNdD/nBGcRi/bs1HGrhkvGzm8l04IXuIvlDkafCOKibb?=
 =?iso-8859-1?Q?aFLF0UzVaufYz/rtzxfJ3YFW4b6i6gu9N7YqUZ71s7CFWLNc23yMYC+G13?=
 =?iso-8859-1?Q?eE3loJss4Yl2vkTjvvPXE7iAs1F+pjYX11GKAO7DufHp33fmQWhymiEl+q?=
 =?iso-8859-1?Q?J2XuNgBPkmaMiy4kWyV6/gK6/u8/6YuvFEKFJtfmxhK/TBS/Tlob33nflI?=
 =?iso-8859-1?Q?ObzzpWAQoAzYoMjqu5bpITBEOuJjNajNtuskeg91UoDJUr4FuZvSSJmjus?=
 =?iso-8859-1?Q?XbNfdfvZtQr9UE1R/1vsLwD2b0vBOXbXjyqySn7EKkFx+QWxsZQw4N3v0J?=
 =?iso-8859-1?Q?A=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB136;6:Q6LJFyqKPtIG8UzaFxeq4qQNazH8xHTjsQ6RRykZbQMks7qQHxm9kNN8S7f2+OJ7CsPOI56Q946BCm6BmpwUQu+BVmy/d0J6MkirKF0D1u+2c8Gpb2UzP8jrMdOypFHjesJigREBqXTUtf5y2jeA9g0DT2OKuaY+FzQKc3+5qrgA0u0lJuACCLupUChAdKDWxfEAqy6w8QUYLcQem9XSr1XgW6UKq4TDnNWZmZ97mJEaUdv8EkX9KkY4MbqhuTJhh+y2RN0snOTM+kmboICpnveIDZMHm9jVTA70p3suhUt0JYHMqp4pR80tOFTw7flH5LJj7VMy5n+QvrIm4G+Oyq7v/gwnxoCkEnp22YwAks8=;5:u+0yry6TzkXlncmbx2onrwP7bIgmEt4gNGS1nG5mxBpc4OU0JHWpZpoxSsclHNSiostVo0tVwb6sZw7ZKnTMtq+xzpBEZrXnbFRRnS3RYPML4zhi0bdPuUzyNgdigr5svX+cn/UDAN8rNdKd9srSIQYIg5/l3Fw/dRbopHF/KZ8=;24:eHdAzlOiNNX1wnlXTPgqR5jLOaplXfPCaCAAyugshuw00ggopRnbKU8V3/NHvsYwriB0rDkrA84WY2MdzJBt3PQuH4BDhopvoKTVTa4aU8g=;7:gCt17YMocKCHzwZDkgf3DLImP2I09nVVPNENTCVxX2GvjQ4jUXH1TbbPpnDbbs5JTDeDSkoxvOBYtZzQjvBjQrBqNnGy9swDCzhhTDzmvdyg/zoblTAAZm/4q4X1g/UW3DgECWZSjldeuQGigySLBzHeNwwxdXVjOHoJzoauIV+t9J7c4FYbyv0FWliPVwHQytZwyZhBBqJftbnJ1WDRm6icAw8btRF3rBLpZX0vcDeOLXlLamxCJxsIHttWQh17
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 14:53:41.3307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d07bcd1-8432-4efe-414e-08d5698395c1
X-MS-Exchange-CrossTenant-Id: f267a5c8-86d8-4cc9-af71-1fd2c67c8fad
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f267a5c8-86d8-4cc9-af71-1fd2c67c8fad;Ip=[208.19.100.21];Helo=[avsrvexchhts1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR02MB136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11Erq3Q027281

> -----Original Message-----
> From: Ming Lei [mailto:ming.lei@redhat.com]
> Sent: Thursday, February 01, 2018 4:37 AM
> To: Don Brace <don.brace@microsemi.com>
> Cc: Laurence Oberman <loberman@redhat.com>; Thomas Gleixner
> <tglx@linutronix.de>; Christoph Hellwig <hch@infradead.org>; Jens Axboe
> <axboe@fb.com>; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> Mike Snitzer <snitzer@redhat.com>
> Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is assgined
> to irq vector
> 
> EXTERNAL EMAIL
> 
> 
> On Tue, Jan 16, 2018 at 03:22:18PM +0000, Don Brace wrote:
> > > -----Original Message-----
> > > From: Laurence Oberman [mailto:loberman@redhat.com]
> > > Sent: Tuesday, January 16, 2018 7:29 AM
> > > To: Thomas Gleixner <tglx@linutronix.de>; Ming Lei <ming.lei@redhat.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>; Jens Axboe <axboe@fb.com>;
> > > linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; Mike Snitzer
> > > <snitzer@redhat.com>; Don Brace <don.brace@microsemi.com>
> > > Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
> assgined
> > > to irq vector
> > >
> > > > > It is because of irq_create_affinity_masks().
> > > >
> > > > That still does not answer the question. If the interrupt for a queue
> > > > is
> > > > assigned to an offline CPU, then the queue should not be used and
> > > > never
> > > > raise an interrupt. That's how managed interrupts have been designed.
> > > >
> > > > Thanks,
> > > >
> > > >       tglx
> > > >
> > > >
> > > >
> > > >
> > >
> > > I captured a full boot log for this issue for Microsemi, I will send it
> > > to Don Brace.
> > > I enabled all the HPSA debug and here is snippet
> > >
> > >
> > > ..
> > > ..
> > > ..
> > >   246.751135] INFO: task systemd-udevd:413 blocked for more than 120
> > > seconds.
> > > [  246.788008]       Tainted: G          I      4.15.0-rc4.noming+ #1
> > > [  246.822380] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  246.865594] systemd-udevd   D    0   413    411 0x80000004
> > > [  246.895519] Call Trace:
> > > [  246.909713]  ? __schedule+0x340/0xc20
> > > [  246.930236]  schedule+0x32/0x80
> > > [  246.947905]  schedule_timeout+0x23d/0x450
> > > [  246.970047]  ? find_held_lock+0x2d/0x90
> > > [  246.991774]  ? wait_for_completion_io+0x108/0x170
> > > [  247.018172]  io_schedule_timeout+0x19/0x40
> > > [  247.041208]  wait_for_completion_io+0x110/0x170
> > > [  247.067326]  ? wake_up_q+0x70/0x70
> > > [  247.086801]  hpsa_scsi_do_simple_cmd+0xc6/0x100 [hpsa]
> > > [  247.114315]  hpsa_scsi_do_simple_cmd_with_retry+0xb7/0x1c0 [hpsa]
> > > [  247.146629]  hpsa_scsi_do_inquiry+0x73/0xd0 [hpsa]
> > > [  247.174118]  hpsa_init_one+0x12cb/0x1a59 [hpsa]
> >
> > This trace comes from internally generated discovery commands. No SCSI
> devices have
> > been presented to the SML yet.
> >
> > At this point we should be running on only one CPU. These commands are
> meant to use
> > reply queue 0 which are tied to CPU 0. It's interesting that the patch helps.
> >
> > However, I was wondering if you could inspect the iLo IML logs and send the
> > AHS logs for inspection.
> 
> Hello Don,
> 
> Now the patch has been merged to linus tree as:
> 
> 84676c1f21e8ff54b ("genirq/affinity: assign vectors to all possible CPUs")
> 
> and it breaks Laurence's machine completely, :-(
> 
> I just take a look at HPSA's code, and found that reply queue is chosen
> in the following way in most of code path:
> 
>         if (likely(reply_queue == DEFAULT_REPLY_QUEUE))
>                 cp->ReplyQueue = smp_processor_id() % h->nreply_queues;
> 
> h->nreply_queues is the msix vector number which is returned from
> pci_alloc_irq_vectors(), and now some of vectors may be mapped to all
> offline CPUs, for example, one processor isn't plugged to socket.
> 
> If I understand correctly, 'cp->ReplyQueue' is aligned to one irq
> vector, and the command is expected by handled via that irq vector,
> is it right?
> 
> If yes, now I guess this way can't work any more if number of online
> CPUs is >= h->nreply_queues, and you may need to check the cpu affinity
> of one vector before choosing the reply queue, and block/blk-mq-pci.c
> may be helpful for you.
> 
> Thanks,
> Ming

Thanks Ming,
I start working up a patch.
