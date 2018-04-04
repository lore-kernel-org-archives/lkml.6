Return-Path: <kernel-hardening-return-12850-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48ptoDe1Cr0hHfCQv5F+ZHWSr7Z97mDXt9ndK/lbJLKgTLS8bjv8GTl7+W5koPgHctFkQEU
ARC-Seal: i=1; a=rsa-sha256; t=1522859006; cv=none;
        d=google.com; s=arc-20160816;
        b=KncyySBo4iAdeaQ2NHBip1cYLY3d821Wu+1JbG3llEARxZ1ug8rWtjvYPumNskdnHJ
         ZtYKNCH6DRXav7fyoPujLAEgJNgXbEouBoR9s0FbvZ3g5D9JNJ4xDIFRCPJbNsxXhT7c
         +j9NRGNkJrbXFFNizV/jp/ziGbeF2JciFEUz/0WguqFNWJ1fp9IiB1S4TyPSa2jA+8GB
         XeVd8DSClvMGruBrCB3I9cCRvKDIO2BpcJGoapgo8hsJ3jTd3yMwK0iP+mzRDC5ItOID
         DSenc5jGhfA90931UXB9rYdo00W1AcpRpQ4WTCs8LIVxXEa+aKV4apfjBirlwXWsQhAT
         3Z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=wlroLL/fqWK8+Ekh9flI9l7/6+E2C7bhejN0Rp4ZKos=;
        b=Cfh9S5ib1voGNuPHzNfdAfZU+eE+z2boBeJ1wMeHgaPM/s/ll9xdclqmHpKjsK5PfH
         byQG18fn1sO1SI+RxatZVPTa8IU8A7ft5RNhAhiylGKDJ8FmfabthyCkxLlrq8Z7OyXv
         HhmFsr42/4fTk+WEdepLYopXu3hF/p4GS7ZaAtJBQuksj0FjPAJsaG4IPn65b4NnhVt8
         ZPFus3QqouGC7id73nPxFN0gRfo7BOSO6uYzhHSDe9caLuOLicI15TXsgueOrL7T2gPO
         CoHDg6s8mVyqcSyUI3QLjl5WLMsEyh2WW+4d7vxLA/JclIDWw36RzLS6zeodq5uDsnsW
         Oi9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gU0mtnWW;
       dkim=pass header.i=@chromium.org header.s=google header.b=D3NENXbQ;
       spf=pass (google.com: domain of kernel-hardening-return-12850-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12850-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gU0mtnWW;
       dkim=pass header.i=@chromium.org header.s=google header.b=D3NENXbQ;
       spf=pass (google.com: domain of kernel-hardening-return-12850-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12850-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAPDyKFobX6U4_st0nE7-yHt1SPFu4diLhzTaswY6Xt3BrruvAA@mail.gmail.com>
References: <1522045994-21913-1-git-send-email-me@tobin.cc> <CAPDyKFobX6U4_st0nE7-yHt1SPFu4diLhzTaswY6Xt3BrruvAA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 4 Apr 2018 09:23:05 -0700
X-Google-Sender-Auth: oSuTxUddjutnIdIBxwsCwxaOYTI
Message-ID: <CAGXu5jJgt+sUtTPpqiFVx19mNXs-asjTUQJABrLBf_g8q=FQAA@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq: Use kmalloc_array instead of stack VLA
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595980934577926333?=
X-GMAIL-MSGID: =?utf-8?q?1596833405688947940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 5:45 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 26 March 2018 at 08:33, Tobin C. Harding <me@tobin.cc> wrote:
>> The use of stack Variable Length Arrays needs to be avoided, as they
>> can be a vector for stack exhaustion, which can be both a runtime bug
>> (kernel Oops) or a security flaw (overwriting memory beyond the
>> stack). Also, in general, as code evolves it is easy to lose track of
>> how big a VLA can get. Thus, we can end up having runtime failures
>> that are hard to debug. As part of the directive[1] to remove all VLAs
>> from the kernel, and build with -Wvla.
>>
>> Currently driver is using a VLA declared using the number of descriptors.  This
>> array is used to store integer values and is later used as an argument to
>> `gpiod_set_array_value_cansleep()` This can be avoided by using
>> `kmalloc_array()` to allocate memory for the array of integer values.  Memory is
>> free'd before return from function.
>>
>> From the code it appears that it is safe to sleep so we can use GFP_KERNEL
>> (based _cansleep() suffix of function `gpiod_set_array_value_cansleep()`.
>>
>> It can be expected that this patch will result in a small increase in overhead
>> due to the use of `kmalloc_array()`
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Tobin C. Harding <me@tobin.cc>
>
> Thanks, queued for 3.18!

Time travel! ;)

-Kees

-- 
Kees Cook
Pixel Security
