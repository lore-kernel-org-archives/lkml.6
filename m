Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeEUPwz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:52:55 -0400
Received: from mail-dm3nam03on0085.outbound.protection.outlook.com ([104.47.41.85]:43840
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753307AbeEUPwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:52:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
Cc: brijesh.singh@amd.com, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: X86: prevent integer overflows in
 KVM_MEMORY_ENCRYPT_REG_REGION
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20180519060135.GA4991@mwanda>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f8e3af2e-08d2-bcb2-be09-c93f8b6d6bd6@amd.com>
Date: Mon, 21 May 2018 10:52:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180519060135.GA4991@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0072.namprd12.prod.outlook.com
 (2603:10b6:802:20::43) To BL0PR12MB2449.namprd12.prod.outlook.com
 (2603:10b6:207:4d::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2449;3:tYFNoY/dABrRCmW6C31b94N7kaSO/4N4fdjojHGG7c7zrw1+yXznf0+2BBvYFEGQehIvGmaeo54p/AVFGhyDnkZ5ZLjaal/a4TNF7xniAxJdvNxF0LFP2y0VnxHLObd8WW8BoqLJPXDZ+V9q3huOuZjtK8T8wu6jBEy4WFzMljsc0+7WNXdhCSnD98v0XUnxv+ngrQep2CLoJXH41EtdUF6Cv7q+I1azQwZ24zxk1rmOn/BvyJufenc7JlRqkAUy;25:nQPoNKwgY5FL2pb4CzXtyG7oK1XhrC01Yb914YtvKAqQtyJGnmynQZN+CAe6qYBI+Ls2Yld4PJIbyqqrPeFpqQrpmC8B9A0zASe86kg3rkqZsS09Jv2pFzw9+7REqzBJnyjvJ1PC9mwUs6f9nl769LXgGsu9bvvJjzyFe+mV7qfu/D6yw+c/JU0Y+zXg7d3mIrR7pgwJsRTF4neP4psG8vJYcKSEduWI81BAAjWSovU+jMsvn+elXzPPW3oRofTp6kpv0n+oKmxAcW90MJ1I/xzPVwegiTWppmJyGhrUxNHPW9+XoApqykqdAECcU4hJzM62LF2+fTXn3HtMLfolpg==;31:JvJQ3Em04t4iMRfqfoqZWgIH5KdSDiZ3K2ko0UimHr4MuMJB9tjB4XweLf5sXYi8Tz5AhlLx//zsyN7neFxvE2MbLzIOSuj6GmcCuLqQ1kabquqGhfasvq5Gd6bH0jdVy0vemocQiLnAn8Pxx5LxvHwCy9tB9gwqDT4EUFRtStIohXI0kW88bVuRKxqQLdYGXVvJ5p+B6ppRG3NB54xBTZ8ElX4ojJYOPzw+sFVcL2o=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2449;20:Rw0woIkAE6gv1powo9Nyhv+6xOVv7YO3f79PmQuXlKAp08w7dnjUpaw4fmjqcfgBGjqiC7maOAnMKCXLm8eKVfWkaQiqr6pBTfmoTTMwIq0OihQ2BnBnmJz57bRXEwype9LS4WIsWvkkxdVJD8DFKwBGvtxxyH0ymEgtlMhRtEZG0AbS8z+1JuusJ5x1HkZRER0qTNhLuloibgsf3qMegDH3On7mkY/7wMdGn5gtjP9DMD1TEMbiXDJGKtH8Thw0SEAWKZaCrWePbFA5JOxwHOsBCakmGt9Ik5SXVlJYsEStGutjqmRGN5BByWlgFI9QSPENZqkutjTM8xsuXk4P31w+O4hUQ541dwD17rHhHph0+OchWkTQdTVe/+3RVsYRNFGqKRmb3MT9Ec6NhSVMHpKyPHismhTZO7uNQ/Ww9ST0RUnNpmxPD+uU09Uxmy0vzdTr+iH/UBM+q6rWCCPHLZmKxptj8gFcIkEPDQssoe8VZOWqG34UmxpksCsx+mja;4:SCX8eIc2zIK1z4CYYXaA/JvWwBWkG6J01oEFAt2d3uj8L3FYIMjEjhwXlaHNmfnoTQN5dAMYK9cGJP5dZd4Pq+E1xb2UQyP7lkimNRn5IKvge9hryN4oC4rQywdtw3cFHDJSUyIkzzZ0E64jkF31Qk5E5gpySzu3SluY+H1TT7E5ckG3Jy5OPr1BhUt9qJqBCjIHsHpCaz8dNH5dvL3o0q+XydarJhvzj4td3mNuhsmy7+Un5wOsrvNqYBmyzZQyxoXUmKzKikjxRvN1uOj02B1hIJ5VKZIt5XViEGfNf1NLpxd3FbLFI5Uyvg0Lu9McluBFZ9LpDICYoRAC3QEJqQ==
X-Microsoft-Antispam-PRVS: <BL0PR12MB24494153EB446040E3610FC8E5950@BL0PR12MB2449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL0PR12MB2449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2449;
X-Forefront-PRVS: 06793E740F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(366004)(39860400002)(376002)(39380400002)(199004)(189003)(110136005)(50466002)(956004)(58126008)(476003)(25786009)(97736004)(486006)(86362001)(31696002)(53546011)(54906003)(3846002)(65956001)(66066001)(65806001)(6246003)(305945005)(5660300001)(81156014)(2906002)(8676002)(2616005)(81166006)(47776003)(7416002)(186003)(7736002)(16526019)(64126003)(65826007)(44832011)(53936002)(6116002)(316002)(36756003)(77096007)(26005)(230700001)(16576012)(6486002)(68736007)(229853002)(106356001)(386003)(31686004)(23676004)(59450400001)(52116002)(2486003)(52146003)(478600001)(446003)(4326008)(6666003)(105586002)(11346002)(8936002)(76176011)(67846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2449;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjEyTUIyNDQ5OzIzOkdRMEJUR0drSjlTc0hBK2s2NnEzRVBwWUxr?=
 =?utf-8?B?dGd0ZWwza3RHQVJsaGNXbWdyTUowdVA2ZExldFNjYnVZR2dmeEdNUlBSWjQx?=
 =?utf-8?B?ekpsVHU1Smw0SmVvWnBGb1dPNk5acHJ0S05KaGR4c25NZjZJVy9CWFJZSm5J?=
 =?utf-8?B?T2dDdEdDY2lnUHQzNWUxanBlNFhvcEdEQmNUdnNXcTJtdFNkRTlMZ1RHanRv?=
 =?utf-8?B?TlV0K1VEUHpEN0ZhVUNBV3JaeUgvaC9XOGVNalYzYmRMYStiMjE4YXF1cURO?=
 =?utf-8?B?SDFZU0drUnNCOXhzanJqSXdhMHBjVitGWDg4Sno0Q29NTEczb1EzMEFJdmJu?=
 =?utf-8?B?dlRZcFd4dFpTYUU5eGY5bHdCYzRYaGJ2RE9kL2FQYnhRUTZkb2RqUGpoOTlR?=
 =?utf-8?B?dTBrSmR6WVhMd285WTFaYlJidEgxZ3Z2eXM1TnFwTUtqMlVzbXdhTWNleEtN?=
 =?utf-8?B?Q1FHNDRUQXhCRmhwYyszN3dVYkFPS0RlOGpOK0tleG00eGpnSFpQVHFxeWhh?=
 =?utf-8?B?Q1g5Zy9uZE5WRjE1MDFJWEpvckE4NWlTRmk3K2dRQ2ZHQjBkQTNwTFdqZFp6?=
 =?utf-8?B?dVBGdldFOTJVcnVOT0U0SWRteVBtaVJBYVJ3ZjBRK2JKd3B1WmRobGZocExM?=
 =?utf-8?B?UHNZWi9rYWZBV0I3QXhNKy9zUzRlRHE3UVZNdFkyM2FVdS9iN1B5R3Yzd3hC?=
 =?utf-8?B?UEdwOEdBcm41RVpZck1lc1lLKzA1ajVlQ0pNY2xvZkdpc3lDZFNtaklwdWtU?=
 =?utf-8?B?cWFPOG1keXU3ZVdHZmhrcDREcEFnbi96YWsrTE45dHJpVHBGaExsZU9OMllT?=
 =?utf-8?B?TkFidmM0eGZueS9oYk1jZk5kcWNMWk9IbzNXY1paZ050YUJJUCtmQ040czE3?=
 =?utf-8?B?dEZrODZYZCtGV3RoTDFFVWRQVGV1ZTExTGRsYXlvQmRyZ3dLT0d6U3JscW5z?=
 =?utf-8?B?SUE4WE52RzFTOHUzWmI5SUtXYjdZV2I1TTVKLzRSNGkxZSt0aW50TTVEdVFG?=
 =?utf-8?B?cHBjSGJIdFROWUNreEpPaFlFbDRiNUtSNzVMWjc0RVczZjhMOTFRQjlmdC9i?=
 =?utf-8?B?WG5KZUxpS2Q2QTYyTWVpcUdFNnRtL1psdE5ETllUWVF5enpMRTBPS0M4dkN2?=
 =?utf-8?B?VDkyWHR3WEV5Ty9mRUxVS2ZiSnRXWG94U1FvZWl5Q2gyTWlSNksvd2hPMTY4?=
 =?utf-8?B?NjI4K3dZUjB3WmJuUmJNWVJMWEpCTG9oanFXd3I0Skp6SzRaS0hUenkxU3JL?=
 =?utf-8?B?bk9FVTN5T2pDejFSSEZSY1hwdGlTRU0yUnRwekhMZ0E0UTZyNVJwWmdjL0lC?=
 =?utf-8?B?QUZXcU9KRGtCOTlRcGR2TFE3QndYYkFFajVjdUxRZ3MvQlg2emwwN3BnU0Jq?=
 =?utf-8?B?eFkxK0c4c01EZTNqQXE1RGtLY1BDeDhEMUxkQU85bzhCbFplQVhuNC8zcDVN?=
 =?utf-8?B?aC9VNVZBdHl1amZBR0QvY0E0eThVMTlDUDNyeklOTzJhTWd2eHQ5MjY2SDhZ?=
 =?utf-8?B?bjVVeGpHVTI2bzJkTk9hbGQ2V3ZSYjJSbzdQOEs1WlFpN0h1ZXk4UnU2ODZi?=
 =?utf-8?B?MFhlNVh5NGNRM09kL3VGdlYwSnFPakxWMnZZTXBVZmZpUFBjeHVIZFY0ZmdN?=
 =?utf-8?B?UkdHTEJKQ2pFdGltUFR3MTBkY2N1eXZST0R4bWFDRU5LRGl6cDdER09TR0NG?=
 =?utf-8?B?WkFPU3dEcU1uK0JPd0xiT0toK0ZaMk5xNTNhVUNneTlkT0NQSFM1aTBLdHNG?=
 =?utf-8?B?VHFnYjlwUnF1ZlVYKzN2ajFoNXQyUUVUdFFEcENjb3hZbGNaTFErQ0drcXJG?=
 =?utf-8?B?MkRlTzYvcGdRWEM5N2NaY0c3YlJhclpaZGVPWkFMQlFDSnNkbUJRS0xadGVY?=
 =?utf-8?B?TFlUNnZCM045NmlFV3RGb2dZVEpyeGJBSFN4ZzNiUTFsSmRuUmJNY2lyMFpn?=
 =?utf-8?B?Z2NLWi9pd0lWeWVuYUE4QmRmS09qTUN4RmxlMnBGcFFjOWpuZExSZWlmNW1y?=
 =?utf-8?B?UFNQd0VDMDB0TEZYM01IMVorT3lWK1NmVXhQakw4WTdWM09QRnkxWjlhdlRk?=
 =?utf-8?Q?zmDlM4Azy1hciPF0glXACMekB?=
X-Microsoft-Antispam-Message-Info: iNFE797sz29y9WGTEa0sZ7cQMTxDvASoRdiIVyy3yCe7OSgxCTpEfxz7Xc07k7juNjRmo1NqEPkNVYbzp76YYmD6DFWLpiXTJmzSdNWwdQ0hlhpVDHSTRTmVExyE9em7J25m9AavXEILD6y1KZ7akOwlHNI70lx9QD9nLi0t+faShT2mKRvWNWGNKIQnPIOi
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2449;6:AAlxyNX82vrxiYMFYFMGaoHAyYjUZMQoAmWxcxndWqKAly/e8j8kdWlx8Lb6XTpbABNDcixNsnJqKmAR3R08a10Td/8QJSbvhkWmHdMLybzjYX3tBkZYtCEcx5SrQAakc1VoLGifjMyw/9YdOC4oi1lV6d/zcuk7iWUydVXkDM1IXd/Lh1ifQYuk/DXYIQzdAC4hdtvBHnbkHNxxnrhnGEerjyVFmdEyRxzuUmMrskBTVC6cCykF+4MxFwZS4U324jApVLMTG3Zi5SlMk1QMPYhx4h79noFIA4HCvHRvlS66MWMfr3g1Gu0jU7OObZ56jctNJHJjqUPnmkafyn56O8Obqv9E1Kd/K8y/Arasps0S3q3tNB0oCCunjMGiVkj2IP/U3wQ4gYTdzfWR3JmyIYC/Hvtk0Su/x2Dhs9o0PEoQT9KXruxqZns5AxsjbzsW7ie3rzIN9Ndjr0/0dYgOLQ==;5:/B+elX7hrgGwyY0PQrtyoyfozb75XpmaUwBipc0d4Ptwpnd96uD13FkQ6E9bg3b0I90zPdQ9EdAiUMplXszMjA0ACQuBF0md2HhX4u5dAbOCusx9wWE5pJewGE+Of0AOJ4ki0AJYedulUEdZD5QNuoVe4PCr45cAkUK5mIv941U=;24:VqYCU86sbeGJX3+Ob1/4ALJoYQffsFW3fX7fDRFeM4tbvg+Qs6pWFLtndnt6+RaDBO0dYd01p+2wS4W2D4cr7VOpjpCxh2My7bAC5z9y3Sg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2449;7:EwtOzp4xT+HlFtLUCdly4oZNAYtywEzm+sxsjrPQ+CA1LH2ssv5GCssKd9P3XHyoiaGJMPZ1xtVWYVPCgVp2K/YYTzkSMBXln9L6cngL4Mp80x3J4DIYK1/v2DswenakKF55Kf69h7Cl/vAg+/mPbK8hkjToq12+usco/acoZlis3Yza3u/aoE7dl9/4zQwde1GRc/UDrP9QLilW2z1DY44vGWVEjyZFVU2ss1BlsSQtvaq97LuPu1jJdRdGUS9/;20:wPFvRvsXJUzOE4o6Qa5je53YUYf1Q9UE7XIeObM9lDkKojgZt+pAVsKor1SnAIldnvoaXICxSmFMDZPwhFQcevQbMqCRgLK6cDb3xelfLiFdDpSFIKHsWYAo9eA+JYN+fM2ZhsPX3txUsvwVSwTK5KZG3jUq2u0e/iZyfqUWZqidwTgQQ9xiFYSdwAEkCikxRwCwc5NsifiZQGpqF/gpMXeMgI86sfaoXS3PSvaZeYk8blxre8IJxxE4AI8Kva1Q
X-MS-Office365-Filtering-Correlation-Id: 19241b38-0e2c-45d5-689b-08d5bf32e3c2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2018 15:52:42.4806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19241b38-0e2c-45d5-689b-08d5bf32e3c2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2449
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,


On 05/19/2018 01:01 AM, Dan Carpenter wrote:
> This is a fix from reviewing the code, but it looks like it might be
> able to lead to an Oops.  It affects 32bit systems.
> 

Please note that SEV is not available on 32bit systems.


> The KVM_MEMORY_ENCRYPT_REG_REGION ioctl uses a u64 for range->addr and
> range->size but the high 32 bits would be truncated away on a 32 bit
> system.  This is harmless but it's also harmless to prevent it.
> 
> Then in sev_pin_memory() the "uaddr + ulen" calculation can wrap around.
> The wrap around can happen on 32 bit or 64 bit systems, but I was only
> able to figure out a problem for 32 bit systems.  We would pick a number
> which results in "npages" being zero.  The sev_pin_memory() would then
> return ZERO_SIZE_PTR without allocating anything.
> 
> I made it illegal to call sev_pin_memory() with "ulen" set to zero.
> Hopefully, that doesn't cause any problems.  


I think this should be fine.


I also changed the type of
> "first" and "last" to long, just for cosmetic reasons.  Otherwise on a
> 64 bit system you're saving "uaddr >> 12" in an int and it truncates the
> high 20 bits away.  The math works in the current code so far as I can
> see but it's just weird.
> 

This change looks good. thanks


> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>


> ---
> Again, this is a static checker fix.  The most risky parts of this
> patch are blocking "ulen == 0" and changing the types of "first" and
> "last".  I felt like those changes made the math easier to understand
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 220e5a89465a..de21d5c5168b 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1762,7 +1762,10 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
>   	unsigned long npages, npinned, size;
>   	unsigned long locked, lock_limit;
>   	struct page **pages;
> -	int first, last;
> +	unsigned long first, last;
> +
> +	if (ulen == 0 || uaddr + ulen < uaddr)
> +		return NULL;
>   
>   	/* Calculate number of pages. */
>   	first = (uaddr & PAGE_MASK) >> PAGE_SHIFT;
> @@ -6925,6 +6928,9 @@ static int svm_register_enc_region(struct kvm *kvm,
>   	if (!sev_guest(kvm))
>   		return -ENOTTY;
>   
> +	if (range->addr > ULONG_MAX || range->size > ULONG_MAX)
> +		return -EINVAL;
> +
>   	region = kzalloc(sizeof(*region), GFP_KERNEL);
>   	if (!region)
>   		return -ENOMEM;
> 
