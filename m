Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3428274-1519150551-5-2142119492436371085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensvda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519150551; b=gAWBWLrZw9r8uJQope+SPrXHpvX3/fCA++Utmqd/Tod/jBg
    qgztsGIDO+nSGr7wH3Cr8SgjzBVEIDdyRj8j13LNd2iWx9Q5GsBkiX064Qa6+J9L
    /m9aKdFbrq30/Vw2kUgVECZ+zn74pNfIbVJ5BknUEZJCqewfs43FlSosY0ZoKACV
    dMffIMUTEpUbGvCJXCIdf1llxatlX5G01q8hlyK+ZugRmg9t8J6E4TZsS1TCMM8J
    NAWEUx/GQXsh0ShXuBFwdwVu+kPac3aa4MrFd/sf6sLgACILjgtiXyxeUDzNEna0
    +f7fTT8nSRPfymzOglsT2guX/YpRXCFE6QYR0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1519150551; bh=A7+P0tgWuL5Hjt35YDVsYW6Vi6354l94u2vMni9I9NU=; b=Q
    9sGXpx/lDmLqbXHtsyJB7SBHbJkuJEV5ea8jlZS84/aXfa1VWUzNGhds5jHsl+gG
    tSEd/J6PWC2RkTtf6UiG4klZkDBGjlniFflQorw6RFVJJa+cyHSmd0VtskSrl357
    aAkUXQbn//7kfhQdHqXYH5ls2t05KJGpjDUdv+v/oA7FI8J06lNnHa6+9qgAqAfh
    gDZBhC47vqZkcqgeAIIAnQ2RqJKfM/wJ36NT7mTPCgEMO8kKlnzdaUtn2kjsZdF6
    C9F92A0x/HE0NQ8gIjgPXirnG4z+3Dy6qP/ZaaSHpOSdw4EA+mXcopuKx0S58psy
    CFlYnVTwUSnzK8yq3lPVA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MimxSoCH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwfinger.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rilxCBnN;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lwfinger.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MimxSoCH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwfinger.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rilxCBnN;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lwfinger.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt3S+UWoX7tRAbUtGU1ASxNYEOs/iowuQ/ar4SGfU7bXLBtBxgrEM2AsMxaoV3JpP/vU/2lFg==
Subject: Re: [PATCH-next] staging: rtl8188eu: Remove unneeded cast
To: Christopher Diaz Riveros <chrisadr@gentoo.org>, gregkh@linuxfoundation.org
References: <20180220163722.14694-1-chrisadr@gentoo.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <a418ef3d-c297-8438-6246-321bd05a930f@lwfinger.net>
Date: Tue, 20 Feb 2018 12:15:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220163722.14694-1-chrisadr@gentoo.org>
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
Cc: devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/20/2018 10:37 AM, Christopher Diaz Riveros wrote:
> Fix Coccinelle alert:
> 
> drivers/staging//rtl8188eu/os_dep/usb_intf.c:336:13-27: WARNING: casting value returned by memory allocation function to (struct adapter *) is useless.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>


> ---
>   drivers/staging/rtl8188eu/os_dep/usb_intf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> index 32c7225a831e..127ecf896fc9 100644
> --- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> @@ -333,7 +333,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>   	struct net_device *pmondev;
>   	int status = _FAIL;
>   
> -	padapter = (struct adapter *)vzalloc(sizeof(*padapter));
> +	padapter = vzalloc(sizeof(*padapter));
>   	if (padapter == NULL)
>   		goto exit;
>   	padapter->dvobj = dvobj;
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
