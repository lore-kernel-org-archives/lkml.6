Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965330AbeCAAeT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:34:19 -0500
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:27645
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965280AbeCAAeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:34:15 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH 2/3] crypto: ccp - return an actual key size from RSA
 max_size callback
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <51c265e4-6153-3e5e-316a-ebef059ac36a@maciej.szmigiero.name>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <510c8c85-8619-5fe6-9275-1549a73bd545@amd.com>
Date: Wed, 28 Feb 2018 18:34:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <51c265e4-6153-3e5e-316a-ebef059ac36a@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM3PR12CA0082.namprd12.prod.outlook.com
 (2603:10b6:0:57::26) To SN1PR12MB0703.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eea4f89d-d777-4324-f939-08d57f0c27df
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN1PR12MB0703;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;3:6Z7pPQchAWI2beSRKcCU0lFWtYbDCd0BAcuP47b1RidpgtDgd2cUvMy8SIwyyCEw5RUm0sgpMfzS6iOqf6PNpNxovS+SUoBA3c9jQCVGMs5Y997opjv4LrFyAPuoByc8uLupSskQkwqWAmdA2uVT8l+Qh7d2A+P+cws19quOWkhWFd3QKk11QwVGZiYxAQK3s36+y6VuzXxMlHc6DZ3sXr8uVzjmqY6v0GmVu//HxeeaiX7S4rLykrvrlEzXuz28;25:lgspgnFHeuT6MuvUWJX9StUY5nw83si+jqEy0C4yCifvR8XrnfU4h+XGd8xEgsLlZ0w5Bny7qZUZbF6ok1INegc03Kp+C8dDwOy+E2UiKGU/Vb7CJqnK3eBQ4nvpY1KMphm04lhXwDS6a8MCLeUvutFpAQjmK5QvtXQc8nET+T4NX0188rG03bBz/HXXIvt9RT4GbXCr9dulLepnVpV36WGdJ+harfYgkyuH1p4sXjw5TUwtKjjGK2mdsPze/eR4R1Ra5dEBLQsBdJfagah9bFZbY1YXpUrbKiwjMPX3KzUIk2FpFSKYnEbETElzAoiv3m5dNMNu3dn9vOJD239sEA==;31:J8FuEsm6TqtAt/UgfgDkdZSG6ynUrIzVKD+sAc8QNZtwoVeCP1rs96OhS3JOFEOJ+nQcW0kRO4pso98INZL1SFKgHsmV8DkXh8Hd1M43hmrrO6onHAHBiQkzLHITWrEdnj3QBdJuFs5aGfqUR7qRfUHVHk2SJbG612iExundGv05CTrhf41kx1HiJMq4hT8BLa8RL2rlghUkrEuKWC+ZoXUBc1jMRo9z/yl08/I9yj4=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0703:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;20:290TZmsmfvWPl7YzLrmy26LUiZsO8eFYpg5fWE5OfAqFnclw5tsJqtRiZGYFV+WxigG1Dz4PEBraOL9KjJ6N8uIo6tqEex3yB97tKPczzgEaRNnpuVcoax52TFj4a1NiudtbhfyHwPL8KNT/lDPvwCSXR4G7TsfjVvvl1SWYaLZ2Xmxz7f9DetnVQPVpNdn0rUmekthPj8lmOowBQUcWrSLmc2IdaecYnzVjXRZt3aNZOy4kHGRCKUg89WcrM1XRnCsZ43xL2e4q2oUKt605nuSSwDMqYiAblfgbSXO/7x+GQTm4jADKVWM/MxA7HIO/YhxpNSOo4lizMxp1oR3st+Dq2fyN+hj7vS1s7YRogwdwhAqoTOxJq4Y4zW6LrSb97Wu6SUeKbQLs2wo1/CZG+aUCKFawsdNgH4cJWEpz6d5Hbrx4hhkwbkShAumLaZZYJCHjaGBIq0MHG1+kRzwooFsmACjcV4H7rZxGCHADnBy1FmwsiPQ1jTWTEEBzxXcF;4:c3MhNb/cSSQrDEBZrhXWVchmn1WUIVGeAUSk1Z+ESceYWYxy/DGscV0GkEQgNOTVtEmihvhOuKNljvCy0JsnX+U7lFnHJzmcaPITU8UXpnrywJk5NLji91IANeghGR2vUUJHg0RzNundXgmeHKNWL6w1rYnooNX8alDzEhCWn4DnA+0hDFMF6/ZuKeaigdmfy0KMIqSaHYrKxFdZ49OKqh57c+ngBajH19I2VJpWWQe6K8M4gQrVGx8f9mU51QEXy77qIyStQGNFHSG+jwJUZ9fHqP5MPbsvOYG+Z7YZqj/wyjv9oJPQQch8v3nDYRojG5BO1m85m0XsdEC7Jxnnhw==
X-Microsoft-Antispam-PRVS: <SN1PR12MB070306316EF689A0FCBBBF49FDC60@SN1PR12MB0703.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501161)(52105095)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR12MB0703;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0703;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(50466002)(2950100002)(76176011)(67846002)(5660300001)(6116002)(68736007)(66066001)(106356001)(230700001)(65806001)(47776003)(65956001)(305945005)(1250700005)(7736002)(229853002)(31696002)(575784001)(64126003)(36756003)(86362001)(65826007)(6666003)(3846002)(4326008)(52116002)(72206003)(26005)(6486002)(186003)(2906002)(53936002)(97736004)(53546011)(105586002)(59450400001)(386003)(16576012)(478600001)(31686004)(16526019)(25786009)(8676002)(81156014)(52396003)(316002)(110136005)(81166006)(8936002)(6246003)(77096007)(58126008)(54906003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0703;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-2?Q?1;SN1PR12MB0703;23:m19nJ2DeOj4LxiWmyR6rfG+F8YJOfbytnPXHDvA?=
 =?iso-8859-2?Q?0KKRBamkJ86SiNxT1/VeblGyk3q9GaNsOEQ+p3TzV4lmpIVBZPmp2LsK1C?=
 =?iso-8859-2?Q?iWgYVt/D/YtZ3oh83ocnZqaACDFDlIP6+2TngBwtDcRqxQn1cmFClpL6bl?=
 =?iso-8859-2?Q?bNgtJ8nBGRLae8YcIyEMTOoCasuMGWaY3GErfPJWSAbCXSIN+wf1D94ZWo?=
 =?iso-8859-2?Q?F1lZ+NnMdaMKxlHpWz/23r/q2Vv3ifoKoVBvtYwh7G+Xq8+Y5w+YxFW+Q/?=
 =?iso-8859-2?Q?jgp52IFsPoqZ8v1dIZ8Znin4UJzoNEJqTKcd59mbxwRmNS/zjbh0w3Hzz5?=
 =?iso-8859-2?Q?invY8XhI0RWgYGvRLCdmHv6EZYNtWhWX+vsFZv5L+wn1/xNs5CPoA3UzMH?=
 =?iso-8859-2?Q?xhNJLCc5nMax17r88iFF4uHfUEnRx/NS/pmFQMWdySYVmslWVNFuUj7s5l?=
 =?iso-8859-2?Q?9TmK5Y0dTREg4ihZoPELc1vAAQ0h+Ql2Q+y6Zj3JbIZu7LxCABU8NTiCKx?=
 =?iso-8859-2?Q?7CSp6iftDFxg24cIq7qGYFRairA9RifouFzRdqCvG9gTSWD0KIS18Zte5Q?=
 =?iso-8859-2?Q?3BQTKoV0M0iVSohSDRTfpNnfxKiDjmcXQciRql+Cb+Uck6fCzXXskq/oMx?=
 =?iso-8859-2?Q?m7L1u6bAM57YQ5XGN+R4u8ZZlNKBZITfOw9rkDFFLLiFcm1SqaQl3CRtye?=
 =?iso-8859-2?Q?sZPBsOOfCVwpd6r8J8kszw57xnmXk6zv5SvM/LvdXyL3L+eobBggTCqUJ+?=
 =?iso-8859-2?Q?DPZSdbir7yp+7JI4TfPmkm9qM1+3SsCNnqo6qXu9z+qWXzrV3/4k5K78Pw?=
 =?iso-8859-2?Q?0GEebfRTABqXZghY/kP2Hl2gdLnlRAb1GQ6Cg0xWbjg2K92fVqTm9K0oQS?=
 =?iso-8859-2?Q?9Xm282zF839jWPucmBIj3wpfauQQoo2IbiZs21wFIDZx75xxks4mJMP5aI?=
 =?iso-8859-2?Q?n+EHtVDNCVdejUXiF0Y3JFx3EPjouP3X1zS17JqCIvn5LiOzhdcyWxSJWc?=
 =?iso-8859-2?Q?EfaIH+jvxvzc0Nb9ihvBDLNq0kXP6jT2vsD7Xd3EX6bHVhaavi/XB5QQY1?=
 =?iso-8859-2?Q?B/vFIUApCnaFvoXRnvaUjx3wtmnoIgg82R4/zvZNCQ5yVnFLqbFeyWOgFd?=
 =?iso-8859-2?Q?fraGsVxmq2te0s2NxAgRbO+++62q6QcdD9YxDmWiP4ahIC4cICqe5YWNGo?=
 =?iso-8859-2?Q?gXhXnJvoU13Gv/dm1HWehQTAYU9oRcDqdmLvviB3kKQ0VfLIYiycoTVWM+?=
 =?iso-8859-2?Q?o7yHAXteuwtqmZWGVtksIkCsI80pz15P7E3CYdW0TA+3nuaHuspz9UAIk2?=
 =?iso-8859-2?Q?H0cVercnMzbJ1JcPiTzEZiT+/D/62bGJl1H6ljTqtsEzgUoURgbqZPIHwW?=
 =?iso-8859-2?Q?0ueBt0G8fLT7AnTu8oytKg0SgLrV2kPECVWfLW0Z3t9uL4xagGj9R294zz?=
 =?iso-8859-2?Q?MxqtAOolOkV3b5b2Pa21rIhqZ0de4vIgeYzFOjORQm2o9Cj9Xqexw8TtxC?=
 =?iso-8859-2?Q?HXHjLhp0xkc+q9GqQaBgb8+R0QKj795BVSSZYCGBN?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;6:R8S3JvRdSDNZ4Mem2ZALseMWly6DuAamThqE+mXQFznzfukjzXJ7wELeaonX8jDb2hkW/UMnYuefpVJCkmoY/YN8HiLWVneQkMcthw2mkZ26BI1FkD5bEWlJOAT1scAEsodfYL6+e7r3kR4/ZjaU0nYyc4CwoQ3NJg63zVkStOT6+i3NLtq0XzLPiPu1LY7oBWcPQqG5kBVVH/SjSNcDomsfrJsYg6AVNupuhNrPDqPRxs9o+1xpbWXXsIEsNmMM2rz0il3vJ3+0ovndaCcgX2W1NyruwB2fz0MqYcbq+3hwkDO4NDPLoeXiFOygGs5OcY19D/ICszs/W3HHA4ybQWm1fzfFjXXONj1FXQft93U=;5:1Zvx25cZ+nT6TopQpmO9gdDF+nWIWUbPjstsSPzkI9zKRQtAY3BTrWTes13KOoOo5oD55HyDHKXTGebKCHMUC+AzFynHSAEIAFSzsnGzE9Dcgj5sgzX4Bz3GwvWIitWY3HHt1nTG/AjGSO03Pfy4lRBfmXN1KFvkDCtNeIRFdFI=;24:rkM4DN4qfJI+Dfm0R8IyAVBw7td8RwlSpkebQQFtI7tmsfTAfKPxZPBNKkanYNv2Q55o+SahRhtZyJBYFD1S7uUJ1uvfh7Z8SsYCfs4jpWs=;7:mCvvebTSLR1tvKbiLUK/K1CNOjp1//brDW6hl/oY8aofQXXcWL2YUIOzU7yqUsQYnbSQHA56a67whCqSEhIHwgoKXMxL7GJ+Z/mm0DMsU1nEoCpCRDwgX1rSvoIWfjjJANX8Vd+kDRfqAvLKCbHH0Me0ovAdNMDGMkrxLjH7yo4cvX4xWSf/NuiIauo0eSdWnhytS4mz/AKDBQIyPcJIa7nl9OdHL9JpPoQiseFs5s45avPEw8G4tHa389diXmAe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;20:vtjDP+JFU+6c3ld+KQJcKD1VXW6SdjglOaiSU5yMn4Sf7fCa5jorydsx21w7NWgkeazbIZgxjmae5nNa/COyZOOHeLiCs4ys4LX9aGC/euA34PrHyI4Grl5DxFw9ejVF07oTVR4bNv2NA7ZO/bPTyz6PkBLbWidTQjo7ScRWZK3dNv9RR34r+N+OpixA7Rv29WIB6Yidav5hA9IP2tVHjmZxm70sIxk4numBG1CkxGbos5cqvsvMFe1+/UNvmj0L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 00:34:12.3117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea4f89d-d777-4324-f939-08d57f0c27df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0703
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/2018 10:03 AM, Maciej S. Szmigiero wrote:
> rsa-pkcs1pad uses a value returned from a RSA implementation max_size
> callback as a size of an input buffer passed to the RSA implementation for
> encrypt and sign operations.
> 
> CCP RSA implementation uses a hardware input buffer which size depends only
> on the current RSA key length, so it should return this key length in
> the max_size callback, too.
> This also matches what the kernel software RSA implementation does.
> 
> Previously, the value returned from this callback was always the maximum
> RSA key size the CCP hardware supports.
> This resulted in this huge buffer being passed by rsa-pkcs1pad to CCP even
> for smaller key sizes and then in a buffer overflow when ccp_run_rsa_cmd()
> tried to copy this large input buffer into a RSA key length-sized hardware
> input buffer.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Acked-by: Gary R Hook <gary.hook@amd.com>

> Fixes: ceeec0afd684 ("crypto: ccp - Add support for RSA on the CCP")
> Cc: stable@vger.kernel.org
> ---
>   drivers/crypto/ccp/ccp-crypto-rsa.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-crypto-rsa.c b/drivers/crypto/ccp/ccp-crypto-rsa.c
> index e6db8672d89c..05850dfd7940 100644
> --- a/drivers/crypto/ccp/ccp-crypto-rsa.c
> +++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
> @@ -60,10 +60,9 @@ static int ccp_rsa_complete(struct crypto_async_request *async_req, int ret)
>   
>   static unsigned int ccp_rsa_maxsize(struct crypto_akcipher *tfm)
>   {
> -	if (ccp_version() > CCP_VERSION(3, 0))
> -		return CCP5_RSA_MAXMOD;
> -	else
> -		return CCP_RSA_MAXMOD;
> +	struct ccp_ctx *ctx = akcipher_tfm_ctx(tfm);
> +
> +	return ctx->u.rsa.n_len;
>   }
>   
>   static int ccp_rsa_crypt(struct akcipher_request *req, bool encrypt)
> 
