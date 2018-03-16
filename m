Return-Path: <Rasmus.Villemoes@prevas.se>
X-Google-Smtp-Source: AG47ELtxkQ4MLlVA1ILjjB7N2IuYOIeMGPBNTxoptCa7wusLIVev12OJtmDz8onPsHkHvD0/rYFi
ARC-Seal: i=1; a=rsa-sha256; t=1521214054; cv=none;
        d=google.com; s=arc-20160816;
        b=QaDK5qxDEsvFGqxUyxosQ7WlFfKBzaKYtwRlH3F6UHYMA3Q4q/LPPHXbCoXDPzVl2d
         jXPo+R32drSNaAsbpogb2ALQS548pJKh7gSzlS7YJtZg+UkJCd/CMcKyStW/hwn2bqjL
         nUmggfm8lVKxHmbberE0e4cc0VPt4MXrEqP1wa6OMztqvfTjdKPd1+LRI0wcJWCXOfwn
         U2NUF6DIXreLrfNY/EHK7pdIKosp+S9KeLvRpTEcOo+KNQ5h0ZAfzK27O3HZRLy9s9e5
         enUOzNFeYm0M5NIElPywgliO1ZpDkyvZveR8rkE3o8t6wA9U9oeABg0ZeGz9X0Sqdq7g
         XvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=p5FjUAPflPiK81YGNlnsswqHCBveeowDUm1UPsbu9eI=;
        b=w2hL5GpOoc/2V2XOzbU7VcH+7GlmekOlAoQXLhxe4FfJsUEc48ZTK+Y9r2ZMAZgERT
         uuYLCpr+hi91Lw2taPeATkS8UoDT/tTl2EQrwkmo/jQQaPtFOraennG9t8GqJS6BakDm
         L3FtY0kRyNtG9ZRMFU97dbvI+xC3+1GMxomarnImayeA8CKAjvgdU+dT6WIMYK1ONr8N
         xvKIUjlc7li6xm4QAAO18duWSRakF7Uw8Zgg/FxKkonvwmPhGzxn2ZPMBvmjE4M4iMt+
         6/6oD/I6k2x1lENsYi1EYynEU8G7/peFLjFxd/ZEbva1X1tOD+NkjPRqGc/kQhAsyNDH
         wceg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@prevasonline.onmicrosoft.com header.s=selector1-prevas-se header.b=UZWHejEW;
       spf=neutral (google.com: 40.107.4.106 is neither permitted nor denied by best guess record for domain of rasmus.villemoes@prevas.se) smtp.mailfrom=Rasmus.Villemoes@prevas.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@prevasonline.onmicrosoft.com header.s=selector1-prevas-se header.b=UZWHejEW;
       spf=neutral (google.com: 40.107.4.106 is neither permitted nor denied by best guess record for domain of rasmus.villemoes@prevas.se) smtp.mailfrom=Rasmus.Villemoes@prevas.se
Subject: Re: [PATCH][RFC] kernel.h: provide array iterator
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-media@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Kees Cook <keescook@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ian Abbott <abbotti@mev.co.uk>
References: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <b6af11b9-d697-59ec-6acc-80f0657a3e11@prevas.dk>
Date: Fri, 16 Mar 2018 16:27:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM4P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::26) To DB6PR10MB0438.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:11::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e594a144-eaf9-4714-5aff-08d58b526fd0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR10MB0438;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0438;3:4jJiTWlY501LfVkj6zq3hveOAeJw0eJcgQTFQ0efwmS5rLrxhrJ5/uR4lTaJ0HD4JwY5D2Ib/5MKRfcJ0y/isK4gXfM0eymPEmWER+WzqWlTmlQi1tlZ2984J8XxJTQetnv1dTaKA6p79n0biFYqbEBJUrIsIvcuFi0PuSkkmRMqTZhrApti2wYgQ+KJ4atsmBjeXzgyKDoGFu9Nxyby6H2tdkedMHcrUAnjLPly5qlHuwY8lM9wfoOWZ/TIYYUE;25:x9Y+jsSnehIsHU7nG72YzMuOF7DitzSn90++y8f1qAh3xImuSZ6L+Uc0zGlbU/elCGN8+xmo0M21c9DTE3XdpfB49SNv556YE9ndWkny1ZQkVyIW9M8Z3xEXG+0hvm/Jg6L/99A9BLms5HUVzYIVPFfnkkf558gOKaiWzmQdiNmUY7JZjEzR4WAodSd23TPuqSqw704Q084QeC2jLoU7suy9Q2V8NIZQ0t8eLaKmVHYXL3dYlrbzpD0yYD40ejMcj2ql/j8uHEP2X1rL5C/PhXwt/azF8CcTHxNGGtYiFbcDgG8oyNr21CwaDTuL3kOAx3hGAQWhzpDzNdJYdQgscw==;31:7RubpvMHi9GM3fTq82kKaTW1MoBTP3or9vzDaS5rRjcFCMcSfqBxKF/8OqTaKyHvOUsMqx2Bp5ruYDrbNGmGrxC3jnjbKBLDmAw17nVac81MYm6H6CmR8SdHmXjr4kksXPOHfNR9Pkq9QRbzPHUOCDKWvFXQKC05SFmxW614LI2P9hoLqe4a9CwuYlU9M1hH9Mc0N4HRd8liFx8IAtqzZ2AlK0YEMXZb1R5HRBiz8iM=
X-MS-TrafficTypeDiagnostic: DB6PR10MB0438:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se;
X-Microsoft-Antispam-PRVS: <DB6PR10MB0438C8538B1320E4B09384168AD70@DB6PR10MB0438.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3231221)(944501281)(52105095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR10MB0438;BCL:0;PCL:0;RULEID:;SRVR:DB6PR10MB0438;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0438;4:qLtKoErmm5y47EhEAMofiMHEspg1N8udbevzA0R40NMAgQifSOVMMuwh4cXNMrRAZDYpBiDjhHSA3Cri92cpSr2QDY0H8QWqDpIzbpLkN/1WOfqo2Zx14Hpa5c0SjdkbiNlVG5Rs2do/IKGaa84KvR4AuzafbTjfkYKwDZteBO9x2wFisWFWRcLaIik0fb5raW3gFpqmZN/JSQJt0fDNfOHpKTzNp8J0iry5S6Z+kWq1kVlV9v/nhB8poFjeT8x3XQT2lZzrhsSPDNi3elDRQBngO4G9WMMOrt4SGd2weaDHAeTx4S0rUDc3xE8E0mjI
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(376002)(346002)(39850400004)(396003)(199004)(377424004)(189003)(72206003)(8676002)(65956001)(478600001)(4326008)(186003)(68736007)(386003)(16526019)(105586002)(53546011)(229853002)(52116002)(64126003)(74482002)(52146003)(23676004)(2486003)(5660300001)(6116002)(31686004)(36756003)(76176011)(16576012)(50466002)(316002)(26005)(6246003)(3846002)(77096007)(305945005)(65826007)(6486002)(8976002)(8936002)(7416002)(7736002)(106356001)(81156014)(31696002)(2906002)(2950100002)(54906003)(53936002)(81166006)(58126008)(47776003)(25786009)(66066001)(42882007)(230700001)(97736004)(6666003)(65806001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR10MB0438;H:[172.16.11.22];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjEwTUIwNDM4OzIzOnhad3k4VWF0WVIyWFpZVjdoZThoWEpSZjhi?=
 =?utf-8?B?U1oySWp2VWdmQm9rTjNzWWcvSTh6VFVmU1YwOFlyNVpXWEIzV04zTFZGNmFU?=
 =?utf-8?B?dEdFbjlKRFFTNENuckFOZUhvWkhteGlSOG5seVlGbGRwVWZ0WVFtNkRNZE1N?=
 =?utf-8?B?blBVMWRDZi9kUzZjdkQ0UHo5SmQ2bStEZmZlbzZzR0kzSlNpSDNQSURnbG1G?=
 =?utf-8?B?ek9yT2Z5dGJmRVo5RTVDZy9vdy9aTGRLTEUvdkJaRE9HYml4UHl2RTJpRGFH?=
 =?utf-8?B?ZWRhY0thVXZJRElQa1FMQUphUjh4ZjFYRlhYUEtyQW5XQjRuaUdsYjZ3Vm9F?=
 =?utf-8?B?RC9mTVI0YjdFa2M1eHJhTEpGZk9JMVJlQ3ZWcjQ0Nk9MZ3hwanlCNVJJR3Aw?=
 =?utf-8?B?aWx2ZlR2OXFWZ2xubnRQeEtrclI5ZWk5aThxdW9NY05rYndtVXdtNTAyUGtK?=
 =?utf-8?B?Z2QybGZYZ1FURTlIUGthMWxQZXpuRmRITytIeEd3blgyNjUvbXRMK2g2L3J6?=
 =?utf-8?B?UFdhbGJqWlFDZUJxcFRQT29OOGVDZ2krS1l6MUtFVEdDYjJtcGFuUnYvelQ5?=
 =?utf-8?B?cjlsQmxDeWdpSk9YejNQTlVjaks4ZFBhcWM4eGlKelFGRU85NXFqSUtVdk9O?=
 =?utf-8?B?WWNyeVRMNGZDSnovbWdvWkhyNlJwcVg0ZjYxYU5aUVpjMzQrUmtJZ1RnUU5t?=
 =?utf-8?B?MVFxZmd6WWhxclZyS0lFaWFKcjJReG5IdjgydUU3TDJETjhsUGhNeGxnK3Va?=
 =?utf-8?B?YklJUFRoMjNTZGxkMGNZdzhsaDZPVm4yWVA5TVN6KzZZOHlVVVNsMG9vRlhY?=
 =?utf-8?B?U2NpRnFDMUVkN3ZtUVRJM1JSNHg1L0VobmZtN3hZa3pFNEFhSEk2c2JIN3A4?=
 =?utf-8?B?SElVdXBwKzBDd0NzSGVsYkRVQUtrVEFDZ1JWTUNqTXQ5NnFyUFFHUlltUUZo?=
 =?utf-8?B?eVNPT1hMNjNpeExmZStiaHhwZzNJMnpiVmR3Z3ZnOHRkbTV4QTFtNExoQlBw?=
 =?utf-8?B?QWlLaUJPOXM5TFpRTTE5alk1cWdHNmlzUlNjQjB1VjFDZnQ0SVBXYyt3TDM4?=
 =?utf-8?B?T3F2THJMU2F0L0lqdmZLT3dhdlVaWVV6empQZjA2eU5IaWVRbE9aeEd5SGU3?=
 =?utf-8?B?MW9jalJ2MGdWeXA5dFFBU1JDejhxT3ZGRE1DdUZBdUpObDlQTGFsb200VlVh?=
 =?utf-8?B?aGkrTC9NNmVjemZ3V0pEQ25IL3d0bmQzS1lzdk41TFRXdGRTMTlUSE9xR3lI?=
 =?utf-8?B?WGYyTE03WjR6Q2FGOWorRGlmY2dKYjFTTmZaeG5iS0N1aU1jc3pPU2h4eUJX?=
 =?utf-8?B?bFNkU1pMOFNURG1JMmxzSUYxRm1lWFhvYWhpeDEyODdTaHRRNjVRSHFUeGFQ?=
 =?utf-8?B?WmxWNzRmeUczd0VycmR5bjY2Qi9OaWNzeUxZQUU3dFhMNDZucGFuZXlqYzE5?=
 =?utf-8?B?Y3RkNGd3emhVSWhPVlVIbFJ1YTY4UWRPYUxpdG5vRmM3ajdjcmp3THhQV05W?=
 =?utf-8?B?dTQyQ2tTR3JZTTFjSnIzdjBhZkRpZDZ5dlVuSmRMYkNseHdKdnp1WktGbjBx?=
 =?utf-8?B?OS9ZSlg4Y2dSNXhUKzQ1RUxTL3RPMUhOeGFSc3krdDN0VlN4dGFUZ0s5NlVh?=
 =?utf-8?B?QWE5bnI3MW5IbTBkK29kdDlWelF5cE1udDVoMXdPRFFGb01HelZQOTYxL1c0?=
 =?utf-8?B?TFpZcnN4RGJHUXZQOTRmemc5R3V2am1lRVhScUJlTGd3QnpsdVY3ajU1dzFV?=
 =?utf-8?B?T2VxYSt6R1lXWllkckxESElReGJtSmxIZmJoMktCWFRUSi9RSGRvRGN6bGJ2?=
 =?utf-8?B?ZHRXMy9jSWFiUitsTzN1MHNSVnhESEtGWkIzbWx4SjVlSUdxeUhUTitacWNr?=
 =?utf-8?B?aHo3bHA5VGI5TmJ6MWtpZEhYbFZLeVBxR21WZmlzZFUzdFJBZVh0OVp5cVJK?=
 =?utf-8?Q?QtL9x5TXibEQj9Z/BBq7njLZg1wDvg=3D?=
X-Microsoft-Antispam-Message-Info: +9QrA9d9L89Jk9m0hYB7BgMGp2nsxRpAcVwbWKPX7z3hdf/2H8Y99r438X4BPn/3rh6XlqJH4lmahw7hMPJlELoT4e3PNpIu4BWQllaWlabCiRIU+Sde+FNenAHRXFohYpt8SC7GOxbj41Gthi9D9K5wGV0GX048WD5rZ9HHLqscuh9vcWps8bM7D9o4LMbU
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0438;6:PNylZfM3uMV8dFA1mqMf7H+jZoADITPVwurZWpIzNZtRUjCbtwup0s256ot3QlxHpt6Cbw1lvcKRk4AvYr+WomUf151osqJr5LG4Pfzaw4fyUUYJY8qOijb/oEGGRM3EGVsbUQAfiEsG279nBSOZH0cWd12zVH4fr6/egaJY6Js1+MMHVFh5W3LbdyfoYD9z+6OF4rDlB5d+mM4hsMl1IolZ6pQgep09Nompzb3PX7iC8oQskPdoqgFwn19yjkvM+slaLf9E1OFA75iOKn8YYTnSFN6+rDXjRy8EW5uaHhwQCSw1v+GmJTICnu+zex7IkaPyfcfktvOt+Ovu0D30NiZunOJGODCYyGUwQAGS8Gw=;5:YxaBJq+t8PfB0gKxD1D/AezGC81JkYUBKBRLUcp1bDuK7EDkYrpgT0l+5ppn1r6un4DZA47q4IoO8S4ZO6NzgB2Megmh0rkiGEK6PiDfypMVyT8DzRqQ1IW3JZzp4au/knX2uJeF9s6LgP9lvvHtjnILdRy4Ixxnu4AkUwag1OY=;24:Gm+RgVJY6FGMReVtVkbxoKIbkrkKhi/8+U5vl/+Z4oBjay6TeZ9TqabFaBhq1yiESyJ9D1HPv6ktV5hOM5mxo/uuaoCEVAp2qtQO5VbMyjU=;7:t3QQ8Zd6YYbilp45OyfMR/Ubyc4KMYf9ZHREaDpa5A93054FOwJX2NLT8xBOMo7uBK5BqUVd6HmH3f206t2tc6QJ6xBiJwGyzpXDltMY1QsahECyiGiHqDrWJzwJYROKrexYP1Hh6jS6f1rsopTVHaDGVi5+2os/9+uwjpnWw+9dVCsFKl8yfXGGfP7dUzYgvH4yroD3OVlPLw37cgwm84lEF1N/3xmUuRj5O+Dte3enFa+DpyUzNFEoEcfQTExh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 15:27:31.1672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e594a144-eaf9-4714-5aff-08d58b526fd0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB0438
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997409535098266?=
X-GMAIL-MSGID: =?utf-8?q?1595108548751654106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-15 11:00, Kieran Bingham wrote:
> Simplify array iteration with a helper to iterate each entry in an array.
> Utilise the existing ARRAY_SIZE macro to identify the length of the array
> and pointer arithmetic to process each item as a for loop.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  include/linux/kernel.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> The use of static arrays to store data is a common use case throughout the
> kernel. Along with that is the obvious need to iterate that data.
> 
> In fact there are just shy of 5000 instances of iterating a static array:
> 	git grep "for .*ARRAY_SIZE" | wc -l
> 	4943
> 
> When working on the UVC driver - I found that I needed to split one such
> iteration into two parts, and at the same time felt that this could be
> refactored to be cleaner / easier to read. 

About that, it would be helpful if you first converted to the new
iterator, so that one can more easily see they are equivalent. And then
split in two, adding the flush_workqueue call. Or do it the other way
around. But please don't mix the two in one patch, especially not if
it's supposed to act as an example of how to use the new helper.

> I do however worry that this simple short patch might not be desired or could
> also be heavily bikeshedded due to it's potential wide spread use (though
> perhaps that would be a good thing to have more users) ...  but here it is,
> along with an example usage below which is part of a separate series.

I think it can be useful, and it does have the must_be_array protection
built in, so code doesn't silently break if one changes from a
fixed-size allocation to e.g. a kmalloc-based one. Just don't attempt a
tree-wide mass conversion, but obviously starting to make use of it when
refactoring code anyway is fine.

And now, the bikeshedding you expected :)

> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index ce51455e2adf..95d7dae248b7 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -70,6 +70,16 @@
>   */
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>  
> +/**
> + * for_each_array_element - Iterate all items in an array
> + * @elem: pointer of array type for iteration cursor

Hm, "pointer of array type" sounds wrong; it's not a "pointer to array".
But "pointer of array elements' type" is clumsy. Maybe just "@elem:
iteration cursor" is clear enough.

> + * @array: array to be iterated
> + */
> +#define for_each_array_element(elem, array) \
> +	for (elem = &(array)[0]; \
> +	     elem < &(array)[ARRAY_SIZE(array)]; \
> +	     ++elem)
> +

Please parenthesize elem as well.

Rasmus
