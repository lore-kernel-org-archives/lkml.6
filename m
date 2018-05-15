Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeEONxR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:53:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753893AbeEONxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:53:14 -0400
Subject: Re: [PATCH] crypto: reorder paes test lexicographically
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
        linux-next <linux-next@vger.kernel.org>, linux-crypto@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ofir Drang <ofir.drang@arm.com>
Date: Tue, 15 May 2018 19:23:04 +0530
In-Reply-To: <1526025847-13134-1-git-send-email-gilad@benyossef.com>
References: <1526025847-13134-1-git-send-email-gilad@benyossef.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051513-0044-0000-0000-00000414A566
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009029; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032670; UDB=6.00527956; IPR=6.00811801;
 MB=3.00021126; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 13:53:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051513-0045-0000-0000-00000846B9B0
Message-Id: <1526392384.19317.3.camel@abdul>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-11 at 09:04 +0100, Gilad Ben-Yossef wrote:
> Due to a snafu "paes" testmgr tests were not ordered
> lexicographically, which led to boot time warnings.
> Reorder the tests as needed.
> 
> Fixes: a794d8d ("crypto: ccree - enable support for hardware keys")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  crypto/testmgr.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index c31da0f..b1b8ebb 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -3012,13 +3012,6 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> -		/* Same as ecb(aes) except the key is stored in
> -		 * hardware secure memory which we reference by index
> -		 */
> -		.alg = "ecb(paes)",
> -		.test = alg_test_null,
> -		.fips_allowed = 1,
> -	}, {
>  		.alg = "ecb(khazad)",
>  		.test = alg_test_skcipher,
>  		.suite = {
> @@ -3028,6 +3021,13 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> +		/* Same as ecb(aes) except the key is stored in
> +		 * hardware secure memory which we reference by index
> +		 */
> +		.alg = "ecb(paes)",
> +		.test = alg_test_null,
> +		.fips_allowed = 1,
> +	}, {
>  		.alg = "ecb(seed)",
>  		.test = alg_test_skcipher,
>  		.suite = {
> @@ -3610,21 +3610,6 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> -		/* Same as xts(aes) except the key is stored in
> -		 * hardware secure memory which we reference by index
> -		 */
> -		.alg = "xts(paes)",
> -		.test = alg_test_null,
> -		.fips_allowed = 1,
> -	}, {
> -		.alg = "xts4096(paes)",
> -		.test = alg_test_null,
> -		.fips_allowed = 1,
> -	}, {
> -		.alg = "xts512(paes)",
> -		.test = alg_test_null,
> -		.fips_allowed = 1,
> -	}, {
>  		.alg = "xts(camellia)",
>  		.test = alg_test_skcipher,
>  		.suite = {
> @@ -3643,6 +3628,13 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> +		/* Same as xts(aes) except the key is stored in
> +		 * hardware secure memory which we reference by index
> +		 */
> +		.alg = "xts(paes)",
> +		.test = alg_test_null,
> +		.fips_allowed = 1,
> +	}, {
>  		.alg = "xts(serpent)",
>  		.test = alg_test_skcipher,
>  		.suite = {
> @@ -3679,6 +3671,14 @@ static const struct alg_test_desc alg_test_descs[] = {
>  			}
>  		}
>  	}, {
> +		.alg = "xts4096(paes)",
> +		.test = alg_test_null,
> +		.fips_allowed = 1,
> +	}, {
> +		.alg = "xts512(paes)",
> +		.test = alg_test_null,
> +		.fips_allowed = 1,
> +	}, {
>  		.alg = "zlib-deflate",
>  		.test = alg_test_comp,
>  		.fips_allowed = 1,


Gilad, 

The given patch fixes the boot warnings.

Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

Thanks for the fix.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
