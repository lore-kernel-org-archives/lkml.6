Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeCPEDT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:03:19 -0400
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:19739
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750711AbeCPEDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:03:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH] KVM: x86: Fix device passthrough when SME is active
From: Tom Lendacky <thomas.lendacky@amd.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180308231731.27881.84826.stgit@tlendack-t1.amdoffice.net>
Message-ID: <8937db5e-4c8e-57cf-4059-d9e10ea1a393@amd.com>
Date: Thu, 15 Mar 2018 23:03:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308231731.27881.84826.stgit@tlendack-t1.amdoffice.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0048.namprd05.prod.outlook.com (10.167.112.153)
 To BN6PR12MB1140.namprd12.prod.outlook.com (10.168.226.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7db1735-ec51-4e94-134c-08d58af2d7a5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1140;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1140;3:V/QLCX4wHvZxk5muBDLxa6aZ4geSS0MXdpeXvshfIx15zEDFKPcyieDAKAxgLUkv3EmwKrVSdATPp8xMzFX7+PK3641HN2zTKFuoh4K6nLLwoKCS1T6rL5H8ORgaAg47BEkWyXU3i2XRLO2hohs7xTteS6anAZO5P159sNjBZgnF0lHU4tTHM804K84PstBhHM8+cOUnhlwhtQgGSebJT+DP+rNL9fu6sb0ZdOTgaR1kfzIoGIUTPeYjyTreVWgA;25:lDNT66VudtcshfpvOoDmQaje5F+ZyWeF5VyWrDQs4nAZVfNWPV3U09etRNpk9dfLP5I1rRMfkFF+X0XYrldxwHht1WyuotdzUKqsaplIePWR+CP65PR8mMAvBG23nVe8vgVt1xPpyY5nCAPKor1OYZS9z/Z4usV06KRGUEJT17wEWM+kKqOqfRxwt1WNHEu6eMvYpiuuh4Au5z5jOy+EEbJQs0HDju7PuueqoifzRqN7Oh735TlgWwzJw7XfY1stCLnvD5pqIZkdlVl0U4ai2MLW3uryNkY1kv4/qxLg9sHkaxB7ng+iV1yS/UGL24Ckkjydubs+y7ro9bzKyn7xJA==;31:3uyRRyV3XyRGmIQVFQgzy5AGcGjouFxONYAdk26dM0le/uuXq/3JEkh2KLRUPxfPkOo21F70YrCtTD382Nmtzidu/9LxRDrP8kM5p4/lKUZJKKjj5GkQA+I5xQgUOEdGIG052/3lB1Ikz81IWsasVdm3lJ9v5B1ArjQ6PzFQ4WVZnXa9wunnEr0WVp1hjQLsRHOloiuzzPtQf+GqEayQaEoeNAgqvQhTJU+b+buHAtw=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1140:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1140;20:IPxxPDcwR8Xj2ldSspI/+TnytV1Oom6W1nexuTt6KZ1dMsIo+GBW01DV7KdyVKgigYhX5CHcjBJ9I+RmFIIrZ23aInLv8pZhkQTmOr4C7J7i50nUJ04vBr37/u8rVQX1UbeQFsFmmMFHMQfBXbsNd5fKjfslc/Pg+TGIdeksf4qPZc3esrhFEAMyTgdL75H0KBcLryxGUG2bMtujT0O0FEKYDe1sTUzVvXvxfLN1G/AXlQammvfDk3a6qMTwPLhpmCS9pV5pVs0Q0DR/orVJZ4vFufl/xGzO6LSMKkDTRtPUHDpzwe8r+Cxc8Vd7uewFIpMlWfcF/qVpoZQJmBeOODt7qasdtW3t+G3ukAVYb+d+hd6HrxI5Aum84qN2qUwDz6vuqsP+cK2RFRUBrU1AKUvUPoDwUy1hOxfxZiCcmYyIlfTh3QIiNqXwxkrlu7AyzX11J87H1GWWXh5gpLc7lr9fUDMnze8sEiwZx2coMwtCOGlAUlSDQjwu/ZAoFr1o;4:+DMPft1CaeXGlGpZXXpGr66xZdfGMHa2uEjWbZ8bhE2qnmPZc6yLXgqBz0s2GQ3Rs1LzeIJJCNbOaKSrUSjggx0jH5zJEVEF4QNXOpHyvV+Pp+JfAMfJV7oA7nAUt1sfuDVixnPCH+b0GKWnipULqJExlx12uYlQldv0s7ELbzE2lKmxBl6zn/UAOb2KqH6mvzBLp0VWNuJunnltatKfmLdd/61+gtfR0wJ9r9cXiHzkVMci8zk21509ojrGcctY4zV4kdWQrn+NT7x/ZO1CQrJjD5btmYcnqGz4XyNQsYHmmCCaDz/2iGZfSSD6FaPTBbTAmsWaXmiP0kT9LvuNAw==
X-Microsoft-Antispam-PRVS: <BN6PR12MB11409839B5663E0E6F8B21D8ECD70@BN6PR12MB1140.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1140;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1140;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(478600001)(65806001)(5660300001)(72206003)(4326008)(65956001)(97736004)(230700001)(8936002)(65826007)(50466002)(305945005)(64126003)(6246003)(81156014)(7736002)(86362001)(68736007)(81166006)(90366009)(53936002)(6486002)(7416002)(31696002)(8676002)(3846002)(58126008)(52116002)(66066001)(36756003)(52146003)(6116002)(2906002)(23676004)(316002)(2486003)(59450400001)(25786009)(47776003)(3260700006)(2950100002)(106356001)(386003)(16526019)(76176011)(31686004)(77096007)(53546011)(6666003)(54906003)(186003)(26005)(105586002)(229853002)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1140;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxMTQwOzIzOlVwZTNRYUxZOGtWUDFWa0RSMVF1UExTLytI?=
 =?utf-8?B?cmsvelJ1LzJ0S3pYcFloY1A3ZXR1dmZZTXU0bUlQWmNwRHo2Yk9GVk1KbklG?=
 =?utf-8?B?VFlSSndNdElRblhObnRDQ245ZzJWcE5qS0l0bStveWoyWjNId1BEUVJZVjNU?=
 =?utf-8?B?VUdpamZGN0UwSFlVSkZHYVJxSzd0dkp0OWdoeCtnNjE1bjRMQkhGWTJRRFpv?=
 =?utf-8?B?RVZaTDBUV0twaU9qd0ZqbTh0T1lZQUxIZEtsYWIxQ3pvSWtFc1k0MEwzVFI1?=
 =?utf-8?B?OUpQSGZmdlVoMGNBT2FyLzN2ajdjMkt6ditlUkxYZzdROWRoOXVsbk5XRG83?=
 =?utf-8?B?REJwTStCcC9jdm1DbkNxdXNKTUM1S1A3MjdDLzZ4dEdGSVpNdER4RkVkZ2dr?=
 =?utf-8?B?elp0NStHZko1NUdIcUxFM2pLNXpxbG5VNFVHekZ4aWFZT0Z6RXd2RVduTERT?=
 =?utf-8?B?c21na3lDbXhUYkFYbnRKSWMwaGt5NnkwbTkwVmtzTXpabXZGZXV1eHFVTGVp?=
 =?utf-8?B?K1NLNnJYdE1BeGlYL3Fxa2pzZ3puZGd5a1E5cmRlL1JUWGV6QTNnQ2dIR1Yr?=
 =?utf-8?B?NEhMM29CWEFkdzFsVzJoUDRHSGg1OTdDaWk1NzUvdFluUlZkY0MwWkhLcUtD?=
 =?utf-8?B?ZG40bHptbjdWbGp0bU8wNWRaaFRHQnRSUTliM00zMXhsRkNkSWlHMjhWOFRy?=
 =?utf-8?B?YTVpSlBYMW9sWDFCRHd4ZG5EUWhFS0JlRmZrYW1Hd1Y5azJZY0JCVGtpWjBP?=
 =?utf-8?B?YUR1a3pxKzh3eDNTVHY0bzBneE5MSjRGUnAydHEyNllvSVhsNEhvV2RhWXdn?=
 =?utf-8?B?Zmw3em5VeXpqY2R4eHJ4L01QTWNGN2ZzVWx4bHQwN3U5RUJhVXc5SlpFcWY1?=
 =?utf-8?B?TG9kSTFiRWVmS0dlU25XZWNiSHVMNmx6bXZpNDJXdUs0TzZHU3FZOE9uaWRB?=
 =?utf-8?B?VDJyN3FwNm1RMXF4RHl5dm9HcUxFTVQzcHA1V20xVkJJdWEwMk5Gck5IUlha?=
 =?utf-8?B?ai8rYWdXVkF6clVXcFpscCt3VTg5cDNYUzlmM2NsOCtpeEp5ZjB2MXdkV25L?=
 =?utf-8?B?bDdHeDcwQlNlSWpUOGtaU0E4dTEwM3pRYmh6MThBZUs5UCs0NE4vNFpPQzRm?=
 =?utf-8?B?czA1SnY1TXcyOUhIYkdaalA3a0tCZzMvZm9iY05GRm4ybHFOdkZEdTA1MHk1?=
 =?utf-8?B?V0x3cVl6Yys0REJPK3hLWC9qS2o2MHl3dXJjYkF1M0VhbmRaQ1hMT2tidG0r?=
 =?utf-8?B?OG5WTFpURXd2M0VYMmxSQjlPWENrV0E0dkpNMFVCeC9NNzh2WW93T1p5QWZV?=
 =?utf-8?B?b2ZLc0xlaU5aRVZzK0I3eFRGVEZxc1pQRDFOSGllbHdHU1ltVjR2ZEQxVWVH?=
 =?utf-8?B?RnFxSUtFUE9SaHEzeU9IMnB2WGFYRk1IeW1BRXpNN0FSNmdmY284dnMvUEFG?=
 =?utf-8?B?eEl0L1ZzcVM1YjZhWmx3OENHRVEwSHg0c2w2UEJXTkU4QS9hQUpvVDlSelhI?=
 =?utf-8?B?UW96RExrR0RGbzl5ZFlkamRBWUFzcjZHSW1rL2ZsaFZVQVc4WklBTVNWSGpp?=
 =?utf-8?B?dEpRS3J2S0IwZ00xSHF1TlFpM0ppL0xhYmkxTlN0endpZ2ZoRlBqNVNEdEtC?=
 =?utf-8?B?M21jQWNjMDBMRGhSTHFmTCtYVEJXWno1RE9zRUU0Mll5N3JTREtyNndObmxF?=
 =?utf-8?B?OHR3Q0U5QzJjbERPd3BPRXNnRXk1SVBhb1NFT09xTGJ2MDVrRlo2T3cyY003?=
 =?utf-8?B?aWxHSnFFdFcvZy8xc2thVnh2T1RnZzhmRGdTOW9FR2szdjBoN0IyQW5JWjJn?=
 =?utf-8?B?eWxyWlQ1dDhtM0FxR04ybm1qK296TWdGL2c0RzRHM09ub1FWOFBTOHI1UURX?=
 =?utf-8?B?UWZqaDZSRkVuQnAydWwxaDlxcm1WV3FyNHJkdWl2YzJhNFhmSUk5bEN1SUhD?=
 =?utf-8?Q?31Bh+LpDleqCmdf3XPT9YTr6mEtTfQ=3D?=
X-Microsoft-Antispam-Message-Info: VojjjoM04hxIgRefoberl0g/SQO2C9fZKMZ0jfckxqGbvVc/iKX4QHOoHo4uWAhZP2BtXF3gW+Bm7PqGOrPHseCLnD9M6buob+P4maaJ4YBPGsc5HI6695niUxtN13zAQDzNRRUc4PKXzbR6uIzRVkioxkkgCipb3grRxBoqMzry1R0aaynxsX7Iv3RZjafi
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1140;6:p7okEGp56U7VsA4TJmL9dzD+tGqWJSLd+mNAvD+ECq+iTYM3zWcQFUOJpQ7iRYN/qD41a9CZLfYZtmU3VzUx6P1MX9We6P5dEKnCezVrXwFfkblxRgRySUeXNSRkkCp3f6Fp9aht6teeDeKoOtR2GM4jsNYt4++GkGdws5GPT0HRtHzsMiFRsTRtppfnfCXdjD/TX9eIwgA0oHC9SsOugYQ1ax84S1wDYXYv83UFJDo4gAMBBkQW6ZwlxUxUM+3GmFug62m6eHB2WNQ22fKMRFWat/IaToRKCpPwNUf7yBmfrA8wAqs2ds0KY4Z9F2zrnn78Mu8CkfMPLqi15lmRcZ5UzKzqYD9k13p7t6nrxYM=;5:gKA7Zl2jFk6LhtmONUE3kl8w4VCYaH6bG+RzfCMEjrHPCfeRSYYKfnnhJkx49bZ8ZDd48o5JeQrOfdilv2RgPZ/IDcrBLIR2XuE3Y0yiIv4EiZLOGpQxszdbNapbbmQtjCVEA+1DVZNhhhEgH9mSVmriv0p0CZmgaPHDlNrRDBU=;24:0nvA+IlJINPskt2PnZAHzs7h7yMcH4a/KQhWZ879SLTRSh5H0B3r+Mc9lJBzZ0DzjGHhSOeoJjIxKJAJDGfYMBLnf+s1rW3E9XCrdGwUAjo=;7:7Xy/7hkIA4h0l67ThbPiKWC8ZViMxSpllJgRUMoII6tRPwMMZpH8kVVOZN8v3kianQs0dHRQ1hzuTVHk3zkIrizhaOam/DTUAYS6cRwTZiU+zMU6hfs9vBRZPgU4I6W2OlfPnMlyeVZ+YdloSCpb2N39teCo2pm2u/ZlAMqT51Utjl5vyDLZrpxtMtsnCoIg6WUDFdLr7iDgpTkBEh7Aler3LCKGZSRMUqjb+ZvPQl0t22nlewhYAIknmt44+CAs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1140;20:tHl6sftVLBgo6aQghDwV1CEk/urH8aPi8oiK6W/Nbdvb5y1A5c61kTcHtWcj94UIt7y8VeG6bAYDa3/j/JcOdMZmZTPobvpEgAtYDFuET+pgcWCMNU9eJvGbVmOwOO1YTBnyy91HDTvO4UOVm/yVyzjHnPdSvNYNC3ePV0fIo1ssKl2ErSdUf111s8/W+EhEC7eHLYEksHZOhE5z8yZraJab78wPuMP+/z3z6PUEBc/1HIRWB6yO2aYGDrg1YpZf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 04:03:13.6192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7db1735-ec51-4e94-134c-08d58af2d7a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/2018 5:17 PM, Tom Lendacky wrote:
> When using device passthrough with SME active, the MMIO range that is
> mapped for the device should not be mapped encrypted.  Add a check in
> set_spte() to insure that a page is not mapped encrypted if that page
> is a device MMIO page as indicated by kvm_is_mmio_pfn().
> 
> Cc: <stable@vger.kernel.org> # 4.14.x-
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Any concerns with this fix?

Thanks,
Tom

> ---
>  arch/x86/kvm/mmu.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index f551962..763bb3b 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -2770,8 +2770,10 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
>  	else
>  		pte_access &= ~ACC_WRITE_MASK;
>  
> +	if (!kvm_is_mmio_pfn(pfn))
> +		spte |= shadow_me_mask;
> +
>  	spte |= (u64)pfn << PAGE_SHIFT;
> -	spte |= shadow_me_mask;
>  
>  	if (pte_access & ACC_WRITE_MASK) {
>  
> 
