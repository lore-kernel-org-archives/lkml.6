Return-Path: <kernel-hardening-return-12380-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs94CCEbouecwheykyuDB7y7A/hwGa8/+FDL+3pHqHXycG0fG5CBv289yJqxFvBddDQNYhC
ARC-Seal: i=1; a=rsa-sha256; t=1520702346; cv=none;
        d=google.com; s=arc-20160816;
        b=e6561OijIG35201bhb+A6WjjCyUKrPBkvIqbn0H37Su65IcnzmTIuRGiSsGUmv5KQv
         vSAUCMnLxTQnvBsvQnvYJa9GRzXIMEmjKSIz7smz8K37TI/47isgts4uISNQdyMiIquX
         P/80x8lZSmltg0EC5bLrhcbKOwJrvWvIsay5Cq3hRe5zE4N8OkNKPPTMvlbE9ZAJ76+E
         RJ2mQXXJcVML+pd8XsTKJYJnINirmT4NARxGMdfKTYEm1lGVrEyvzSHQabcZf+mvpzcc
         ACJkP/woHAtb9Qwgh9AeHntpGDX8pMLvO0IvCLAK1iJF4nDMeDwdwfiA85ulvIA/FJ/7
         z30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=4cD7a8GCFy3B9FQkjRZ7AJxdhdvGTFjnuinOGu7I/rg=;
        b=co3RdH7VYso9qWkLMfQJukhCZXO2eo1HJTCn5MW6tCNwAv0LOFTmzLcs/wDjm5KGeF
         TAJ/BN2GRKDy7H5UPOEo+PkK9o/ERWvv6eMOBEA+nTWXhgxS7T1YZgeWOY2ecoMmc6U8
         cRS/XDLAhSrsJJ0I2rOy21x/hUTsrRnRnNibKwYIkGj/0H3woRTtnD75pxLM17mQOY1C
         cM8gWtWqBvPfJZTdSbHkRsNr47h5xw2rHNUrTkcySjUFyopTbeoKTKYQ/CXy5OMpNctn
         yibirgvdRdWhKhKHJYXEt0yge7Bt4AtQ4S6cAC1rgOnZAmOk6b9lE3PBVDuRa+fSd+Li
         vEag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=The6MBoV;
       dkim=pass header.i=@chromium.org header.s=google header.b=DL2LBrtT;
       spf=pass (google.com: domain of kernel-hardening-return-12380-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12380-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=The6MBoV;
       dkim=pass header.i=@chromium.org header.s=google header.b=DL2LBrtT;
       spf=pass (google.com: domain of kernel-hardening-return-12380-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12380-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180310094327.685d181d@epycfail>
References: <1520667645-21975-1-git-send-email-andreaschristofo@gmail.com> <20180310094327.685d181d@epycfail>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 10 Mar 2018 09:18:46 -0800
X-Google-Sender-Auth: 3hQkUisQaAIU7UXL91yizFGtEzE
Message-ID: <CAGXu5jKwWRzK8EJOo2zraxi9ghQ7an5d4yr8ktGa+ijWX_aJZA@mail.gmail.com>
Subject: Re: [PATCH v2] net: ipv6: xfrm6_state: remove VLA usage
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594535997865166060?=
X-GMAIL-MSGID: =?utf-8?q?1594571984027356996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 12:43 AM, Stefano Brivio <sbrivio@redhat.com> wrote:
> On Sat, 10 Mar 2018 09:40:44 +0200
> Andreas Christoforou <andreaschristofo@gmail.com> wrote:
>
>> diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
>> index b15075a..270a53a 100644
>> --- a/net/ipv6/xfrm6_state.c
>> +++ b/net/ipv6/xfrm6_state.c
>> @@ -62,7 +62,7 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
>>  {
>>       int i;
>>       int class[XFRM_MAX_DEPTH];
>> -     int count[maxclass];
>> +     int count[XFRM_MAX_DEPTH];
>>
>>       memset(count, 0, sizeof(count));
>
> Can you perhaps initialize 'count' instead of calling memset(), now?

Do you mean:

int count[XFRM_MAX_DEPTH] = { };

instead of the memset()?

I thought the compiler would resolve these both to the same thing? The
former looks better though! :)

-Kees

-- 
Kees Cook
Pixel Security
