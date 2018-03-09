Return-Path: <kernel-hardening-return-12333-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvasRzYsckX9x8wlJ9holRIJJ9FDkzwsdeKWNHWJlcgKiiThi1764U/OUeK/YAey+ZylqFc
ARC-Seal: i=1; a=rsa-sha256; t=1520620544; cv=none;
        d=google.com; s=arc-20160816;
        b=UgolOmPWMsFUTlvTZMzjWQKOrn8fiGfAQ9MrZ28pho/RRiCqYuf64VmHfSEIZBeFet
         pbhWB5aMiYiEJTJoB0pHqoPy1TaAMGCsowxu0pnU9zvHfMcgTSUDhB1q+86K0He6YweX
         4E3W68JCGit/cGRO6TvwEoaXKEsJIJIMERkam7KxVsO2e5Nwnrg73kHfetyKVk1ojTMj
         wJ9KuYI9hJYSLRw8VlnmBmrVwN2pbvCeofrqXt9xOEnNHuY7cisJIcY6JLX59U03oYKa
         O6v8tFlY/8fm04oSyCEdE38RY2RRK1Lg5qXEEwOh1Uz5w4GrrSKNMWv7vOBn8QgaF+DR
         LJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=TJYptfOi8JHJ7X138K8Wne+qru6T+F2n+mk5ipsal00=;
        b=yojCRy0JzoPS7JrwenqwMeF1bRefapHWuh6wDogTB3swMTEg560Ow7qwBsCfneMbLx
         XOXQDjp6pkQPuikH6OIzJJRH0hFWNUPddzjIWuLvi5WDvmNAiEXrslWfyBH189Fe/u3q
         UIujtF7ZYCF9DDCnsKZuUZBQrHVcdWamkKwg8spZ266ilHOAPpy91uAV6L50IJJ4v5Id
         pVRVsj14yWXeyfNzpVxpj6M49YhwQ9wMrL2nTysHpFxKhaR3dHz6VPRhnBcLyPjdOOhd
         dXRpo5/EGRtPP0mT/u+xDe4Qpn6NXCIs4tu6pHkFaSdtNqi2qny//PfEZGG2SjNLgek2
         ky1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=sUCjQW9W;
       spf=pass (google.com: domain of kernel-hardening-return-12333-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12333-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=sUCjQW9W;
       spf=pass (google.com: domain of kernel-hardening-return-12333-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12333-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] net: ipv6: xfrm6_state: remove VLA usage
To: Andreas Christoforou <andreaschristofo@gmail.com>, keescook@chromium.org
Cc: kernel-hardening@lists.openwall.com,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1520598106-3271-1-git-send-email-andreaschristofo@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <168b5c29-b037-cf5d-1383-4dfffab44e55@cogentembedded.com>
Date: Fri, 9 Mar 2018 21:35:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1520598106-3271-1-git-send-email-andreaschristofo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463771060382720?=
X-GMAIL-MSGID: =?utf-8?q?1594486207698059766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 03/09/2018 03:21 PM, Andreas Christoforou wrote:

> The kernel would like to have all stack VLA usage removed[1].
> 
> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
> ---
>  net/ipv6/xfrm6_state.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
> index b15075a..45c0d98 100644
> --- a/net/ipv6/xfrm6_state.c
> +++ b/net/ipv6/xfrm6_state.c
> @@ -62,7 +62,12 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
>  {
>  	int i;
>  	int class[XFRM_MAX_DEPTH];
> -	int count[maxclass];
> +	int *count;
> +
> +	count = kcalloc(maxclass + 1, sizeof(*count), GFP_KERNEL);
> +

  Empty line not needed here.

> +	if (!count)
> +		return -ENOMEM;
>  
>  	memset(count, 0, sizeof(count));
>  
[...]

MBR, Sergei
