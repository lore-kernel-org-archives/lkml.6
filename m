Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2024893-1523438328-2-4382544936962849830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='uk', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523438327; b=AmhezBUHVMWn3lXY/YReknv7y1x9uMDMWMDXQo3vWi0A5vHTsK
    cMaGSMN6ods/Ll1NQY56FRzU9q5P424l+8PsFr+Ncu+TbSGn1ea/LCgDJxNVBs7K
    fT88bdfPwxWKy2+jKC58M8vndT0nM83XPSYSA4jbSVq6KG4xpg3pJE4hmCR546lz
    9p5VItGMNf1MuUYjVA4eQ+RQccwAa+Z1RLPa75OxOroAaiokm6EQ4jHZCVwnOJRB
    hPKnv8xRDPCLsYRExWKE0CF1jqdXbf6RSawtsmTh4Wxa+l0IycaFQLihZTyh6gm8
    XqPFrI/6BtwyX5+oxKL2k7RotoGow5KbkqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1523438327; bh=HVNJlkGYbLS5HB3Y1fDeYKbWSqCQYXl35WHvdr0OwLo=; b=H
    KdnQUGmOGMNOQfgOLHe8HXzyuFymcu0P+xXKXkICfLW5G58kRFGb/K+j/XVWn7RF
    NBDRvt4IGnt7X+ZuFa/IKtX7hdOBxk9uTiUcGSi5/ZWq5BkL2dAvMA6FLbnz6cZh
    kheJS4MxGmCgWIkK/q/ipYGLLqMtA8WViYLzE9P5HzJHir26RBgELWkQlj6BJP0V
    Xx1Dsq8t8xfubdCPP3vLEqh9iFw5IL8FueeRl4TEXb+DCx+TRBCMprWw6Ih9yb+e
    eI7NzIyNyPwXUoEjzS7pytjrarr1+zYK9XsqoozlbHgc63nl9FKT6jTBIb+W6Ilg
    PIXoTBLIC6aCBRIUn2MAA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mev.co.uk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=mev.co.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIn+1kMIh/BygODlCkmGosOnoVo5pCPXTJPCWj4a1BX7Spt7xvRnZf4rsWqq0qCmwmfdc6jYK7FsAyCauoreAJph9ubDnzki8c5/qrunwDOLlTWbpxPE
    /RyPj6eAFEBcsKnx/G+lovswh9Jands4OGg9FyUXnm6a/eP1rzITcJqZI8PPE2m3F7ZC6XySnYxi+VlcB37AOk7N1KbFUY2IF0rVHWxC455dApEt5rOKv2Ox
    6kRFwqVujHa0jTRlEPOOdg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=LMMEo6NmNBYA:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=v8_uC2TkAAAA:8 a=DDOyTI_5AAAA:8 a=jwI3GA17WMZauTxd-jMA:9
    a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=LPG4CVFsY2Za8Ycu:21 a=Fi4gkQWg0tsC5NX1:21
    a=CjuIK1q_8ugA:10 a=-zX3Q7Ulo5sA:10 a=OGrQfBrq7qvr04naqs9r:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Auth-ID: siepeng@mev.co.uk
X-Sender-Id: siepeng@mev.co.uk
Subject: Re: [PATCH] staging: comedi: cb_pcidas64: fix alignment of function
 parameters
To: Gabriel Francisco Mandaji <gfmandaji@gmail.com>, gregkh@linuxfoundation.org
References: <20180410225007.GA5050@gfm-note>
From: Ian Abbott <abbotti@mev.co.uk>
Message-ID: <50d5d5b9-d4f3-68a5-268b-fbe46188ebb4@mev.co.uk>
Date: Wed, 11 Apr 2018 10:18:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410225007.GA5050@gfm-note>
Content-Language: en-GB
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
Cc: devel@driverdev.osuosl.org, lkcamp@lists.libreplanetbr.org,
 linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10/04/18 23:50, Gabriel Francisco Mandaji wrote:
> Fix most checkpatch.pl issues of type:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
> ---
>   drivers/staging/comedi/drivers/cb_pcidas64.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
> index fdd81c3..631a703 100644
> --- a/drivers/staging/comedi/drivers/cb_pcidas64.c
> +++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
> @@ -2268,14 +2268,14 @@ static inline unsigned int dma_transfer_size(struct comedi_device *dev)
>   }
>   
>   static u32 ai_convert_counter_6xxx(const struct comedi_device *dev,
> -					const struct comedi_cmd *cmd)
> +				   const struct comedi_cmd *cmd)
>   {
>   	/* supposed to load counter with desired divisor minus 3 */
>   	return cmd->convert_arg / TIMER_BASE - 3;
>   }
>   
>   static u32 ai_scan_counter_6xxx(struct comedi_device *dev,
> -				     struct comedi_cmd *cmd)
> +				struct comedi_cmd *cmd)
>   {
>   	u32 count;
>   
> @@ -2296,7 +2296,7 @@ static u32 ai_scan_counter_6xxx(struct comedi_device *dev,
>   }
>   
>   static u32 ai_convert_counter_4020(struct comedi_device *dev,
> -					struct comedi_cmd *cmd)
> +				   struct comedi_cmd *cmd)
>   {
>   	struct pcidas64_private *devpriv = dev->private;
>   	unsigned int divisor;
> 

Looks good, thanks.  I guess the remaining case of open parentheses 
alignment wasn't changed because that would exceed 80 columns.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
