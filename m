Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeEVQGK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:06:10 -0400
Received: from mx141.netapp.com ([216.240.21.12]:3524 "EHLO mx141.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbeEVQGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:06:07 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="275458984"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Christopher Lameter <cl@linux.com>, Jeff Moyer <jmoyer@redhat.com>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <010001637399f796-3ffe3ed2-2fb1-4d43-84f0-6a65b6320d66-000000@email.amazonses.com>
CC: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <5aea6aa0-88cc-be7a-7012-7845499ced2c@netapp.com>
Date: Tue, 22 May 2018 19:05:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <010001637399f796-3ffe3ed2-2fb1-4d43-84f0-6a65b6320d66-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM6PR06CA0006.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::19) To DM5PR06MB3081.namprd06.prod.outlook.com
 (2603:10b6:4:3f::30)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:DM5PR06MB3081;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3081;3:baADxJanvL4YcRV7hRzrjwzbM94OVR3NUWmtMkJO4cDDJ0M+QVqS56TaJls7UWP9Y24KJoU45IpS5ouAwtxLrbo/fQJcT9XyexfA6/N0XzZ+WZhHHsIo1f7f6utcXAxvqrmhi4WQndjvrtGSuAV0d+ovK8Q0K1BPHZOpXXrizAdm7Qku/2WMhp3vuU33/CYbSbd0gs6X2D6+72WQpPDYITL3qSjUKJE5bjrSbK5S/3yA+iRCU0HHtBc1sXRnsgwt;25:Md8tXfSPrQC8vnSYNGSvAJR34hJ81lTXv5dkNsWITUMCbSlQXnrUDMmq5QRoULEkJUDfTHY8daPmSLCA/zTo1yjY85ybNLJBaIbHUQHmpBFayK1sytb2JviUu/zclBpk+YjXD+WFqPI6CUqOlIj2gApwDCz1873DM/P27KRF4jqAtv0/DGg9+SG1JUpepADDYX9m0QvnoV8BXZF2UOs+wpPTM/qix89ll6QbhyoyuRWda+d7XlBngXXbZ0VkVQgP85QA/6vb4RMCy4RnwmR08xBvMjtvAzGmrraZ2Yy4x4Ye3AewSEmpxCJ/gP51MSu0ANgeDWi2FrxTGWJyLeJMoA==;31:j66+J1Wk90FzJBpX0scukXXk6Nl9mQxa66Bec+/YKzJHCsZjeLIrDZFz5buKozI5+b0/8QUiZ4S+XZ08rUV5hNzNh3KrXYibH+noeB22DYp+UfRkdBkcM1DozAMSe7GVl2NK7HfxzVBkbyN6m+gKAHzG/6gMj71boxWbQo/fD6H/slzQCwMPAWSOThGoXDsNrQgi4SI1RUr0AKzGt1aS8S0R6HlN8GE2AYzNxC/qCC8=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3081:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3081;20:NZCmVAa38ZPPPa58gnS0xBy0W10K/MH6vHmzFvls1pX80LCmemDDnnEZuarFhbItCD2qnbyn7ewJvRrta8tbsuWKfrD5iWWQWqfthM2ApXaJU7flwdpVhem8agM2ZM0061dzcSH5fquox+04da0Flo6/GhscuN/UtVHh07sjvjDNbopIksbMTAQe0W6Lr66IGyvp9Dwrye3HVD5sytWe/zBGHzXJkYXSxegFIQrbc7Fbo6rlYSn5DicEXsxHI9+R/lSSX44dc1uAeASufIKie87nrrC+ATrt7y+Cjjjjyv6YFGhQ/CLimrocyZvEKiK7sc4wXq1lfliWJW5KtezZjA/+OHiTpWIN4GbAHiBlpXagBEEcllbewheDIP/O22jdT0NyiR0IfZJehZaDrwI4dl/q+ggUU3+vs3h1XSFsm6gx9pwJM/6devnq2mhJEQt61dJBhnsVrxIycGebXs2zYg/tvUgzfI1COK+XKAm22dqudRnFxcjtJIjcKZQkSerV;4:4Fvx/y7POVDPS5QFpSp/cvhadGlCXh44xPB35XXum5pO/XMwmDt8ARHuHrr+3/FlU7Cfd6CE9icyLUDbEf2VebRgOrTUEHBC5i7KZPjv/uVsOrQtHfH0N6nRYVQzKztkF0/BnhvWzroIrJs/jIrteFWpfzhltoM1xtDCLUNGXL/6xMm2Jy3RtCbhEL2wWmLZfa7LriJlGvDlrKn4+65wVNk/JxBWYQKMTsqYBVhuvngL06xrv9Hgh6keolsirMSvBa7j7zhCmcc/MmzItlzXDT9KWJuO5/4Rbt6GaChafYwbmSupSxY/525msjaOn6uL
X-Microsoft-Antispam-PRVS: <DM5PR06MB3081E369E863ACC44293922EEE940@DM5PR06MB3081.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR06MB3081;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3081;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(396003)(366004)(39380400002)(199004)(189003)(51444003)(106356001)(6486002)(65956001)(65806001)(105586002)(66066001)(16526019)(47776003)(26005)(59450400001)(77096007)(386003)(53546011)(23676004)(305945005)(31696002)(36756003)(52116002)(2486003)(76176011)(8666007)(52146003)(64126003)(72206003)(50466002)(229853002)(7736002)(97736004)(31686004)(478600001)(3846002)(230700001)(6246003)(107886003)(6116002)(476003)(53936002)(2906002)(316002)(93886005)(7416002)(11346002)(2616005)(58126008)(54906003)(486006)(81166006)(16576012)(25786009)(110136005)(81156014)(8676002)(65826007)(4326008)(5660300001)(68736007)(8936002)(956004)(446003)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3081;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA2TUIzMDgxOzIzOkRXL3RiZm1PSGNFYWxhM2thbHF4d2ZLWGsy?=
 =?utf-8?B?MTRwQXhEYXB1KzFRdUkzSGNXZFF6ZE1paktrMVBYMDREUGt6eDdkMm5YK3RI?=
 =?utf-8?B?RGJwazlPemllbUZXZGpNUkZHYk1yNmN2UFRhbEJkS2F1cG9sNkRncHNmVkF6?=
 =?utf-8?B?L0RlTE5Cazk4K0QxeER6TDJBOE1Qdkd4ei9UN2dTSVUzVjN1dmVIUmIzMXdX?=
 =?utf-8?B?Y3JObk5wRHJVeUszRlZKZHg5bnllNTJYVkFZUGxJTE9jclN5RERqM2p2OXFV?=
 =?utf-8?B?YzdjVzlPbUYyQXBsQ25ZSFl1Z01TOHNXUzVMREo2VEhWNjVyQ1ZaMFl0MVJi?=
 =?utf-8?B?cytEd2FWNE5RbHV2UmsxSm9jalkwWXhzUGtTc2VjejliYWQzb2JxZG52bjY2?=
 =?utf-8?B?SGdTdEhUbmw4cWFVMklSbmRxVTgxbFlPQ2xnRWsxSTE2cGxTb2NYUDdaY29U?=
 =?utf-8?B?ZUpXMytub1R1YTVJcXpwVXVpbFJYMlZCaUF4a1NMV2lVM3RScEJJUWEva1Rs?=
 =?utf-8?B?alppKzgrVEtPeXREUy93aXBldkUxTVRNd0Rqbk10dldHeVY5QWRHdUJnZjVZ?=
 =?utf-8?B?UHZkTWtFOTIxQVZwbFIxU2h4T0VPQXNSYi9waGZwckhLZUFZckM4WmNPQkFz?=
 =?utf-8?B?cmg3SXdqZjNuNzdOaEcvZjlPWDJTZHFhOHYvdnBkeXBTSWZ1NGplV1hOeVBG?=
 =?utf-8?B?K0Q5S0RGWkRvZEYwWkY5Y0Q2L0l2QmdzMHQwNTg5UWFNUHV0N1o4aGJEeGFy?=
 =?utf-8?B?Z1VKbmVlV2FDZVE1aHZpTmRDYWtLZzJvcjZYWTZyY0JJVjdmTVN3Q00raUR2?=
 =?utf-8?B?WDRJWkl2aUJlRHFicWQvdUhGc0ZUaHRkb3VpUnBjN3FmalBadUJYZzN5ODNn?=
 =?utf-8?B?RHlvYWdOdTEzWFE4bVdyMUpwbzNTQ2g0bVM3ZE8yN1hXbVNvSzFwdVdHQWRW?=
 =?utf-8?B?N29rcCtySjFtM3hrTkpuQ0hvcGE5OVB0c0xIalJWRzAxUzNvcHc3Z1VZT0pK?=
 =?utf-8?B?YnY2RDlEeTEwZVExc24yRE41MWZaMUwzOHJXQzhyR0FMN1RRNnM3cU5qdlhy?=
 =?utf-8?B?amNCQ2sxZkZncFF6UXpReS9vcDB3SGRxWWdiWitsYVNidTVmMWpnZE5QYkpv?=
 =?utf-8?B?SjBSeEYycGRTYXZtOHliTXZoaVovbDd2THErYzhFdFZMWTBVblBUSVRTUFdK?=
 =?utf-8?B?UmkvMkNzS2FOZ2VVcG5WMlYyQ2YxSmZhK2VTeWpIb2g4ZHRUVWk2NUorOFBn?=
 =?utf-8?B?UEhwVnRIQkhkNFlNUmp5OTVrc0Z5Sm9yR21QWW5KcFgxRzBDY00rcEtmdS9Z?=
 =?utf-8?B?VXBYeFNJZ2RIUW9OZmIrdC9sa1F1dFluSnJ5Z3JQemFTd1pXdU9mV1pidUZk?=
 =?utf-8?B?alRnS0wzOUNsZmdpMkIxMGNPQ3o2WDQxeFB5aGc2aWdmdVM3Skg1eGs5UmlP?=
 =?utf-8?B?KzFJSVM4ZS9KakVmSTN0OS85TEwyZVJ4aXNXU3c2USs1Q20rL0lsaVphTlNu?=
 =?utf-8?B?QjhidG50YmxLZFEwS3RJU1FPdm9RSFFEWG5QcU9WNnhvcTFKaUxoT3hOV2x4?=
 =?utf-8?B?RU5sV1oxZzFEeUZwYVJFcWFieFl3NjNBMWhWNHNNeGxndk4zcmUvaTk5cVlR?=
 =?utf-8?B?WmVjQTE3Z0p2ZGhBSm9NdURsbGlONjluT041S0paRGRUbmFWTlpkdnRoMiti?=
 =?utf-8?B?NUtUWi9ZcHQzREZlL2pIazNybjhyS21CNC9kTUJRd2Zuc2V3OEtpdG1aUmh5?=
 =?utf-8?B?blhZQ0hMTkxadWRUUWFSdEZyNGVMNWYvbU01U3htZDQwKzdZU1lHVVVQVTEr?=
 =?utf-8?B?bVZpOUEyRG1jMStKWWkreEt4QW5yOTJXcFBRLzdnZ2VZZ08vNzFKRmRVVDUz?=
 =?utf-8?B?bExHSnpzby9YS3YrR1BhL3ZRMDhaL0hjOG9weVFQcnBQWGVIMGFXaGpZbHhM?=
 =?utf-8?B?bHR5R2Z0V2hTak9SL0JSYkdFck41cG5yQmxONWJ2MjJYNDV3bmVFNW44am4x?=
 =?utf-8?B?LzdIcmx0amNNeFJzN1hvSVg3eTF1U0hqTGdGSkhrdzVMN2dZK1BzRzRXNE1L?=
 =?utf-8?B?K1dxOWJrWlNPRU9KVlFUNzYxL2VkcTh3WCtJRmo4L3krdlppTmsvOGx1TEQy?=
 =?utf-8?B?Qnc9PQ==?=
X-Microsoft-Antispam-Message-Info: gKWXmckmX+S0UHyloFgwQbRu0vBujGn6/TjracCa7W3bFYEzHxHR+m29s10LPTnPYMcMjzLV4ojtwuqjBrYw56o1z45FyNcheH2UBCNVsrCYhOiujIR2+4xuYQI8LxR8vFbQDRjO+X4eOD5+y4p6AONXTeOSSmi/u/1GZoMIumdiIf4bRoNTabAHKcqHmIIH
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3081;6:ncVXU91rwyCwhgVGHNakfnhPfQzfIfJDsQ4AUx9b0qzXXu4YtsLeZoxmYNKRdWva+G0U26TjnXUPfme5vTNVcUAdRHz7w1A7unhMS2YaL9vz8WPz5MYiZrNnmaLHJBQPZ5pkKBmC/fPz6YuMLYMK6Sdb1G/uGrXIB1P3Lbd3Iiih4JXGsw5C3JDTD4qWr56qMGtWzzv1/aLR/v8MoZWNtepYTiQxdNvmZu+q5sVqjAycjSKZF088UARDGggc1M0+3Y+mbcnyc0f5HUw5+5V11dCEUI5hVr0iquv1hH8HfTXyogH2zox3Eg4mN3TPQMRZXeiDJZgvtnS6NkU84KhFAnjhXqtOPsOpbZgNKtykyA7Snddm8Xau/x1J2Xr4Y6ov38QFa6wM/xX8eUB9X9i4oeptwt7x62Mr+XbpM8sX7yryMjCoXuUZnY9Wvpx6bUQL7UhzLhuMmH8Eip8/yo+FQw==;5:lqoumLthhJgO9TrEm/JNxW7sENKPd4kxUFqBZFlxBOIx3LNIi6aRdLOutM9uTe6pdVanuyBKgWMeoPQEsVnXcvVmyTYkQ0tQ49CWoEhlO4DhhmkBVD8Ozhg/FZDRV7FpDQOB+tKpJuPBxE+JKNcsHcY0g2lSWylYhZ7+NpkeRsc=;24:ou59FeUJfDuFLbXRy5byxTK9fEujOMcgZSX0S492k/VjPehTirX3f7Jt9SflPpG8Hgz7B+P/QEKYKLVLlJ5eIEi3R1U/6+DIXZDnpuEQ+jY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3081;7:BZpJvRneYoPvj9XpsMVPNx2SCQ72kjEBEiyyfCoYzlOqanddjIwWJpHK9fti6natBdCq41lfOyYEE5TzEGJFsL5qvBsSl9dTRLAXWI0xvrlIBcBZymvX03XtyNHjKi0feFk47MqGaP0Q5z9Nnfq7RDQbb9YR3Yun6Y/QKiDxsbYeFK2vthxGB6YwwDt83lzMSf8i0HvZ7O24TAENTgKWTI4tG6rE7LJs1xqvOVDP3xIYdIiOFYNtAz3IS8pu9DtH
X-MS-Office365-Filtering-Correlation-Id: aee10e25-e27c-4e6d-27fa-08d5bffdea72
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 16:05:58.4086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee10e25-e27c-4e6d-27fa-08d5bffdea72
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3081
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 17:14, Christopher Lameter wrote:
> On Tue, 15 May 2018, Boaz Harrosh wrote:
> 
>>> I don't think page tables work the way you think they work.
>>>
>>> +               err = vm_insert_pfn_prot(zt->vma, zt_addr, pfn, prot);
>>>
>>> That doesn't just insert it into the local CPU's page table.  Any CPU
>>> which directly accesses or even prefetches that address will also get
>>> the translation into its cache.
>>>
>>
>> Yes I know, but that is exactly the point of this flag. I know that this
>> address is only ever accessed from a single core. Because it is an mmap (vma)
>> of an O_TMPFILE-exclusive file created in a core-pinned thread and I allow
>> only that thread any kind of access to this vma. Both the filehandle and the
>> mmaped pointer are kept on the thread stack and have no access from outside.
>>
>> So the all point of this flag is the kernel driver telling mm that this
>> address is enforced to only be accessed from one core-pinned thread.
> 
> But there are no provisions for probhiting accesses from other cores?
> 
> This means that a casual accidental write from a thread executing on
> another core can lead to arbitrary memory corruption because the cache
> flushing has been bypassed.
> 

No this is not accurate. A "casual accidental write" will not do any harm.
Only a well concerted malicious server can exploit this. A different thread
on a different core will need to hit the exact time to read from the exact
pointer at the narrow window while the IO is going on. fault-in a TLB at the
time of the valid mapping. Then later after the IO has ended and before any
of the threads where scheduled out, maliciously write. All the while the App
has freed its buffers and the buffer was used for something else.
Please bear in mind that this is only As root, in an /sbin/ executable signed
by the Kernel's key. I think that anyone who as gained such an access to the
system (i.e compiled and installed an /sbin server), Can just walk the front door.
He does not need to exploit this narrow random hole. Hell he can easily just
modprob a Kernel module.

And I do not understand. Every one is motivated in saying "no cannot be solved"
So lets start from the Beginning.

How can we implement "Private memory"?

You know how in the fork days. We have APIs for "shared memory".

I.E: All read/write memory defaults to private except special setup
     "shared memory"
This is vs Threads where all memory regions are shared.

[Q] How can we implement a "private memory" region.
.I.E All read/write memory defaults to shared except special setup
     "private memory"

Can this be done? How, please advise?

Thanks
Boaz
