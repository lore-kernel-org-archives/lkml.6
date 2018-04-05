Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeDETt3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:49:29 -0400
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com ([104.47.38.72]:5440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752653AbeDETt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:49:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 05/11] x86/mm: do not auto-massage page protections
To: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aarcange@redhat.com, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@google.com, hughd@google.com,
        jgross@suse.com, x86@kernel.org, namit@vmware.com
References: <20180404010946.6186729B@viggo.jf.intel.com>
 <20180404010958.44C7DE5F@viggo.jf.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <32d28abb-a0f8-9a02-2b06-318a94e15a59@amd.com>
Date: Thu, 5 Apr 2018 14:49:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404010958.44C7DE5F@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR1101CA0023.namprd11.prod.outlook.com
 (2603:10b6:4:4c::33) To CY1PR12MB0165.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e0f2bed-4571-47cb-40c2-08d59b2e5454
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;3:f6pqvL8ELs6NSBxZwgXeHBgRnHE177S1JddtqpuT7VDHXxRR0K27GMDV+UVkGfD1dkeO1PJ6G2nhGMSGbRY+PfcPfyoCyYM1y/uZkNCVtN3PiFWzQb5NypJnOZam5UOBB4BX0pVejwziHzSXWh6kP9zrLg+G579WmCuB8LZdsJYM98o3RPfjFqgrz1eQTUDGjS5fZB5qKAj9HYcppTAEac4w5xVqG4/lCtyCU/DbhYc4LK7bIfC1S5jCgLqqxsdB;25:X4TbLap2fXAOPC7o7+YlVHSQxqFj3vLBWfmMTUardzVvnfmprk0y7QuwXKR8K4f2YTGwChaR41tsvbk8Ov3a3IX+2Hb14X6HlYpC0xRI5W4DEYBzGv/1MwOLL6BgVdI3d3TuV62H+WWY3QVUvHA0yHwNtvRlTAUqA2oXSMaZKU/CN8JurGeIJfQg93egxG6e+ACTYaBvBfqRomcLIa/JBe6yTbcFx2KI9cjw44PyUK4T/rpCfjs3OPp/9V0rzdhXj879vhQgPd4rlFuNtI4xeuvSKyF/TszDdgzUvgwQbuHErRDc02WOC08E52ugQXX6leKTCxCP8hoVkKTQjfQJ5w==;31:vnKe6PtS1ZJ7BAdOyL2C8h2fzVImMV2gZqVblHiZ6IvYNBPojjFwcRI/eOiUZUZlTap089DreD/k61lhsnXCJ/MCUNKL26YMCG+z1CT/hi92NbcUiqg8o46H3HWTErjIr1e2umujCNT7PK5LuurgBUVZC8DZdo0lPGhA8wQ/VNBEOWk9pOPhTjHxnzEd2lBA2MRnI23zvUOYhIoQAEAlsPLbQ63b+33wGjhNqoKBs68=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0165:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;20:tMQorUNC9Kx+t7orhdulQJkJV+gXvb2aMVsWAO+ETGaoJDmDQ3rTpFrK7fNyUI1D6PH4xWBBRpObKuLJI2MZBBZnoxoM1U9qPePObc2lotoj8sgjwKcIzvQCSjKUyFmUiWNZIL0Cd7tQLHClrmKbGhMcNDNfD7b5m2nhPuDuk1klz8iuGnuf0JscZ3NK4uaS457uuaLGWRvi+1erf3smmWfyUXa5pQ74otCos9c2UnEQ9IOfaneyTLbvgOs3eEY+ThALEPYwoZ9v7rSZxmfL6xsRzBOT0ChC7ATSCJSfvU/M+AWMd1THAkqSX/E0N74Fh9m/g1i22t1g9NjQJ96xzo65Chzz3jcu4j+0Mo0dqJas6HouXNrRcgxZQGoQ+66CHz4DJitmnc9UOu+j9mwz3Amld7VdQJ7TtE47MOcUgBSOfsaCpuP5xT1jlB16uXB6M9dG03tKnGd/jaHsdHlMiEM1T+DRnMTh1O5NPdSiK7H80mQ/GXihu3ls4JmLHSkL
X-Microsoft-Antispam-PRVS: <CY1PR12MB016578BBD0D3EEB0B868890AECBB0@CY1PR12MB0165.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(211936372134217)(153496737603132)(228905959029699)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR12MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;4:JRNFtGWhSaCctgpVwnlwXfVnyDCNFtAMhoUr0S+iHK6geGL5tvF7/nSH9mu4lvzf1veac0Y+/3BfW8QRExhHRwWZE4P8yAz4aPHs62GKOmoIdXWDhjMcB9xNEL5JiXwaOEcJHjgs0fUsXuUScBENTjasgmsxUs+SPlVtSwAOcslMG/bEeIPT2LhFkaCKgytfWVUEIMuY3fLYWZtvvwwHGJtvhdZZePnVkTLhyYiJpbLa8hvJkAkYp3RtyO4w7fqwEbFRduPp/ZEeFBIuzHxjhbz1UxiWP8wb6UNkEoSg4d2Gqppm3RiX2wdtkRJkjUrsDpnYh/omK2yv/3AXYsbaUKbjp6zJjFD9dafbM1camZcTKI7T6ip7c+2QLgG8CSGOGRt4qNiENsjZ8QYExqy+CX6yVhAceOwBV7IWmi97bLckk5ITlq7mdWiWsa9wnH++
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(39380400002)(366004)(376002)(39860400002)(199004)(189003)(377424004)(3260700006)(65826007)(53936002)(65806001)(6116002)(305945005)(3846002)(65956001)(7736002)(8676002)(31686004)(4326008)(230700001)(25786009)(81166006)(6666003)(229853002)(6246003)(66066001)(7416002)(31696002)(6486002)(81156014)(16526019)(53546011)(446003)(5660300001)(59450400001)(47776003)(386003)(52116002)(956004)(50466002)(8936002)(476003)(64126003)(77096007)(486006)(106356001)(86362001)(2616005)(36756003)(23676004)(16576012)(105586002)(72206003)(26005)(2486003)(58126008)(478600001)(97736004)(68736007)(52146003)(76176011)(11346002)(2906002)(316002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0165;H:[10.236.65.235];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY1OzIzOldIMjZBaWl3Y3NnM1hUZFBRdE9iV0crN2x6?=
 =?utf-8?B?TjVSWEs3UEtTYlBpcDQyTGZTK3pMUDdObWtLRU5UakhMNEVlcDRiOVZWQW9Q?=
 =?utf-8?B?TEhHN2lwZVFqemtGSFUwZTJlcnlNa0g2UktKZW9SRWVnWUlYalNWaU1kRmMy?=
 =?utf-8?B?cENqYkFsejd5Ym5xaFI0UE04Wms4NGsvNmhuUFRrWjRuMDVCZDltcEFrQjRH?=
 =?utf-8?B?SkVnS2N0WnBBWHMzbHdjVFVxWVR1UG5sWmJDd0hvUC9ST3RkWUlyV0xjSXF4?=
 =?utf-8?B?UWlrQTNTUDNCcHFoUmwwZDIzN0haM05iRFhVVzN1TjdDcnFNOUJPcm5YRXYy?=
 =?utf-8?B?OGp2ZFBmSlpUM3NTNUp2dnhtK0wvNkgrTVloV1FtY01FR1oxRjhLd0ltZ2gr?=
 =?utf-8?B?NDdLbGNNV28wb2hjQUk2LzZUNm43Und0Vmwvd3g3Ykd5Z0dzSW5nM090ZEQy?=
 =?utf-8?B?a0FodlNBS01LbVVtMzZEcVozZGhaY1VWN0NtTGJEZW5pbmJ2ZEI4WTBOLzdY?=
 =?utf-8?B?NEQ4V1JoazZLZGZDeEt2dytKV1l6Z0ptZ3krNjFnZ2kzU2hobDNlbm9YS2dz?=
 =?utf-8?B?UTlLZEtkeXQ5T1lmZVZYdzBGZVBVRzVlVUt4ajFtWUxKY1FHSmVteG42dDlD?=
 =?utf-8?B?aHVqQWdMRmN4Zm0rNFppd1Ewd1lBdEhIcnl0OHZ1YmZoaWJwSGVFUFd2SnZY?=
 =?utf-8?B?OWY2OVppMTY2UUxVdGFqeUlUSEgyUVgwcDFqTkFqZHJBQVpoWURsTWRDbmQ2?=
 =?utf-8?B?S2p1V2trK2NjMzhaZ0RYaDNHdGtYY1cwdEhRc3Zpa05iVUxPUjF5Nkl2dm5Q?=
 =?utf-8?B?cUJoWHA2NDN1WUJDYVIxdDBxTDlkS0VYRHgyVlFRTXVub0s5dlVka2pYY0F3?=
 =?utf-8?B?MVY2bkcwOE5ITjUyaU1KSWZvdk5jTFk5VVpuQjdSMEprM0Y0VFJzd296RHFs?=
 =?utf-8?B?QTIwSFZoMWJmdzNUUUoyOEFkdmhRYkJvcHhXN21GbjdlZHB3N0hjbkxYYkVE?=
 =?utf-8?B?SGdFWmNFRTQxNTRxOGhJSGxpRTNRQ0Z4SXZ1aXlkQkJKUUYvdzZDbWE0UGdn?=
 =?utf-8?B?MGk0K20rUzBURDJEVy9BbzU4UDZZTm9OQkZtdzU3RzNtQ1ZPUVg3ejY5dFFv?=
 =?utf-8?B?NlpLUFMvMGZLd3RTc3JWR2FaSXc1eFJKYjhMYys1VjZiVnNLT2dqT3l1MHBX?=
 =?utf-8?B?MHY2TzlUZmVnTGZ2R2dMaDZlYUsxRlR3RVJ4dWRNWW12US85V25ZWW9nV3hk?=
 =?utf-8?B?WjIzS0k4Zi9Yalk0VVlTU085TzRQSjRnT1RGemhKTlk2K29zOWMwREFyK1Bq?=
 =?utf-8?B?UkxBKzY0YTJYZnc0R0lRVlkrZ1FjK1MxMUxqelYvMTJweFNXWnB2VXBpUU5E?=
 =?utf-8?B?RHRCVUlVelN3WnI0bWRGazd6RzZsMXVKVHc0ZzhhVFE1Uk0xR2UxMnlPVWsr?=
 =?utf-8?B?Y253ZGZRQ0cvbjdxa2VKK1pYMjM1QVRVV2t5UG5YdFBVYnpzR2VBbjRZUjhu?=
 =?utf-8?B?MmlndEUydGN5MjE4Ly9URVIramt6WXR2S3RlN0xzOWh5RDNXOHNJVEM1L1hk?=
 =?utf-8?B?VUp3eFdWYXdGUkJ3TGxuVFNEQTZHMHpjKzFrNTBjWlcwcmY2dVBwZU1idWtS?=
 =?utf-8?B?NzEwYzRlTndDZFZPOFpXa0xkK0xZLytRb2dyWHpRRTFsTWNLbjN6RThOc1VU?=
 =?utf-8?B?YUE4azgwRkVDZFpWT28vMFBiTTFTeGxETW9xZ3dNblRjNlVpT1lBZ3RLdVNM?=
 =?utf-8?B?UXdtODEzL2ZLOGFPelNQNEdzNzk4MFJiYjBRYzRoTi9Ta1REMXlNdWs2VXFI?=
 =?utf-8?B?QnVOVE5kSUdRSVVZQzFkcjQvOTlJeElJd0p4ZVJoVlNVWnlaV0k4b0hZLzkz?=
 =?utf-8?B?QnlSM1NoaittbU5CdWUzRStVRnBBMFc5NlB5YUtpWFd0ZG40OVhPQytQR1Ns?=
 =?utf-8?B?RGIyTk1IZ2xpVjJ2aUpUQmg3TXdPZTV5U2huQzVvVVY2WDgwUmd6bjEzV2RY?=
 =?utf-8?B?YlpXOE5UMzdKQ2RzanNtNlp3TCs3WCtMUDY3M2g3WDNiWUp0b0xIWUh0c2pF?=
 =?utf-8?Q?SQb0=3D?=
X-Microsoft-Antispam-Message-Info: 8dZDG+i05DVqKT6yi87ZQWb8KwTYpguSRiZuprSrtt13KWgkZCJJmvLBFz4KmIhHMUs4RMMVFXg3w7P4nNuC6HIMjO5bnnu/XJLjwqYF2cSKPTwWqeqBkAWmB3Di3DQj9USwYZSCrmGi7Y3cxEE+l1HyNu1GGAtMXvEgJYSEB72yyElLAAdOZkR6fBOWOOfV
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;6:B17qOVESXXP/devx7h3b5ZV8Liob8xBBgRkFYlIcHZXjaL/HeU81mlGSIYZN4iuvONe4OlnuMmfjx/P8T/CU5YdhxaiXbj9sO75Yr7qCLsgpPJFV4uaDv9T3tS7w+VQ/WGt5cmtZtr5tJTtWDqm1TKbK8R3ASQ/xecgcE6xrkcbQfXeGQOBQqhxDplBRG57he2M+amrYj/jPjFzjLt80y1jIvX1XFJBpyGgQa/8IYBCCJhCdPCy/7iPRAJnYKgL2MQPHTybcSP/fN1VuYcZFLQbQb3PKxanRv/fxfUm7yznGNhdNhR2A2Jla4xO8DZl+AMM/xwh7XnnrP2pry5tPUoG1jWWLrvvZMXGL2zhduEacvPXrUtktaoASYf5DPOEQQbG2xqQOidZ19QqRlpWVpUaP5XXvwNcnWGgZN7KiAytnrcsZUVGPaJLl8bVa6K1cv7u5S9q+9Tlo60i6jM/mtg==;5:kxHIlLIjoy2FLOZP+gkMdRiiRiJuB+iU58XbPHf6FWYxtw0eDBRrvgJpevaeViDlql64tKx0ZCZK6pJV+vFaCVX1uZENI/8oawhJ5kfZ+18p6AQeeCnf32W2mpuGQsR+WqYPSYkmMZimJI8yjIOJAchkGKXmNkEt9En3OZxQwGc=;24:XonyztlMtY3Jy+Ev3vvK9g9Ui6bFmFtWqmoQy+WE3DpMI4PBVCi/b3JWEcZVQODXOhkFswvqbkeGF9e2qL9F7IviRrJhgaSDuU8QdNrE/ek=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0165;7:2pEimtCexsMp4suDJigGs7QMH/XrVZVtvHXhsQHfOBnXpUsOVkLOcOOQL6eBJx6ImVgaZ144oKyUZu+QXKo407rmga5O5m5suleLUpQbLglWr8Ix41WupisxbScmAmZZF2OFmTtPp9dLpzeoAR7cYOjPLgPR8wgW54KJ+CtFRAciRRd3q6r1ZYSBpS+1y1WvPAANxG4XI6z+TDE9Ufy9gvifucPPokia50wamn28wXgp2F5ht/ghjBLWmIDgDFvE;20:hXYGBREx849hYcUu7s88yWJhjasxX/fpjGfAhQBGuMcoyNSeiGF41z+NyQIKP1bVzOgZi0brbM70LLVb0RJoO3pOdCXxdtFcvUejKxNQjvlDYETN9d0hrb7B8GV3DTCBe+zKSzQSwSvUK4g7Kf3xAyq9t8dOcY27JHG+7onwbuW3zBmS8gr1ATvF5jZg+E4d7JlN7OX5P26aR1DdnHMkJSEoKHvmdjhtnT+eY4ML6JsWzNEJNcxt0qyy3Su2FAtV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 19:49:22.1683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0f2bed-4571-47cb-40c2-08d59b2e5454
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2018 8:09 PM, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> A PTE is constructed from a physical address and a pgprotval_t.
> __PAGE_KERNEL, for instance, is a pgprot_t and must be converted
> into a pgprotval_t before it can be used to create a PTE.  This is
> done implicitly within functions like pfn_pte() by massage_pgprot().
> 
> However, this makes it very challenging to set bits (and keep them
> set) if your bit is being filtered out by massage_pgprot().
> 
> This moves the bit filtering out of pfn_pte() and friends.  For
> users of PAGE_KERNEL*, filtering will be done automatically inside
> those macros but for users of __PAGE_KERNEL*, they need to do their
> own filtering now.
> 
> Note that we also just move pfn_pte/pmd/pud() over to check_pgprot()
> instead of massage_pgprot().  This way, we still *look* for
> unsupported bits and properly warn about them if we find them.  This
> might happen if an unfiltered __PAGE_KERNEL* value was passed in,
> for instance.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <keescook@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: x86@kernel.org
> Cc: Nadav Amit <namit@vmware.com>
> ---
> 
>  b/arch/x86/include/asm/pgtable.h |   27 ++++++++++++++++++++++-----
>  b/arch/x86/kernel/head64.c       |    2 ++
>  b/arch/x86/kernel/ldt.c          |    6 +++++-
>  b/arch/x86/mm/ident_map.c        |    3 +++
>  b/arch/x86/mm/iomap_32.c         |    6 ++++++
>  b/arch/x86/mm/ioremap.c          |    3 +++
>  b/arch/x86/mm/kasan_init_64.c    |   14 +++++++++++++-
>  b/arch/x86/mm/pgtable.c          |    3 +++
>  b/arch/x86/power/hibernate_64.c  |   20 +++++++++++++++-----
>  9 files changed, 72 insertions(+), 12 deletions(-)
> 

This fails to build for me when I enable KASLR (RANDOMIZE_BASE), with the
following error:

arch/x86/boot/compressed/kaslr_64.o: In function `kernel_ident_mapping_init':
kaslr_64.c:(.text+0x245): undefined reference to `__default_kernel_pte_mask'
make[2]: *** [arch/x86/boot/compressed/vmlinux] Error 1
make[1]: *** [arch/x86/boot/compressed/vmlinux] Error 2
make: *** [bzImage] Error 2

Thanks,
Tom

> diff -puN arch/x86/include/asm/pgtable.h~x86-no-auto-massage arch/x86/include/asm/pgtable.h
> --- a/arch/x86/include/asm/pgtable.h~x86-no-auto-massage	2018-04-02 16:41:14.811605173 -0700
> +++ b/arch/x86/include/asm/pgtable.h	2018-04-02 16:41:14.829605173 -0700
> @@ -526,22 +526,39 @@ static inline pgprotval_t massage_pgprot
>  	return protval;
>  }
>  
> +static inline pgprotval_t check_pgprot(pgprot_t pgprot)
> +{
> +	pgprotval_t massaged_val = massage_pgprot(pgprot);
> +
> +	/* mmdebug.h can not be included here because of dependencies */
> +#ifdef CONFIG_DEBUG_VM
> +	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
> +		  "attempted to set unsupported pgprot: %016lx "
> +		  "bits: %016lx supported: %016lx\n",
> +		  pgprot_val(pgprot),
> +		  pgprot_val(pgprot) ^ massaged_val,
> +		  __supported_pte_mask);
> +#endif
> +
> +	return massaged_val;
> +}
> +
>  static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
>  {
>  	return __pte(((phys_addr_t)page_nr << PAGE_SHIFT) |
> -		     massage_pgprot(pgprot));
> +		     check_pgprot(pgprot));
>  }
>  
>  static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
>  {
>  	return __pmd(((phys_addr_t)page_nr << PAGE_SHIFT) |
> -		     massage_pgprot(pgprot));
> +		     check_pgprot(pgprot));
>  }
>  
>  static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
>  {
>  	return __pud(((phys_addr_t)page_nr << PAGE_SHIFT) |
> -		     massage_pgprot(pgprot));
> +		     check_pgprot(pgprot));
>  }
>  
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> @@ -553,7 +570,7 @@ static inline pte_t pte_modify(pte_t pte
>  	 * the newprot (if present):
>  	 */
>  	val &= _PAGE_CHG_MASK;
> -	val |= massage_pgprot(newprot) & ~_PAGE_CHG_MASK;
> +	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
>  
>  	return __pte(val);
>  }
> @@ -563,7 +580,7 @@ static inline pmd_t pmd_modify(pmd_t pmd
>  	pmdval_t val = pmd_val(pmd);
>  
>  	val &= _HPAGE_CHG_MASK;
> -	val |= massage_pgprot(newprot) & ~_HPAGE_CHG_MASK;
> +	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
>  
>  	return __pmd(val);
>  }
> diff -puN arch/x86/kernel/head64.c~x86-no-auto-massage arch/x86/kernel/head64.c
> --- a/arch/x86/kernel/head64.c~x86-no-auto-massage	2018-04-02 16:41:14.813605173 -0700
> +++ b/arch/x86/kernel/head64.c	2018-04-02 16:41:14.830605173 -0700
> @@ -195,6 +195,8 @@ unsigned long __head __startup_64(unsign
>  	pud[i + 1] = (pudval_t)pmd + pgtable_flags;
>  
>  	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
> +	/* Filter out unsupported __PAGE_KERNEL_* bits: */
> +	pmd_entry &= __supported_pte_mask;
>  	pmd_entry += sme_get_me_mask();
>  	pmd_entry +=  physaddr;
>  
> diff -puN arch/x86/kernel/ldt.c~x86-no-auto-massage arch/x86/kernel/ldt.c
> --- a/arch/x86/kernel/ldt.c~x86-no-auto-massage	2018-04-02 16:41:14.815605173 -0700
> +++ b/arch/x86/kernel/ldt.c	2018-04-02 16:41:14.830605173 -0700
> @@ -145,6 +145,7 @@ map_ldt_struct(struct mm_struct *mm, str
>  		unsigned long offset = i << PAGE_SHIFT;
>  		const void *src = (char *)ldt->entries + offset;
>  		unsigned long pfn;
> +		pgprot_t pte_prot;
>  		pte_t pte, *ptep;
>  
>  		va = (unsigned long)ldt_slot_va(slot) + offset;
> @@ -163,7 +164,10 @@ map_ldt_struct(struct mm_struct *mm, str
>  		 * target via some kernel interface which misses a
>  		 * permission check.
>  		 */
> -		pte = pfn_pte(pfn, __pgprot(__PAGE_KERNEL_RO & ~_PAGE_GLOBAL));
> +	       	pte_prot = __pgprot(__PAGE_KERNEL_RO & ~_PAGE_GLOBAL);
> +		/* Filter out unsuppored __PAGE_KERNEL* bits: */
> +		pgprot_val(pte_prot) |= __supported_pte_mask;
> +		pte = pfn_pte(pfn, pte_prot);
>  		set_pte_at(mm, va, ptep, pte);
>  		pte_unmap_unlock(ptep, ptl);
>  	}
> diff -puN arch/x86/mm/ident_map.c~x86-no-auto-massage arch/x86/mm/ident_map.c
> --- a/arch/x86/mm/ident_map.c~x86-no-auto-massage	2018-04-02 16:41:14.817605173 -0700
> +++ b/arch/x86/mm/ident_map.c	2018-04-02 16:41:14.830605173 -0700
> @@ -98,6 +98,9 @@ int kernel_ident_mapping_init(struct x86
>  	if (!info->kernpg_flag)
>  		info->kernpg_flag = _KERNPG_TABLE;
>  
> +	/* Filter out unsupported __PAGE_KERNEL_* bits: */
> +	info->kernpg_flag &= __default_kernel_pte_mask;
> +
>  	for (; addr < end; addr = next) {
>  		pgd_t *pgd = pgd_page + pgd_index(addr);
>  		p4d_t *p4d;
> diff -puN arch/x86/mm/iomap_32.c~x86-no-auto-massage arch/x86/mm/iomap_32.c
> --- a/arch/x86/mm/iomap_32.c~x86-no-auto-massage	2018-04-02 16:41:14.818605173 -0700
> +++ b/arch/x86/mm/iomap_32.c	2018-04-02 16:41:14.830605173 -0700
> @@ -44,6 +44,9 @@ int iomap_create_wc(resource_size_t base
>  		return ret;
>  
>  	*prot = __pgprot(__PAGE_KERNEL | cachemode2protval(pcm));
> +	/* Filter out unsupported __PAGE_KERNEL* bits: */
> +	pgprot_val(*prot) &= __default_kernel_pte_mask;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iomap_create_wc);
> @@ -88,6 +91,9 @@ iomap_atomic_prot_pfn(unsigned long pfn,
>  		prot = __pgprot(__PAGE_KERNEL |
>  				cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS));
>  
> +	/* Filter out unsupported __PAGE_KERNEL* bits: */
> +	pgprot_val(prot) &= __default_kernel_pte_mask;
> +
>  	return (void __force __iomem *) kmap_atomic_prot_pfn(pfn, prot);
>  }
>  EXPORT_SYMBOL_GPL(iomap_atomic_prot_pfn);
> diff -puN arch/x86/mm/ioremap.c~x86-no-auto-massage arch/x86/mm/ioremap.c
> --- a/arch/x86/mm/ioremap.c~x86-no-auto-massage	2018-04-02 16:41:14.820605173 -0700
> +++ b/arch/x86/mm/ioremap.c	2018-04-02 16:41:14.831605173 -0700
> @@ -816,6 +816,9 @@ void __init __early_set_fixmap(enum fixe
>  	}
>  	pte = early_ioremap_pte(addr);
>  
> +        /* Sanitize 'prot' against any unsupported bits: */
> +        pgprot_val(flags) &= __default_kernel_pte_mask;
> +
>  	if (pgprot_val(flags))
>  		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
>  	else
> diff -puN arch/x86/mm/kasan_init_64.c~x86-no-auto-massage arch/x86/mm/kasan_init_64.c
> --- a/arch/x86/mm/kasan_init_64.c~x86-no-auto-massage	2018-04-02 16:41:14.822605173 -0700
> +++ b/arch/x86/mm/kasan_init_64.c	2018-04-02 16:41:14.831605173 -0700
> @@ -269,6 +269,12 @@ void __init kasan_early_init(void)
>  	pudval_t pud_val = __pa_nodebug(kasan_zero_pmd) | _KERNPG_TABLE;
>  	p4dval_t p4d_val = __pa_nodebug(kasan_zero_pud) | _KERNPG_TABLE;
>  
> +	/* Mask out unsupported __PAGE_KERNEL bits: */
> +	pte_val &= __default_kernel_pte_mask;
> +	pmd_val &= __default_kernel_pte_mask;
> +	pud_val &= __default_kernel_pte_mask;
> +	p4d_val &= __default_kernel_pte_mask;
> +
>  	for (i = 0; i < PTRS_PER_PTE; i++)
>  		kasan_zero_pte[i] = __pte(pte_val);
>  
> @@ -371,7 +377,13 @@ void __init kasan_init(void)
>  	 */
>  	memset(kasan_zero_page, 0, PAGE_SIZE);
>  	for (i = 0; i < PTRS_PER_PTE; i++) {
> -		pte_t pte = __pte(__pa(kasan_zero_page) | __PAGE_KERNEL_RO | _PAGE_ENC);
> +		pte_t pte;
> +		pgprot_t prot;
> +
> +		prot = __pgprot(__PAGE_KERNEL_RO | _PAGE_ENC);
> +		pgprot_val(prot) &= __default_kernel_pte_mask;
> +
> +		pte = __pte(__pa(kasan_zero_page) | pgprot_val(prot));
>  		set_pte(&kasan_zero_pte[i], pte);
>  	}
>  	/* Flush TLBs again to be sure that write protection applied. */
> diff -puN arch/x86/mm/pgtable.c~x86-no-auto-massage arch/x86/mm/pgtable.c
> --- a/arch/x86/mm/pgtable.c~x86-no-auto-massage	2018-04-02 16:41:14.824605173 -0700
> +++ b/arch/x86/mm/pgtable.c	2018-04-02 16:41:14.831605173 -0700
> @@ -583,6 +583,9 @@ void __native_set_fixmap(enum fixed_addr
>  void native_set_fixmap(enum fixed_addresses idx, phys_addr_t phys,
>  		       pgprot_t flags)
>  {
> +	/* Sanitize 'prot' against any unsupported bits: */
> +	pgprot_val(flags) &= __default_kernel_pte_mask;
> +
>  	__native_set_fixmap(idx, pfn_pte(phys >> PAGE_SHIFT, flags));
>  }
>  
> diff -puN arch/x86/power/hibernate_64.c~x86-no-auto-massage arch/x86/power/hibernate_64.c
> --- a/arch/x86/power/hibernate_64.c~x86-no-auto-massage	2018-04-02 16:41:14.826605173 -0700
> +++ b/arch/x86/power/hibernate_64.c	2018-04-02 16:41:14.831605173 -0700
> @@ -51,6 +51,12 @@ static int set_up_temporary_text_mapping
>  	pmd_t *pmd;
>  	pud_t *pud;
>  	p4d_t *p4d = NULL;
> +	pgprot_t pgtable_prot = __pgprot(_KERNPG_TABLE);
> +	pgprot_t pmd_text_prot = __pgprot(__PAGE_KERNEL_LARGE_EXEC);
> +
> +	/* Filter out unsupported __PAGE_KERNEL* bits: */
> +	pgprot_val(pmd_text_prot) &= __default_kernel_pte_mask;
> +	pgprot_val(pgtable_prot)  &= __default_kernel_pte_mask;
>  
>  	/*
>  	 * The new mapping only has to cover the page containing the image
> @@ -81,15 +87,19 @@ static int set_up_temporary_text_mapping
>  		return -ENOMEM;
>  
>  	set_pmd(pmd + pmd_index(restore_jump_address),
> -		__pmd((jump_address_phys & PMD_MASK) | __PAGE_KERNEL_LARGE_EXEC));
> +		__pmd((jump_address_phys & PMD_MASK) | pgprot_val(pmd_text_prot)));
>  	set_pud(pud + pud_index(restore_jump_address),
> -		__pud(__pa(pmd) | _KERNPG_TABLE));
> +		__pud(__pa(pmd) | pgprot_val(pgtable_prot)));
>  	if (p4d) {
> -		set_p4d(p4d + p4d_index(restore_jump_address), __p4d(__pa(pud) | _KERNPG_TABLE));
> -		set_pgd(pgd + pgd_index(restore_jump_address), __pgd(__pa(p4d) | _KERNPG_TABLE));
> +		p4d_t new_p4d = __p4d(__pa(pud) | pgprot_val(pgtable_prot));
> +		pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
> +
> +		set_p4d(p4d + p4d_index(restore_jump_address), new_p4d);
> +		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
>  	} else {
>  		/* No p4d for 4-level paging: point the pgd to the pud page table */
> -		set_pgd(pgd + pgd_index(restore_jump_address), __pgd(__pa(pud) | _KERNPG_TABLE));
> +		pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
> +		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
>  	}
>  
>  	return 0;
> _
> 
