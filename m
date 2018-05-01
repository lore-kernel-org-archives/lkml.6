Return-Path: <drustafa@yandex.ru>
X-Google-Smtp-Source: AB8JxZoXOCqx/7jpOtBoheilECPmmEuv5eanZZa/x3Vqkpa5M6DUIU18/tLfLmwVM0kTUjRtijL0
ARC-Seal: i=1; a=rsa-sha256; t=1525200878; cv=none;
        d=google.com; s=arc-20160816;
        b=qDhjySEls+gUU9wArKeSVE4QCIqPMdXi9T6K66scPSmT9C4Chz6pd2BGcXOXFdji2j
         +eF8lSwUvbvXh/ckQwi56daW18YfC1hjmca9SeRt1BTHcXMgrOFSPx7/qnswjCacKLN/
         3ZI5m/9nuwcWOaY0fJPd6WmrGFimCNIT8oOnrbQw8NFDYoxsOJwtenYlhvcjZZKBXLlk
         mD+l8YRvnuEWfsVbI+naJOiTji/RQS2t0vSIaT/No7uB1SgLGQ1QaxZ2FPmG+UVMJi/N
         3pcOtLkPzs+erhWWXPykLpe4wrs5A8cvvj53WNXhydyABbKorpc5DHG63isqAnmosdSI
         vt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:date:message-id:mime-version:subject
         :references:in-reply-to:to:envelope-from:from:dkim-signature
         :arc-authentication-results;
        bh=lGW3PBZ570U27NIyjKAbSvApHzK9pGw1SbyMoSWCfFc=;
        b=PSVx0eQ0iDTSHloXaO6n4mJxy9zmzw85OllfdZR/LlblVs0a4scIV9SiHrQCX4rAjv
         g922C6ajOmp4P2jJxZ+HCgfKjJRACTOhy1YIRe9acW7S+NL0zli0v9VeAQSjVHwA3J9h
         dYJ1NK6bONKqSospg22FZ+HLVswEk9F71J/lyNuo6BVWIPLywzuOgcKr5DWZ34EluqmB
         okZjNY2vOfdQDjBSaPOqrNrhj0MBIIM74If6FI4K5sQXqgUMBpcG3i8vHUQSLTsP8s+c
         Kae38th68LG8BLj1w8Y5lWNuoCs2ZEG/NuWh0IyOsiSEWx7qpZ8JZfCnCExqR0sAL4DS
         kZWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yandex.ru header.s=mail header.b=FV1BaFQX;
       spf=pass (google.com: domain of drustafa@yandex.ru designates 37.9.109.248 as permitted sender) smtp.mailfrom=drustafa@yandex.ru
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yandex.ru header.s=mail header.b=FV1BaFQX;
       spf=pass (google.com: domain of drustafa@yandex.ru designates 37.9.109.248 as permitted sender) smtp.mailfrom=drustafa@yandex.ru
Authentication-Results: mxback5o.mail.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To: Ingo Flaschberger <ingo.flaschberger@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
In-Reply-To: <629ce39b-e3ad-1a4a-be11-7eb3da064ce6@gmail.com>
References: <629ce39b-e3ad-1a4a-be11-7eb3da064ce6@gmail.com>
Subject: Re: [PATCH] 1wire: family module autoload fails because of upper/lower case mismatch.
MIME-Version: 1.0
Message-Id: <5841141525200877@web25j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 01 May 2018 21:54:37 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599271166540841953?=
X-GMAIL-MSGID: =?utf-8?q?1599289036828022969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ingo

Sorry for late reply and because of forcing you to resend the patch, your changes are correct

01.05.2018, 17:10, "Ingo Flaschberger" <ingo.flaschberger@gmail.com>:
> 1wire family module autoload fails because of upper/lower
>   case mismatch.
>
> Signed-off-by: Ingo Flaschberger <ingo.flaschberger@gmail.com>

Greg, please pull this patch into your tree.
Should it be stable material?

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

> ---
>   drivers/w1/w1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index ab0931e..aa458f2 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -741,7 +741,7 @@ int w1_attach_slave_device(struct w1_master *dev,
> struct w1_reg_num *rn)
>
>          /* slave modules need to be loaded in a context with unlocked
> mutex */
>          mutex_unlock(&dev->mutex);
> -       request_module("w1-family-0x%02x", rn->family);
> +       request_module("w1-family-0x%02X", rn->family);
>          mutex_lock(&dev->mutex);
>
>          spin_lock(&w1_flock);
> --
> 2.7.4
