Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeCFSEN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:04:13 -0500
Received: from mail-co1nam03on0086.outbound.protection.outlook.com ([104.47.40.86]:22238
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753504AbeCFSEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:04:10 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH] crypto: hash.h: Prevent use of req->digest in ahash
 update
To: Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20180306114512eucas1p286d36bafa1bc719d7e7ccbaa9f549fc1@eucas1p2.samsung.com>
 <c29d442e-22b6-9013-05a4-32c8eb04b692@partner.samsung.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0d5cfbd5-8675-290b-f840-d9121872f8da@amd.com>
Date: Tue, 6 Mar 2018 12:04:04 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c29d442e-22b6-9013-05a4-32c8eb04b692@partner.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR10CA0061.namprd10.prod.outlook.com
 (2603:10b6:300:2c::23) To CY4PR12MB1143.namprd12.prod.outlook.com
 (2603:10b6:903:38::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efb0f07c-8003-4885-01d1-08d5838ca8b0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1143;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;3:i9mqeno0mNQv/mYstck05/hig2nqS89x0dFIBN/EG/hHEzKSN+Jo5v4sLRY/y2xs8vqFW6YawoWRziETGLTPJpVEJt4g06obWioOA7HzCxBydtbweuAcCMnpkZL6OUN0bGj26jQm3iF1aaz4QXF+CmtgZ7EpFqdNwgyLU3QKRkTGVT+HCROyU9LK7z63rBQP7zi8P2cPqwKmtoPru18ovehLzycaH4LkFQQRtNxztuCT2DAd8FsDRRR5jPk3uF6V;25:9RM/ozjjYIqY5bbmwIkwb5nMEnISycnHcVLKe+Fzxw/q/nK31KqxPklAWBPN5tqgDYIobQAuYu8sDpyUTgSaUqdgYQdtIUyKPkxuTBtjIvQeF2XbIajEEXwy7Ou2ZK1MS+K7dcnvOUvXuYregitPSban/MMouFxJg4L27PvBXRRlSHjcpYNmpdODefhrz6FQ8qE+mU7KTX022cEBFE1ApaFjAaBmYX0jUL/S6On+1D4SXSU9hX92IVdh4b745NUGot3H5Nu1uUgB5+ClEX8xTVZ5l8O1PikfpJ03avMYoILtBTmR9EjZJBx3xMIJ0BSoXVY7gtNDNpBuVnG3ZhA20Q==;31:ghW2TDuoQ1whz9rlSY203u+hjrhppupY3K9aUmKbx/mxnc4wYayvH+j0yaZDND25ge9ySXsDS/DWpGwbdrsUPortIcW2VOGGyNxLNzCBfJSLKvawZPfS77BxTh6SqpVM5JL2JFTS1agYJLfOpXy8+Q/K1PeG10M3ZSJWaqSpYA1iaAMpp1ikem+HMwTNOSTBX3hJstBvhHV0r4s26QLt847/Oor/pOXTrghEKW9zOyI=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:Ly+hvs9fjjLYwuut/pMHSncIdubLoNzl94cfdLSkr26u0xO5A8G+gXteZfIqTBKABh//i4anjFzo2f9RIeyRJ8LdBrdTpyexjR6Nbaa1Ob1gspxDoRTirpoTbknUcS/qSsosPnSZhhHKzY8pSdPmp8oogwHUcF1eCxVTtNeT/bIOcFBx6TEARgdnFQotRJ59VfaCd4fsT+kNubn2kyy+75euJfQxNrmP8jA21YQAaor4EU3TqPn+poDfvSM40/qTimNjN+hUvmFRfrpTyWodMVZ4rWycCoeIvk98X05oWMDqxkqz37X6o5HfU98jz6sQt/byV//NqCV4xnG8Q1g68iopCnFdFz3Kv9Oh8ZyKM+hvXo/kguDq7UJK880XXIlVvi8m96r6i+cF0o+35P+jFu2tNe4W8aZl2YemVXXh6Kx6QzVynQ+buNE4yVvT/eUO27N/rqne3HZz8tBbwSZwNAmTDHKLcLSQP/N/fL9fOqrNMZ+LnEWWZeYsH36/DgbR;4:cXTGbZGytAheCoEjYJisLya+/RbwrLH6uVq4Ap/Z2a28HfY/QZ8ZxwybcfSQVrg7EVxUIJQtt8p9Z908E+tcBj+odkE4D7WDhoNZL+CUQkMzhM1ZMlfGZ352Pm9wc79AxLwEHLnMfMkr5smXdC0Tg9GN3xyVIW20YSes9wSa07eFDJfDQ9wnaxQiYQ7De3NNo9UmgvJNOuXKKe38vJ2I3H6uLCVoFbb1R5z7hGC3mr29LYQhtr0C5TciKdaY5LBVLA2puwnOlhjw+zVVHMa93s76qqsEVdxljdGslLRUsjPFDI5gfR3iu6LZ5YbM6KIR
X-Microsoft-Antispam-PRVS: <CY4PR12MB11435F15AD71BD3765D23F89ECD90@CY4PR12MB1143.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(7411616537696);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1143;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(39380400002)(376002)(396003)(39860400002)(189003)(199004)(18543002)(105586002)(110136005)(2486003)(15650500001)(478600001)(6246003)(230700001)(6116002)(31696002)(26005)(53546011)(3846002)(386003)(77096007)(106356001)(47776003)(305945005)(16526019)(7736002)(86362001)(2906002)(66066001)(65806001)(65956001)(53936002)(76176011)(186003)(6486002)(3260700006)(59450400001)(23676004)(81156014)(81166006)(52116002)(54906003)(36756003)(316002)(50466002)(4326008)(8676002)(52146003)(229853002)(65826007)(64126003)(72206003)(97736004)(58126008)(8936002)(2950100002)(25786009)(6666003)(5660300001)(31686004)(68736007)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1143;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQzOzIzOlMzbUx6VTVPQStCRTBocDNMUitBMUpIazYy?=
 =?utf-8?B?V1lSVXVORE9GeGtHdTVLcjhVcXphZ2REYXdWQ05PS0JIaXFFSUxsVStxY1gx?=
 =?utf-8?B?d3VDSVBLWDd5UnFBZGE5SnFIQ2dBUWI4NUlSZmtGV3lrMmcwUUNQNEhQL2pU?=
 =?utf-8?B?eEFCVW8vK0tZNHQ4K2VYUGMzY21WRU5DVlNNMGVldzk3dzZKZ2E5WVN4UU5x?=
 =?utf-8?B?QkhkQTNKdFRGWUFqM3MzS1g1QUJhYXV0cDZQMHRBZjN1UXg2WGdoM21XK0hL?=
 =?utf-8?B?ejJyc3F2dUttckVXem54cWtuTTBScW5nOGJDYWFOYWhRS2JTQVVyRzE0dDU5?=
 =?utf-8?B?ZWhtK0ZJMmxhQzZlNkcvYVZmcmZ4QnZOcXR2MG44OEVad3hZNGFmNUJNcWtE?=
 =?utf-8?B?WlRYcHdMbDRsYXBzd3VxTy95K2E0N1Z3WUpsYU5kUnozU0NocUZvUHhxN3VF?=
 =?utf-8?B?U3UvR0V0WmJ6VkRkWmI0K2RsM3BqV2ovMk5FTHdDRzAzYlJWeWtMMk4zRzhI?=
 =?utf-8?B?U2tZQ2xHTWFMWjFDMHN1YmpDTktBQktrYmttck5yeit2VTdldWVPYmtSS3ND?=
 =?utf-8?B?bVljZDAwc3hlQW5QTzdhVXZSKytxbjhoZThWeE1FZFlnVXNiUTBvQVlpM1BR?=
 =?utf-8?B?SGFtbm5Lay9BM1lXOCtwZ3E0RWxCbjdHYnVTc3J5R0RSSHk2RjdBdGhaZG5K?=
 =?utf-8?B?V0p3T0hCZlFzaWRXajhqMTBKbVF0UXJNMGMxY29CZE5MRmMzWHBIS1RrbHNP?=
 =?utf-8?B?cEhCTTFEa3A5VUdJUENLSHpGNk4xaGhqUit0MDNqaW5MRGR0blljN2FqenM1?=
 =?utf-8?B?QldUZDljNjBaM0VNM0xyNWdyUkNJNldERWhCWHFObDVrbXBvZHlBNDc2dyt2?=
 =?utf-8?B?MjIxbmg0MFlCVGlIWTdNSEpQTGt3SENlN0hkK1N0eXVENWZ6eHZTdVYvZkZX?=
 =?utf-8?B?YlJLQzFqMURyQlVhT1hzM0RLOU1rZ1RuZUZIRHJwT2J3V0ZnU1NFL3pNZ3N6?=
 =?utf-8?B?bWF2WEtDVkY2ZVpvazBrMHAvOWVFQUM2MXd6elY0bFFaNWxMcXFISkhJQ1pS?=
 =?utf-8?B?ajcyWmwyUm9vajBoOTRxRXRwUTk0ME9WS0RscHlOVDdlc3BJMC9kUXkxRTFX?=
 =?utf-8?B?WkV0ejFmSGFRakxGL2JpZzdGUnQwdlR5aWxuWDh2UEZWdEJGc1RsK3NrcFMy?=
 =?utf-8?B?MW8wK3JzSXJaTjFjakI0bHRFNWpqaVNUZ0pNL0QxU1lCK3A1OFRxVjdtaEFs?=
 =?utf-8?B?ak5ZYUlzOVB0eVpoa3pJbVFyVkp3YWN4VVFwdmN4dWs3NmJrZktlcUpPbXBm?=
 =?utf-8?B?b0dkMXhHMXh5Y0U2NnRBUnRPTFZ1Y2psK1hjUzM4TDEyV291M3c2ZHhQeVlP?=
 =?utf-8?B?Ni9YLzBYVDJEUTUrMXJMUmQ2Q1NraVQrUmNtcjV6d21rWE9kdG84VmhUUUZO?=
 =?utf-8?B?V25HVktMdDN5b3hIcDFsTGlzNXpBeDh0RTZXOW9ob2JqQVY1dVJPZFVUa2tz?=
 =?utf-8?B?b25iS0dtejFKNmN2RGp0SnR0angyRkZNTnhlZS8wMVNxajFCbHJEY21pL3k2?=
 =?utf-8?B?NkVsVmswdjFFZ3NxS09IaHVIWFhyOWxqNDJhZ1p0WUErK1JQOUR5UmM5V3l0?=
 =?utf-8?B?Tm9uWFFXdUhFV3pzZW05dGFsZkxoeHJKRTE0bDJwNSt1QjdJOFhmbllIQ0I5?=
 =?utf-8?B?TFZ4a2hOZWRoVVdRQjFrMGFyWjA2WUVzcEw1ZGFWa3YyRTNEN2c1bzNGdU9v?=
 =?utf-8?B?YkVVdlZyUEE5Y3VmRksybmduMjYwUndaSUJHZXg3alJwZ3VwWTNJNkQ0RHd5?=
 =?utf-8?B?S3dGTkVyenlKWXRuMGZsSGVKTllXYlRzdjkydktlNGhlSXNPS0VtRk8zN0dj?=
 =?utf-8?B?alp5VVoyUU9EMjZlak5GeURuSkYvMVlGRmprY2NyTHZNazU4a1FVM1VsUnhk?=
 =?utf-8?B?NS94SXdLN0d2Nzd0dXZOSkhHRStsRG0xYlJINlZtdjd6TWJDb3NYM3pKZFVK?=
 =?utf-8?B?UmVzUStmYkVBblZTejlZUDdwT0paYUFJRzNoZz09?=
X-Microsoft-Antispam-Message-Info: gR5s8RNOh3gSV8UlOyPMrjjAp+SO4v+T1CQpX4JYJimunIZljqlj83WHPDeeLyuXOJN5BfOVrxsQClzZyKj53yLpFFyegHjkS5XSFQdsYrJJkIpj7xX2G/59acf7JdkHFVcIiqUHyVJV+PHSkbn0YVfrrkjB2n75CPDb7WJsfraZu5TynNcCEdnOeP4K10U+
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;6:9hyANMblRBeZ/M5SR3MklphhQBdDDxCR3Yxkw4HKuuvDvi0ka82CkJBoyvjiLNmXDHEwcySGR1wvWsxJlt1fLDxFWPpf8JdIkiBT9gLhaDsK7k1SfvijIT+Bl7vrofm3BWt6zhOak+pfRzs9LxuFS2Brg5XlTs4Io1x5C1bUbA87NhuK7NwR4QDovhJEgvtgJG6bsLVpdXw4fC7pg+7G2sJAzRWPH1ZfT7YB7+NIQe63VYgVhuxXAPyeMkgGxjwC1/RGJg5dc2PFMIOVvRvhk5gU+ADV6HNwwSOBlYxPiWxgU5LAlcqkRdiNLovXrhLhS9/xhZOilEQjqpUyxsY8dyy8GIbEOJs90q42vtFHKpE=;5:rBxDkGB/9K5nTbCG43t4I2lzGwQlshMXohoFEe0PzFqpUiYQUOpE22WigTHQF8tpFt2hMVL8oh2XfQwF1v1KcS17UfJciONJL7yeE1Y4g3DiDf3tzcktMDyDavQ0pqQ7GEndEZcQnRegmPZQSUiktaiOaTgJq5J04E8lgEZX1Co=;24:teAkN8bZn2uArfQVQmCku17gbSCmEM9uuUUcOBnLGLdniKM4mPIThYMMIHFeb6upchAAx0uX75Lx+gMhWmJGotcjm9gBCKP/9WGknBVMClA=;7:2Ju+986YKGMTWhioeidXWTC0s0A9jPsSGtjNISpSIAFxlln2CR2TYG83HyORYUPXJkgDU/mKSYQWI0mtoK3GzCMs9bYBmHH/vWKW0mNS9vC25UthM/VcrqTjfWs6ycra+pU22HCaSBSoE3DzGVw50tMX+I7D0axmfN7rCt0FuqSgkMCmWlQfHY+lodihmg2BegRW3Z1a+CwCy+9nWX4pPBeWgYZHOP1s18jCzxu3fHFTn1fuznY9DGOnJFptiJvv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:yDLn8fRE/xyxyt6vdkz8uJUY/w4kC+pimFU3Cr32GWxXNH5ALRxeaKjwG/+M/+VIAiE5heyKyS68JbMYo2srB7xKa2USWkL4xhUMDMCxEz0qCC51pHrCOiVrlEZp1W+U3Ilqz2Trwl3fAHchQjaaEwcORzcFKkLRChyGUHFXGWJ9fnK9QvW6rUQEpcbDWuLXFXWoaKTvlsPhuULxQcVCCg/HEgl3WuRxhT4pzLc9KeSnL/fjWLGJ+8Q1nhmSJNUN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 18:04:08.2966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb0f07c-8003-4885-01d1-08d5838ca8b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/2018 5:45 AM, Kamil Konieczny wrote:
> Prevent improper use of req->digest field in ahash update, init, export and

Shouldn't that be req->result (here and below)?

Thanks,
Tom

> import functions in drivers code. A driver should use ahash request context
> if it needs to save internal state.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  include/crypto/hash.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index 2d1849dffb80..e97c2e662d6a 100644
> --- a/include/crypto/hash.h
> +++ b/include/crypto/hash.h
> @@ -74,7 +74,8 @@ struct ahash_request {
>   * @init: **[mandatory]** Initialize the transformation context. Intended only to initialize the
>   *	  state of the HASH transformation at the beginning. This shall fill in
>   *	  the internal structures used during the entire duration of the whole
> - *	  transformation. No data processing happens at this point.
> + *	  transformation. No data processing happens at this point. Driver code
> + *	  implementation must not use req->digest.
>   * @update: **[mandatory]** Push a chunk of data into the driver for transformation. This
>   *	   function actually pushes blocks of data from upper layers into the
>   *	   driver, which then passes those to the hardware as seen fit. This
> @@ -83,7 +84,8 @@ struct ahash_request {
>   *	   transformation. This function shall not modify the transformation
>   *	   context, as this function may be called in parallel with the same
>   *	   transformation object. Data processing can happen synchronously
> - *	   [SHASH] or asynchronously [AHASH] at this point.
> + *	   [SHASH] or asynchronously [AHASH] at this point. Driver must not use
> + *	   req->digest.
>   * @final: **[mandatory]** Retrieve result from the driver. This function finalizes the
>   *	   transformation and retrieves the resulting hash from the driver and
>   *	   pushes it back to upper layers. No data processing happens at this
> @@ -120,11 +122,12 @@ struct ahash_request {
>   *	    you want to save partial result of the transformation after
>   *	    processing certain amount of data and reload this partial result
>   *	    multiple times later on for multiple re-use. No data processing
> - *	    happens at this point.
> + *	    happens at this point. Driver must not use req->digest.
>   * @import: Import partial state of the transformation. This function loads the
>   *	    entire state of the ongoing transformation from a provided block of
>   *	    data so the transformation can continue from this point onward. No
> - *	    data processing happens at this point.
> + *	    data processing happens at this point. Driver must not use
> + *	    req->digest.
>   * @halg: see struct hash_alg_common
>   */
>  struct ahash_alg {
> 
