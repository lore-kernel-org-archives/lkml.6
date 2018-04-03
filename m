Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1190338-1522752073-2-3874842540996457996
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522752072; b=YUW/R9bZvHWCpgWRp8s3UrhKJASbKIwFRW2k8N22M7Jg5Gf77K
    KC54yQaT4fTuKM+VukAaXrfXbO02+eC9LBFEMaBkuwDCMOYjGzIO2FlI30gEwYBV
    C/PgMjrfGckpo+50jEgJAnHaKRis3vTjSZ6DQ6ZZsj556k/a42SmuWPjyNhMCDvE
    7jsAfBHXy861KzFTeRm90p/aqx4Z73A50WqyoQC2xg9FkvdLx8sclXlqlRgwMroX
    4TksUYlAp3+qaZXUX/TlrVXxM2uQ7V6ZZ77a0o+r8xa7Wrby83wUOtz6pOXSokMZ
    +ox0WSCaxAdvGwnV1/g/Ek4L/QS/66s+6kCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522752072; bh=9699l
    BHDVGYHy9lODmkD/zWnfdRYtmFllGItSW5cbU8=; b=FPbKtfKzM/E/TcHIZf2pM
    nf70Jo6oKA6EVoyIVKuVoq8eQfWxJLMNm7i9YlCKKWHz2GBNZi/6fQ7P8/xiXd8U
    wqYw82cnMQsu7oXbPCfCzo1nrlC/eT8YFdQASXFdrGmjMABCO+ng4M1VWz8+jYLW
    Zm44N2d/5EbJUxzKNcYygG8dO0xZgZT4VS8kI/cWQfPA+u+Q09UH5vhQ3h2+DmOP
    Z15SY/W3020jh6N8wArQhXyMg1ekhMu/UIuAFpZyuao52Hx0c1SNeSHe0a/R9oA/
    OTK8Pmmv6+Uw1KgyKXSidP1bwcoYBw1B+L37K4xgH4LJqnw4Jmo6S0N7LVseh4X6
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=hTo07P2D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=hTo07P2D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJB+8sZ/ZFbFrhTKLCwXASJ4XiJ5khAmM+B+ddJ08zHbKOiLVQIGHZ+FfT9Cr0M3hFRh8OJ01ugt5QhHwJ5hXy8mpbyA0tFH5nEyBMTK/EplNHYGdlwn
    fXSvKrntBQLcBL6a62YsU9E61wMDiNmzRyuJaMLDnBqjh2H+Fqm+gEwIFJd5Y3cmqjR/YwyHylyD+0bUcbk48pvoegSnYGlHQkL9U6f9hOwwISR9NkiYPqlz
    OWNnaUETPN6/HuLVsWYcVQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=1XWaLZrsAAAA:8 a=DDOyTI_5AAAA:8
    a=1aPI_1tQwmsEff5gB5sA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 3 Apr 2018 13:40:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Subject: Re: [PATCH v3] staging: vt6655: check for memory allocation failures
Message-ID: <20180403104052.6wbomdguifrmlmpz@mwanda>
References: <CGME20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf@epcas2p2.samsung.com>
 <1522377844-23591-1-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1522377844-23591-1-git-send-email-ji_hun.kim@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851
 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030109
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
Cc: devel@driverdev.osuosl.org, y.k.oh@samsung.com, gregkh@linuxfoundation.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 julia.lawall@lip6.fr, baijiaju1990@gmail.com, forest@alittletooquiet.net,
 santhameena13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:44:04AM +0900, Ji-Hun Kim wrote:
> @@ -528,18 +528,22 @@ static void device_free_rings(struct vnt_private *priv)
>  				  priv->tx0_bufs, priv->tx_bufs_dma0);
>  }
>  
> -static void device_init_rd0_ring(struct vnt_private *priv)
> +static int device_init_rd0_ring(struct vnt_private *priv)
>  {
>  	int i;
>  	dma_addr_t      curr = priv->rd0_pool_dma;
>  	struct vnt_rx_desc *desc;
> +	int ret = 0;

Don't initialize "ret".  When you do that it disables static analysis to
find uninitialized variable warnings.

>  
>  	/* Init the RD0 ring entries */
>  	for (i = 0; i < priv->opts.rx_descs0;
>  	     i ++, curr += sizeof(struct vnt_rx_desc)) {
>  		desc = &priv->aRD0Ring[i];
>  		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
> -
> +		if (!desc->rd_info) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
>  		if (!device_alloc_rx_buf(priv, desc))
>  			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
>  

We need to handle the case where device_alloc_rx_buf() fails as well...

Some years back, I wrote a post about error handling that might be
helpful:
https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ

You are using "one err" and "do nothing" style error handling which are
described in the post.


> @@ -550,20 +554,29 @@ static void device_init_rd0_ring(struct vnt_private *priv)
>  	if (i > 0)
>  		priv->aRD0Ring[i-1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
>  	priv->pCurrRD[0] = &priv->aRD0Ring[0];
> +
> +	return 0;
> +error:
> +	device_free_rd0_ring(priv);
> +	return ret;
>  }

Of course, Jia-Ju Bai is correct to say that this is a layering
violation.  Each function should only clean up after its self.

Also, this is a very typical "one err" style bug which I explain about
in my g+ post.  The rule that applies here is that you should only free
things which have been allocated.  Since we only partially allocated the
rd0 ring, device_free_rd0_ring() will crash when we do:

		dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
				 priv->rx_buf_sz, DMA_FROM_DEVICE);

"rd_info" is NULL so rd_info->skb_dma is a NULL dereference.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
