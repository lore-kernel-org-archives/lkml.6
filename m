Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754326AbeBUMjB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:39:01 -0500
Received: from mail-ve1eur01on0129.outbound.protection.outlook.com ([104.47.1.129]:47846
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754302AbeBUMi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:38:58 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 1/4] vmalloc: add vm_flags argument to internal
 __vmalloc_node()
To: Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com
References: <151670492223.658225.4605377710524021456.stgit@buzz>
 <20180221122444.GA11791@bombadil.infradead.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6e4ab6e1-7ba5-4b18-9399-75eb593050ac@virtuozzo.com>
Date: Wed, 21 Feb 2018 15:39:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221122444.GA11791@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0701CA0001.eurprd07.prod.outlook.com
 (2603:10a6:203:51::11) To VI1PR08MB2831.eurprd08.prod.outlook.com
 (2603:10a6:802:19::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6890677a-80a6-4655-d376-08d5792812e8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB2831;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;3:32wHzB6ePKn/NvK13im+z4D2/Hhqv/jNO3WcxDRLlmpn4aus1JKh+C9vyIV6fK0DTYdSNT67pMDycfMQOBul/pFrUZ8GyIQSBkJLizzVRyj+jE8j75CuI8IijzRXL8wrbR7I3k0X2ig4nUOmBHu6pGyLaYFqjRQ06EYt1hOCGA8pezvSXyP76Kt2iBmk3BpmS8bbebpKO3cJOKps7a1KY8aakQASGMty0bcWyCdWzIdB+hcAXHZ65qiwVbWM3pkm;25:XM3XqS/Do171LhhcRFZb3os55LErVnZ9eiaQvK0ET1rVzobUEcl/vUm3i0iEUx4y1EupFhie7FccPpjQyUPhHB4aJWRRbwcRdwXn9DyDtCjH7jk5e/FPAIfXqSZz3hBCly6cQdbvJHWxFSuMEteSAoJpuPib7lHk4aKushvCmkLDH6K029VRDbmWBuBIHNYKSpxrShhRcMtIDMII7RnSAZl6TJ2pTJ5JyDw3urMgnyFO7l7F4aJQSpgObCEQvTL8JYPk0Q15cJgpByo4aBFzeHzO6s7eGrqPbom2OydufhFTZrny/+JlCBSqWHFIrgSCPjHPd4/6hbQyuUcOfk695g==;31:pObPsdX6vqAYBCt9oKCRN9KhB6TJXKD2jkE0GlPtiZQmjiR+Eb4bzpG416BvUtkiXXsxqizibBYfpjHKJzXXJg47hU4atVloMyxIY5Yk35lBzSWFJxlSFJfqShWI41/t4vdnZJYLKR+pHQSY8flDFH4rNrY43jgbEbO1cuxWErgALxBegNBJ+9QZ+LsSm5bZgntOK4xLWjuQJCtTF+iOtSotbUQYK18ZYRaJJdxfdI4=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2831:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;20:IGPxI15HVQz1r6R3pAAET48pQTtHWBejLA5WTSP+KSNtbjNvZkfjxp3EbBshxDiQWnp6j6scH2wHyiDR1VIkDol59xhQpZ6mKHXt37sYzUrgFQHr2jxxf+CVD0h31QupNL3qDbc+DEFXiSM+Qm/mUk/S1d4RMOVbnS2brvqwaRBr+DC26seuuY7/2CQqUpJEb6TsSWySNjl+46s1Kxgp3/lS1wCTUYELc4ncd+TQIxJXyuHD36SdPMOGz6rjLGHYK61/vChnPBoCJH1UOgmgf/1feSMB6piitXwyZqf0bugvT31eFGjuBcaoAXZm6FZE3lZoVSErG+xZcx7NtBgclVR4ULENCQnRggOplqFXFxtEYVpPPbrbYxzaVRrh2OPqaShkx6SZUZ/u9uzoMHHwLDuzbWoD3m+jvYtFv+mC/Lxs88tMVAK9hLRbjMenvq8gWTOEs0m91oLZS1zWHfOpqVbfGB2S1KDv3uZyc90h2Ao34ktSbDZ5FTQ4eDRPuJww;4:JAi1pOsZtGuQqJvWUZlm6QvIdav8mGeQp5spMYCYTUV9TkJxw9xyjWdZHXBpC8IdjjGJm62RKc8HbfGPMK6o8kGq+JYMSxjb1NUmKNMGzIWN12iJ1WUaBN1xogXHM36of6EJxaoBHUdUlcMHvMQ24nI9oeQnVhZEHALX/2uuCeEqitR1u295LJ/0vSFkBWjMQhLXAo6gbfTEXVnCv8EWo12H+6qceErVR8ND81vnF6DkKgLJdp9xRjpJeCWIUOYhjuhRzfXDIwoz2wO4fzf+HQ==
X-Microsoft-Antispam-PRVS: <VI1PR08MB28311DB77866D09F0D633FCCB0CE0@VI1PR08MB2831.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6041288)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB2831;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2831;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(346002)(366004)(39380400002)(376002)(199004)(189003)(305945005)(53936002)(65826007)(66066001)(64126003)(2906002)(23676004)(186003)(52146003)(2486003)(229853002)(36756003)(110136005)(50466002)(2950100002)(6246003)(3846002)(6116002)(65956001)(97736004)(58126008)(65806001)(52116002)(47776003)(54906003)(6666003)(86362001)(6486002)(31696002)(16526019)(81156014)(81166006)(55236004)(8676002)(4326008)(106356001)(386003)(230700001)(53546011)(316002)(105586002)(16576012)(68736007)(5660300001)(31686004)(8936002)(76176011)(7736002)(25786009)(478600001)(26005)(77096007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2831;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIyODMxOzIzOjI0ZWxDWGZBa1JXUENETitITVlZSEg0UW45?=
 =?utf-8?B?SUo3QWVDTUdwZ3ROek1KNW1BZ2V2ajUxdHk4cWM0MW85VUd0ZjlQNTJ4ZWVP?=
 =?utf-8?B?eVJJVEg3WGcyZUNTOFNYcTBCTWN3MU9HNWNrdXlrMmphOEVibThaVzFDOU9k?=
 =?utf-8?B?R3pyRWxBTnhNdkExS0tic1ltaUYrdmR3TGEweFpzRzRJcGlHd0Fvb2Q3VjBI?=
 =?utf-8?B?SSs2ek50a0c1aXVkQWNxZXJ0Z3FqbkdtcURTSDRyMWUxTERTSDNkSHM1MURt?=
 =?utf-8?B?bnl4SFhVdmErTlRvWnVlUUt5Q3Z5VDR4Nkk3Umtxay9EOURXT3VCSDBlV1kx?=
 =?utf-8?B?Q1JLQVZpNWV0Ly9OSjFPWk56STFoUitTRnc5a280OGRwUm5EVllrd0ZHTVcr?=
 =?utf-8?B?Qk1wYUh2N3QxeUJIWFlmb3hzeEdXRXlwR2FiK1Fvd25odXc0MnlBVC90eG9Y?=
 =?utf-8?B?bmZlcXNnYnM3MEJrcVVTQ3MyVEJNTGErOHNTZXUwWTUxc3lJcm9pUSswQWRC?=
 =?utf-8?B?aGRGYjdQU3VUT0hTdGxoQis0MXlIRk1OZHRUTGJRWmg1TjFVaDhnSnVOb1Bz?=
 =?utf-8?B?UU1OM0tMa2VpTm8rTkdZbk9GL3Jpa3hFRlpuR2NjaFE0YlNBYytMd0tUQW45?=
 =?utf-8?B?YlRnQUJGWmJYWVRFdVJWRGpWS3NvczkycGk0a0tWT29McENKSzdQMEtFQ0Yy?=
 =?utf-8?B?Y0J0Uktrc3gwVkVST0REMnNnbVk3WkNZWVpxeE9xbDFzczZzNGZndFNDWWNZ?=
 =?utf-8?B?WGNlWjhLTjlMd0xocDZZcGFDd2VwZEY2QTBqMTRzQ0FaN051YUJCWTJkTTNR?=
 =?utf-8?B?dGFTcGZQN3NtUldEOWVadVFxSHJHdGJLd2VMTjYyaUE2VldLSVIvLzZjd2Zv?=
 =?utf-8?B?SFZyUWh1UEkvWHd2SFovR3oxWnoyQmlmWkRQbEI3enZJU29CaEJaR1J4NnlL?=
 =?utf-8?B?QTN3aW1ZYytZQm95ZkJNVUNyMnFaQmhRMCtMVXRHUEJsUWJoYm1RVHRGWWdQ?=
 =?utf-8?B?QlExZWhDYUxzMDVteldoZ2xZTDkwcHI4RXhyVm1ab3ZLbFRjdXpKaHErbE9W?=
 =?utf-8?B?YWhRdG83ZENSaTFISStUcEdQeUx2SXNzOGtyRytoMm83QmZyVUxtVnpHZlpj?=
 =?utf-8?B?ZGVNZ2trWUx3dVJFU21CektKMTdCK3VtRTBNQ0tKclVHQWRUWHgxTHVKL1JX?=
 =?utf-8?B?TkpHOG9wQkp2c05zSVloNnhsOEkzVFhRR21Kc0l3ZGVPSzJEYjNWaFdSV0Fs?=
 =?utf-8?B?WmdXSlpmMWpZdXYyQ09JcmRVNm0zTWNXRXkrZkpIRUdwZzVXenBnNFFnenVR?=
 =?utf-8?B?bWZiK1J0NlJUeDExbnZFdUxOYUtlcXdTeDl2MGgwOEVtNkFLdWtqeE8zWW1E?=
 =?utf-8?B?RG9jKzhFSkVkWkhmUTFPSDU2dEVYM09tYXcwUDBXZkxtL0RRSldsVlpMWE9l?=
 =?utf-8?B?TFczcXFLNEFUQ3pwR2RsbS9Rem9DZ0t0VE1OL0YxMzNsaTk0Z0pYREc2SHpU?=
 =?utf-8?B?L3VLUTkzeGU5R1YvbEMweUpXR0plVVlYY2xURVFNWkM1MzlHcC95SUlXREQw?=
 =?utf-8?B?V0N4RXNySnZiOXhXVTFjMzRLcXFubWxEUjQ5ZWxpbUhQdDlBVTF5S3JDQlVO?=
 =?utf-8?B?ZFdFVUYxVUorMlhDUXI4NUU5WmlheFRZU2VJbS8vTEN0ZDl2alJtRVZPTWZo?=
 =?utf-8?B?ZGNhRGhEQjlRTEREdXZHQ2FoNVBSMi9RZVVoRXVhRURZMytyMmdpMGMzNFVh?=
 =?utf-8?B?c1cvL2RwR0R0dWRINkdlTWF3N1ROMjdLUEJBTFVnL1dveWE3d1FDTWdGZjNG?=
 =?utf-8?B?aGZ4SEZMdW9SN2lQczFCWWpsYmNrWUdtYVVaWkdKaDJncjZhaVhQMU1YYkZj?=
 =?utf-8?Q?FKug3GseR+4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;6:RyGtxQBw+0le8nxuLiUdmS8qxatPNlDfrPO+VtZAfl7V0LaE77z10AqOBFe/yt7qkxjUgmK2taBbsWJ8CBYiHMLy4tS4dHurFMbxNZDqKiz1OdzDkzPAMSK/uLBWWqs2tVAOIAoC7Pc8WlKugQ0smfQH7xRGznPINda5vAXKK8a0kUi/daLVoho/xMYuj0po2w7sR5gSMBwdysldRIVN6tI43BExa4nSORD2cvLwf6IBhR+SyvcyEuYkz+/p7o8QRJ2srezLn5azjpv1/6sqTz+B+o7Qhf9uUMmObwVwUu+g5j9KhAjiuHUfjKHG0LuvQ8hoKTA0Jxz3FnI/EZ1sGW+iZiz+ecU173uLDNheqNo=;5:o4wwwqpeQMNPrvuy5Q6oUpQot1bMaGV5TNA4ZjN36M/46s8qCQr3+bc0Bq9bQPiKU8ZOwKP5EVssueaRVy2WoJWhXSQESBu/56sw8ZmNYVSiRmklhLA7C8WAOHQSAxOSZRZbesFkkE573IADKVGnxPIOa43FawsjEOI+jtlTD28=;24:8wUFmWYYnQERANBOjsT7G3flGZgF57OOsgVq7svwkWswOLVqXHIKAzjq6/k2tTfXGnONqKxY7ZVKSrHt1p9/Ub/9cnLiz6fFG60R5jdKITM=;7:1kU2uDHwQEi1VqY9gGu7if6mGE1JTEaknY+r3mYEhK8YAi1zn0tAs8pSc5gJoJ0K17m1lPPOz5pWXL7XChKlc6z6fklatyMTwk/MKDKxR8s5tSSUjOjR6tf6OJ0d37r/x5y/gsxvKK6Fgl7Oh6Lq2vODBiTXseLUQE1qHHpoo0c0S2DHTUbDf7t7Xjo9Rubq2pCkL2mYFweKi5zafP52Sn5txXot6X8Dn9GERGKKnNB9gf43IzMhEBU61YpCjaZh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;20:b4cEh4FhNNHSXgfpEikx1oEFBgBTngh49YF1jbDkGf1Q4XXmU8hEv5vLj70HwzUQvbHadIlAQHrfFHu0oHnwexGcfI/2TRKjsur9CyWJjSAg8HB69L5TKmkl3ZZq72d5Sc262be80Ga1lXSWpeKMKdaeCX1u6bEqi9gPv65zg0A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 12:38:55.8350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6890677a-80a6-4655-d376-08d5792812e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2831
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/21/2018 03:24 PM, Matthew Wilcox wrote:
> On Tue, Jan 23, 2018 at 01:55:22PM +0300, Konstantin Khlebnikov wrote:
>> This allows to set VM_USERMAP in vmalloc_user() and vmalloc_32_user()
>> directly at allocation and avoid find_vm_area() call.
> 
> While reviewing this patch, I came across this infelicity ...
> 
> have I understood correctly?
> 
> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index e13d911251e7..9060f80b4a41 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -631,11 +631,10 @@ int kasan_module_alloc(void *addr, size_t size)
>  	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
>  			shadow_start + shadow_size,
>  			GFP_KERNEL | __GFP_ZERO,
> -			PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
> +			PAGE_KERNEL, VM_NO_GUARD | VM_KASAN, NUMA_NO_NODE,
>  			__builtin_return_address(0));
>  
>  	if (ret) {
> -		find_vm_area(addr)->flags |= VM_KASAN;

addr != ret
That's different vm areas.

>  		kmemleak_ignore(ret);
>  		return 0;
>  	}
> 
