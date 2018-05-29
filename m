Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936921AbeE2QzR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:55:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935486AbeE2QzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:55:15 -0400
From: Song Liu <songliubraving@fb.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Song Liu <liu.song.a23@gmail.com>, Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, "Kernel Team" <Kernel-team@fb.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
Thread-Topic: WARNING and PANIC in irq_matrix_free
Thread-Index: AQHT9GSPvVlQSgBGI0+pRnF2w/wY8aRE+2SAgACA+QCAABp+gIAAM+8AgACcbQCAAIuNAA==
Date: Tue, 29 May 2018 16:54:59 +0000
Message-ID: <7954157A-E523-4041-825B-828A3A38E51B@fb.com>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
 <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com>
 <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de>
 <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com>
 <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
 <09A22A95-6BBD-48EB-A2FE-42BF6244F751@fb.com>
 <alpine.DEB.2.21.1805282206440.1584@nanos.tec.linutronix.de>
 <3F47F523-64C5-422B-B9B0-73B8D105CF71@fb.com>
 <alpine.DEB.2.21.1805291031480.1685@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1805291031480.1685@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::4:40e8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1631;7:97sWd0OPcNwk3veg1tF3stnm5u2b40Q+vsoJt5CrqWc7Oy2OPrMawoym+35vxT7i21qWlVrqEargT+FynELn6t2EavKWfmc9Jwz20SgZhSvJC/vHdkT/F4ZNoQKbbCeAuKQVGTbzfTZfrEyUZRUzJOOYINoS73nagCph/Z+HTBsO6FothE0HCLzTH2tRW1rwbz+2t6ZOjDTWgZ4ukN8cXlV55xATd3Ibb5Xtrg+v8tChwt7aK8lcRLoCds/Xs2w+;20:pXMtjnlTIw1yrs32pjAsi1h6jRnXn3cZUA4E9zX3KwKl/wYJspQW/p7QRSD10n+ZjFTKcmWTf9m3varen3oYX+sBy8HuQGHZDOwkTKBh7CTBlMFFmcA1XImwNWngdOAIG9Eh+Q+rfqrnkV1oQ96dNHUz2pnh+JxREnrQKQgc37U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1631;
x-ms-traffictypediagnostic: MWHPR15MB1631:
x-microsoft-antispam-prvs: <MWHPR15MB163146E051FE6AF874528027B36D0@MWHPR15MB1631.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1631;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1631;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39380400002)(376002)(39860400002)(199004)(189003)(2906002)(6512007)(2616005)(446003)(39060400002)(11346002)(6116002)(229853002)(33656002)(6486002)(486006)(5250100002)(53946003)(76176011)(6506007)(6436002)(5890100001)(53546011)(102836004)(478600001)(4326008)(14454004)(476003)(3660700001)(99286004)(7736002)(53936002)(59450400001)(106356001)(105586002)(2900100001)(46003)(3280700002)(25786009)(57306001)(68736007)(305945005)(36756003)(186003)(50226002)(97736004)(8676002)(5660300001)(6916009)(81166006)(81156014)(93886005)(54906003)(6246003)(8936002)(316002)(86362001)(82746002)(83716003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1631;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jINbYZVCbNt/gREr6hqoc0nLmCJFJYHN7d8LmwzgaGsX6lT74O/mgdC1dxZVChUrCHoEQ+CmaMEHDkzHZCJAsh47xqatVRrws+wxll8EsoHYFVoRzXssOY8P6w8TWGpZBqG9Xfx7URxjDajFZqO3zavubkDbj3/oXTbsP9iqspIY2EKn9KJEhpi/DBm3hn4r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32919D25A0BD8C44AC747BB8326A27C3@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4b7f04bd-8193-4c7a-b9cc-08d5c584ea68
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7f04bd-8193-4c7a-b9cc-08d5c584ea68
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 16:54:59.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1631
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TGtPJm008654



> On May 29, 2018, at 1:35 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Mon, 28 May 2018, Song Liu wrote:
>>> On May 28, 2018, at 1:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> 
>>> On Mon, 28 May 2018, Song Liu wrote:
>>>> This doesn't fix the issue with bnxt. Here is a trace with this patch:
>>> 
>>> That's just the backtrace which is not really helpful. The real question is
>>> what leads to this scenaria.
>>> 
>>> What I was asking for is to enable the irq_vector and irq_matrix trace
>>> points along with ftrace_dump_on_oops. The latter dumps the trace buffer
>>> when the problem happens and that should give us a hint what actually
>>> causes that.
>> 
>> Attached is the dump I got. It seems pretty noisy, with many message lost.
>> 
>> Maybe we cannot enable all trace points under irq_vectors/ and irq_matrix.
> 
> Right. Sorry, I forgot to say that we only need the irq_vectors ones which
> are related to vector allocation, i.e.: irq_vectors/vector_* 
> 
> Thanks,
> 
> 	tglx

Here is the ftrace dump:

[ 1609.472697]    <...>-53363  19d... 1610359225us : vector_deactivate: irq=29 is_managed=0 can_reserve=1 reserve=0
[ 1609.472698]    <...>-53363  19d... 1610359229us : vector_clear: irq=29 vector=33 cpu=21 prev_vector=0 prev_cpu=0
[ 1609.472699]    <...>-53363  19d... 1610359230us : irq_matrix_free: bit=33 cpu=21 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11239, global_rsvd=23, total_alloc=17
[ 1609.472699]    <...>-53363  19d... 1610359231us : irq_matrix_reserve: online_maps=56 global_avl=11239, global_rsvd=24, total_alloc=17
[ 1609.472700]    <...>-53363  19d... 1610359232us : vector_reserve: irq=29 ret=0
[ 1609.472700]    <...>-53363  19d... 1610359233us : vector_config: irq=29 vector=239 cpu=0 apicdest=0x00000000
[ 1609.472701]    <...>-53363  19d... 1610359242us : vector_deactivate: irq=30 is_managed=0 can_reserve=1 reserve=0
[ 1609.472701]    <...>-53363  19d... 1610359242us : vector_clear: irq=30 vector=33 cpu=11 prev_vector=0 prev_cpu=1
[ 1609.472701]    <...>-53363  19d... 1610359242us : irq_matrix_free: bit=33 cpu=11 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11240, global_rsvd=24, total_alloc=16
[ 1609.472702]    <...>-53363  19d... 1610359243us : irq_matrix_reserve: online_maps=56 global_avl=11240, global_rsvd=25, total_alloc=16
[ 1609.472702]    <...>-53363  19d... 1610359243us : vector_reserve: irq=30 ret=0
[ 1609.472703]    <...>-53363  19d... 1610359243us : vector_config: irq=30 vector=239 cpu=0 apicdest=0x00000000
[ 1609.472703]    <...>-53363  19d... 1610359248us : vector_deactivate: irq=31 is_managed=0 can_reserve=1 reserve=0
[ 1609.472703]    <...>-53363  19d... 1610359248us : vector_clear: irq=31 vector=33 cpu=20 prev_vector=0 prev_cpu=2
[ 1609.472704]    <...>-53363  19d... 1610359249us : irq_matrix_free: bit=33 cpu=20 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11241, global_rsvd=25, total_alloc=15
[ 1609.472704]    <...>-53363  19d... 1610359249us : irq_matrix_reserve: online_maps=56 global_avl=11241, global_rsvd=26, total_alloc=15
[ 1609.472705]    <...>-53363  19d... 1610359249us : vector_reserve: irq=31 ret=0
[ 1609.472705]    <...>-53363  19d... 1610359249us : vector_config: irq=31 vector=239 cpu=0 apicdest=0x00000000
[ 1609.472705]    <...>-53363  19d... 1610359255us : vector_deactivate: irq=32 is_managed=0 can_reserve=1 reserve=0
[ 1609.472706]    <...>-53363  19d... 1610359255us : vector_clear: irq=32 vector=33 cpu=9 prev_vector=0 prev_cpu=3
[ 1609.472707]    <...>-53363  19d... 1610359255us : irq_matrix_free: bit=33 cpu=9 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11242, global_rsvd=26, total_alloc=14
[ 1609.472707]    <...>-53363  19d... 1610359256us : irq_matrix_reserve: online_maps=56 global_avl=11242, global_rsvd=27, total_alloc=14
[ 1609.472708]    <...>-53363  19d... 1610359256us : vector_reserve: irq=32 ret=0
[ 1609.472708]    <...>-53363  19d... 1610359256us : vector_config: irq=32 vector=239 cpu=0 apicdest=0x00000000
[ 1609.472709]    <...>-53363  19d... 1610359261us : vector_deactivate: irq=33 is_managed=0 can_reserve=1 reserve=0
[ 1609.472709]    <...>-53363  19d... 1610359261us : vector_clear: irq=33 vector=33 cpu=18 prev_vector=0 prev_cpu=4
[ 1609.472710]    <...>-53363  19d... 1610359262us : irq_matrix_free: bit=33 cpu=18 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11243, global_rsvd=27, total_alloc=13
[ 1609.472710]    <...>-53363  19d... 1610359262us : irq_matrix_reserve: online_maps=56 global_avl=11243, global_rsvd=28, total_alloc=13
[ 1609.472711]    <...>-53363  19d... 1610359262us : vector_reserve: irq=33 ret=0
[ 1609.472711]    <...>-53363  19d... 1610359262us : vector_config: irq=33 vector=239 cpu=0 apicdest=0x00000000
[ 1609.472711]    <...>-53363  19d... 1610359268us : vector_deactivate: irq=34 is_managed=0 can_reserve=1 reserve=0
[ 1609.472712]    <...>-53363  19d... 1610359268us : vector_clear: irq=34 vector=34 cpu=7 prev_vector=0 prev_cpu=5
[ 1609.472712]    <...>-53363  19d... 1610359268us : irq_matrix_free: bit=34 cpu=7 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11244, global_rsvd=28, total_alloc=12
[ 1609.472713]    <...>-53363  19d... 1610359268us : irq_matrix_reserve: online_maps=56 global_avl=11244, global_rsvd=29, total_alloc=12
[ 1609.472713]    <...>-53363  19d... 1610359269us : vector_reserve: irq=34 ret=0
[ 1609.472713]    <...>-53363  19d... 1610359269us : vector_config: irq=34 vector=239 cpu=0 apicdest=0x00000000
[ 1609.472714]    <...>-53363  19d... 1610359279us : vector_deactivate: irq=35 is_managed=0 can_reserve=1 reserve=0
[ 1609.472714]    <...>-53363  19d... 1610359279us : vector_clear: irq=35 vector=33 cpu=26 prev_vector=0 prev_cpu=6
[ 1609.472715]    <...>-53363  19d... 1610359279us : irq_matrix_free: bit=33 cpu=26 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11245, global_rsvd=29, total_alloc=11
[ 1609.472715]    <...>-53363  19d... 1610359279us : irq_matrix_reserve: online_maps=56 global_avl=11245, global_rsvd=30, total_alloc=11
[ 1609.472715]    <...>-53363  19d... 1610359280us : vector_reserve: irq=35 ret=0
[ 1609.472716]    <...>-53363  19d... 1610359280us : vector_config: irq=35 vector=239 cpu=0 apicdest=0x00000000
[ 1609.472716]    <...>-53363  19d... 1610359285us : vector_deactivate: irq=36 is_managed=0 can_reserve=1 reserve=0
[ 1609.472717]    <...>-53363  19d... 1610359285us : vector_clear: irq=36 vector=33 cpu=10 prev_vector=0 prev_cpu=7
[ 1609.472717]    <...>-53363  19d... 1610359286us : irq_matrix_free: bit=33 cpu=10 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11246, global_rsvd=30, total_alloc=10
[ 1609.472718]    <...>-53363  19d... 1610359286us : irq_matrix_reserve: online_maps=56 global_avl=11246, global_rsvd=31, total_alloc=10
[ 1609.472718]    <...>-53363  19d... 1610359286us : vector_reserve: irq=36 ret=0
[ 1609.472718]    <...>-53363  19d... 1610359286us : vector_config: irq=36 vector=239 cpu=0 apicdest=0x00000000
[ 1609.472719]    <...>-53363  20d... 1610366617us : vector_activate: irq=29 is_managed=0 can_reserve=1 reserve=0
[ 1609.472719]    <...>-53363  20d... 1610366619us : vector_alloc: irq=29 vector=4294967268 reserved=1 ret=0
[ 1609.472719]    <...>-53363  20d... 1610366621us : irq_matrix_alloc: bit=33 cpu=7 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11245, global_rsvd=30, total_alloc=11
[ 1609.472720]    <...>-53363  20d... 1610366623us : vector_update: irq=29 vector=33 cpu=7 prev_vector=0 prev_cpu=21
[ 1609.472720]    <...>-53363  20d... 1610366623us : vector_alloc: irq=29 vector=33 reserved=1 ret=0
[ 1609.472721]    <...>-53363  20d... 1610366623us : vector_config: irq=29 vector=33 cpu=7 apicdest=0x00000010
[ 1609.472721]    <...>-53363  20d... 1610366629us : irq_matrix_alloc: bit=33 cpu=21 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11244, global_rsvd=30, total_alloc=12
[ 1609.472722]    <...>-53363  20d... 1610366629us : vector_update: irq=29 vector=33 cpu=21 prev_vector=33 prev_cpu=7
[ 1609.472723]    <...>-53363  20d... 1610366629us : vector_alloc: irq=29 vector=33 reserved=1 ret=0
[ 1609.472723]    <...>-53363  20d... 1610366630us : vector_config: irq=29 vector=33 cpu=21 apicdest=0x00000030
[ 1609.472724]    <...>-53363  20d... 1610366637us : irq_matrix_alloc: bit=35 cpu=0 online=1 avl=197 alloc=4 managed=0 online_maps=56 global_avl=11243, global_rsvd=30, total_alloc=13
[ 1609.472724]    <...>-53363  20d... 1610366637us : vector_update: irq=29 vector=35 cpu=0 prev_vector=33 prev_cpu=21
[ 1609.472725]    <...>-53363  20d... 1610366637us : vector_alloc: irq=29 vector=35 reserved=1 ret=0
[ 1609.472725]    <...>-53363  20d... 1610366638us : vector_config: irq=29 vector=35 cpu=0 apicdest=0x00000000
[ 1609.472725]    <...>-53363  20dN.. 1610366643us : vector_activate: irq=30 is_managed=0 can_reserve=1 reserve=0
[ 1609.472726]    <...>-53363  20dN.. 1610366644us : irq_matrix_alloc: bit=33 cpu=11 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11242, global_rsvd=29, total_alloc=14
[ 1609.472726]    <...>-53363  20dN.. 1610366644us : vector_update: irq=30 vector=33 cpu=11 prev_vector=0 prev_cpu=11
[ 1609.472727]    <...>-53363  20dN.. 1610366644us : vector_alloc: irq=30 vector=33 reserved=1 ret=0
[ 1609.472727]    <...>-53363  20dN.. 1610366644us : vector_config: irq=30 vector=33 cpu=11 apicdest=0x00000018
[ 1609.472727]    <...>-53363  20dN.. 1610366647us : vector_config: irq=30 vector=33 cpu=11 apicdest=0x00000018
[ 1609.472728]    <...>-53363  20dN.. 1610366650us : irq_matrix_alloc: bit=34 cpu=1 online=1 avl=199 alloc=2 managed=0 online_maps=56 global_avl=11241, global_rsvd=29, total_alloc=15
[ 1609.472728]    <...>-53363  20dN.. 1610366651us : vector_update: irq=30 vector=34 cpu=1 prev_vector=33 prev_cpu=11
[ 1609.472729]    <...>-53363  20dN.. 1610366651us : vector_alloc: irq=30 vector=34 reserved=1 ret=0
[ 1609.472729]    <...>-53363  20dN.. 1610366651us : vector_config: irq=30 vector=34 cpu=1 apicdest=0x00000002
[ 1609.472729]    <...>-53363  20dN.. 1610366654us : vector_activate: irq=31 is_managed=0 can_reserve=1 reserve=0
[ 1609.472730]    <...>-53363  20dN.. 1610366654us : vector_alloc: irq=31 vector=4294967268 reserved=1 ret=0
[ 1609.472730]    <...>-53363  20dN.. 1610366655us : irq_matrix_alloc: bit=33 cpu=9 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11240, global_rsvd=28, total_alloc=16
[ 1609.472731]    <...>-53363  20dN.. 1610366655us : vector_update: irq=31 vector=33 cpu=9 prev_vector=0 prev_cpu=20
[ 1609.472731]    <...>-53363  20dN.. 1610366656us : vector_alloc: irq=31 vector=33 reserved=1 ret=0
[ 1609.472731]    <...>-53363  20dN.. 1610366656us : vector_config: irq=31 vector=33 cpu=9 apicdest=0x00000014
[ 1609.472732]   <idle>-0       7d.h. 1610366658us : vector_free_moved: irq=29 cpu=21 vector=33 is_managed=0
[ 1609.472732]   <idle>-0       7d.h. 1610366660us : irq_matrix_free: bit=33 cpu=21 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11241, global_rsvd=28, total_alloc=15
[ 1609.472733]    <...>-53363  20dN.. 1610366662us : irq_matrix_alloc: bit=33 cpu=20 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11240, global_rsvd=28, total_alloc=16
[ 1609.472733]    <...>-53363  20dN.. 1610366662us : vector_update: irq=31 vector=33 cpu=20 prev_vector=33 prev_cpu=9
[ 1609.472734]    <...>-53363  20dN.. 1610366662us : vector_alloc: irq=31 vector=33 reserved=1 ret=0
[ 1609.472734]    <...>-53363  20dN.. 1610366662us : vector_config: irq=31 vector=33 cpu=20 apicdest=0x0000002c
[ 1609.472735]    <...>-53363  20dN.. 1610366666us : irq_matrix_alloc: bit=34 cpu=2 online=1 avl=199 alloc=2 managed=0 online_maps=56 global_avl=11239, global_rsvd=28, total_alloc=17
[ 1609.472735]    <...>-53363  20dN.. 1610366666us : vector_update: irq=31 vector=34 cpu=2 prev_vector=33 prev_cpu=20
[ 1609.472736]    <...>-53363  20dN.. 1610366666us : vector_alloc: irq=31 vector=34 reserved=1 ret=0
[ 1609.472736]    <...>-53363  20dN.. 1610366666us : vector_config: irq=31 vector=34 cpu=2 apicdest=0x00000004
[ 1609.472737]    <...>-53363  20dNh. 1610366669us : vector_free_moved: irq=31 cpu=20 vector=33 is_managed=0
[ 1609.472737]    <...>-53363  20dNh. 1610366670us : irq_matrix_free: bit=33 cpu=20 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11240, global_rsvd=28, total_alloc=16
[ 1609.472738]    <...>-53363  20dN.. 1610366671us : vector_activate: irq=32 is_managed=0 can_reserve=1 reserve=0
[ 1609.472739]    <...>-53363  20dN.. 1610366671us : irq_matrix_alloc: bit=34 cpu=9 online=1 avl=199 alloc=2 managed=0 online_maps=56 global_avl=11239, global_rsvd=27, total_alloc=17
[ 1609.472739]    <...>-53363  20dN.. 1610366671us : vector_update: irq=32 vector=34 cpu=9 prev_vector=0 prev_cpu=9
[ 1609.472739]    <...>-53363  20dN.. 1610366671us : vector_alloc: irq=32 vector=34 reserved=1 ret=0
[ 1609.472740]    <...>-53363  20dN.. 1610366672us : vector_config: irq=32 vector=34 cpu=9 apicdest=0x00000014
[ 1609.472740]    <...>-53363  20dN.. 1610366674us : vector_config: irq=32 vector=34 cpu=9 apicdest=0x00000014
[ 1609.472741]    <...>-53363  20dN.. 1610366678us : irq_matrix_alloc: bit=34 cpu=3 online=1 avl=199 alloc=2 managed=0 online_maps=56 global_avl=11238, global_rsvd=27, total_alloc=18
[ 1609.472741]    <...>-53363  20dN.. 1610366678us : vector_update: irq=32 vector=34 cpu=3 prev_vector=34 prev_cpu=9
[ 1609.472741]    <...>-53363  20dN.. 1610366679us : vector_alloc: irq=32 vector=34 reserved=1 ret=0
[ 1609.472742]    <...>-53363  20dN.. 1610366679us : vector_config: irq=32 vector=34 cpu=3 apicdest=0x00000006
[ 1609.472742]   <idle>-0      11d.h. 1610366680us : vector_free_moved: irq=30 cpu=11 vector=33 is_managed=0
[ 1609.472743]   <idle>-0      11d.h. 1610366681us : irq_matrix_free: bit=33 cpu=11 online=1 avl=201 alloc=0 managed=0 online_maps=56 global_avl=11239, global_rsvd=27, total_alloc=17
[ 1609.472743]    <...>-53363  20dN.. 1610366683us : vector_activate: irq=33 is_managed=0 can_reserve=1 reserve=0
[ 1609.472743]    <...>-53363  20dN.. 1610366683us : vector_alloc: irq=33 vector=4294967268 reserved=1 ret=0
[ 1609.472744]    <...>-53363  20dN.. 1610366684us : irq_matrix_alloc: bit=33 cpu=10 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11238, global_rsvd=26, total_alloc=18
[ 1609.472744]    <...>-53363  20dN.. 1610366684us : vector_update: irq=33 vector=33 cpu=10 prev_vector=0 prev_cpu=18
[ 1609.472745]    <...>-53363  20dN.. 1610366684us : vector_alloc: irq=33 vector=33 reserved=1 ret=0
[ 1609.472745]    <...>-53363  20dN.. 1610366685us : vector_config: irq=33 vector=33 cpu=10 apicdest=0x00000016
[ 1609.472745]    <...>-53363  20dN.. 1610366688us : irq_matrix_alloc: bit=33 cpu=18 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11237, global_rsvd=26, total_alloc=19
[ 1609.472746]    <...>-53363  20dN.. 1610366688us : vector_update: irq=33 vector=33 cpu=18 prev_vector=33 prev_cpu=10
[ 1609.472746]    <...>-53363  20dN.. 1610366688us : vector_alloc: irq=33 vector=33 reserved=1 ret=0
[ 1609.472747]    <...>-53363  20dN.. 1610366688us : vector_config: irq=33 vector=33 cpu=18 apicdest=0x00000028
[ 1609.472747]    <...>-53363  20dN.. 1610366692us : irq_matrix_alloc: bit=34 cpu=4 online=1 avl=199 alloc=2 managed=0 online_maps=56 global_avl=11236, global_rsvd=26, total_alloc=20
[ 1609.472747]    <...>-53363  20dN.. 1610366692us : vector_update: irq=33 vector=34 cpu=4 prev_vector=33 prev_cpu=18
[ 1609.472748]    <...>-53363  20dN.. 1610366692us : vector_alloc: irq=33 vector=34 reserved=1 ret=0
[ 1609.472748]    <...>-53363  20dN.. 1610366693us : vector_config: irq=33 vector=34 cpu=4 apicdest=0x00000008
[ 1609.472749]   <idle>-0       9d.h. 1610366694us : vector_free_moved: irq=32 cpu=9 vector=34 is_managed=0
[ 1609.472749]   <idle>-0       9d.h. 1610366695us : irq_matrix_free: bit=34 cpu=9 online=1 avl=200 alloc=1 managed=0 online_maps=56 global_avl=11237, global_rsvd=26, total_alloc=19
[ 1609.472750]   <idle>-0       9d.h. 1610366696us : vector_free_moved: irq=31 cpu=20 vector=0 is_managed=0


Thanks,
Song
