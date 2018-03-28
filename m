Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1982828-1522230983-2-10089828547708111590
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522230982; b=KqzvCBE1cj9X+fqYaTgSg0CA1Wflw6BcwMSNIutSo6082hn
    /tIPox+773tqma56JF7COPk3A4l2XRIAg5kT3fq0upDdU6fGPr9yLvTqgn001XzD
    w2nXQAajq33y+5wEP62LHGwD0Y0kAmVP81YOg8w7WF6WzKT2NKgTRuWsYBnnqEtY
    8/mXvLjVk3BDcDoYgKXczVrnV2bT0JlNmZS0tkPxHOsRSuc7E+4OPt8JDDPWjPSA
    ZAq77FPi90ZumBckjZWr5Rd5pNHlmPgZp6ASPpx3btwIgT6EsYjAJ3q0pjJQGCmm
    j1wdB92+toKlQ2NL4X98B5O0PeYMCvFC6nOn1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1522230982; bh=DlGUzb9uv4QDJkIVFK3NcGu03tpc7jrwJZQXHhuCBlc=; b=q
    //CbDQ2EJVh5kwflx7MtGCsCrNldTrJCWsQtc5LbqH6OHHh136vb/GJzRderBmdi
    CkQ/zhggdU93K0cwjXP8h8YdYV7O/NpQHazqGDIO54i8V3PrXDkP8w8oljF0uFQU
    PkIlRQiGwFZJXZDKGhBcTWEyNmUgFsUjEJWQePvtEXcbS2z9flfzgZaEk4RkKfSe
    /f2k/ntpBvqtdUF14j4lgL6tygZH2LUyK2Pc8aK94gnpiZR2aodtO59sd0B+2ryL
    wZJtigxfLHJFnCpKuAjAdZcOds58pEN7l5QfO5AFQX6ADQYsPHVpeclb2KPk2/CP
    BCoC9JG8ElCr1SEkeTLYQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KhgCVOGs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r9reZ+n5;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KhgCVOGs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r9reZ+n5;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBI4cg3ExCAhMKkuW0+q+m0asC+Ai3WeP//QitTjBxGxzU9qvJAMJ3umSVwbA1/zndVTAVTOU20yCoz8cRbv5957eg8QUpdLIp1Ixc1wfyh+fR8fyiPS
    P3jrVUr85bBO3nSSa3Uk3JqNJkg2ESJD1lDsEUJxVK4PEx0ObuCzwF+TxJLnhpRnbjAtOH1GCUc02UKjWIRueVrIa/DeiZBCvAPAkq9dGexK/87X2Ty+4cWq
    eMhHpKBZFUN6sZoi/mUHYw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=G6XcdxE4dO7y4t2AJrQA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvzkBUvcEBQMQeTVa7y+8LrNvhGenea7PwB2fdzfdqqQ+r5tGzsGUNNaVSU99I+nMVhbOA7Dg==
Subject: Re: [PATCH] staging: vt6655: check for memory allocation failures
To: Ji-Hun Kim <ji_hun.kim@samsung.com>, gregkh@linuxfoundation.org,
 forest@alittletooquiet.net
References: <CGME20180328063144epcas1p305216b582520b884b09c93a7ad591660@epcas1p3.samsung.com>
 <1522218691-7917-1-git-send-email-ji_hun.kim@samsung.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <fc4cd041-f8b4-f799-916d-9df790efbba7@gmail.com>
Date: Wed, 28 Mar 2018 17:55:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1522218691-7917-1-git-send-email-ji_hun.kim@samsung.com>
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



On 2018/3/28 14:31, Ji-Hun Kim wrote:
> There are no null pointer checking on rd_info and td_info values which
> are allocated by kzalloc. It has potential null pointer dereferencing
> issues. Add return when allocation is failed.
>
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
> ---
>   drivers/staging/vt6655/device_main.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index fbc4bc6..5d0ba94 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -539,7 +539,8 @@ static void device_init_rd0_ring(struct vnt_private *priv)
>   	     i ++, curr += sizeof(struct vnt_rx_desc)) {
>   		desc = &priv->aRD0Ring[i];
>   		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
> -
> +		if (WARN_ON(!desc->rd_info))
> +			return;
>   		if (!device_alloc_rx_buf(priv, desc))
>   			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
>   
> @@ -563,7 +564,8 @@ static void device_init_rd1_ring(struct vnt_private *priv)
>   	     i ++, curr += sizeof(struct vnt_rx_desc)) {
>   		desc = &priv->aRD1Ring[i];
>   		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
> -
> +		if (WARN_ON(!desc->rd_info))
> +			return;
>   		if (!device_alloc_rx_buf(priv, desc))
>   			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
>   
> @@ -621,7 +623,8 @@ static void device_init_td0_ring(struct vnt_private *priv)
>   	     i++, curr += sizeof(struct vnt_tx_desc)) {
>   		desc = &priv->apTD0Rings[i];
>   		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
> -
> +		if (WARN_ON(!desc->td_info))
> +			return;
>   		desc->td_info->buf = priv->tx0_bufs + i * PKT_BUF_SZ;
>   		desc->td_info->buf_dma = priv->tx_bufs_dma0 + i * PKT_BUF_SZ;
>   
> @@ -646,7 +649,8 @@ static void device_init_td1_ring(struct vnt_private *priv)
>   	     i++, curr += sizeof(struct vnt_tx_desc)) {
>   		desc = &priv->apTD1Rings[i];
>   		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
> -
> +		if (WARN_ON(!desc->td_info))
> +			return;
>   		desc->td_info->buf = priv->tx1_bufs + i * PKT_BUF_SZ;
>   		desc->td_info->buf_dma = priv->tx_bufs_dma1 + i * PKT_BUF_SZ;
>   

I think the bugs you found are right.
But your patch is not correct, because it is dangerous to return directly.
I think you should return an error and then implement error handling 
code for these functions.


Best wishes,
Jia-Ju Bai
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
