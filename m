Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2401537-1522379729-2-3216611486733458737
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522379727; b=MfxbmjPIzw3Kt9vMntfNDPIon5QRFrJ/aa/cnOGOekpf2lY6LB
    f8MhOD+wqPweuOnFm/a+6iefN/C4GYlYxAgSUGnDiMxOwt2s0ROh/3YLvT2x+YSb
    QlpNCxbvI77DvtGLkR5O2jTaWW/cprVuxXT1YPcBzp0p7HhGiRNZ3F5CYNwSXyRE
    AV5O9QZobkVGXTbqqKzM219kJnZwZECryIkYm16wXAts6cgyX4srA3h1/v+RWdbd
    O03j+mNl0swKScSAGtrCocdinHgP7JPJPGQK1f7x3mNkmlUUGWsGJEtdjhimNRS/
    rZYxCnRr6Ww7CmNixx0Cw2/1Us45t659t6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1522379727; bh=L7I8r25BQqnZrazBMEY7jNcaQiglNadA6FHtgZhN+0E=; b=D
    j3yCyZIOuaVyJC0S0TeNLHbvdqMYPx86p86S7YZuwz/X3AYzM/otkoNuER1usos8
    67vBsfOHGCGyiT0pvC0qkpUAVBN+16faU72esTmIn4UfemnVd7eCXaZV5Fm5xakX
    3KvY9n5k8B27rXAOCGx1jfSXWDzBlil8IYpe6mels0wph4kuQIIKQ9/M76HKxLvm
    7KSYZ00C8hMKdw+lRlggHuY3FCRyLENUY1xZzWc4XN7etkL1W8isnrMFXlbj7U0e
    Z86UtpHmcalwwKl3K2yhHrIP3E6J0OweUEwTEy9lzBBiQUpZOC98Zd8m+YFDIwYP
    3YR0CTj/ZLwDEw5znewVg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qTyTm2KM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Xpvpq2Kn;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qTyTm2KM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Xpvpq2Kn;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL/7N57fcEjjiC5mDiCtxuOt61uAjlj5A89X+U1YDJevkYf3Aiy4l9t9/EFOsHH3Ub0DPUe3aFAn5vZ8pD6yoNrPX08IGA+CfGMbt7CXKzI2ygKOj4AH
    jj3M8IFuCQrebhYmIzgUpxuYFUvWdSrPfQ9v41PnQGcEwE6ok6/TFXFySbvadQ3dC+snfRmyY7dczhYG3MYP/obUA4/YMoU6vVlKRyH3P2Iz4IGvcd14U2H5
    3HmFtJ2LPyv6d6DanD9k6A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=gYsqBrxumnXwPZ7PDP4A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48hiIMzTre4sI7upyC4kB36POCuLdVeHgPnIYiP83NoezOlV/PahRsLTr7Z2eE+CO8BmT36yg==
Subject: Re: [PATCH v3] staging: vt6655: check for memory allocation failures
To: Ji-Hun Kim <ji_hun.kim@samsung.com>, gregkh@linuxfoundation.org,
 forest@alittletooquiet.net
References: <CGME20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf@epcas2p2.samsung.com>
 <1522377844-23591-1-git-send-email-ji_hun.kim@samsung.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <be23acda-38c0-dce3-9c79-8672113f6960@gmail.com>
Date: Fri, 30 Mar 2018 11:15:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1522377844-23591-1-git-send-email-ji_hun.kim@samsung.com>
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



On 2018/3/30 10:44, Ji-Hun Kim wrote:
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
> +		goto error;
> +	ret = device_init_rd1_ring(priv);
> +	if (ret)
> +		goto error;
> +	ret = device_init_td0_ring(priv);
> +	if (ret)
> +		goto error;
> +	ret = device_init_td1_ring(priv);
> +	if (ret)
> +		goto error;
>   
>   	device_init_registers(priv);
>   
> @@ -1178,6 +1226,8 @@ static int vnt_start(struct ieee80211_hw *hw)
>   	ieee80211_wake_queues(hw);
>   
>   	return 0;
> +error:
> +	return ret;
>   }

This code will lead to memory leaks when device_init_rd1_ring() fails, 
because the memory allocated by device_init_rd0_ring() is not freed.

I think this one will be better:
     ret = device_init_rd0_ring(priv);
     if (ret)
         goto error_init_rd0_ring;
     ret = device_init_rd1_ring(priv);
     if (ret)
         goto error_init_rd1_ring;
     ret = device_init_td0_ring(priv);
     if (ret)
         goto error_init_td0_ring;
     ret = device_init_td1_ring(priv);
     if (ret)
         goto error_init_td1_ring;
     ......
error_init_td1_ring:
     device_free_td0_ring(priv);
error_init_td0_ring:
     device_free_rd1_ring(priv);
error_init_rd1_ring:
     device_free_rd0_ring(priv);
error_init_rd0_ring:
     return ret;


Best wishes,
Jia-Ju Bai
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
