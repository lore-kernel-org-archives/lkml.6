Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeCESwZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:52:25 -0500
Received: from mail-bn3nam01on0053.outbound.protection.outlook.com ([104.47.33.53]:63936
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751764AbeCESwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:52:22 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
Cc: brijesh.singh@amd.com, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, kvm@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] crypto: ccp: Use memdup_user() rather than duplicating
 its implementation
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <ccd82e60-ba87-d224-3662-365662fa4e6e@users.sourceforge.net>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a4fc5dc1-1378-313a-9909-6b5891fd8d81@amd.com>
Date: Mon, 5 Mar 2018 12:52:11 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ccd82e60-ba87-d224-3662-365662fa4e6e@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: CO1PR15CA0093.namprd15.prod.outlook.com
 (2603:10b6:101:21::13) To DM2PR12MB0154.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e5cd0cb-ba97-400b-38db-08d582ca38a1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM2PR12MB0154;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0154;3:0DIEjibEDHhCrP/dzOStKSIUC3eVsa5oaGvCzvKEV99yXQJK3tyzZLDvBdCLyu56l7Y9oRuD/14sb3xx1JsYWPTlurwPqkH1ARFV0Z062ruW9Q+mZpdXGXL6ihQVN5bGZ+69gRyTNwJf1SPzDSRpdu6tPwM9fgrorbN/t1B0y3Hw+Gj9RgRXWzoEftnKnLp7m981YykrpAAgBNNcizDGW326m9hHLld87BRDiJb1+oyZaXTYUo6dJBaCPNr3Zz2O;25:kAyLPuIgbmMmGPWiuLBbR6N/0+pzWGt1YrVOnOFiMkYyHtxPhJRyJBxBaCDIwl7bc7F49ZU7Skz2ZSh/txE41PGaD63k5N0cPeg+HF7zK8UrbgZ8zBVGbGJiNOPHqU+CIQ0ubbvtjwNxjAu1uiHFcfOl3ZJW1HoDmo5wURJ0via+QW1k+IDIZ9QAlHjT3Jv2pwiF6h5fAOHHQz5amKJuzZGno15ye9/srbxtrO2ioDVB7yRbIgvjK3jrOW1yG53SyQu79dJ7mlriVm41VOeODC9WlynUGhvg+sAYrAewxZcUnx3rC6vSe99Kp+Lajy0HMMu2PvJRpOJ4iRFZ9vZ37Q==;31:OIPCdG72Tj8t4PRfPMC9yV7sSBqg3We2717K2xU7lBN54mxbjzl9g/AzR48tb+PIx1e8Q9VBNSLXU9tBfOABrOJtJyeys7vk1rlG1yEbn7v7P3aH4nwxipVLGo3dgqzNEORzRUYha4f/zCzYV2jd4RIvL1MbyivaQtGwIz89tJfv1/12OCq27b8EA48iSooReRJ8zCh7HQLAmsf5r0oDCbkqkz5dBIrwVaJk7GRN+3Q=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0154:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0154;20:Mq8is2pUpM2g2Twzkkz2f/OVLJ0o8dWQW2JtJzO9D2oMZbXQwE4SjUM0kWfd6swhC7t7g9fITjQZtozev7J9Dq5Wab4ivtvdGBPt/czKEzl48OQtQFDIXvN+iNHJ9faA710RYacJqoFriamLUtT29WFI9ft3t5EFRmZ2cd7OK0bi1EBicQEPkVP7lTtt6lNlDo5qbLuRy3bq5bmz+aMDy8NE2rEoZJPmh396a4a3N2Q+yDTsK8RJLm6uwBagg58ivySzYbahkrzCbS7k/ufV4y7nHKm5RUoD9xvLDyFDS0wXnzpkyPTsqzrqdPr2v+sF3T6EIdG3duax1vp3iAVM4QbuzIYLGEep5E/yF/2SYae0vGuV4WRYtBnVgqkUlzH4ECMxO8xM+wZ/WvrS0NSNf2wLifvV/Dv52TcFIN3ep6lXZslYalTPy63J7r7744Ld2H1gjpIOAm/RKHnDxh6XauYlOOnHMTtsaowf1GzcSkg9zW13CBKIWIJogDOAJxYG;4:UZafxmsHGD2JLMrJsuI2Qdmdl3l4ufzhe71LwaJ3ZyiYe2RNr6FInRF8BnsvaynJN3eD0EFYL01RmyjlSoxskPRYIFMKIaY0phaAi4XCRJpgoHlEbQwowiOmtUJYtLYgnG0pDC4Nagl6BaJco40aHLyQY/m+oOFj/z2l5F6X2ma1aw+f0olC4t+ffdgtOeBmNxC02QJUSw2y9uuu03zgIbZa2NzcUGotebElcW3qM3MTtazVATHS789ow/WgAQ1CcCvfAoGjE6c9f8v0TJ5xnbmOa0S/fMXgIWK7syIlDbRC/t3YaftnnHMt545WsUfdzAWcFochfRDps2jZFQ8A0w==
X-Microsoft-Antispam-PRVS: <DM2PR12MB01549557E2022D06C3573D24E5DA0@DM2PR12MB0154.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42262312472803);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR12MB0154;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0154;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(189003)(199004)(2950100002)(81156014)(65806001)(6666003)(6636002)(65826007)(31696002)(4326008)(52146003)(81166006)(23676004)(2486003)(316002)(97736004)(186003)(478600001)(8936002)(52116002)(230700001)(76176011)(16526019)(86362001)(229853002)(66066001)(7736002)(65956001)(25786009)(305945005)(47776003)(3846002)(6116002)(106356001)(386003)(6506007)(53546011)(53936002)(2906002)(68736007)(54906003)(110136005)(58126008)(8676002)(5660300001)(6486002)(7416002)(36756003)(6512007)(64126003)(6246003)(31686004)(50466002)(105586002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0154;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTU0OzIzOklLdHphd1llSlFSeVhLTHJtUzZ2L3FpY25L?=
 =?utf-8?B?UExLWk5UTCtNSklBZk4wL2xSdW5leXB3RkNIQlNDRnFIai9Xc09EMXpyRXVW?=
 =?utf-8?B?V2N4MUwvS096R25Icm9WZUZpNUJna0ZhaG5iOXJIdWNVeGRkMzZLUkpySDJE?=
 =?utf-8?B?ckFHSmNaYmxmTUUxeEFZaHZTNXJ6dW9UQk5kNEFDRDQ5VE9VMUhST1BZcDZN?=
 =?utf-8?B?a1RLNGROd3JlU0VyRXRORzhJa01PZW94azhxek1zN3FTWFV4a1VobXlHQW4y?=
 =?utf-8?B?SFc0WmM3cSt6K3ExLytWVnNEWmM5TThFelpqYUdIdk5UZkFSdkNHek1LSHhN?=
 =?utf-8?B?TzJZb0l3Sjk5MGVKWHhvY3ZkZ24vcExBM2VqeFp2MTZ2RVdNeWRzMFlIRmJj?=
 =?utf-8?B?U2NFbVhFS0ZqeXRzdHF2aTRJZmpKQzZJNHZtb2JrbE1Wd3k5T0lQd1RTUmwz?=
 =?utf-8?B?bXYxQkNyeU5DM0RrNGJnQkszd21qZzJMVVRTY0loOE9hbmhjQ0ZBcFhhSUQ1?=
 =?utf-8?B?bEFxTjl6U1RJWXdZaDQxSTcvaXpYUm44YVg3VFNSaklmZlFNSjJaT1drY1VZ?=
 =?utf-8?B?dlA1UkZKV2d4NDB6Nm9yUDFvb0FoYkNOaDhTeExQcGxzci9NMDQrVkozWERQ?=
 =?utf-8?B?ZG5BUms3MEYwaVIyenRyYmJvemU3U0hXdEcrTE9sV0syZEJjNDBQWlk0QXpH?=
 =?utf-8?B?SDZ1eTdrd2dmQ1hyZTBHU0gzenNZNFl1MzBSSlpHcHJVeWVrbmRRSUdkUUo1?=
 =?utf-8?B?QWdZTEtHUGFudW54dTNwc0ZsdHJIS0JsWHUrN3RMK3V0eWIwcTBXNEwwM2ta?=
 =?utf-8?B?VWZyVzZ3cGhhaGlWMCtmbjl0Nlk1amdVTlRxT05TeFlxa09JQVJhR09US1gy?=
 =?utf-8?B?V0xpcDVYUXVYc09OcXc0akc4L1o0bkZvVEo0S2JQWTRCejBaQ1RZempscFQx?=
 =?utf-8?B?SUk2RWxHTHlUMUhZdDh1T21FS1BMYUh6YVN3a2x0eE4zOGRWdDA5Y1lnWFo5?=
 =?utf-8?B?aVpCM1BCOTV3c2pkMENLb1V2RXVYUmZBbThiZzdyWWVhMFVxNFRoME8yaUlG?=
 =?utf-8?B?Q01zd3I3dlY4b3hWbnRTeWJ1Zjdtbzhyclh0aW9ydC9TVWpYaGNHamowTmhN?=
 =?utf-8?B?R3YvT05uVFo3cEZMeFRnd3Yzb1d6Q2VGbmxrajU5ZEt1QlZFRDU0WHRCckY5?=
 =?utf-8?B?YnJEL2dKczh6S0FJRC9OYnJmTlh0aFJFME9MTFhaQ2RzdDJQT1JQWFRoS1JX?=
 =?utf-8?B?dHZCV1lQTEF1akM3MDFVK2dEN0xrZXBpcFlzSG0zT08rbThUdk9WZG1MTm0w?=
 =?utf-8?B?QTdyQUR4RzRvZTRsNDJsbWd4ZnVtNUtsOE9CTE1MV0RDNFMvSWpVbWx4MXJB?=
 =?utf-8?B?cEJTZ1dDSzlKZnBmMUorNkZxYXY5NTZnQUFkQ0Q3WXZjbzRBVVZkMUZJZ1gy?=
 =?utf-8?B?L21TWERSUkpSTWxCZWhCelB4aUZkTjhNN21tS1ZYdjR2VjJMMlZWOVVVSGdr?=
 =?utf-8?B?ak44bE1FdGNwbWdXZG0yOTk5U2Q4TUEzZEZocUEyeE5NNjBscUo4VzFhS2Q4?=
 =?utf-8?B?dFhiTGMyMkd2dndXOGhkcmxlNHoxcmg5eW1VTmMrNTdBZ3Q5U1dTYTZnSHB6?=
 =?utf-8?B?T0RFbHpLK1Q3YzYvL0hRSU5XQUlpS2pHQ3BRSGVkZnMxY3FDQUR2MDdZNWls?=
 =?utf-8?B?ZEx3QUpyVlEwc29Uek54OUhoMExDWThTaDRWcmRDdi91VTZlREo5L3Z4SU5P?=
 =?utf-8?B?NWlqdXNFSCtLUDlSSkhRSjVwZW5VV3RBTW5PMWtCbVNQSjUwVExPL2dyM0lC?=
 =?utf-8?B?QURNcldpN1BzYUpneFJWbzBNeTFmWWt5K0lDMUdLTldkNXhHT3pIRVQwN1dV?=
 =?utf-8?Q?beK9brVdriA=3D?=
X-Microsoft-Antispam-Message-Info: 6pFv0UixpQp2xUvt2mABgwbhA7Z5VwQJN9cLCkaIrwoVxxRBvulyNO0FGNPi68InM0dhF0kO+4jIWWkMqpYzo2qhn5vqh13XbnOtvLjnriPvDRNDBVzMMJ/Zp07m4Mn9+rU3yOU0sdO8rNTzgvcleOw0ppQoM/396ArAVC97BL7M7qa2iwAsXaa7GM+sVE+x
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0154;6:17xxdrFGMZyWr0EIovT39VWGM2TYzYBx9HoROIFvdcnHpIsv0QnKQuWhyWXr7MHY65ZalHyu/YO8oVXtIKrQAvIUrxzACiF364s+J83OvdeL3wBnmqCaR2LVr4wImTpDQ3wfuhDpwfEdOfIuhlNL5Easa160MV+4iOdDAkiG1rG4CsaZNJg6djABJhkhLrXum+iT1tEWGVjoNdVR0yP3VzBKySfypGUJbmFSCtPF9UawGw3MVKGYM24qbQxNqA2U17PxSYdWXSJJfRnsSCS9BDESdlnnTkTPYBOfMTfnnPudpoV5bNRLsJJsgyexvYY3ozevyIbwJ0h3bVX1AEzaviJf5dHOU18yAWEziVWRHAA=;5:uHaO+ov9QLtfxgWTgskNaJLp/WFcn6kudrq8rfHsCAqr+ka3N1KoWF63Tvjkf7CAgEvqOeSzlEKjBelR4K/nqICan/5DyQmlnK2G05Nd4eSG/8hLjYiorTO1T5Mfq12Bh+d/ZoMPq9rAL46aJ1MOITSDk90+S0m7txNN7AZRinM=;24:7AbQc1oEi8KsdvhYU5/MTF/Ch1DK1h5Lm5klEBYdcL0MidvDjtfrs0p8TxLJOMYnqfojUY7h2+4QilF6492coBv35iSXYERmasOQf5AwGAk=;7:bboNY3UgLD8ncrgTu8Sgt3NJV2H0ZC7IRGJ0IXRXk3NK76tbfpo6iKkgvMpXcHYPW4CBd1p7eEkmzub2addYemzUG4xC7Fjncs0KYBvPUdtIAK9B+HgwxoiN/tcayHue/+jrnIkL2ZJxgo0hG7Yuw8MDKUCCn3SyXIlHYo9DV2ot3cpQ5E+KgW2UiVKFcbrFGbsh/9EznIPbh4L5pxo/a+kfMf52pEUBquLWYPMGLdcIQTxRFwyzTJTBlszfl/6G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0154;20:qFFZaHKIdiDNSMKrHpbNKfPUGBqZWTiXIAj5BuiIZpzcGx/UxRNUt6a3+EYvMQ6IzSIEzoLtdUdDxC9nlTaPitIA/PAzj5yyJS6QHp/eLNWLTsfSqSsc/zwCE9ZIpKsP2/dLaZDvVhApFGeR3NP8tam+erh4lvHyBsz3OJ67UCfwvr//0YC7AO+3z4zJiL656f8mBJC3ze4TI9HJ8nS28agwbIL/kPQi7n9hD0EJmuQAVTBPXGpqEsvnZwr1yIeX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 18:52:16.9762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5cd0cb-ba97-400b-38db-08d582ca38a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/18 7:10 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Mar 2018 13:50:13 +0100
>
> Reuse existing functionality from memdup_user() instead of keeping
> duplicate source code.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/crypto/ccp/psp-dev.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>

thanks

> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index fcfa5b1eae61..8255258cd040 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -367,8 +367,6 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp)
>  
>  void *psp_copy_user_blob(u64 __user uaddr, u32 len)
>  {
> -	void *data;
> -
>  	if (!uaddr || !len)
>  		return ERR_PTR(-EINVAL);
>  
> @@ -376,18 +374,7 @@ void *psp_copy_user_blob(u64 __user uaddr, u32 len)
>  	if (len > SEV_FW_BLOB_MAX_SIZE)
>  		return ERR_PTR(-EINVAL);
>  
> -	data = kmalloc(len, GFP_KERNEL);
> -	if (!data)
> -		return ERR_PTR(-ENOMEM);
> -
> -	if (copy_from_user(data, (void __user *)(uintptr_t)uaddr, len))
> -		goto e_free;
> -
> -	return data;
> -
> -e_free:
> -	kfree(data);
> -	return ERR_PTR(-EFAULT);
> +	return memdup_user((void __user *)(uintptr_t)uaddr, len);
>  }
>  EXPORT_SYMBOL_GPL(psp_copy_user_blob);
>  
