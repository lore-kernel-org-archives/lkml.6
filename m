Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031166AbeBNPJO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:09:14 -0500
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:46144
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030723AbeBNPJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:09:12 -0500
Subject: Re: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
References: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
 <5199949d-6795-aa55-888c-7ba8abd406e2@amd.com>
 <20180214042121.tza3cpvrnpztjeme@node.shutemov.name>
 <37cf20a3-653b-1ad7-1e65-6bed935cf325@amd.com>
 <1518593420.13066.11.camel@linux.intel.com>
 <20180214090239.cjidydeflvgeww4d@node.shutemov.name>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <6f5f917e-cded-66ca-2549-f3d51dff1595@amd.com>
Date: Wed, 14 Feb 2018 09:09:05 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214090239.cjidydeflvgeww4d@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:404:65::25) To DM5PR12MB1146.namprd12.prod.outlook.com
 (2603:10b6:3:73::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a67b9bab-1672-4845-5cc3-08d573bce6f2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1146;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1146;3:+LDupJ4FoDgLr95Xza8BXnZZeOvmR5grohusfFkgshQN9orkt36l5YHp8lV/3TpGP6aSbtj1+c0rAwc8izq8vLNuVRNvWSChHbfXOAXv4icATlQURspyS7jp1sBkhfXfqL0UtvidhyTqPqajUhUN8mvj02kL6wZd7b8FZDbgzmNkU6pA2uORY/xk5ai5TA+fWo550YgLhWik9Ow87+25mDMvuJ4h4a42rynvQ5rsc3K9uaOcsC+ZnlvznwhIFFmF;25:Ix+N6bXcxkU9iX3VHKoKzSN9hYK/rN4h9FIJUxVC1DW3xyRkXomtiT7SeQsn6X/g4w2TtZl8OA9RrH85VDtnHs9A0kI3Ny8TkpXMyrCu6hta9cLJpejCp0ukwGm6xZlg5LneXVqU12Mixj3ggRiaiXEhNUmY6uXS3rUXJNEOgdJzTFD0z4l5QeCfvIA71/m1X1IQMxna6FoSIjR9qT7NnA+mjLVfi/yK981xpfF7D5mKhpO/UFR+2d9zTQ2ZkEXWDRXUdVnce7iWhqzPLqrMm3XcH26uXbKXLc1MPEPT05k8Fc5/Pp0Zjy+TUHKx1/iPW8204iE+eBIZbnUVmxIkXg==;31:ZEWTSdSIzNG5VY7tPs385UGXr6AdOCn7LnFo41qGfbl7OpByaUqR5HrcL+dhIAKONCuNS66k6yuI3x8NNjyn+oqouw56FUKpvjz3JV9rHgBIBvwcgnXRoo2X8A/bLTYC/H0kPLYWRTBr+0equPbTjRKwYp2u4/nrWR4ACCNpeH90+Kh8idyLi7/vfYzKWTuOh+5nz68RR4RQ62fp0RSsNfY2ghJZFok5tyAY7M/05W8=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1146;20:kIxntsEE54J5l0Ok3v5pI5OmdNT80vLd/34CRjsZHp4yX6hx+bXFWUOsdmFs1633hYNl8AKdW+hHhRIefN4WghDQp7T5MhdbA/c+ClKxxZ3YcHWjFEs8+fMm5D3clug7SmRTWBmhW4EU7gwepH4serkMPwrOrXRq0pAFyZYwm5w9K6DGygjKQ2WqPoKwvv0SKLqmyqOoMVmdA7hbMXPlSaRVYyEZmKIoRAV7l2riH/hbPIRJREW591qsQccOBadELocgjVf+mmafJ2GWWZfPNJwt5qQ7RnPiJyBujWPSII7gLJLcR5Fjus5HGMoFF/idgOixN/h5UvVqGVGuNZ+ImZM+/FOFq59HNyWyk+zdFwZ55IQUwLpLZmxa9keO70fk/j03mmqHaWGjVpiR2/B0l+St4tC0gZlIjtqNX5ygyRaxXCRzg+YEbHTE5rR4xW4Cl9RNfEgqaHTkwR7ET31npz9RoSlOoBV0BYQsYKuzi2pp/e8wwej+LTIPec/NHHku;4:OGWtnos9U/GnRBmif5H0AX4p4JAAKBiopS5ohg/Fobs/UaCKjtYlSG66V1Cr1Nl0P9aZTvb1W13zYfcC4QEsgHKHk3LTh8Qg2DoDObpvzfw3UA0LuYvsXNPkaDJ07WFip3+ffN6tEFQTzjWeES0smqjrEQDPck2IFvY1kAea6XZgVbfzcub/+ioFxIUULzOG1CZzaK5mrfq/+Qq+cFG3KlW0CD7V7/syXHwSZSnL+cHel85xJGjjB70ZXoIqAQ7XDnIkGytdv+B6/Or+plppKA==
X-Microsoft-Antispam-PRVS: <DM5PR12MB11460F8AA2F2BF18745A40A9ECF50@DM5PR12MB1146.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1146;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1146;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(396003)(376002)(346002)(366004)(377424004)(189003)(199004)(7736002)(65956001)(47776003)(66066001)(65806001)(229853002)(52146003)(52116002)(23676004)(2486003)(86362001)(36756003)(2906002)(77096007)(26005)(230700001)(8676002)(8936002)(386003)(53546011)(3846002)(76176011)(16526019)(186003)(6116002)(6486002)(50466002)(6666003)(2950100002)(93886005)(16576012)(316002)(64126003)(54906003)(110136005)(53936002)(68736007)(6346003)(81156014)(58126008)(106356001)(3260700006)(105586002)(6246003)(31686004)(31696002)(97736004)(81166006)(305945005)(65826007)(5660300001)(72206003)(478600001)(4326008)(83506002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1146;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMTQ2OzIzOkdZMWx3U0hCeVFYMGt0MXZlbVZJWUtLWTdT?=
 =?utf-8?B?MkpCZHFnTFZ2R1RHeEp2MHJYd1ZiNEE1ZWY4emtzdkE0ZWV2c01EV3Y5ZCs3?=
 =?utf-8?B?b1JKcWZYMTFnL1Q2QU5GdTh0eG5rMEZocDhkcEpHVXJvdHpubFZRclNDRkww?=
 =?utf-8?B?VmZQZUk3U2JFdHI1SDNIZEZoQjZzYUJsdWdqZVdDaWxhZXl6VHJiOEJDeFpt?=
 =?utf-8?B?c0hUdVBxWkw0bmtxN3B4ZDVRQ1d4OXpPcWZZQWpzVVk5akQzRExOZUdxVXUw?=
 =?utf-8?B?LzhRVUVHZHo2amRZZHdYQmc3ZVpCeW5ONGR6VThxMU1hdThsNHpaZmc3bnl6?=
 =?utf-8?B?ckFhZDFERVN3OE5Qbms1Tndjelp1Y3hTOHpuTDJMVFFrOTFlNGJlWWJ3Q0Rn?=
 =?utf-8?B?TTFDOWJsYXJjbVVYNk4wajdXK3gweWNUL0pCQ3ZES0RSZEZjTnhDUStiWFgy?=
 =?utf-8?B?ZDQzcmYvcjltVm1aNW1jSm1IOC9qaGxwMlRuTDgydXFkZllmb0pmZXo1NTg1?=
 =?utf-8?B?YXpZSmM1cHNzNTZ0Rm5tQTF4NjFkWUJRR200ZU40YkEybzJqVDhXS013MVk1?=
 =?utf-8?B?Z2JEOHpzUEpuVlRzZWNxank1ZGVGWXhXZ3JXKzBiNzRyeWtnTGpoYk12dDQw?=
 =?utf-8?B?WUl1NDJ1LzQxTXlHUXI1K3NycVh6NkRlZFdBVmdVSlcrTWVUbEdUUUlHd1lm?=
 =?utf-8?B?clEwZDR3SzlLWC93WXJHQUtLVVdRbk9XYzl6QTBEQm1IVldOek9hRERJSTQ4?=
 =?utf-8?B?cFN1a1ZrWlMwS0FJbzlCRVRMeUNLejdCdlFzNWZmSis0Zk5teHU5QlBDU1Zv?=
 =?utf-8?B?QzRqd2xKeHQycHRSdHVqNnc1Y1A3Q2JBUFBPZGV3bXlVWmpwa3ROMUJacWxh?=
 =?utf-8?B?QUM5eGFucFJlR0RKNFlIekZYVEhBNXRTQnBDOWpGSndNa1BtYnRlUW5EakMx?=
 =?utf-8?B?UkgyVTBJb2RHT3RWd1VWaVBxRDRjanBkazdtdVlYYURFK2ZWRERBZTdkUGhi?=
 =?utf-8?B?bElqbTJ3UjVGSjNtVUMvdnplV2RKcDBHNEdBOEJBK1B4U3Q5VWhBSDVrYzlB?=
 =?utf-8?B?UHFTWkJsWFdNSEhRZnRjekdpaFR5MWlhb0F5R3JSQ2VoeTZocWNzQld1MkQ1?=
 =?utf-8?B?ZnJmUGg4TzdqbzhCcGRmYnhSY0pBUWFyelVTbm92WTBoMXA3YU5OSFhkR0M2?=
 =?utf-8?B?ZTN1SmNLak5jUWpQdmpUTktlQjFiZjNOYmVuYlJQaERSR01maG1sSm8zNmpn?=
 =?utf-8?B?YmQzUGdNeGRhUkR0RmNnTWlQYkFib3k4Mk5NN3RFc05GWExQeU0ybEtnb2F5?=
 =?utf-8?B?d3hFYlRUa1FTbElhbXdHNUJvSTl1UjVtRkJnNnRtQnRjYXRrKzdXQk9kcjdB?=
 =?utf-8?B?czVRS2pCcXlVTVFlQkUzUjJpN29Fck00SGYvMHlIVkhDNys2Si9GWEdITXRY?=
 =?utf-8?B?S1Avc2Q0YUNxNDQ5UFZIbEJpZ3UzazVheWRBZWIwZlBxWTRyYVNoaUJRVWdP?=
 =?utf-8?B?VDN6enh0N05MdFlEQUNzNjUvN0NEdktSblhISWQzT1YzN0duVC9mNmc2V2F5?=
 =?utf-8?B?aVUxRm5pQzlqVCtkQ3dYd0twL3RHRHV5VXMvVENONFhqMnJzTEo4REtnYXNQ?=
 =?utf-8?B?cUk2blIxMSs2K1ArbXdnMTBhK0Q5YkcyVmRqVFVhcEhMQlV5ZGtGR3BuckRR?=
 =?utf-8?B?YTd2YWJ0L0RiVlFGak1hRm0rMjMveG9LbXNwQUErcFliRG5EWlBuY1FUV2FV?=
 =?utf-8?B?UW1uSEJBV2h5RVIwSm45V0VIUDg1ZVhmMTN3NkdlV1FJbWdoWndNZTQ5RzBi?=
 =?utf-8?B?S0QzaHVIN0xRZHh3RmRhaTBPMDVpWldBNUZod3VFWGNPejhFZXJha01lRWFa?=
 =?utf-8?B?MVh4NW4yK0xPRDRPVC9VWm1IOWNjUHU1NUY4U1dxSXJMSGdXamZYbXZWek9E?=
 =?utf-8?B?Y0c0MWhMYzZtaFNxNGo0SmM5N3JTVXZaVFozNHdOSVZ6UC9WdmNBOVljMUth?=
 =?utf-8?B?UGdhM2tJZlhKZ3hZcGhkZTdtYzBLV2E2ZGdmQT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1146;6:BCdhYxxobxORbpMPeYGmcQ6dqx4Zh9bS560k1dhNHRdkYVRoUddKbBDuCT6ImxoMnZknSKm7nDveCtN535MaN26Ug6HwyOZRBqqF920uLGvILBLtHNXcPkPWoxNSgwtYEGON1SI+M+s17yJqI0Gf2eVMtO9m/1G1DQb/YckVuhFbJ0N72T+Dwmvtdlu8fdVAg25B14Es75xw1vRK+bWkYfQzoddvMcuJgMSInVbuLaCRtA6Aa5zi7RrpOFrImdLwaHg2RhkEgY9wb/ZcWvBGAx9Pj6GJYbBRa9VjEfIk9ZmbHHdJnyzLVXc9xoWVzkk2hIZcDmy69nFEK+zPTdwlaz/f3CaX55UU+FOyAPsWp2I=;5:A98rQAt8r0I2kpR0wY16V2G/pXa6rMor1GYJwly4OEsRkLl/IedcYWYFL3m0gGvvNpEu5s24sTVkm7PVTIZ9dIJKx7WxImSnuGNpZDfqGjdrfPzB5AvzcbbxZ2RBlisCShZTDGkGne5GKCC0qeIxbnJbFmis/no7Stmpv96q510=;24:Ke1PigwegLnrbTqvAwbr/6jHGSY+pxzeUStdPA+01j1jTh9rUNgh//jmFgq6YVt40FbvdGo5LtNAWVsROsLUuLd5Gooxm4l5DHwU/ytEYmA=;7:NIPPMERTh+gh5bRFNQBoLo5lncDoOit0N0OAsRDefAoiEriNhteA1I8XiSo7so7/xDAGrUn9jmHSw7/RPxbkPGwwKPHmwx8oxIQjzYKdjcssdOWWx+rdZFR6Q02AlvxmLJoxziFW6gcGQPegHeERQbYTTi+ha2zZnDvtDLl5kDgXm7SZIzqktyNiUolKFWFaKQWI8GFkbLeg86aJpArQ5gHFzDGVzRFzjyG1blJH80czC8y41mjkZksjtPD94WI1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1146;20:1pdNMbQWLjreg2/q8oeATCUOnhNi+1WSt88IDNxhHucg4Pix30NII9EUEWCEB4uAQKqPqwbj4PCfxpZ0qFhKhq455PFTL/8os36PUuwz4fJKDIFnqIAJbwxL0QEK7RZepmcNSBmRserSdb5yaxzfD7TIdjynw6ceGJyW74uHtq2gKuLQ8w1PR1UVCv7RadZe6S7owT3kZDCjpqCcZG1Hhzp0U1tngvo9ILCM86Gh9zEVvyllmnSlUttHlxVMTpMd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 15:09:09.9575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a67b9bab-1672-4845-5cc3-08d573bce6f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2018 3:02 AM, Kirill A. Shutemov wrote:
> On Wed, Feb 14, 2018 at 08:30:20PM +1300, Kai Huang wrote:
>> On Tue, 2018-02-13 at 22:57 -0600, Tom Lendacky wrote:
>>> On 2/13/2018 10:21 PM, Kirill A. Shutemov wrote:
>>>> On Tue, Feb 13, 2018 at 10:10:22PM -0600, Tom Lendacky wrote:
>>>>> On 2/8/2018 6:55 AM, Kirill A. Shutemov wrote:
>>>>>> AMD SME claims one bit from physical address to indicate
>>>>>> whether the
>>>>>> page is encrypted or not. To achieve that we clear out the bit
>>>>>> from
>>>>>> __PHYSICAL_MASK.
>>>>>
>>>>> I was actually working on a suggestion by Linus to use one of the
>>>>> software
>>>>> page table bits to indicate encryption and translate that to the
>>>>> hardware
>>>>> bit when writing the actual page table entry.  With that,
>>>>> __PHYSICAL_MASK
>>>>> would go back to its original definition.
>>>>
>>>> But you would need to mask it on reading of pfn from page table
>>>> entry,
>>>> right? I expect it to have more overhead than this one.
>>>
>>> When reading back an entry it would translate the hardware bit
>>> position
>>> back to the software bit position.  The suggestion for changing it
>>> was
>>> to make _PAGE_ENC a constant and not tied to the sme_me_mask.
> 
> But is it really constant? I thought it's enumerated at boot-time.
> Can we step onto a problem for future AMD CPUs?

_PAGE_ENC would be constant and it would be translated to the actual bit
that was enumerated at boot-time when writing the page table entry and
translated back to _PAGE_ENC when reading the page table entry.

> 
> In case of MKTME the bits we need to clear are not constant. Depends on
> CPU and BIOS settings.
> 
> By making _PAGE_ENC constant we would effectively lower maximum physical
> address space the kernel can handle, regardless if the system has SME
> enabled. I can imagine some people wouldn't be happy about this.

I don't see how this would lower the maximum physical address space the
kernel could handle.  Bit 57 is part of the reserved page table flag
bits and if SME is not enabled the hardware bits are never used.

What I do see as a problem is a kernel built with support for SME, and
therefore _PAGE_ENC is not zero, but SME has not been enabled by the BIOS
or mem_encrypt=off is specified.  In this case you can never be certain
that the translation from software bit to hardware bit and back is
correct.  Take for example, pmd_bad(). Here, _KERNPG_TABLE would have a
non-zero _PAGE_ENC or'd into it.  When written to a page table entry when
SME is not enabled/active, the actual hardware encryption bit would not be
set.  When reading back the value, since the hardware encryption bit is
not set, the translation to set _PAGE_ENC bit won't be done and the
comparison to _KERNPG_TABLE would fail.  Of course we could just eliminate
_PAGE_ENC from the comparison...

> 
> And I think it would collide with 5-level paging.

Does 5-level paging remove bit 57 from the reserved flags?

> 
> I would leave it as variable for now and look on this later once we would
> have infrastructure to patch constants in kernel text.

If the MK-TME support is going to use the same approach to include the
mask/bits real time in _PAGE_ENC then maybe it would be best to get that
in first and then look to see if something could be done along the lines
of what Linus suggests or with the patchable constants.

Thanks,
Tom

> 
