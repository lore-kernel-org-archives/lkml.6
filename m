Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1311226-1522754334-2-2934557400858618565
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
    1522754333; b=UZeQIcGDmO4vJf269WKp6Y4AWr9+BWKvRAdirpJqVzB80nQNhp
    4yRT+gkI4/ipNW6GMBkQHkR5iBGcqQqH9OYlhlgh6LZi2jehRdlbB7GoWFuB02GP
    xqHhrsNNwC+v2F6LEDmIDWIN558u+oK4BB3Ff5fI1YnpXEGs5Khw+GYHOYV4n0Zk
    22rBF8cq+sHMpIn2WAfR/30SJayQblHkTJauSgoDtmc7ewJBsn1FD1+Zjh3FYeMb
    TbqadONOiGLgs3Wcn52QZRzrDNUun6jN2kO9oYiHLdIJO54Rkw40WMW4l+GEwJqq
    +Zuc9TiYJXT6zwH2+7kIxfyG5GZDNPSArjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522754333; bh=f+JsG
    66U1UScTw+lMleNifCNsho+2lsR0JRUmaVTx+8=; b=KLAcGFbUlD3YFBaWj6vqM
    Li0XFiv1Ea3jRlOZwupR48qCe5im1BDgIuFBYemEHwlV5iDVcoyThqdB1E76lSAx
    aEThCM+NUvq7NGpET+3biAmu91ofTqRAb9lXIY9O7unupft8OfzUqncnf9140ljO
    fo6yAoMBn/sFddfYZiWr7ltQx+H6KluKLeEts0Nqj71ruIeivCZa59BIX+o0sxEa
    DOJD4Qtvx5S2busaEwWq0/XpgxDDECPzB+ci0icbxQtH9odaBcmZavNeTvrGvkSX
    05dbJSyrbOI2oy+2OKC1yncW8nZ3D9N/Kk6v1s5uLs8fqEGqVNPqDtSiniSC9GFX
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=FSLpVAAD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=FSLpVAAD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
X-CM-Envelope: MS4wfJeZpm9cnPpj1MCbfo0/oCuaCiN6qHDDdcFmWP+DYOPlulI6D3HNvSIAV6307H1PDSojsgEfNBenNzobr91aAIWhuSnzAWVFnPHPA8vz4J4QMHxcMDxt
    tSAJ3890y9cSLUYk6Sf9iWpVoTIk7ybYEsKpXZu4CWMnoNdsKXP6Qy4Ujg9hJsbxUA0jfyi5m3JgWQBklp9ftwcIQDa3JwBhXJu4pubysLuqY2FNqFrnmYEw
    h2C/xY7p3Aqp56eMYedzlg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=CeBZLuz0llKS90HDwRQA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 3 Apr 2018 14:18:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Subject: Re: [PATCH v4 2/2] staging: vt6655: add handling memory leak on
 vnt_start()
Message-ID: <20180403111833.r6o3xf4go5gfwyj6@mwanda>
References: <1522389115-1124-1-git-send-email-ji_hun.kim@samsung.com>
 <CGME20180330055211epcas2p1a75c707cdf600cfd5027e253ef440861@epcas2p1.samsung.com>
 <1522389115-1124-2-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1522389115-1124-2-git-send-email-ji_hun.kim@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851
 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030118
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

On Fri, Mar 30, 2018 at 02:51:55PM +0900, Ji-Hun Kim wrote:
> There was no code for handling memory leaks of device_init_rings() and
> request_irq(). It needs to free allocated memory in the device_init_rings()
> , when request_irq() is failed. Add freeing sequences of irq and device
> init rings.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
> ---
> It's additional memory leak handling patch from
> [PATCH v4 1/2] staging: vt6655: check for memory allocation failures
> 
>  drivers/staging/vt6655/device_main.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index c9752df..3604f2d 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -1194,14 +1194,17 @@ static int vnt_start(struct ieee80211_hw *hw)
>  	int ret;
>  
>  	priv->rx_buf_sz = PKT_BUF_SZ;
> -	if (!device_init_rings(priv))
> -		return -ENOMEM;
> +	ret = (int)device_init_rings(priv);

There is only one call site.  Just change device_init_rings() to return
negative error codes or zero.

> +	if (!ret) {
> +		ret = -ENOMEM;
> +		goto err_init_rings;

Just return directly since there is nothing to clean up.

		return -ENOMEM;

> +	}
>  
>  	ret = request_irq(priv->pcid->irq, vnt_interrupt,
>  			  IRQF_SHARED, "vt6655", priv);
>  	if (ret) {
>  		dev_dbg(&priv->pcid->dev, "failed to start irq\n");
> -		return ret;
> +		goto err_irq;

This is a "come from" label name.  It's better if the goto says what the
goto does like "goto err_free_rings;" here.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
