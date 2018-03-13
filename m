Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeCMAj5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:39:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34814 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932225AbeCMAjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:39:55 -0400
From: Song Liu <songliubraving@fb.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [RFC] perf: a different approach to perf_rotate_context()
Thread-Topic: [RFC] perf: a different approach to perf_rotate_context()
Thread-Index: AQHTsZcV+ejFiFHeiEK2h1wCYdO9K6O+pNSAgA6/eYA=
Date: Tue, 13 Mar 2018 00:39:28 +0000
Message-ID: <7D4EBE04-79E0-4159-9B94-DD24F812CD4C@fb.com>
References: <20180301195321.2608515-1-songliubraving@fb.com>
 <20180303152631.GF25201@hirez.programming.kicks-ass.net>
In-Reply-To: <20180303152631.GF25201@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.5.20)
x-originating-ip: [2620:10d:c090:200::5:b7cd]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1643;7:IlUiMWeaS6XBwzhlUgE2PkC7DWKjuX7HA0bqsbhnwbmxCmuRIhDdijQqXb2XQIyHzgJ9FkjqqtxG9STFExjWktOp0eDaH8VVrXpRo1grm+pulGGqMyGb+UyvylR/veIWUrEKsBHGi05T7Ka9E4IgM/ryEhv8YUM0XZQHjVNUCq/BCKsQdo7QpdxrbT3hTI7JjNYYUB2cGvxAsC0YWqXOdrTIlEY1UxedzfF/w2d79yXoJGBSZozu7b9fhzn0dYQr;20:1fkj6QOvt21stkouCoUVPhBaOVv3Wpgz4wyLj1fkyO7ya2crGM6JDydhmX66D1YZvBcGn5RrnoBfNsFDdjJSt8PIie812PUuW0Bd367VzAvysTtE6wAP83U4LBlpwhoPoJdLYV3ycAeXTxyCguvhPukabqf1IZaqT0vY9FrHbR0=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: a659f31a-61d4-4d7b-3631-08d5887ae0c9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1643;
x-ms-traffictypediagnostic: DM5PR15MB1643:
x-microsoft-antispam-prvs: <DM5PR15MB16431DEEEE8A6B56E3310CB7B3D20@DM5PR15MB1643.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(11241501184)(944501244)(52105095)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1643;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1643;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(396003)(346002)(376002)(199004)(189003)(6512007)(5250100002)(2900100001)(6306002)(4326008)(68736007)(7736002)(305945005)(316002)(54906003)(81156014)(8676002)(81166006)(8936002)(99286004)(5660300001)(3280700002)(50226002)(33656002)(229853002)(6486002)(6916009)(6116002)(2950100002)(2906002)(25786009)(6436002)(53936002)(105586002)(57306001)(82746002)(46003)(83716003)(76176011)(53546011)(6246003)(102836004)(86362001)(106356001)(6506007)(186003)(966005)(3660700001)(14454004)(478600001)(97736004)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1643;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: JmpzEB2xSW4WrdvFyK6Vt5lSTuCUWfEXHWlHCXvKaUEbziQKGxI8sgRAEM7hdrVza8D5ay7PH+NSId+fyoHNHTyhH+TtFB+/QBnZkd+hQ0ytfxHaRHZfyIxnB2kIS8mOBtjWSPpO8wo2BGV1eCAobEjKYabmSlztaHr4qIjex2QROla7dO9fcoA9hotCJhPO6Ob4sq2ITIj/yV8GGUMissvEobNE1S64dqLOGxpC7Qx9H5GUOkdbWFVtGstiuPXnvQErx9EALxdfJ7NqkXmEWiADOINqrJv05rzH37j+YSCHQE8CyojvjLzoJHc29zWxTmHFtk7OhhL7pQiPYih0XA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5EB3A3E8505CA145A0D3E8FA5A427C6B@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a659f31a-61d4-4d7b-3631-08d5887ae0c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 00:39:28.0838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1643
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2D0e1q5016335



> On Mar 3, 2018, at 7:26 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Mar 01, 2018 at 11:53:21AM -0800, Song Liu wrote:
> 
>> Second, flexible_groups in cpuctx->ctx and cpuctx->task_ctx now have
>> exact same priority and equal chance to run. I am not sure whether this
>> will change the behavior in some use cases.
>> 
>> Please kindly let me know whether this approach makes sense.
> 
> What you've not said is, and what is not at all clear, is if your scheme
> preserved fairness.
> 
> 
> In any case, there's a ton of conflict against the patches here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/testing
> 
> And with those the idea was to move to a virtual time based scheduler
> (basically schedule those flexible events that have the biggest lag --
> that also solves 1).

While looking at these patches, I found it might not solve issue #1 
(cpuctx->task_ctx->flexible_groups starvation). Here is an example on Intel 
CPU (where ref-cycle can only use one hardware counter):

First, in one console start:
   perf stat -e ref-cycles -I 10000

Second, in another console run: 
   perf stat -e ref-cycles -- benchmark

The second event will not run because the first event occupies the counter
all the time. 

Maybe we can solve this by combining the two flexible_groups (cpuctx->ctx, 
and cpuctx->task_ctx), and rotate them together? If this sounds reasonable, 
I would draft a RFC for it. 

Thanks,
Song
