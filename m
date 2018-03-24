Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-602481-1521926681-2-8405171158637491140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, URIBL_BLACK 1.7, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521926679; b=b4KCj7kkzkadA6CyO0dHM4Zdc5KMaUJ4qSHZHR02aO7gSy8
    raRQiy3rTn4SYb72Av4rbw/5R6cbMuQp2kvjdJp6CUZwmpcNL+p2LE6AKgT2CzXQ
    z9HFuQFCcQo30XD5ZKgbaHs9nMWhljWY5vQbQHXLa7ge+Fngz4xZLPTnIGDgu/EL
    qLBx+HCIjsWU3sBaEpkT9v1W61Lli2DGLx+gjNmK95/cW9Og74zGH2nVa+ZhpfeU
    n7FoAENlCwwnWfGLhAVqVLrniMP5+bhTSPrrY5d6nMCa8DibfJbEFmGbDTDz/2MP
    enKNZHK/aGYjUZkS3IGwRE0IwkGIXBKecSRbzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1521926679; bh=pxG1Rkdy7NfkjPg03vmnS7xMQXHnaX36SiddAzI8aJo=; b=n
    Yho/tjJLft2SC5iUih2PP5aclbEH0Fe+zeRPGCaiWsEkCrSBvWKRwuU7QyjkcAd+
    EriR2DX40NHPu2pT7w42EjfaQ9cDOX5obgq0fcH67ucMvJiVnaOlFFfhdEAgCyyc
    /mVfDU5Zptnz5ct8/EnWQ45GnenHmk8ui8ImysRynIMEdBASGzrYmImdBh3rgI1f
    hwvT1psGws57Gh60meYXcspQoZ4SG6pbUoALabRAG+iglghpn9I64Owp6l/bAuoI
    50i13qPz1Yv+R2q8Iu4lddZsEZdoBEen6ZOlclhrfB6gR9GYsniz1NQcXktlRLJa
    T7KDDgtkuIiSmEzJWSxEg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eSbMc/Bj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwfinger.net;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rE8ThZFV;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lwfinger.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eSbMc/Bj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lwfinger.net;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rE8ThZFV;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lwfinger.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsXIJ7OMVxijKv0Q3wKG7291SMegduSc8G6ctejEcjN1Ijp3pIpk7zaG2LREy/K1wGuZbhHiw==
Subject: Re: [PATCH][next][V2] staging: r8822be: fix typos in header guard
 macros
To: Colin King <colin.king@canonical.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ping-Ke Shih <pkshih@realtek.com>, devel@driverdev.osuosl.org
References: <20180323180018.21737-1-colin.king@canonical.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <d6247593-edd2-c6c4-64d5-c0a7d6879d6d@lwfinger.net>
Date: Sat, 24 Mar 2018 16:24:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323180018.21737-1-colin.king@canonical.com>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 01:00 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The macros for __PHYDMKFREE_H__ and __PHYDM_FEATURES_H__ contain
> typos and don't match the #if guard check. Defined them correctly.
> 
> Cleans up clang warnings:
> warning: '__PHYDMKFREE_H__' is used as a header guard here, followed
> by #define of a different macro [-Wheader-guard]
> warning: '__PHYDM_FEATURES_H__' is used as a header guard here, followed
> by #define of a different macro [-Wheader-guard]
> 
> Fixes: 9ce99b04b5b8 ("staging: r8822be: Add phydm mini driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

> ---
>   drivers/staging/rtlwifi/phydm/phydm_features.h | 2 +-
>   drivers/staging/rtlwifi/phydm/phydm_kfree.h    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtlwifi/phydm/phydm_features.h b/drivers/staging/rtlwifi/phydm/phydm_features.h
> index 37f6f0cd7235..a12361c6a1a0 100644
> --- a/drivers/staging/rtlwifi/phydm/phydm_features.h
> +++ b/drivers/staging/rtlwifi/phydm/phydm_features.h
> @@ -24,7 +24,7 @@
>    *****************************************************************************/
>   
>   #ifndef __PHYDM_FEATURES_H__
> -#define __PHYDM_FEATURES
> +#define __PHYDM_FEATURES_H__
>   
>   /*phydm debyg report & tools*/
>   
> diff --git a/drivers/staging/rtlwifi/phydm/phydm_kfree.h b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> index 1ee60059afc1..2c6b0a48e76e 100644
> --- a/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> +++ b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> @@ -24,7 +24,7 @@
>    *****************************************************************************/
>   
>   #ifndef __PHYDMKFREE_H__
> -#define __PHYDKFREE_H__
> +#define __PHYDKKFREE_H__
>   
>   #define KFREE_VERSION "1.0"
>   
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
