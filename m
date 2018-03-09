Return-Path: <kernel-hardening-return-12319-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvE6JXF6B3YF6TLKj1WWYDAe2ugxZKQLdysUei0VsqjtdrUdUWWSor2nELKxzpPWJAqIKU0
ARC-Seal: i=1; a=rsa-sha256; t=1520600694; cv=none;
        d=google.com; s=arc-20160816;
        b=XJSZwyNhL4COEmMaSN64Gur2LLT4qJkeB6uSJDHT3DQ7Fx3VZB9m7zaO7nxsIQUTWa
         SRV/en7GxBJlk0PnaP8BGpsJBMlkBAox6adEj8RVhjO/nwMomPSA5Rg4J+Irxq2ncH0R
         16CvjbWlGjDwm1EgV1AJXFcW/Sl+gZwQZ6qsXEyQvnZP/9BvDnLb7egj+OZ7Wb6W/aZ3
         HOf6kZSt0HGfO+JtkVYxxNDrSF6cznFiaY5erJM40sZeLiPt7pzxI9GWGIzlGxvF6dus
         d5rwErMQ3LVv1blxoFvIA9wkhSkIJ2+M1EHntw0QnbGgqUVAN8boPeDmPTsdNhOY0+3l
         +jcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=a4H8hFkBSDXIMleZ6F2dXPP6m8tdIvi4CXDJtURAOVM=;
        b=hMoIuQ22f8m2VumabZfXDWAUAQs2sR4TiLx/f0M+aihO/AF2Z8HQ/0kgjJvV9THmTm
         c6hFMIkBE0WQE22NMWL8RKUu6oRdEBCpydDAdXvFRtdIk8jV1f1sOWxrnlr0XLLAmJpk
         mD4aafIjQxtCb0sUlmQFMZyJWk2lXwajnd+iFuH6zfov9vurM2XpzI5YdUooIZrl57QF
         qXoXDqQNlsWExdAiGYKoaK8ON2AM+IADismHOKFztunrDklemzQIgFodmfySBE14rbE0
         dxIBrLDMYgTvEZTwbvZJDpErRYw3/iE0T4mr8La7UuRm1D+SDPJ/N8OLT5+7bf8Ei3XL
         flCw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@googlemail.com header.s=20161025 header.b=mLFeQuFJ;
       spf=pass (google.com: domain of kernel-hardening-return-12319-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12319-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=googlemail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlemail.com header.s=20161025 header.b=mLFeQuFJ;
       spf=pass (google.com: domain of kernel-hardening-return-12319-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12319-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=googlemail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <1520598106-3271-1-git-send-email-andreaschristofo@gmail.com>
References: <1520598106-3271-1-git-send-email-andreaschristofo@gmail.com>
From: Mathias Krause <minipli@googlemail.com>
Date: Fri, 9 Mar 2018 13:49:07 +0100
Message-ID: <CA+rthh9g3gcgTt8jbcRrVUK=Lagnz8HWJJLERwSbMi++3VqS1A@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: xfrm6_state: remove VLA usage
To: Andreas Christoforou <andreaschristofo@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463771060382720?=
X-GMAIL-MSGID: =?utf-8?q?1594465393253258309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 9 March 2018 at 13:21, Andreas Christoforou
<andreaschristofo@gmail.com> wrote:
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
>         int i;
>         int class[XFRM_MAX_DEPTH];
> -       int count[maxclass];
> +       int *count;
> +
> +       count = kcalloc(maxclass + 1, sizeof(*count), GFP_KERNEL);
> +
> +       if (!count)
> +               return -ENOMEM;
>
>         memset(count, 0, sizeof(count));
>
> @@ -80,6 +85,7 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
>                 src[i] = NULL;
>         }
>
> +       kfree(count);
>         return 0;
>  }

Instead of dynamically allocating and freeing memory here, shouldn't
we just get rid of the maxclass parameter and use XFRM_MAX_DEPTH as
size for the count[] array, too?

Cheers,
Mathias
