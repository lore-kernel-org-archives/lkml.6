Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753086AbeEON3r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:29:47 -0400
Received: from mx144.netapp.com ([216.240.21.25]:2239 "EHLO mx144.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752377AbeEON3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:29:45 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="257427058"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Matthew Wilcox <willy@infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <20180515111159.GA31599@bombadil.infradead.org>
 <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
 <20180515120355.GE31599@bombadil.infradead.org>
CC: Jeff Moyer <jmoyer@redhat.com>,
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
Message-ID: <afe2c02f-3ecd-5f54-53ab-d45c11a5b4aa@netapp.com>
Date: Tue, 15 May 2018 16:29:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515120355.GE31599@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM0PR0402CA0021.eurprd04.prod.outlook.com
 (2603:10a6:208:15::34) To DM5PR06MB3082.namprd06.prod.outlook.com
 (2603:10b6:4:3f::31)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:DM5PR06MB3082;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3082;3:F/sxU3YBqH8f/gnbVKM/lzxNIStMo0d6CDRLVFXtKakjc5zYI3zlwsiznl0mmwIoKnF6l0eljOhbmkuJbGv7O0vDh3c2Zx4e9XeFkWc4BIrrJZkGIWKwSTB9MGCccGOOq8wpmtrdXceo5nKy6utSJgIEBNNXsHLUGUpu7p0WrDWWJ9fcBL06f8fPtU96ojcgr2CUUCuAQ9HV8f3Zr+z8+JZ/QEbjD697i7nQ2b4k2QBu6sin1ZbHl+fMvGWmbKHQ;25:VjMkASblL23BCrrhwHHhg2wwbqHmgp9x47D0hMQ0WnUwBXnUfD/Kbhz8e+wfWi1DbjkAnyS18pL7lvYNJe+zzTU33uKhti9hxCTsXIxZcd6jmfjLqlolMqlAruquSUb0nk+4YFeooTHtb16Ok7l0P63bat8bT4sNLveMnx76C2HAiVOYvJsEQQzGfjb9RrSs0dZWRRrTjGzMuPCBuFx2KsJbmCpbKUBU0idkXNeS2qTFG+zveI/apjpAgc04IsdspiIut2ZTPTSoqh8gY5LMQCUV1l9BUZV6GH5MYZlbY+AY8/GvvgFw3szlPgICZazZFzLiUfQTK9sLaXB4Tt3a1A==;31:DgFbWZsMU/PlQ2vb8lYSINRevULIG6beG5X8VNp8Nf401xgOchsGulJuBOkXL7tB9Vp3nQBmHx0sIyq/cBgnWAlzCVHM1UCjpIn4U3xRB4Zgvk2T23RiUvhSc5tsr5z9UZGtUvV77aQ82lu5/UvYfUlxgL7DCTlItBZagpte7oc61nqOJcErvwku3SO8GSDggmgJTnqZnB+xnz6yYN/N3AU8gY3pBbhW78cJhhYH9ks=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3082:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3082;20:MmAHQtrCXwP49p1Oz69PfQvKhOx9jytdQULX+8vv9vf5SVAIKoRSjKRpA4lhdUql6wGCj6eugedaq1NST7RQyfMa0mQjktSOifxUXJmnzIM6J6COnSTnL3PN1ET17f5BwRZ/uOsh/ZL2B2cDKLOAfQJwPekTVSEoBs4su9kGwjEgSi7d8bok0Oh+9eErG5IJ6X9imIsh1dOd9wRwMRj01saqiw8LLsnvKqp2P1sXfPlZDkGfCyqoAr5sTyOPUuOD5tiUx9qw3cMchMsHba6Yhz6QIe/zmcgazXKUWncpeXK5tUwj4yH5O8gVmbqoUQHoZNWNBL0DA651KsC4NN1pf2GiWwBHlY4QLyYgIVvav0+G5U+aalc9nuYoT7+tgx1oIRt3dkuNmkAHJdsIwKuN05Uj/hqWgDOJz5ea55MIzFpogQMZQ9KnJLbhawCwZAZ9gC7L1Dl3Fjf3EDhbf29CDQXfK0INWTf84V8ekYEqrGVpdcNxus8JRpxdo/Uo0nrv;4:+ksGwrXWDg7qy7wGKTK3lwFDTHTap95A5fOuENEGolowfT/LgTZMxqJn48zTVABCwVmU+AF5jDRya67xSIxsBfb9TG6A5NzaIWDoZ9z+C4Tq9YKjAJhVn+2LfyG1sPF3GI9kkaJ+wJWqACRNM+D1wtxckPe7j8cShwrq+9Xd2Z9/hju11V1ThDEaZSLifDhNnXYSQCMscEoGaRmZuPM4AtOuLhLYrexzd7+EawgvioBx0qoEgEQbrdQwaUJWyA/hUT2rB4Ra2LHWXBYYK/ydWLtRDoEMJ+QS42LxeVBOLVF/cST3vgtvojNscEkazrwq
X-Microsoft-Antispam-PRVS: <DM5PR06MB30825F0C135D75DC3D3C6F37EE930@DM5PR06MB3082.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR06MB3082;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3082;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(376002)(396003)(346002)(39380400002)(189003)(199004)(7736002)(76176011)(305945005)(68736007)(59450400001)(93886005)(52116002)(52146003)(36756003)(23676004)(2486003)(230700001)(6486002)(53546011)(229853002)(316002)(386003)(6116002)(3846002)(47776003)(66066001)(4326008)(8666007)(65806001)(65956001)(7416002)(8676002)(16576012)(97736004)(58126008)(26005)(31686004)(81156014)(81166006)(77096007)(31696002)(72206003)(6666003)(107886003)(486006)(64126003)(6246003)(54906003)(16526019)(50466002)(2616005)(6916009)(476003)(956004)(5660300001)(2906002)(11346002)(65826007)(25786009)(106356001)(53936002)(105586002)(446003)(8936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3082;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA2TUIzMDgyOzIzOnhUQ3V6YkM4QXZuSlNNNzVKZi83OGJaUnR5?=
 =?utf-8?B?MDZGVTl2elBhRjJMZXpXL2ZyL0J2WEZJNVdGZWpGOTFReEZ4SzdiT01Ua3JK?=
 =?utf-8?B?MHdVNERXT21Ib2Uza2U5cDFTTjZCQWNpdlg1Z1QxR3dzbXRyN2dva1F3WE8x?=
 =?utf-8?B?SC9vMHhhNE8rSy8rWEF4U2hBK1o1MmVOR1JHVkU2Vm55TzZ1QVF4MGhITUR5?=
 =?utf-8?B?UTNuMklZR1h0Qy9hMWQvZlo1VmNPMXZRNTVhL2NuaHhza00rZEVzQVVVNnEr?=
 =?utf-8?B?MjNWZGxsSUhJMzJWbTNDOHloOXVDZS9Sb3hXUHlRdGNGWnhxQlRhNGhiTVNV?=
 =?utf-8?B?ZjlXWUZSQ3huM3M1Mmo2R3V6YUdKSGE0VFJvY1M3bnludkxZN29hL1NHNE5P?=
 =?utf-8?B?a1ZNMlRhejNNbVh0T3M5aG45NGJ3R0RLRisrSjdRQ0hWeE1UcmhndU10ajhH?=
 =?utf-8?B?NS90c3JvYm9iUVZEWHVua1ZOY3diZExlN0wxdHVNbGdtTmVXbFJybndLVnRD?=
 =?utf-8?B?anN2OCtHZVFWR01YUG9BVUZpaHNWSFEzK1BjbWRJK0lEdnErcUJUNGliOVdZ?=
 =?utf-8?B?cDVQRTc4MzdVRGhDR1NoVHNCV2oyckpoLzFCNlhUdDFwM3dFRThyUGZWQ2JE?=
 =?utf-8?B?VU5WLytvVWpTamhsenhNeUdYY1dLOHA1aG5kdis0YnZSSmNUTzRJa2ppRDMy?=
 =?utf-8?B?VWpUZExUOEhCUy9mTVFJT0lxRDkrUWpoeHdIVUppZ003K3IxYVNGVk5qMlJq?=
 =?utf-8?B?NVFQZkRlMGo4WlF1Rnp5cVpBS2Q0M2RyNXREejA0UmxrZ2xBVUJBblNEV3F3?=
 =?utf-8?B?cWRkVCthRGlRSVdQWEl6OGc1R25yNm5ETnNDaXFvMWR0d1hGODF0ak40bDE1?=
 =?utf-8?B?WUpDNk9HTnFVUVdQRDBwYytodjlxNnQ5SlRIc1FPQVN6VkFRWUZsekp2TUZP?=
 =?utf-8?B?T20vVXdjTFluRTN5TjhpMHptRTJoMkRvYUhiVXNrR3IxRnlOOFpjLzNubjFa?=
 =?utf-8?B?Y0V2VDduWmJBZ3lhRkdIRFJtSzdqNDFOcVBGRXg0eHY0MlBEWXFvdUw5bk9W?=
 =?utf-8?B?WnFDTDNJZUZUeHcwSStrQTloR1pnb3RVZnRJeWx6VnNhbkkxVUZpUGxXVVJa?=
 =?utf-8?B?S1kvVFAxSCsyUnNBSURlSHJSb2txNjMvNi9nc3hGdXdUVC9hVUFRcm9uRGhk?=
 =?utf-8?B?T084RThIZVgwR3RFdDdMeW1wSVl1c2JLbStxQWpKeUtqS0pVbnVoY3ozNWgw?=
 =?utf-8?B?QnpzWEtjZGJkYUIyb05DMkRTMzlhQjlCM3oyTUp2U1BjVGpobzQzajd1OVpX?=
 =?utf-8?B?RzkyRFFobjVBZnFjTExibklwUHc4NEdHd0xueUtOWk0zQXZqb3hWUWptK3Bs?=
 =?utf-8?B?cUxpdW9VS1NMWWJjeExHMEJUT3VvMkU3Sng3QnhONmZvUDRacUVyQVdZaXFs?=
 =?utf-8?B?cjl1YmtEOGMwelk2ZkZ2cldoVEEzL28ra054V1lpK3ZRdVc0d1lOZEF5b210?=
 =?utf-8?B?WjR4cFE1dnJYbjJmSTF3SGJoQ0tmaUx1YSs1RnErS0Y5MW5WUTZxU1BVMWU2?=
 =?utf-8?B?UW50TWxiejgyZGFuWUlPZnFKdC9tUWhoeUIxT0JNVGo0RmtIYWwwQXhKWnRR?=
 =?utf-8?B?NVhWa2h2Tm1iZFJMOUtsRmNqMW1pbmY1OHlidTNvQnVFVnBRaUVkNGVlejBX?=
 =?utf-8?B?eEdQTTRuKzBQNkhQTjh4dHROUFI3SFE1clB1VDg2emF1NU5LTy83MGxtMk5V?=
 =?utf-8?B?QjB3ek9tNDVWcndGVEpVUG1VQXliS2tlU0VEZW1VY2duUklNOE9JR1ZlOFV5?=
 =?utf-8?B?bDlzUWRNaEtrbVlsbUVIb2FQYTYwOEQ0Z2lxN3ZiSDVsYjFQNXNTUDBmQklQ?=
 =?utf-8?B?SzJob0Q0T3JmRzJEcWxlQ2N0SkFUY2RGVFpXbG1uVG5uSHh1cG9MQ2M5c3NI?=
 =?utf-8?B?MzJhZzRDd2FkNDNRZloycUgwbmJ2R21JVlYrSkNoMWlrNC90TGs0cytrUnVK?=
 =?utf-8?B?RWRIaGRhS0xxWjlGblFmRlJka2RVdm40YWlPVnJLbm51THd1WUxJTlVIQjU1?=
 =?utf-8?Q?0IMn5LGiTXjkoTneS7sgP/M6M?=
X-Microsoft-Antispam-Message-Info: M9tuwc4FfJXxNmuyKE68DLzmfWJHgX9Dz6p03wDecckkXFGH/ZFL/czCk7tQ4XSqWlXLZ3sdwgibdO0CTjy4W010tHpIhFHTZ1Tp0xMfUF1TN37DUv2NWxynLYAtqb8OKkLd2FORv+lTfsSLKlkxl0GYirnBetxJUCdkmRaQXG3H9ez7fbvTOVrPODM8OJhR
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3082;6:Gv4LN0Oszob79hpc6+C/mx34sVC2e1ezoYlWPZ0tpj3xREgX/1vAqTkyGVI+p1h+n8aH4aGECpjE0cOAn4zX0CbnFDEbXW45SyfCbsq7CI1JZ9lAy/SEhsAF9NgVLq5bCSaKp3O+LjqBojCv+/PFA3bYgDs6ZrB9BA5D394iK+NN89Pf8yJ9RMsbGHpVZehy+f3dowShatDuQg3oBT+Z57qwlyJ7OPzbzhFFwSq9fDfNlYZx1NflHjwkhGTLnfGoAHQOies0eiJYxRBlx+Lzaiu/xgDTEaOr9jDV/bTsZA1MXRrrrhhgP2NGFdqYElVgJ32ga9erHEVyd3dOpjJRRi+Pe3JwlJJnobLScNsVyZ12Ooga0J11C8wWyrhZDK20pPj0X0RpqlQ4kDkSNkjW98wq9lrmqETm0Xh0tcudHausdafx0WEcB3rU3s7cwr67+xWmc9RafRz3o1qoVNL6mw==;5:P9trnvc7VMd3CdUVHKdwx63y+GMjkzQu8lo0Do5+GqXms/ZeP+pNiP86BrQ2oQBehNN4V5pPhCgjVFDRd6spcQXgb/5Luv3qMTuO/d4UZfvqm/Mqfju7PxLCzkW7UiY14TSW1gpwwczAYs8B7OiKrHJwhPxLEJJRceV7QMFoQSk=;24:MOKfy5+Xv9U1bHRplINjdtNHw5LetejhDvQaf5MzLWhwX8MpObkYI4eNwY5rFGnZH1GyEfmT5uRzkMI3FSXIoyWyP6dfuYrlX1XNAx4pCXw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3082;7:EuKeY94DgnMk9TujQBGh4qT4XeAK5yoF2U2J0r17zNd/sqYsOUDItHc64pg9Z6Hm/SaCNGO53leAwAxXsvziU6KXMEc45EwvWEWiVOEyZxMGCcpPlNkR9Rb3kM7XYgME6hSk5Vp1EHCwNwKxXhcluNdHZ5pStYsRwbaYaGjAmISi+a54ChPLHTulYlc4T2+lvK9uwj2Uxywh3AZWT9qKX8WxhTMje/eI/ZrMQXGuH/JAIyYT5E6dxm8qLc850ic+
X-MS-Office365-Filtering-Correlation-Id: a43346e5-001b-4f79-40ae-08d5ba67ea1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 13:29:37.6825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43346e5-001b-4f79-40ae-08d5ba67ea1f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3082
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/18 15:03, Matthew Wilcox wrote:
> On Tue, May 15, 2018 at 02:41:41PM +0300, Boaz Harrosh wrote:
>> That would be very hard. Because that program would:
>> - need to be root
>> - need to start and pretend it is zus Server with the all mount
>>   thread thing, register new filesystem, grab some pmem devices.
>> - Mount the said filesystem on said pmem. Create core-pinned ZT threads
>>   for all CPUs, start accepting IO.
>> - And only then it can start leaking the pointer and do bad things.
> 
> All of these things you've done for me by writing zus Server.  All I
> have to do now is compromise zus Server.
> 
>>   The bad things it can do to the application, not to the Kernel.
>>   And as a full filesystem it can do those bad things to the application
>>   through the front door directly not needing the mismatch tlb at all.
> 
> That's not true.  When I have a TLB entry that points to a page of kernel
> ram, I can do almost anything, depending on what the kernel decides to
> do with that ram next.  Maybe it's page cache again, in which case I can
> affect whatever application happens to get it allocated.  Maybe it's a
> kmalloc page next, in which case I can affect any part of the kernel.
> Maybe it's a page table, then I can affect any process.
> 
>> That said. It brings up a very important point that I wanted to talk about.
>> In this design the zuf(Kernel) and the zus(um Server) are part of the distribution.
>> I would like to have the zus module be signed by the distro's Kernel's key and
>> checked on loadtime. I know there is an effort by Redhat guys to try and sign all
>> /sbin/* servers and have Kernel check these. So this is not the first time people
>> have thought about that.
> 
> You're getting dangerously close to admitting that the entire point
> of this exercise is so that you can link non-GPL NetApp code into the
> kernel in clear violation of the GPL.
> 

It is not that at all. What I'm trying to do is enable a zero-copy,
synchronous, low latency, low overhead. highly parallel - a new modern
interface with application servers.

You yourself had such a project that could easily be served out-of-the-box
with zufs, of a device that wanted to sit in user-mode.

Sometimes it is very convenient and needed for Servers to sit in
user-mode. And this interface allows that. And it is not always
a licensing thing. Though yes licensing is also an issue sometimes.
It is the reality we are living in.

But please indulge me I am curious how the point of signing /sbin/
servers, made you think about GPL licensing issues?

That said, is your point that as long as user-mode servers are sloooowwww
they are OK to be supported but if they are as fast as the kernel,
(as demonstrated a zufs based FS was faster then xfs-dax on same pmem)
Then it is a GPL violation?

Thanks
Boaz
