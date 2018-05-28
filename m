Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932976AbeE1SEQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:04:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41252 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932488AbeE1SEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:04:12 -0400
From: Song Liu <songliubraving@fb.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: Re: [PATCH v2] mm/THP: use hugepage_vma_check() in
 khugepaged_enter_vma_merge()
Thread-Topic: [PATCH v2] mm/THP: use hugepage_vma_check() in
 khugepaged_enter_vma_merge()
Thread-Index: AQHT8gVd7juqs8vqokyfL62G9qOR7KRFAUYAgAB3MIA=
Date: Mon, 28 May 2018 18:04:00 +0000
Message-ID: <8F62086E-03E5-4A65-99F3-E4ABB4FFFC70@fb.com>
References: <20180522194430.426688-1-songliubraving@fb.com>
 <20180528105724.okg6c7i72r3v3jno@kshutemo-mobl1>
In-Reply-To: <20180528105724.okg6c7i72r3v3jno@kshutemo-mobl1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:180::1:be]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1341;7:104jZGrBF9TslCCKZS/cFb9xJ9gZIyfzgILIpa7BvSeWlWsOweQ8j9JBOTYjF1b6wjF+UNZUTYgIBRQljOWDiCr92P1RGN4JqPvo80aJ5GKJvovjUUNbhdMLKnN1ECTnA6hVA+aTRCO5eNVxHnW3yveFqE7VqlgOBX3eSvhLZL6/QYJLOOGOuQ6oQkEl2pMSIzqnXmgy2eC2uSm7De/ssDwwhBAQY/zIhxPAIL2qKi1RUH5rNnFwoPGOa5KEk/9H;20:TmJ5NWOwSm2aod0UU2wsh5DQEBSN5apSv5lnFs2VwPjL9gOhMjtmZANPaxVfN6KYhuXSwWQt10qWQkP7uXjp1ZGT4hq47SUfr/B1+vJXMHtUSl/vYd1Guoa2Vp4BMiwB5VdCku7mCRyqpH20CjcYG3yjPU6PtO1HXxMhWa2J09U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1341;
x-ms-traffictypediagnostic: MWHPR15MB1341:
x-microsoft-antispam-prvs: <MWHPR15MB1341A78581AC09C415823A37B36E0@MWHPR15MB1341.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1341;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1341;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(51914003)(189003)(199004)(7736002)(476003)(105586002)(2900100001)(53936002)(446003)(57306001)(11346002)(106356001)(486006)(4326008)(305945005)(6916009)(68736007)(6246003)(186003)(2616005)(36756003)(33656002)(316002)(76176011)(3660700001)(6116002)(229853002)(83716003)(14454004)(3280700002)(102836004)(81156014)(81166006)(8676002)(54906003)(99286004)(6512007)(5660300001)(8936002)(6486002)(478600001)(6436002)(53546011)(50226002)(2906002)(5250100002)(86362001)(6506007)(25786009)(46003)(82746002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1341;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: K4ZmcAZpKgt9bcoxsP26vjGjkrtA15SoH32jV0mtckQCZsAToUHKs5JYjGL4h6z33DNxgfiiorv4e1xqDR/Qu/8muAJqTDCYafDpBZJDUSY0cTGe95IcoIIP/YOD/LW36Q2rO/+NQMBbuzAqEAHb/WtkkQkqjrwFT4j9NOoEDGDymhJRLb0sMuiFLxnBA9vg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8DD54734F576FF429948A0393436350D@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5d1321ff-f213-45d9-2686-08d5c4c563f7
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1321ff-f213-45d9-2686-08d5c4c563f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 18:04:00.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1341
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4SI588a019733



> On May 28, 2018, at 3:57 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> 
> On Tue, May 22, 2018 at 12:44:30PM -0700, Song Liu wrote:
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
>> will not call khugepaged_enter(). Here is an example of failed madvise():
>> 
>>   /* mount /dev/shm with huge=advise:
>>    *     mount -o remount,huge=advise /dev/shm */
>>   /* create file /dev/shm/huge */
>>   #define HUGE_FILE "/dev/shm/huge"
>> 
>>   fd = open(HUGE_FILE, O_RDONLY);
>>   ptr = mmap(NULL, FILE_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
>>   ret = madvise(ptr, FILE_SIZE, MADV_HUGEPAGE);
>> 
>> madvise() will return 0, but this memory region is never put in huge
>> page (check from /proc/meminfo: ShmemHugePages).
>> 
>> This patch fixes these problems by reusing hugepage_vma_check() in
>> khugepaged_enter_vma_merge().
>> 
>> vma->vm_flags is not yet updated in khugepaged_enter_vma_merge(),
>> so we need to pass the new vm_flags to hugepage_vma_check() through
>> a separate argument.
>> 
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> mm/khugepaged.c | 26 ++++++++++++--------------
>> 1 file changed, 12 insertions(+), 14 deletions(-)
>> 
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index d7b2a4b..9f74e51 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -430,18 +430,15 @@ int __khugepaged_enter(struct mm_struct *mm)
>> 	return 0;
>> }
>> 
>> +static bool hugepage_vma_check(struct vm_area_struct *vma,
>> +			       unsigned long vm_flags);
>> +
> 
> The patch looks good to me.
> 
> But can we move hugepage_vma_check() here to avoid forward declaration of
> the function?

Thanks for the feedback! I will send v3 with this change. 

Song
