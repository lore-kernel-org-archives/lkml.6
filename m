Return-Path: <garsilva@embeddedor.com>
X-Google-Smtp-Source: AH8x226ingrlSnNgjAeveoSwk4vxb0PTUvxbZjFJupjE//ciOOXSVGchjTv8g0UNf9gajKPqr79d
ARC-Seal: i=1; a=rsa-sha256; t=1518641853; cv=none;
        d=google.com; s=arc-20160816;
        b=yOur3a5BkOzRzfh9V1wHf5TGgkUWSN2k+T5eUAnvLjhE7/80a8XJVfz7J9gqvHX9aG
         bkZBKZXayHJIVqAZvw/G5poMpADF6R6dEkNn3K/72dnPqlPAwWy/l7QuJ3zY2uOhrEe4
         6j1aW6zhC6LSGWuJjtAxMcJsa15mKiLfkBjpKpX2LMz6nEwPhBNVLRxG69DyBY2wX2mI
         Celf4zTCSe0LIm76+LpXRVxmPG1sEuc6uT+hQjAt2S8pCcoGxPCFphfSd3KzkefFJipf
         KsL5IRTf5updgJaGCQhHfqVTeR3j2feO6tdfgfIorXa3RdIn3MKyQu4uyoKlnZmIwD4J
         YzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=GVCMBjiyd3kujXFCGBbFnLchr/VVMHhSMOIHWHlAaVc=;
        b=f1uKA1HXpiBlH7Rw0iilfFbvJRYmWI4L7tn8z4GfEWSmx3PxChjxTpyGY+OdJOG9Jk
         Nep/45v9GRzHYnb62rQIvM1b9L5GYxy2k6QJX+Fk65kgijfg9ntNt7D00x6qKCmRo1JC
         9vZYnG7Yvezetuyet7CnuPrxM1nEQ/PGtwiiF8yeKOVdQWKmcSxrex9dj18zERUaPuYI
         UO3FmdAzUEv0D6DDbAHIJsGFD4eRhrh8lbinl9bwY4FqOgsloUwKewFA5xBKzYIgS6Zd
         nHGxoex8k5OG7VYJpF6Sqw5aUwAr3AczfF6H2f7MHyhK2OMpb/PATWQcPeJQCiM4TPE3
         TjHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of garsilva@embeddedor.com designates 192.185.146.7 as permitted sender) smtp.mailfrom=garsilva@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of garsilva@embeddedor.com designates 192.185.146.7 as permitted sender) smtp.mailfrom=garsilva@embeddedor.com
Subject: Re: [PATCH] staging: imx-media-vdic: fix inconsistent IS_ERR and
 PTR_ERR
To: Steve Longerbeam <slongerbeam@gmail.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20180124004340.GA25212@embeddedgus>
 <5e53d6d8-d336-da37-fe12-0638904e1799@gmail.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <4305212e-5946-0bb3-1624-ec23a0f37708@embeddedor.com>
Date: Wed, 14 Feb 2018 14:57:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5e53d6d8-d336-da37-fe12-0638904e1799@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1em47Q-004Mna-V6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.4.238]:33246
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590432494114663836?=
X-GMAIL-MSGID: =?utf-8?q?1592411400318067560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

I was just wondering about the status of this patch.

Thanks
--
Gustavo

On 01/24/2018 06:14 PM, Steve Longerbeam wrote:
> Acked-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> 
> 
> On 01/23/2018 04:43 PM, Gustavo A. R. Silva wrote:
>> Fix inconsistent IS_ERR and PTR_ERR in vdic_get_ipu_resources.
>> The proper pointer to be passed as argument is ch.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Fixes: 0b2e9e7947e7 ("media: staging/imx: remove confusing 
>> IS_ERR_OR_NULL usage")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/staging/media/imx/imx-media-vdic.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/media/imx/imx-media-vdic.c 
>> b/drivers/staging/media/imx/imx-media-vdic.c
>> index 433474d..ed35684 100644
>> --- a/drivers/staging/media/imx/imx-media-vdic.c
>> +++ b/drivers/staging/media/imx/imx-media-vdic.c
>> @@ -177,7 +177,7 @@ static int vdic_get_ipu_resources(struct vdic_priv 
>> *priv)
>>           priv->vdi_in_ch = ch;
>>           ch = ipu_idmac_get(priv->ipu, IPUV3_CHANNEL_MEM_VDI_NEXT);
>> -        if (IS_ERR(priv->vdi_in_ch_n)) {
>> +        if (IS_ERR(ch)) {
>>               err_chan = IPUV3_CHANNEL_MEM_VDI_NEXT;
>>               ret = PTR_ERR(ch);
>>               goto out_err_chan;
> 
