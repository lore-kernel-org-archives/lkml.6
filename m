Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3146351-1522550552-2-7171523385679520978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522550551; b=nHSY5p31aGDg9l3/sJZFpQh8XvU31ZK+TOpk+4/b3skaLk2A5V
    qb+NBNYPCPgVBQntZ5Oo1h2RPPO5Y+oaiaW8vbYjolm1HR4p3QxTNNV5WKetOQF8
    ZQgPO8N2UHN1yYTe/jMJ3vyEZ3R4Qw2CReYskPlm/IVqu9StbBbQkBmU7F1m09jy
    HFWULiHgTBgGR/AQd6pooT9V53AlSdAvzodN6Bli7DvKIstgocubieUv3CBanIRz
    dfgJgvhRfvsaukqOoWuGBbTBcr+JUSheDvO0xiiJe72MEKe/ORxk9IOELEh5w4ye
    0qlEGaxTuKcF1uJCLBRhj1RlulR/PEULP3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1522550551; bh=L97Cwd1E6f4eSULWpC4viX2PfJ4Z02/c/5FlOOSmi+8=; b=H
    uJprq3+kLGtPCHSu2j/57szalb+wy6L2NpqtMYajYEpAx2v7XQTGrb1MSzQ7F0hf
    5B0TY5enE5kaq9jATiWkx1XMr6BxLQ/wXS+dYDIPa7IRPld+xNzMiNVzvyHWQ1Wc
    aZbS48YjxlYVSepT0uydDfyy2d+qUIo6pmOZWBrCTcB0GoZ45lDCnsEY1xpOjdZl
    d635Pjr5ubtVdWPe8zVMvUVeTtlBGwIBN3bNfdUWrP43NIx6LRDhU2ZuESEDx4f8
    JQMmdV8C5s9fe2g5X5ebm9CbqHZUYpMpJgCWNKHghzqx5hONPjrD37/mM2lIRsKt
    pnxvlwxTWoTvaSzOeNDFQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CFwpLqWv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rKFQJAGL;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CFwpLqWv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rKFQJAGL;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCw4mzjb+RABSem86HBXPM6ETO2re43K6jAefvjXICSQ7FReKTV6DCEiDCucqTd520q2sQQVahd7BfTWEt3FzMi0osHGlsTpVHWLsDqYzfoCMbtU+hey
    L2G8/7gGxbmusM4WTrdFcpSDu7ycvUfYZQ+4Q3NMN4mpdwoNnu0DYjg1WUxDnrlBbZx0zsELbnjIkO0u0QJUoGT22yHaojUpvFUbZJvv4nZQymLKNUDDlis2
    WFycmArTRkFFi31PN5Dm3w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=ZtpzOtfCEmfvBxgCkckA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+QlALRLP/FGm8fPeZ4gBB9kfg3JhRXDpJxBrmJTJMNd2TlT6ihgwkpKoRb4Sen8aspT4CfXQ==
Subject: Re: [PATCH v4 1/2] staging: vt6655: check for memory allocation
 failures
To: Ji-Hun Kim <ji_hun.kim@samsung.com>, gregkh@linuxfoundation.org,
 forest@alittletooquiet.net
References: <CGME20180330055207epcas1p14d562f44802bac86a8a7cd95fe2d009f@epcas1p1.samsung.com>
 <1522389115-1124-1-git-send-email-ji_hun.kim@samsung.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <d75a16de-ea8e-842f-1bb6-b8d776d345a6@gmail.com>
Date: Sun, 1 Apr 2018 10:42:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1522389115-1124-1-git-send-email-ji_hun.kim@samsung.com>
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



On 2018/3/30 13:51, Ji-Hun Kim wrote:
> There are no null pointer checking on rd_info and td_info values which
> are allocated by kzalloc. It has potential null pointer dereferencing
> issues. Implement error handling code on device_init_rd*, device_init_td*
> and vnt_start for the allocation failures.
>
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
> ---
> Changes v2:
> - Delete WARN_ON which can makes crashes on some machines.
> - Instead of return directly, goto freeing function for freeing previously
>    allocated memory in the for loop after kzalloc() failed.
> - In the freeing function, add if statement for freeing to only allocated
>    values.
>
> Changes v3:
> - Modify return type of device_init_rd*, device_init_td*. Then add returns
>    error code at those functions and vnt_start as well.
>
> Changes v4:
> - Fix potential memory leaks from error handling code of device init
>    functions in vnt_start().
>
>   drivers/staging/vt6655/device_main.c | 121 ++++++++++++++++++++++++++---------
>   1 file changed, 89 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index fbc4bc6..c9752df 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -124,10 +124,10 @@
>   static void device_free_info(struct vnt_private *priv);
>   static void device_print_info(struct vnt_private *priv);
>   
> -static void device_init_rd0_ring(struct vnt_private *priv);
> -static void device_init_rd1_ring(struct vnt_private *priv);
> -static void device_init_td0_ring(struct vnt_private *priv);
> -static void device_init_td1_ring(struct vnt_private *priv);
> +static int device_init_rd0_ring(struct vnt_private *priv);
> +static int device_init_rd1_ring(struct vnt_private *priv);
> +static int device_init_td0_ring(struct vnt_private *priv);
> +static int device_init_td1_ring(struct vnt_private *priv);
>   
>   static int  device_rx_srv(struct vnt_private *priv, unsigned int idx);
>   static int  device_tx_srv(struct vnt_private *priv, unsigned int idx);
> @@ -528,18 +528,22 @@ static void device_free_rings(struct vnt_private *priv)
>   				  priv->tx0_bufs, priv->tx_bufs_dma0);
>   }
>   
> -static void device_init_rd0_ring(struct vnt_private *priv)
> +static int device_init_rd0_ring(struct vnt_private *priv)
>   {
>   	int i;
>   	dma_addr_t      curr = priv->rd0_pool_dma;
>   	struct vnt_rx_desc *desc;
> +	int ret = 0;
>   
>   	/* Init the RD0 ring entries */
>   	for (i = 0; i < priv->opts.rx_descs0;
>   	     i ++, curr += sizeof(struct vnt_rx_desc)) {
>   		desc = &priv->aRD0Ring[i];
>   		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
> -
> +		if (!desc->rd_info) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
>   		if (!device_alloc_rx_buf(priv, desc))
>   			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
>   
> @@ -550,20 +554,29 @@ static void device_init_rd0_ring(struct vnt_private *priv)
>   	if (i > 0)
>   		priv->aRD0Ring[i-1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
>   	priv->pCurrRD[0] = &priv->aRD0Ring[0];
> +
> +	return 0;
> +error:
> +	device_free_rd0_ring(priv);
> +	return ret;
>   }
>   
> -static void device_init_rd1_ring(struct vnt_private *priv)
> +static int device_init_rd1_ring(struct vnt_private *priv)
>   {
>   	int i;
>   	dma_addr_t      curr = priv->rd1_pool_dma;
>   	struct vnt_rx_desc *desc;
> +	int ret = 0;
>   
>   	/* Init the RD1 ring entries */
>   	for (i = 0; i < priv->opts.rx_descs1;
>   	     i ++, curr += sizeof(struct vnt_rx_desc)) {
>   		desc = &priv->aRD1Ring[i];
>   		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
> -
> +		if (!desc->rd_info) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
>   		if (!device_alloc_rx_buf(priv, desc))
>   			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
>   
> @@ -574,6 +587,11 @@ static void device_init_rd1_ring(struct vnt_private *priv)
>   	if (i > 0)
>   		priv->aRD1Ring[i-1].next_desc = cpu_to_le32(priv->rd1_pool_dma);
>   	priv->pCurrRD[1] = &priv->aRD1Ring[0];
> +
> +	return 0;
> +error:
> +	device_free_rd1_ring(priv);
> +	return ret;
>   }
>   
>   static void device_free_rd0_ring(struct vnt_private *priv)
> @@ -584,12 +602,12 @@ static void device_free_rd0_ring(struct vnt_private *priv)
>   		struct vnt_rx_desc *desc = &priv->aRD0Ring[i];
>   		struct vnt_rd_info *rd_info = desc->rd_info;
>   
> -		dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
> -				 priv->rx_buf_sz, DMA_FROM_DEVICE);
> -
> -		dev_kfree_skb(rd_info->skb);
> -
> -		kfree(desc->rd_info);
> +		if (rd_info) {
> +			dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
> +					priv->rx_buf_sz, DMA_FROM_DEVICE);
> +			dev_kfree_skb(rd_info->skb);
> +			kfree(desc->rd_info);
> +		}
>   	}
>   }
>   
> @@ -601,27 +619,31 @@ static void device_free_rd1_ring(struct vnt_private *priv)
>   		struct vnt_rx_desc *desc = &priv->aRD1Ring[i];
>   		struct vnt_rd_info *rd_info = desc->rd_info;
>   
> -		dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
> -				 priv->rx_buf_sz, DMA_FROM_DEVICE);
> -
> -		dev_kfree_skb(rd_info->skb);
> -
> -		kfree(desc->rd_info);
> +		if (rd_info) {
> +			dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
> +					priv->rx_buf_sz, DMA_FROM_DEVICE);
> +			dev_kfree_skb(rd_info->skb);
> +			kfree(desc->rd_info);
> +		}
>   	}
>   }
>   
> -static void device_init_td0_ring(struct vnt_private *priv)
> +static int device_init_td0_ring(struct vnt_private *priv)
>   {
>   	int i;
>   	dma_addr_t  curr;
>   	struct vnt_tx_desc *desc;
> +	int ret = 0;
>   
>   	curr = priv->td0_pool_dma;
>   	for (i = 0; i < priv->opts.tx_descs[0];
>   	     i++, curr += sizeof(struct vnt_tx_desc)) {
>   		desc = &priv->apTD0Rings[i];
>   		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
> -
> +		if (!desc->td_info) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
>   		desc->td_info->buf = priv->tx0_bufs + i * PKT_BUF_SZ;
>   		desc->td_info->buf_dma = priv->tx_bufs_dma0 + i * PKT_BUF_SZ;
>   
> @@ -632,13 +654,19 @@ static void device_init_td0_ring(struct vnt_private *priv)
>   	if (i > 0)
>   		priv->apTD0Rings[i-1].next_desc = cpu_to_le32(priv->td0_pool_dma);
>   	priv->apTailTD[0] = priv->apCurrTD[0] = &priv->apTD0Rings[0];
> +
> +	return 0;
> +error:
> +	device_free_td0_ring(priv);
> +	return ret;
>   }
>   
> -static void device_init_td1_ring(struct vnt_private *priv)
> +static int device_init_td1_ring(struct vnt_private *priv)
>   {
>   	int i;
>   	dma_addr_t  curr;
>   	struct vnt_tx_desc *desc;
> +	int ret = 0;
>   
>   	/* Init the TD ring entries */
>   	curr = priv->td1_pool_dma;
> @@ -646,7 +674,10 @@ static void device_init_td1_ring(struct vnt_private *priv)
>   	     i++, curr += sizeof(struct vnt_tx_desc)) {
>   		desc = &priv->apTD1Rings[i];
>   		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
> -
> +		if (!desc->td_info) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
>   		desc->td_info->buf = priv->tx1_bufs + i * PKT_BUF_SZ;
>   		desc->td_info->buf_dma = priv->tx_bufs_dma1 + i * PKT_BUF_SZ;
>   
> @@ -657,6 +688,11 @@ static void device_init_td1_ring(struct vnt_private *priv)
>   	if (i > 0)
>   		priv->apTD1Rings[i-1].next_desc = cpu_to_le32(priv->td1_pool_dma);
>   	priv->apTailTD[1] = priv->apCurrTD[1] = &priv->apTD1Rings[0];
> +
> +	return 0;
> +error:
> +	device_free_td1_ring(priv);
> +	return ret;
>   }
>   
>   static void device_free_td0_ring(struct vnt_private *priv)
> @@ -667,8 +703,10 @@ static void device_free_td0_ring(struct vnt_private *priv)
>   		struct vnt_tx_desc *desc = &priv->apTD0Rings[i];
>   		struct vnt_td_info *td_info = desc->td_info;
>   
> -		dev_kfree_skb(td_info->skb);
> -		kfree(desc->td_info);
> +		if (td_info) {
> +			dev_kfree_skb(td_info->skb);
> +			kfree(desc->td_info);
> +		}
>   	}
>   }
>   
> @@ -680,8 +718,10 @@ static void device_free_td1_ring(struct vnt_private *priv)
>   		struct vnt_tx_desc *desc = &priv->apTD1Rings[i];
>   		struct vnt_td_info *td_info = desc->td_info;
>   
> -		dev_kfree_skb(td_info->skb);
> -		kfree(desc->td_info);
> +		if (td_info) {
> +			dev_kfree_skb(td_info->skb);
> +			kfree(desc->td_info);
> +		}
>   	}
>   }
>   
> @@ -1165,10 +1205,18 @@ static int vnt_start(struct ieee80211_hw *hw)
>   	}
>   
>   	dev_dbg(&priv->pcid->dev, "call device init rd0 ring\n");
> -	device_init_rd0_ring(priv);
> -	device_init_rd1_ring(priv);
> -	device_init_td0_ring(priv);
> -	device_init_td1_ring(priv);
> +	ret = device_init_rd0_ring(priv);
> +	if (ret)
> +		goto err_init_rd0_ring;
> +	ret = device_init_rd1_ring(priv);
> +	if (ret)
> +		goto err_init_rd1_ring;
> +	ret = device_init_td0_ring(priv);
> +	if (ret)
> +		goto err_init_td0_ring;
> +	ret = device_init_td1_ring(priv);
> +	if (ret)
> +		goto err_init_td1_ring;
>   
>   	device_init_registers(priv);
>   
> @@ -1178,6 +1226,15 @@ static int vnt_start(struct ieee80211_hw *hw)
>   	ieee80211_wake_queues(hw);
>   
>   	return 0;
> +
> +err_init_td1_ring:
> +	device_free_td0_ring(priv);
> +err_init_td0_ring:
> +	device_free_rd1_ring(priv);
> +err_init_rd1_ring:
> +	device_free_rd0_ring(priv);
> +err_init_rd0_ring:
> +	return ret;
>   }
>   
>   static void vnt_stop(struct ieee80211_hw *hw)

It looks okay now :)


Best wishes,
Jia-Ju Bai
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
