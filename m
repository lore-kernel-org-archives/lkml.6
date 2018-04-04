Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3959850-1522835621-2-4617440202239230485
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522835620; b=nxnx0d8ztHPJkMUtGLTT+qM/qcMBkidOab/CqEHx7Mj6A4Ovhq
    5On8Bq1WLB1VdGPFSposl3z1wxFvYvV3QBRT+Mhdx5k969c4WfLN2lE2P2S/nXNo
    8orrt5S/QpRt6KLXyNsok33SWZWW/0TYJEee2vE1TYY9qpGVX36QPdyQ04/kpPbt
    ZUbq4gxaws39oMsa7bj2429yfPp2VGpH2UDNWsynAlGZgc0UxCv3lH6iGkFIJOeJ
    Tj59rXi0I4pGlhdQsLNwjW5J9jiYICCNPCxD+rfgA0USHslyGJwFa/dT767XWRMt
    kMVMKiENdIWDd5XDWYYz65GPGG8rQAj6tLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522835620; bh=MOr0q
    U0R0/FzXg4eMR33yc2UO8w08COOjxTWy2sM+78=; b=SlvdB98EX5bEe8ym3sbby
    v7wR+HwWd7uvtyuuQQ3tLus2xuMBoPM2x4l4M6orMEgCNBhV2OkyFpJFnIRTvdb7
    rgRRDsWtdEWMu0NqQUXHAov2DwtsGL/OY0vHd1kwVI+hfQKhT2MeBzw0GePnMjjR
    PoaToYK9ADz6cchhuO0GnCTnOSK+za7EUaIPmzxQraDgSQrObemJd8BLSy7AK8iD
    s5xVTMPWLL3RxO8ThmYPByh48X3T7I5GD4DxwRL938SdwUcOq/FcjslPlUAYKffK
    L/4rE+Ao1CQqSh1yXn95ahZ+Fs2QE6uoAwjN6p6kJ9DZOJKvctsJDGAevRHrIrJ1
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=n8aWcVcI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=n8aWcVcI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ3GfnSdrdfIlNP6Dl1YWBKZifpZHZ5VVq/e68IU2199ZTitpgqiB5VL6oMsMRQPjKhAk0ltrMf89Ahy4Nl4/tJCz3VnBl0yrigK1AxnILJwPgBBZF/Q
    8V2QRAVWTZyFmQD2CEVR8Npcv4NE5X9oPBO+hAZzbc2m0gLcHjfs6Z9p+vBC1aCan/ef6NxFKDQrpAbeFRdBY062Mft0UEzkk7FwR4myV+KPX8rLJFvn52DP
    mxtLZwFpVrHHHK13eM4M/w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=-g8SutxOOoXPudxWzVcA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 4 Apr 2018 12:53:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Subject: Re: [PATCH v3] staging: vt6655: check for memory allocation failures
Message-ID: <20180404095319.zshtp3cbyf6sxsfq@mwanda>
References: <CGME20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf@epcas2p2.samsung.com>
 <1522377844-23591-1-git-send-email-ji_hun.kim@samsung.com>
 <20180403104052.6wbomdguifrmlmpz@mwanda>
 <20180404072410.GA31134@ubuntu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180404072410.GA31134@ubuntu>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852
 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040097
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

On Wed, Apr 04, 2018 at 04:24:10PM +0900, Ji-Hun Kim wrote:
> > Since we only partially allocated the
> > rd0 ring, device_free_rd0_ring() will crash when we do:
> > 
> > 		dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
> > 				 priv->rx_buf_sz, DMA_FROM_DEVICE);
> > 
> > "rd_info" is NULL so rd_info->skb_dma is a NULL dereference.
> 
> For dealing with this problem, I added below code on patch v3. I think it
> would not make Null dereferencing issues, because it will not enter 
> dma_unmap_single(), if "rd_info" is Null.
> 
> +               if (rd_info) {
> +                       dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
> +                                       priv->rx_buf_sz, DMA_FROM_DEVICE);
> +                       dev_kfree_skb(rd_info->skb);
> +                       kfree(desc->rd_info);
> +               }
> 
> I would appreciate for your opinions what would be better way for freeing
> allocated "rd_info"s in the loop previously.

Of course, that works for this particular bug but I'm not a fan of that
approach...

When I say "do nothing" gotos, I mean.

err:
	return ret;

And what I mean by "one err" is this:

err:
	free(a);
	free(b)
	free(c);

	return ret;

There is only one error label even though we are freeing three things.
The problem with that is that you might be freeing something this hasn't
been allocated like "rd_info->skb_dma" but "rd_info" wasn't allocated.
It's a very normally problem to have with this style of error handling.

Most kernel error handling is very simple.

err_free_c:
	free(c);
err_free_b:
	free(b);
err_free_a:
	free(a);

	return ret;

Side note:  Part of the problem here is that device_alloc_rx_buf() does
not have a corresponding free function.  Every alloc should have a
matching free function so that if we ever change the alloc function, we
just have to update one free function.  And it's just cleaner.

static void device_free_rx_buf(struct vnt_private *priv,
			       struct vnt_rx_desc *rd)
{
	struct vnt_rd_info *rd_info = rd->rd_info;

	dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma, priv->rx_buf_sz,
			 DMA_FROM_DEVICE);
	dev_kfree_skb(rd_info->skb);
}

Maybe send a patch that adds that and changes device_free_rd0_ring() to
use the new free function instead of open coding it.  [PATCH 1/2].

These particular functions are slighttly complicated because they have
loops and the error handling for loops is tricky and bug prone.  Here is
what I would like the error handling to look like:

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 0dc902022a91..e12a959fe080 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -533,15 +533,23 @@ static void device_init_rd0_ring(struct vnt_private *priv)
 	int i;
 	dma_addr_t      curr = priv->rd0_pool_dma;
 	struct vnt_rx_desc *desc;
+	int ret;
 
 	/* Init the RD0 ring entries */
 	for (i = 0; i < priv->opts.rx_descs0;
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
 		desc = &priv->aRD0Ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
+		if (!desc->rd_info) {
+			ret = -ENOMEM;
+			goto err_free_descs;
+		}
 
-		if (!device_alloc_rx_buf(priv, desc))
+		if (!device_alloc_rx_buf(priv, desc)) {
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
+			ret = -ENOMEM;
+			goto err_free_rd;
+		}
 
 		desc->next = &(priv->aRD0Ring[(i + 1) % priv->opts.rx_descs0]);
 		desc->next_desc = cpu_to_le32(curr + sizeof(struct vnt_rx_desc));
@@ -550,6 +558,20 @@ static void device_init_rd0_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->aRD0Ring[i-1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
 	priv->pCurrRD[0] = &priv->aRD0Ring[0];
+
+	return 0;
+
+err_free_rd:
+	kfree(desc->rd_info);
+
+err_free_descs:
+	while (--i) {
+		desc = &priv->aRD0Ring[i];
+		device_free_rx_buf(priv, desc);
+		kfree(desc->rd_info);
+	}
+
+	return ret;
 }
 
 static void device_init_rd1_ring(struct vnt_private *priv)

It's more work to do it this way.  It's also more lines of code, but
it's easier to read and review because you can look at the function and
see that it's correct without jumping to other functions to verify that
they check if rd_info is NULL or not.

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
