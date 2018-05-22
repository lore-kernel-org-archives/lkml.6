Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeEVTbn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:31:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49751 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751368AbeEVTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:31:41 -0400
From: Song Liu <songliubraving@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm/THP: use hugepage_vma_check() in
 khugepaged_enter_vma_merge()
Thread-Topic: [PATCH] mm/THP: use hugepage_vma_check() in
 khugepaged_enter_vma_merge()
Thread-Index: AQHT8TtzydN2ug5Ms0ixoge/VRLQuaQ7qhQAgAB6bAA=
Date: Tue, 22 May 2018 19:31:31 +0000
Message-ID: <714CDE40-F3F2-4366-8765-C738EC66D8FD@fb.com>
References: <20180521193853.3089484-1-songliubraving@fb.com>
 <20180522121319.GB30663@dhcp22.suse.cz>
In-Reply-To: <20180522121319.GB30663@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::5:2c8f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1915;7:6iCsaTBLuC1r4rGuGVe/WgeXMFKupoTVpizwzwY/cJ6WdpbMAcgfFe/Ijd/JFQc1rqkOOYxixvY2aVO3zDst17rfivWcKz1dUewjapG3EKjR5VI7rJCc/NvXsIZMgK9lb778stRtNtesKA2woIumzUCakTOpGsvW+BoeS2JvkTiObl5fjau5CZN0QhuQKceebqPoF08v3vp0zdyybyt5Xa6uOOrYRE0pZz1Ujeppch9T/tetIc++/vXRvUxG1QTh;20:5l7ntkau+/oTR5k2cjzicIQqrgjH2LYUtMdc6Zxw7ohn/yA6UETjVpO94h3LT+ubSkKcb2fPmOdluJtRQKoJIHOJeX6x6IiEm7s0IODtNQOS4fJq4d1038UPc1by5F8V4DjqkT5Zzow5L8cWjMY82imlkbd1etKjVDBtLqGFFbY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1915;
x-ms-traffictypediagnostic: DM5PR15MB1915:
x-microsoft-antispam-prvs: <DM5PR15MB1915D7E24EAABA11AAA591C5B3940@DM5PR15MB1915.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(11241501184)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR15MB1915;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1915;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(39860400002)(396003)(376002)(346002)(366004)(377424004)(189003)(199004)(2616005)(476003)(11346002)(14454004)(6246003)(53936002)(446003)(33656002)(4326008)(105586002)(6506007)(6486002)(316002)(106356001)(76176011)(6436002)(46003)(6512007)(229853002)(82746002)(186003)(102836004)(54906003)(53546011)(6116002)(81166006)(5250100002)(99286004)(3280700002)(83716003)(86362001)(81156014)(5660300001)(50226002)(68736007)(57306001)(97736004)(478600001)(486006)(305945005)(2906002)(7736002)(25786009)(2900100001)(6916009)(8676002)(3660700001)(8936002)(36756003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1915;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +yakovq1iiwAB/RdU0Am6aoGc9p8fPdwYHoITpJWth0nxVV+QPH0b+U65HVETbdl/mZb5ieW4WwgyqC9AgTkJINsFhOxrpTu5EhANEiyIqRuDcHW13N9Q8KMd/5X08d+PV79sdZdnYcEPfb5+ry/8eeJ6maZBLMG+xPZduiObHeo4mbsvGt5Xee2Litb0+3/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD885E4D76821C47B2225D8DC9991200@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 42dc641f-4cae-4f62-d025-08d5c01a9f15
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dc641f-4cae-4f62-d025-08d5c01a9f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 19:31:31.2701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1915
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4MJVmmh027677

On May 22, 2018, at 5:13 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> [CC Kirill]
> 
> On Mon 21-05-18 12:38:53, Song Liu wrote:
>> khugepaged_enter_vma_merge() is using a different approach to check
>> whether a vma is valid for khugepaged_enter():
>> 
>>    if (!vma->anon_vma)
>>            /*
>>             * Not yet faulted in so we will register later in the
>>             * page fault if needed.
>>             */
>>            return 0;
>>    if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
>>            /* khugepaged not yet working on file or special mappings */
>>            return 0;
>> 
>> This check has some problems. One of the obvious problems is that
>> it doesn't check shmem_file(), so that vma backed with shmem files
>> will not call khugepaged_enter().
>> 
>> This patch fixes these problems by reusing hugepage_vma_check() in
>> khugepaged_enter_vma_merge().
> 
> It would be great to be more explicit about what are the actual
> consequences. khugepaged_enter_vma_merge is called from multiple
> context. Some of then do not really care about !anon case (e.g. stack
> expansion). hugepage_madvise is quite convoluted so I am not really sure
> from a quick look (are we simply not going to merge vmas even if we
> could?).

Yes, it does fix madvise for shmem with huge=advise option. I had made
a mistake in this version. I will send v2 with the more details on what
is fixed. 

> Have you noticed this by a code inspection or you have seen this
> happening in real workloads (aka, is this worth backporting to stable
> trees)?

I noticed this when reading the code. I think this might worth back 
porting. However, I don't know whether it fixes anything else other
than shmem, so I am not sure which versions need this fix. 

Thanks,
Song


>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> mm/khugepaged.c | 12 ++++--------
>> 1 file changed, 4 insertions(+), 8 deletions(-)
>> 
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index d7b2a4b..e50c2bd 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -430,18 +430,14 @@ int __khugepaged_enter(struct mm_struct *mm)
>> 	return 0;
>> }
>> 
>> +static bool hugepage_vma_check(struct vm_area_struct *vma);
>> +
>> int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>> 			       unsigned long vm_flags)
>> {
>> 	unsigned long hstart, hend;
>> -	if (!vma->anon_vma)
>> -		/*
>> -		 * Not yet faulted in so we will register later in the
>> -		 * page fault if needed.
>> -		 */
>> -		return 0;
>> -	if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
>> -		/* khugepaged not yet working on file or special mappings */
>> +
>> +	if (!hugepage_vma_check(vma))
>> 		return 0;
>> 	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
>> 	hend = vma->vm_end & HPAGE_PMD_MASK;
>> -- 
>> 2.9.5
> 
> -- 
> Michal Hocko
> SUSE Labs
