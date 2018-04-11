Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeDKO3l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:29:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58698 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751541AbeDKO3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:29:38 -0400
Date: Wed, 11 Apr 2018 07:31:42 -0700
From: Dave Watson <davejwatson@fb.com>
To: Kees Cook <keescook@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net/tls: Remove VLA usage
Message-ID: <20180411143142.GA32234@dhcp-172-20-167-2.dhcp.thefacebook.com>
References: <20180411005234.GA39848@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180411005234.GA39848@beast>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::1:659a]
X-ClientProxiedBy: MWHPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:300:c0::19) To MWHPR15MB1133.namprd15.prod.outlook.com
 (2603:10b6:320:22::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1133;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1133;3:dfoL2KIwtqdwznMnQX1VmpZ8N/7L2jahxPNiKOzn9x+JwahKAskPPqgHwOirDsYW+ufF6TS+BSFOtFQhBfY2FQZdmQs/QN2D1W7FHfS1N2HMz2TLebulOfc8wfYeWOifHMjTGtpdYnH8lYGOUAgXuY5xnHQYk2G3VSZ0D8iSgqbyTp3OHf+zJ0dJGSIrFE+wS/pykoIKDzrQZgchUCau24pYkDj1dpGlh9SLuv7mRqwhm5u+qq6Q7O8ML8w1rLXs;25:F2AJdnazJVAvh1CGYxAMhG9LKTKG2x0UeJeCGhTMd70PQ+h7A5s3TWJTV5oaeneQFOj+xGfRbH/4PBoLDVmiOlZK5U3MCtlGByedEaFKk9r3Sc4QeWS/m/g69S3mP1B/rYqc9X6Ajb6X0HJsyKmUdligI1VMhYALq+nAZhM0Bua5WsfXshXvlmzo+kqQvgTtTXq5kX0sOLqJDuyawW0U7+cUAsNGdgYLt/RiNz/Rxpb5vWNkzuLPP9IJJWY4gir09xoaV6lI9s4Ar1oSKkvkI1fvdTWadthBLkgAcLoatIUE/4czivdTFnQ27eDhrdiKz3f6cgKMjp/+/jefSyt7BQ==;31:wJNhwO3KHxfxrCb8jdEYcsBF72O2cXDF329JYS5QyRwDi8t5ewxchmKjZgvzXIKAdPRVzORkppNs4qw/ETeCXzxKYWcPz94HHViVc143MiN4IzqBo7/iMTqtSQisN/MIRSK/ebFfQrZ9dRMYoG8VFb40Polr5xvwPDr2d7RF/4mgP+oLws+qk3tyZnx6wzPXcIwcNWakXj4XKhHSn9akVIkTQUZ8KXym6R4a0rY0TV4=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1133:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1133;20:2OQTbZTiPlBVLkF7FwxMsayhXwva9ohkuyeV2jHunyhuZ16a3LmGbd9ry+6YPOOiXy8zbFiVA9aDMa/gSnQxPL1i6wB6AXQYNsUIIpp4n/E5Zn3964zdYFeRyLCFcaWs7S38RTKXuTVRv0XxKnQRjo/ooMNp7yOhVheIvauApsjW0fiLTUFg3+8pE+O6OdTM8t7KGxq2JnSOkkfUP7UeqZ4Aia/Dq+DaT6z27r1+1/ikv7ugSAo1b20zo1No1SwbjkVLqMcFu53k/gFdWtGs48WRUQSU+Z9l0XGt92r135QWEosEA7c8NfD99OfggmhhBGRpEb9/Kj6SsVnnBNKlvB41EWgoqc+9Rfj/u0/Fepn+//81emP98pCg0Gr8HwsSPZDyQf/5qxppi+oZ9KnLrkyazwGwjf7+fiux3olZzOoaA+g0CYlZuZspDT85+Rmru2TKA+Mog1T+/5j5LGJU3J0+ullO/5uyp0WP+34ZKAz57fSiANNEiLiamBbXMNcT
X-Microsoft-Antispam-PRVS: <MWHPR15MB1133A584B262B981D822C68EDDBD0@MWHPR15MB1133.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(85827821059158)(15185016700835)(67672495146484)(42068640409301)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(11241501184)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR15MB1133;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1133;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1133;4:UOKDPcS5IiF+aDjuRTdI4AvcjleC+KR9WxxhVWV0iIwGDw6JO2pro8bDidZc9vrchIB93C+EKu3GFvXZ8Nb2rJhl5QZLfnrcwxnEpRhegATDqjQDWZ7juXpynrU9BIHaiRoMiC+K7EzPF49YwOz19M6fdcE/wA1+o1SWe3kKKf+9My2WuVIMSOqKwHYFPCcJWk/jYSD59gPiJkANL7YlKjIIq1CimHppZ/jKnPUqKnpSfs+lsPmg8gp324K74hcoR4pG+DSE2EDivfqZmbUQLAaVv3XP8R6QufJo4aBd7i/wYyriWxGgYWK7OTmcpl1cHrPDT9+PtY5n/PGwE3evdhueGClbRTsdOcLw8OQNqQ0R5KUP/zJ7Rp8MRR3xgTD+NeycVvgJYpdW3uriu5t9D9J+ur4wEacqtVyPstIt8hBSrSZCIUduHgNs0HwcCLy7c0AVS38vPXb8WWVbsE2MW1tLcwLA0hu61sBA5tENSk4=
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(346002)(39380400002)(39860400002)(376002)(189003)(199004)(6916009)(33656002)(50466002)(81166006)(52116002)(6666003)(81156014)(52396003)(6496006)(1076002)(8936002)(229853002)(8676002)(25786009)(476003)(6116002)(4326008)(478600001)(186003)(6246003)(16526019)(76176011)(47776003)(54906003)(486006)(53936002)(6306002)(9686003)(59450400001)(58126008)(97736004)(23726003)(305945005)(5660300001)(106356001)(86362001)(16586007)(966005)(446003)(2906002)(7736002)(386003)(6486002)(68736007)(316002)(33896004)(11346002)(76506005)(105586002)(46003)(53546011)(18370500001)(102196002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1133;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1133;23:E2fBWdKUpu7Ha34xc1T+PgwuRa0H6IjlE5NmRvGLy?=
 =?us-ascii?Q?I3onVwhC2tdwYWeip07pPGeyPWDBdJZpLd+c+dXn0rQYgr5zoYaWVvkD/lV4?=
 =?us-ascii?Q?kGCBJQTQg07RJDM8pOV+LhMgwhw81ARP0pR8QNncOE+kBFt1ZfPev3uTFaFn?=
 =?us-ascii?Q?S84KtL6yWlXsewLJjz77e3TSz/Ev1G7UJllkQzgqhuz5BY/Ls+b1ukqW2knI?=
 =?us-ascii?Q?+CxMpfJDTmuvUpNGAPqpcJjM+bmFexudwtRDKAkDq7Rp+EpGN9dAC+YCOoAy?=
 =?us-ascii?Q?kSCSEtdfMMqEcD0+u/AnUmnJsKFrFnRCSkyzd38Og+Nh3nk2Z+6wuiTKXLkI?=
 =?us-ascii?Q?LcL7u7sK/L5qktJ5bf8wu0LN73hDORau2hnpQfvL0hoxDuTK6CXZjrwrO1XR?=
 =?us-ascii?Q?rdd+3lOTG1oartCvrr0lfsQ8d5VTNrLbXqTrmVE7uTrkbsAiZE1sTxLeh/Gx?=
 =?us-ascii?Q?i20t6J//tmkPth1ZKZKoSre6cnP74boe50X7HkR0m/riyeTid2Fj2IEqpX9c?=
 =?us-ascii?Q?xfvS80LnGo1mfy+C5H5S9mtnm6CQxgKAp+49LOAr1fo29N2HxRNy7oiqwuZm?=
 =?us-ascii?Q?j9D1H6wr2ZjJqOpiiWT4NLbRisbegBJdRkkjPwFpFfKA7hflOV9ZFyr8gh46?=
 =?us-ascii?Q?VtDEfwYxHAOGT8K8lER5zOI4njbX9PB/XOA/6OqCKmzzmuKpYCsNjbxdCgGl?=
 =?us-ascii?Q?hMwwP5PPM20KXKrfMF8I2kdXZ1h5KBqAxGntQpqR7pwIyIw8ZqcRnNjw8HSh?=
 =?us-ascii?Q?BWNPnphK+dv0Rl5UBkIrVYAy/JMBA89k6yUGCu+fD/CrAIdJRIrbdrsjJVlQ?=
 =?us-ascii?Q?t7rjYGSYWbSoa7P8UEuZtes4C7nqX5HFoliHSfHuY/FbtwsGdChhlUCBdX/I?=
 =?us-ascii?Q?UqsYs7rbWjjb9r4cF5U9yaCkK/FDpWDfJe9WDytI/FUYX4cn8z2ZM0WkNADW?=
 =?us-ascii?Q?snCi9FtTF69Fy0QDCtuI2akNzaqbScCxJElNyXKgdIPNOHLMvymbZ0SeTUZH?=
 =?us-ascii?Q?xnNKoEeV6Q7Xt8CGFYF9+48VGzboG+mMBw11apLCUYx4Gc3R0NX64qChrFfh?=
 =?us-ascii?Q?7Txmg57r58wDiesqATbCZRpIJZhJ3P9knPbqwFqv5aFZfGzI8sxkNGqwP5WG?=
 =?us-ascii?Q?aNz+LW9N7nSXbRFRqZ1RUQkYgiLYy64k+htHptBSevgocGCEXrBSaWgrZh23?=
 =?us-ascii?Q?CVlmLIIdIeKKg5Pf2jtJcfxFCSUaTuFx+WnWajZazH2Bk+p3XX5xqokHWClD?=
 =?us-ascii?Q?lnLly355k0IrBjQdWnpj6lua1Nvy5gJ8kPENCN+yDsKPNy2iBJH1vIL4pETv?=
 =?us-ascii?Q?Ynw5o2d/7lFin0LNdeFqhFFmJHpbD6cJNY7L5t54hEcQmI7dJHdiOt+HvLUB?=
 =?us-ascii?Q?S73+CMzPTrZn4x4mopwA1OL4MQ=3D?=
X-Microsoft-Antispam-Message-Info: QetHMjC0/NgQ4ZtAc8vFndc9AWLF/9J3e8lvYp+2/tTH7ezvqfVDko2COAWZqh4pIMy2BY6bDoj2fogK3r3Jkwcaaxiryn4lj2g3aId1s3c6IqyMLhT+LHWyUpYuRjmlhdAlFAElxo4x44rWaDnTvRtkk5GWlIkst5KWOMqt5psCMqCUXLtHpYjmfUwWuZB6
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1133;6:5NH/gZ8HNcNukfO1TtnJiKC2vCkTGPL486I5DTwlRSk8PQLbSPPd5p1JbjmrXzs9C6rHrbh1V5UqEhJdeskiAuFh7BmR16HVfUfwrnkVom1OA4P3rW6jpyQYxBtgRNKruEeyfrWNWT0mvxF3q4kPFJwZ2jFu4CgbRywD3q7PHnGiUwC6d4KxMKQ9EsGasFdCYRs/D9t0tCFneyJ1iQMPvPA4lIRhdSiTrW/FOkvMLpIYCbzQqZ6HPQCWN7lmUaI79iWYuuL4thB/IfR/9DjJapCtDaYoWmPfrz9ni7/+1GjhgOOrd4f4wLRQmKL+wuhejzlcWxGgfpmckZ32P+1cRXEwKdEOm0wYVdaLMT8f5v3G5jz28x7IWPCSFZGMK9vs9MVDKDFuGODasIaOiGbSZWGiKGdNbpSTzl9Gywjzf7E2SKc7FTI1O1/ioCB2HigLJGCozg6j+d5pmZtIW8MJSQ==;5:VKsf6Xr54DVamanYKxe14ACz2pcerNpSYW2GFZ+4VnLGiA1IJ6bzVLv6djQg6FY//eBeF7WclmyQYHUOFnmm5xd+pbxmDjfmn39+kl4iqIFqarNs3CPeBTI9i6b0OZSHam4EgqdaWWV7zDgHqipyOgVK7sjvMLsbAnDK+9OAQCY=;24:LbbaEcO+smH1m3vDPV9bLdutglEQ8FygJJZLsXz9LY+WjdC1kV3OhtQjbixb7DP7pER9tjV6IOpzuKAEaFwwFFrBJQovJrXu4hWYwGY1XJg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1133;7:7wOhx/c2p0JP7RCBaRwCHs/9AjVdtUtzRhKhPc0Exbwndp7H8fQrmlPlyIDPWXXF85PfI6woeMg3hCvnMfqeN6YJKOB0/Kmp8bm/gnD+MN3uQx+HXeTJNf1d5W3uF5HEopmMNPrCJEkZwvv1eFdmWFdHXwJ7NCmM+DvPo9/lMe3cKr9wqeKtSWIZW0cy2sCkDlyvCbXdIO311kGpmPfnQlaWClD+I/6FEAkRfq1flbZETWxMvhMjDGSDV6AFh4KB;20:2NBWcWjOlAntFRYZk6fTmgv4+a3AmCKlOvP2QTOqwiEJLOkRamEzGFjwYVx8BtRB5UgEu6qnkIqyQZfa2WWL6lLJuZgFaBVazKKraG9I62tfFcxlnf/eFRKAxxCq/Ev0yf8Szs9zLYOukT45S8ac+47UI6Pacxw6IIKq52JId3Y=
X-MS-Office365-Filtering-Correlation-Id: b95055b6-3239-400b-74be-08d59fb89694
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 14:29:09.1002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95055b6-3239-400b-74be-08d59fb89694
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1133
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/18 05:52 PM, Kees Cook wrote:
> In the quest to remove VLAs from the kernel[1], this replaces the VLA
> size with the only possible size used in the code, and adds a mechanism
> to double-check future IV sizes.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks

Acked-by: Dave Watson <davejwatson@fb.com>

> ---
>  net/tls/tls_sw.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 4dc766b03f00..71e79597f940 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -41,6 +41,8 @@
>  #include <net/strparser.h>
>  #include <net/tls.h>
>  
> +#define MAX_IV_SIZE	TLS_CIPHER_AES_GCM_128_IV_SIZE
> +
>  static int tls_do_decryption(struct sock *sk,
>  			     struct scatterlist *sgin,
>  			     struct scatterlist *sgout,
> @@ -673,7 +675,7 @@ static int decrypt_skb(struct sock *sk, struct sk_buff *skb,
>  {
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  	struct tls_sw_context *ctx = tls_sw_ctx(tls_ctx);
> -	char iv[TLS_CIPHER_AES_GCM_128_SALT_SIZE + tls_ctx->rx.iv_size];
> +	char iv[TLS_CIPHER_AES_GCM_128_SALT_SIZE + MAX_IV_SIZE];
>  	struct scatterlist sgin_arr[MAX_SKB_FRAGS + 2];
>  	struct scatterlist *sgin = &sgin_arr[0];
>  	struct strp_msg *rxm = strp_msg(skb);
> @@ -1094,6 +1096,12 @@ int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
>  		goto free_priv;
>  	}
>  
> +	/* Sanity-check the IV size for stack allocations. */
> +	if (iv_size > MAX_IV_SIZE) {
> +		rc = -EINVAL;
> +		goto free_priv;
> +	}
> +
>  	cctx->prepend_size = TLS_HEADER_SIZE + nonce_size;
>  	cctx->tag_size = tag_size;
>  	cctx->overhead_size = cctx->prepend_size + cctx->tag_size;
> -- 
> 2.7.4
> 
> 
> -- 
> Kees Cook
> Pixel Security
