Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-323999-1522310469-2-5897313763494369135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522310469; b=E9PVs3BTB6dEygpk5TaJS8NRorwYNFm6xeamKPNwJT54tX31A5
    v9AUIub8R5OuswwP8BySLZ9av0HdahvyQmjgO4+E/uGo9Ow3zUOFzuQm2W9Y9eWO
    baz3Y7q9Y7ts7F3NDdWOvOfiT7l3y6NarazmTWbfVolq263mBEKSk5Q4Ih4BIro7
    8VZpyroykRiwnpbNSl9DnmUB5tNZk3swbtc3eUAFVz0S7HUBIWyYHYkLJne8gddq
    1f4qJVk5CAVK6emgB1b3H/dDBEY7F2SHrxBRxedjb/ztPCjjSMri2jakL9W1cPW1
    SvGRu2KOk7QeE3KQMjyeHUHnQJFqHUDXnGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1522310469; bh=xwJIZRzojW8SWYBIMA+Pdp83UFzEgfJ+paZrQQcGGFA=; b=W
    ubIJOjIz+PnRMQsqDh3R1HQH56LXUEaZqDElPD8y+q/UMxQgwXl5wqS/557rOmD7
    2erRbELchFvnXF+DHSLcLfzDZGra8smpotYA4b6r02reWxkT7DO0J/ChTZhApy7j
    JRqz8KPX0sPscKCPdzGp3HLRPeOmwvNh5iUnvjK68rsVpg2rC4X7KsQjkqaqJPqr
    YAPI7BRET1Brzw9wCCZeEKhPLjLo6JZd9gw6BdLdcCjbSnLSvK7S5uwGcJs0pEKt
    V4eSQDal6Jidtx+r8MvCZ0I7ooroWOQWobG6eTN1+H8IqWz9oER/66s5S+vZb2OS
    dY/R0cFDwUc5BRcEifUqg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fFBgujdo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F1Goqqwu;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fFBgujdo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F1Goqqwu;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD/9b6cNqYQpuEXICv7aBF+lz/3+V1DJ5JBXN5ul3suO9NwXB3aZJITBlkR8nDyQoNCnaj3rAwAVbVYMLp9USzpOUQ9yH1uTc991xRWFUd0R8jqZC3Bd
    61jnjBU3z01B5+A9gHhA2e/Uyagtqkz9pG2/QuTKl678iFnTCA1e7BWQb4WwRnDt6PV+tAC5ZHiW34wALJmNCU2ZDWFtAXniWr+0Y5V8DuQQdCbWWzW4I4lu
    VADNs0pTztNn/uinOqGMAg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=eNrQ7vU5KGDRxoqpRiMA:9 a=fpmvnTc66gPvxoLq:21 a=RB0GlIj3yPi6Ayw-:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4894omTgvJ7kEILZ+2M4G3dIuG5BPCoZAcSqD6F/zoJE7KcNooasoz2CqvNyYf5Alxug46CIg==
Subject: Re: [PATCH v2] staging: vt6655: check for memory allocation failures
To: Ji-Hun Kim <ji_hun.kim@samsung.com>, gregkh@linuxfoundation.org,
 forest@alittletooquiet.net
References: <CGME20180329072248epcas2p3d12617d41e964252998dd1d34f740a97@epcas2p3.samsung.com>
 <1522308157-26463-1-git-send-email-ji_hun.kim@samsung.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <798fbe60-52aa-4fb0-0cd3-e2c067bd6c04@gmail.com>
Date: Thu, 29 Mar 2018 16:00:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1522308157-26463-1-git-send-email-ji_hun.kim@samsung.com>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, y.k.oh@samsung.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 julia.lawall@lip6.fr, santhameena13@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018/3/29 15:22, Ji-Hun Kim wrote:
> There are no null pointer checking on rd_info and td_info values which
> are allocated by kzalloc. It has potential null pointer dereferencing
> issues. Add return when allocation is failed.
>
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
> ---
>
> Change: since v1:
>
> - Delete WARN_ON which can makes crashes on some machines.
> - Instead of return directly, goto freeing function for freeing previously
>    allocated memory in the for loop after kzalloc() failed.
> - In the freeing function, if td_info and rd_info are not allocated, no
>    needs to free.
>
>   drivers/staging/vt6655/device_main.c | 64 +++++++++++++++++++++++++-----------
>   1 file changed, 44 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index fbc4bc6..ecbba43 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -539,7 +539,8 @@ static void device_init_rd0_ring(struct vnt_private *priv)
>   	     i ++, curr += sizeof(struct vnt_rx_desc)) {
>   		desc = &priv->aRD0Ring[i];
>   		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
> -
> +		if (!desc->rd_info)
> +			goto error;
>   		if (!device_alloc_rx_buf(priv, desc))
>   			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
>   
> @@ -550,6 +551,10 @@ static void device_init_rd0_ring(struct vnt_private *priv)
>   	if (i > 0)
>   		priv->aRD0Ring[i-1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
>   	priv->pCurrRD[0] = &priv->aRD0Ring[0];
> +
> +	return;
> +error:
> +	device_free_rd0_ring(priv);
>   }
>   

I think you should return an error number here, because 
device_init_rd0_ring() is called by vnt_start().
You should also implement error handling code in vnt_start(), and let 
vnt_start() returns an error number too.
The same for device_init_rd1_ring(), device_init_td0_ring() and 
device_init_td1_ring().


Best wishes,
Jia-Ju Bai
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
