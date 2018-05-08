Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525779294-2-16164598879784293395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525779294; b=bVRDJkrakKpEhMo8l2M2i1xpyW3Dg0vmemP8zqyY0g62l4XHG7
    Vkasp1JF55wQtQq3e51LJ7IRoxej9lfRk6HCIZ9wMvV+tDQ18Q9gZoIhQ7/FJqfP
    qZcSDFsz3437LwITuccCqKyn8DPQ6UvaViwUhno1WnPud3Hx5edzJcRuO2RGcoCY
    8Jv40B7A7kD8ZOaVLRDr/E07HqBpVJ2qHOZSMp5WB/j83NtYCCf8hgCLDjXmQ3rq
    TSuCkT1f1snVKWCnOkox9ReEaod/hWiRQl2TihmjcSfRGDCPI/A4suT9iJzWBE/E
    igjWwo6qFtF5zc/RJ580XYXsYyo32IDH0sVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525779294; bh=x3/PZ
    XvW8VnrYejc6uEimCMU6J+Vx7Ab3+PMH2+OWYI=; b=O1eh+APhTW7APLRb1TCDV
    DZFRMFEWot1q5yjkxXllR8ecVNeJi3BnRFCS+PuniUpe2Yo11Zx50E8syztZQ11E
    Ci5BPXySThKe0J3qFtzzpFFEb10Ch4wzWppMEn1B4kCYoyOkRV7D4wdKjT7fWuGa
    V6KXHgAanWVu4tLr12+ClLk6W2MuPwzLiT6Oxb3BKDIRW+W/Y00YYrWBOfwFAwIl
    XU0/u6x8hf16+XYPBQXk6SSqecBskeGIVyAz39vXe68nJaP2mdLNFO74hFXeq8ZJ
    0AeLglKOVW/kzy1GW+GF2wnAus4/acOehb4dzRLGJPbReziNrXnl+7+vB0v3wtNQ
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=YH2kfS6a x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=YH2kfS6a x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLJhZxTb49QniZos8TQ8ah/lsNPQnFLxg0xSZcByzChc8EkgHrjnz/Tnosrll0lKnFryQp4S9MPzVa9BGv+YlPdwPAjScWdirCgJ4l+MR5Ghvm5D6thi
    gsU3plShYQz3A7kKptxuYbgPlF5fqqHRAbppWVF9y4KDEwMhFChhD0GXjx5juDcEDxcfePwMQhgVz60J8KutPN96HLaOrYfB8lFNUf38we3PR4mg93GeZBCG
    97Q+z5xwRVN3rPSQ2v8NZA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=7_LiQqKaejCwzsPvl7kA:9 a=4g0zEg3oZGTZkf5T:21 a=Nwpr4a16GYcs9EQg:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 8 May 2018 13:34:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 7/7] staging: ks7010: Move from bool to int in structs
Message-ID: <20180508113431.GA12019@kroah.com>
References: <20180506220304.13040-1-natechancellor@gmail.com>
 <20180506220304.13040-7-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180506220304.13040-7-natechancellor@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 03:03:04PM -0700, Nathan Chancellor wrote:
> Fixes checkpatch.pl warnings.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/ks7010/ks_hostif.c   | 4 ++--
>  drivers/staging/ks7010/ks_wlan.h     | 4 ++--
>  drivers/staging/ks7010/ks_wlan_net.c | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index 628171091786..43090922daff 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -475,7 +475,7 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
>  	case DOT11_MAC_ADDRESS:
>  		hostif_sme_enqueue(priv, SME_GET_MAC_ADDRESS);
>  		ether_addr_copy(priv->eth_addr, priv->rxp);
> -		priv->mac_address_valid = true;
> +		priv->mac_address_valid = 1;

Wait, why?  This should be bool, not an int.  Why would checkpatch say
this is incorrect?

confused,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
