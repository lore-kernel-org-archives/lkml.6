Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755464AbeEaOsL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:48:11 -0400
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:28715
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755042AbeEaOsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:48:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Thu, 31 May 2018 17:47:49 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] bitmap: Drop unnecessary 0 check for u32 array
 operations
Message-ID: <20180531144749.GA6828@yury-thinkpad>
References: <20180531131914.44352-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531131914.44352-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: AM0PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::44) To BYAPR07MB4374.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::17)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4374;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;3:Td/anLvf1VU2OpdsbywbU1TdQuQLJ8ng7mQXyFUbPGMo0Bsow8iN1cAW6oeFFxJaTm0iXCmUQgp440QmmTaOGaGxcaiEYox7+7NmPW0AgwESO4iLQRcMsuBxhZzwLGnGlN8ym0mjs8RIIP4G6oN99xhvWEq2HmgBXlplEiGLEc8hshw0MHZ33ux2UVUbBf3eDaNpt/ELQVL2MrV5PSE2Ibr/XTucjs/6LPYD8IIWk7k7lK0ND/U6nEtxe0xYfWVn;25:iVaRF8cDZoeOcOlAnTFtT4PZ8MwOsR0DCj+yOumEo0KFnQwth9Ea6mGSoulxB17FZKG0DbPLGXF3DO4LNky6+UOLeTVV/ec38Ab1FrLaD7c8GKZzm0v06iTX9AdJNdnwwWuO94Rq0JfSiit3NgGQyn9b2RFO1i6PpJIJl8gXOCT3BOi7JuG96VHJ2qN4KSsEkXqi+EKw61g2YGKTeH3dGYJrFIRLLDH0NC0B5NaHypTMeQ/melLLihLXXA7qFA1ACkbXvMe+YG7c2XJYJtZnqjFQBTaQvLe1SlQOuFHpAod/hW8Ff5/kRNrBq0mSgRMpQE4HUswN7apA9mhwSC7RKA==;31:0cDPFyjP1f31oY28nWgd17MuBQd220wViYSfUXPEYGbHjMHyaYLvs1QagmI2TKaRqqjmaY6C63UhXcHznVhWMeqbJiPKjPvu/UZ4ktW7i34gEwmBgSIQl8n6vK6C1/qCIGnaNE432w6cT2Vu0CNX4LTyWysyx0vgmYVP9lYeaQjizg4TnZrFqt6OReSLvI6bqXIjkpsjfmkPBuXILZYCUoCHBrup2gZTOurX1vPbYEE=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4374:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;20:D07qw87NDPM61waV/0+RHI9mexumwOvnl1G6nSy7copy0ZKJTVo1eJiAwbvmn9Q6Q24aBywt42MC4UYI/UHQiPnA7Ylf85MibL9sFfo9tgJIeqo//OyIMhfIRNFvCybf6Pm4ZUQvUJGfTTDRufD79XDep34uYWnd0trY94PSahCPmV1dXNBYrUyba6ZWn1Yt/lJWDfmEfLRuvMEIcmjN0s+QX96HatVtbDo67TmTNjyXAY+MgInnM/6U888/mPih9TwVqdCbNO3xwU4vno5j+5wkCzu0Zk4u4alAIpZ2kVcLim4pUlvh1NDAIKvVM16Gd5J58Cvsfp5DoN8mz+JLrI21EePScqeFB1hqFvhAXPYhmu8fUJ1llOUbJJNU/pROsEQ5MhssRyvFs0DyVDtyELxI5ZCqbn+YxzeI7e3x2mGtczndwatThVzUfuYUsOjI2OQT1BnM4HB3J/l1p+6wMsvwJSDHcV+hRnfWS/brzUtX66arN/j7REd5SliGyNFD7/5rEdRJKFNx53KdCj5C8Ii3sIqcdqEa6C3SsJ5EEBVdTIUSGDbSfOG2yRgyM5C0f75kgxYhS/6ZXlmvr/UF1FavwlSB8a5msNa09o28boE=;4:xgkXtQ2AG3LokqqROe2mfrwD3tp9X6jKbfiRRFe6BHks5uhwuYGjV21H12XWFLOuO6pE3+ta07zM6Plv0Pwv94oAzXE12qTJmPJtPYsUIsAIx8vZ5/ceoyCiZ0qiO4zV4Pj+Ip2ai8nOnO4E9AEj6x4Z/59YloTIj+slI+vvUXdLb0NubrGT2YL1zfNhX2eX/6zLc/w9STPNULsxfB8m0vXa9EhZUGP4haJmz6OT/8Ynl8RhGyLAdgaMvS82HRWSQSNyfJA7Gba2bAug3FeGN/1pP5ne6CC3eXppgCW2B3exK3ki+4rCJpdz6WVZPgSR
X-Microsoft-Antispam-PRVS: <BYAPR07MB4374F005CBFBB38619746833E3630@BYAPR07MB4374.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4374;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4374;
X-Forefront-PRVS: 06891E23FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39380400002)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(51914003)(50466002)(25786009)(66066001)(6246003)(11346002)(8936002)(33656002)(4326008)(5660300001)(6666003)(6916009)(8676002)(305945005)(229853002)(2906002)(106356001)(105586002)(47776003)(52116002)(7736002)(68736007)(486006)(76506005)(81156014)(6486002)(81166006)(478600001)(26005)(476003)(58126008)(316002)(42882007)(9686003)(956004)(186003)(16586007)(446003)(386003)(33896004)(72206003)(16526019)(33716001)(1076002)(23726003)(97736004)(6496006)(3846002)(53936002)(6116002)(59450400001)(76176011)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4374;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4374;23:S6e5BfmJheTX/WtSRr3EQd0s4KqgippfbypFWNfQK?=
 =?us-ascii?Q?kCyWy94Htfdbnqlg95i7lTjZB27OxF0f86NUJTrgwp4ehoVKilQsCzUyo9Pw?=
 =?us-ascii?Q?St/dusLjZ97Klk8LIZU4rVNZ0DKRVhCtkX60Tc+C3+tAY7us8BnfxzXn6JKm?=
 =?us-ascii?Q?aNtHc4JfHiHVtweMgusveLBJDePs7FRL5CxJLQHGl1tYkk4Qe804xQYV0kr3?=
 =?us-ascii?Q?9IscuT2aCVvmzekyjEoUR2mi/htIl/KTWEOKwi/MBWKeUz0kw9KTn5ctxMv7?=
 =?us-ascii?Q?SL/M4fwIeogH/p6sunTU9kVf27Y11rvE6kaSpIS5NIGn1Jqj8TcgEkS+OYIT?=
 =?us-ascii?Q?VATKwuemsCsca/uds9SM+RI6n55Y64cIIRKl/9HDs/PTCu2IrejcosHmizZ3?=
 =?us-ascii?Q?yk0VTQBclcwPnS9cJD5qpmyOMXUOzsvvEsZyp8r7XBRXoLW9Tc6NFpa9+ElF?=
 =?us-ascii?Q?W7iFBO8wVBJocEWR78Kb93nZC1ZKXplP8I7/7UNwkkE/lercgTIEGq1RbgrN?=
 =?us-ascii?Q?sVGHdiRKilVr1hZEbAr42gUqIxCs0/Sn5TJ+yAw1VKyHhgF9Ko0hNLrJZZza?=
 =?us-ascii?Q?YiDvfCz8waC9aFmLQNFS3J/eRRpbT2/J7J3jk2XsT6iAZg/bv6ST45D73EbJ?=
 =?us-ascii?Q?ciOUcBZipRFS1qC3LCgbAtEjZ6GOY3i6P8fAD1TCvY0DQb7UbQDfa6oOnuNk?=
 =?us-ascii?Q?Kuq6DDzYMGoAGkWmHs5TGmcbl2pq8fvq7dexZZPwFJ+83TWj07I/PqT9aubm?=
 =?us-ascii?Q?oEWg2h+8O7+oXN0zLagguTELSyU/2OAkGQVE5/EcAUSiefh5142veCoueVOr?=
 =?us-ascii?Q?ak4+w5Kx0A35dOrSPJ+aj611ZcysbiUIk7Ar8w4lhRUssUQs4gRrEjDrDrcE?=
 =?us-ascii?Q?te1sBCxIJSOqmLI64/+5+uyfgzifzykyu4guQV9N6oFMgKTBTNdAfx+MIytu?=
 =?us-ascii?Q?Yq6xL89A2Inzp5K6GYfe/2ZgkxXfSfnYwVc5hcmZqhaZa7GZ2KZo6JqIKD5e?=
 =?us-ascii?Q?Yxbe76TLEHZD231ZKG7+4CoG1hwlmLxlA/W85ei8hGXHkEj6ihWAjzLGMYTH?=
 =?us-ascii?Q?m7hhSopRrWNA6tq4yui1+lKrnp1owfv7bex97EzYoGMarhXvWJO5NQ0VpPD2?=
 =?us-ascii?Q?3PpRNTWV/5qfnwzvdIew7OdlfPXXwjlZHm4ZmOhmXq2DtoODsXSVKDr6cu7w?=
 =?us-ascii?Q?KGbs7ZSQ2lqDl8b6FgkUM2clEVbVQlOspjG2Evz1WALnE6N8JgvQK6u6mMDp?=
 =?us-ascii?Q?j2DefKCkPbfyQ6flXpDCN8ieGiwzuQ9rIn1Ei5f/J+Q/NntOb6tCKEC61zbL?=
 =?us-ascii?Q?Exz+ofK0PfI+7Ug2fViLjJ7sImVZ0jGHTxEqEyvIlaLkQT1k1kmjGPlxbdVT?=
 =?us-ascii?Q?/UNGi9g065VuvUfi/7Qvt5LazRoxfn212FN1jJZrHr+Lxh2?=
X-Microsoft-Antispam-Message-Info: Sa7LyV7OAf2hQLSedSfay8/4dbndwu38OSvoCyXf4O86joQIf4H01xS6ZQBOdwpPpWK0R1RlYBO+mHEX/nVQu2eo2JfTRkTDpQ894lpqAB23ZPMQonBVMZHHPBDKyFHLM5uOko6RRtXxxWVn3qjEqLovevYf21yc1XLsGX35RkRwWa3yz9dZqW2TvmV8n1Qz
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;6:PaMR3LhZSvkqZebZcAQ60xXIn4GkJ3AP1Mrv1+8MElPBzANgsIUFokgF+PJYvS6KAOmmHztSBuPLNHExa4ZSH0vKECz3+xVO/KqiHC/Vkaa8s0BdXpoDexge3qRNFmqIMDEieCGyqkz+/nuA2MEe1j3fF1H54W3t1jcRxRMI8fGv1NGRpSCrx6ROYiu/ZfgNSFg4DBYzq7Nrexf1fbj3QJqRz5XxNpTaq40seIAwVd14Czng8mrFrS1ZqDenMM3YOcW/OQ1gxh6sC8YnoJXE+DKzwClFx6mY7A9maRcQu3Zannq+BtFnm2UON+QZXKV4ipRBSKxhKbMIdkBji/uX/ma2CTvunGtwGkZDvnMG70pyNK3RdscBAc1Iemeedtr1AyoFQ/bDq6QCfRYBMzUJymEgUIqf3e/NRoOxgdw7VbnxgHjExtCsYwTqEM2KyRuRaSXk2FqYOrsRQy7zpcH37w==;5:IV+8TnZlsPu03L3tQEu5lL2wAIO9Jz7MNT93Qv5rQCKTvEbZZmoLXHW5/oZKVAMn0TPcna5MUCUus7BBAsy0zRd9abGT/gHP5Y2AT9MvgCiYfnV20SzyqMLQB/3jNfNze8SwmOlAzrQIK+B1LlE7C/XDV/2a/ybrJGa8qqUQsV8=;24:Tn1XC6JGB+IeVRmRoEQmtU1q7TnEMDSquq6531QGaGdJ92s0WZXacceZSv7hm8zR9sNF+ZjL/tDXzbBQO7sesfJ7fhMme/R3OansE7zMcfA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;7:cNDIu/AKKsR39AJ/LmegBjIF7Z+VyZmMjKg9SKUUaN6w7AAd3Q0Yyr5SZsfU3qc9Rooy/GfDIheO8XejpPlIm48+FK1FOi9l5WiOf46JrYtO/i6TUjiWJsy+a/jkC3Xo8TGoWc49l/JiGDU0/V8bVINtohhGEdIPdbuzMgM/M2blg2lJehVZt1sqnHmPASUYVoGMdg/udNT7J6A73glXmHo4uFKOfMt1a1iT7PcR4+H8ETyiostyIJ7VZDDXxOCB
X-MS-Office365-Filtering-Correlation-Id: 803261f1-a415-4892-bb01-08d5c7058587
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2018 14:48:06.2447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 803261f1-a415-4892-bb01-08d5c7058587
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4374
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 04:19:14PM +0300, Andy Shevchenko wrote:
> The nbits == 0 is safe to be supplied to the function body, so,
> remove unnecessary checks in bitmap_to_arr32() and bitmap_from_arr32().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Indeed. Thanks for the catch.

> ---
>  lib/bitmap.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 58f9750e49c6..33e95cd359a2 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -1132,14 +1132,10 @@ EXPORT_SYMBOL(bitmap_copy_le);
>   *	@buf: array of u32 (in host byte order), the source bitmap
>   *	@nbits: number of bits in @bitmap
>   */
> -void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf,
> -						unsigned int nbits)
> +void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned int nbits)

This line is 81 characters length, and it will trigger checkpatch warning.
(But I'm OK with it.)

>  {
>  	unsigned int i, halfwords;
>  
> -	if (!nbits)
> -		return;
> -
>  	halfwords = DIV_ROUND_UP(nbits, 32);
>  	for (i = 0; i < halfwords; i++) {
>  		bitmap[i/2] = (unsigned long) buf[i];
> @@ -1163,9 +1159,6 @@ void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits)
>  {
>  	unsigned int i, halfwords;
>  
> -	if (!nbits)
> -		return;
> -
>  	halfwords = DIV_ROUND_UP(nbits, 32);
>  	for (i = 0; i < halfwords; i++) {
>  		buf[i] = (u32) (bitmap[i/2] & UINT_MAX);
> -- 
> 2.17.0

Acked-by: Yury Norov <ynorov@caviumnetworks.com>
