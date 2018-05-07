Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-272202-1525672540-2-13044986312115811218
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525672539; b=mNkTGCAlyQ0X/jcqqj+NWPmUUFWXF0B9WdgFXVpDieX/gJlVCm
    CO0gPJQzvfT4THfxFL1PPsNMv4tuj7UFf5T7ldM51VqDIdgQp3v+L7RIt3UTaNK5
    EFEwjPpcFk64BipIE5lXdaTtGHoMDEBcFj/5posWhrLziz6zF/VlOmyweC5CM3aw
    ZbANSFgul3j7idRcBoGQT14yyCghjCrtsustyqrSpKr1vgTmhk7H5RF2PKJqBPR7
    EPFEViTVSUFXjEpfefD3MiTaR9h2jJ6hgd3oEskZ8uGIz5d4fHpPaOxGLKzpgNRz
    DAh1nz7ozOtQSA9NxcpbGTH/1LTLJkq7mREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525672539; bh=IU+zI
    Bkhf/DEtAeA12A6Fr/Ic6938p9wBBFpHdcLeUU=; b=iXqp3cDoX6CL6qqjhYE9w
    j3V0ukvHTtiSZ7S8lNY4mU5UdyuH9/FsuRl97gMW/vPximDIeP8RE71et7Zb0aZw
    /VKHBae/ybdpoKrkBvU6kajU2PwDG9OM/EXLvqnouO+QHbToVajFeAjDfpB7VKTX
    FsLgTkMxhK8iQwAFmnGFNGwebmGlknfpfox/T1JMUtKU0ALLyTg+EpXcxgCAdmPx
    n7Qi9A5li+x9Dd3bK8Sky+v4q9RyFaoilAaJ2Zrsh9q6aKiRHXbz9SGFxwcqbP4i
    STLiQZxS795/U2F/9mleN/CLxber/clUjf7gAO0zeAQF5Y98yzLtRUx6dMi51E1I
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOqjZL35jjlrxBuwDMzYLL02YezRs0/vc2FCfViMREJYRQSqNkR8CFCejlNqbPSypg1lLCbKIMloikRD6eLZUxASWkNmo6AbvpauS/AhjUK7lCr8de7M
    PPv3tYlNaT2SFa1Fdm6KkbDsgViK4j35mhCt7T97VYu/YJmtV+68wJdJ8iPxlD9Vi4DAXOYXbZEeK3cmnwzDzjJUgTDi7mRmM9f44UB7Y4d432zdOtxK6XXJ
    3CV6EmzLHO8q3mPYWmOFVQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=XYAwZIGsAAAA:8
    a=DDOyTI_5AAAA:8 a=qHPcYFDVXG66z-AEe_gA:9 a=CjuIK1q_8ugA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.49,372,1520924400"; d="scan'208";a="13957706"
Date: Mon, 7 May 2018 11:25:27 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 3/3] staging: wilc1000: Remove unnecessary array index
 check
Message-ID: <20180507112527.0037a95e@ajaysk-VirtualBox>
In-Reply-To: <20180506073333.3770-3-natechancellor@gmail.com>
References: <20180506073333.3770-1-natechancellor@gmail.com>
 <20180506073333.3770-3-natechancellor@gmail.com>
Organization: Microchip Technology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ganesh Krishna <ganesh.krishna@microchip.com>,
 Aditya Shankar <aditya.shankar@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 6 May 2018 00:33:33 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> This statment triggers GCC's -Wtype-limit since key_index is an
> unsigned integer so it cannot be less than zero.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>

> ---
>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c index
> b499fb987395..e0015ca6c21a 100644 ---
> a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c +++
> b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c @@ -1054,7
> +1054,7 @@ static int del_key(struct wiphy *wiphy, struct net_device
> *netdev, } }
>  
> -	if (key_index >= 0 && key_index <= 3 &&
> priv->wep_key_len[key_index]) {
> +	if (key_index <= 3 && priv->wep_key_len[key_index]) {
>  		memset(priv->wep_key[key_index], 0,
>  		       priv->wep_key_len[key_index]);
>  		priv->wep_key_len[key_index] = 0;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
