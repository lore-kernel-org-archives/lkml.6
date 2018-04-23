Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbeDWLXy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:23:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754692AbeDWLXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:23:52 -0400
From: Song Liu <songliubraving@fb.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        "Howard McLauchlan" <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        "Srikar Dronamraju" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] tracing: remove igrab() iput() call from uprobes.c
Thread-Topic: [PATCH v3 2/2] tracing: remove igrab() iput() call from
 uprobes.c
Thread-Index: AQHT2MiZgYNckPh3sEiboRaQbyIOwKQOIy6AgAAWVYA=
Date: Mon, 23 Apr 2018 11:23:44 +0000
Message-ID: <7D7229C8-C85F-4BE0-BBFC-4184858C311D@fb.com>
References: <20180420165625.129593-1-songliubraving@fb.com>
 <20180420165625.129593-2-songliubraving@fb.com>
 <CAJfpegu7Xogom_vMOYNaYKN4f+2h8Se94VVii2ufxaMeWhcxbQ@mail.gmail.com>
In-Reply-To: <CAJfpegu7Xogom_vMOYNaYKN4f+2h8Se94VVii2ufxaMeWhcxbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
authentication-results: szeredi.hu; dkim=none (message not signed)
 header.d=none;szeredi.hu; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:180::1:75a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1482;7:QnYOv1k86nzK+eIuszdf+xUm11jCAl6gzg0mJqFsDWh+i6rnj655AMBpr7G7SgGxzeADegAHrP/YlSqYi5xR2zQmsL6zA0tlKEi3d4VBacIRbV0NZtdGzoDb5zPeFph17Nd3HYhRSgW3QSz4v6fliXi3MxddkwO5gtug72cE5yVFNxUc8bXZ3Y1p2bfQ+rWzp7HgePW/fTNPvYSDTJF9b1iOeHfcT3bkug6N9oTlNoS8ZnpNNpd56LE1j3ChWQJL;20:J9Dugw3xclAV7n7Qrp8nm47+1vSKyUhhJy0yn89zhXPk/LiohuQGmosFVn88CEyQKgWh+nuk35PXHMbrH/gHwEEe1kzC/eSsjgyukEoHC2BsllTfZ48rj2uq5ZF+KgpWAhwLcZwPAWildyYM9H4FxqMQEgrnLZ0KXs7ySJmWDtA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1482;
x-ms-traffictypediagnostic: DM5PR15MB1482:
x-microsoft-antispam-prvs: <DM5PR15MB14828DCDE08F2DC73BF6760BB3890@DM5PR15MB1482.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(11241501184)(944501410)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR15MB1482;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1482;
x-forefront-prvs: 06515DA04B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(376002)(39380400002)(186003)(316002)(2900100001)(82746002)(5250100002)(83716003)(446003)(4326008)(11346002)(6246003)(3280700002)(6116002)(2906002)(5660300001)(305945005)(8936002)(81166006)(478600001)(7736002)(8676002)(50226002)(86362001)(25786009)(3660700001)(54906003)(102836004)(6506007)(53546011)(33656002)(476003)(6512007)(46003)(57306001)(76176011)(229853002)(2616005)(6916009)(53936002)(6486002)(6436002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1482;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: HzR239FEwHa32X3zC93atke6e2qvP5QQd8+LERihDYpS8aWTtWGs44dMb3aaI0OmBMUm/XeArytmYnxYLUEl46Jw4wVrxkpTcFjsPT6o+MYffao/LFbGfkEfgiFgbVoeeeTX0y7PHRJlPTw6QLhm3YlwPGmWtHXmJgdQAAujzuYnLmZMQP2Kpu79Xf/feyN4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF071AC914E89545A2AEF10225C9ADD7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6cc82f95-3a5d-4ec5-4c2f-08d5a90caca1
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc82f95-3a5d-4ec5-4c2f-08d5a90caca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2018 11:23:44.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1482
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3NBO0ov001694



> On Apr 23, 2018, at 3:03 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> On Fri, Apr 20, 2018 at 6:56 PM, Song Liu <songliubraving@fb.com> wrote:
>> Caller of uprobe_register is required to keep the inode and containing
>> mount point referenced.
>> 
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Howard McLauchlan <hmclauchlan@fb.com>
>> Cc: Josef Bacik <jbacik@fb.com>
>> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> kernel/events/uprobes.c | 6 ++----
>> 1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index ce6848e..20486bb 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -491,7 +491,6 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
>>        if (!uprobe)
>>                return NULL;
>> 
>> -       uprobe->inode = igrab(inode);
> 
> Where has the assignment gone?
> 
> Testing your changes would not hurt...
> 
> Thanks,
> Miklos

Oops.. I tested the trace_uprobe to uprobe part of it, but didn't test
the uprobe itself. (Tested) fix coming soon.

Song
