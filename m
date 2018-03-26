Return-Path: <kernel-hardening-return-12730-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtjgTnwlaLjPGeYpoZl+XaJvJ/9DLHd+A4YkEDf4OFowogU81TLrTq1fPg3G4l/0IJVGvHA
ARC-Seal: i=1; a=rsa-sha256; t=1522055399; cv=none;
        d=google.com; s=arc-20160816;
        b=ldVjHBEdicap694W7IyFXclGE7EXxzoSAWuHfM1izEnBPNW0PUSfNBFXzeRENEBv29
         GT+h04/3hpYUdiGOEHoVzDcxIxZ3fhlqXowsoCTvY5kR8FvOuEt+RtQfHGrUrYgQLIL/
         Vv4fiBtkPVVdJQZmCw3Vi5csuMZvb7GxQz5a4C1BgMaoXyD5XWhA3e78OtAEZcl9dQ5S
         1TsW9YPbDVfNEQTq6gHxgd6Rf72iJ9/UGJp9DT8D/d35hzpzRmXMHcmJjMbYaFvoCpO0
         wqBUxYS9eKB01z6ypYubwJKGx732buyJpsfmh1Uxfvvm64RdCr6gqEYPV/TsUJImCFJF
         hmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=C2NlxjT3FPtQzWPnsOx4AnnRs/vhk2VrkYJQvEdB284=;
        b=kKdtCUAyNp1eGNFJEi7whlNrXsz/z9bxpCh3eSWeWeP9KA+bxQVX31WATzTzkOrm19
         pmoSnyaAFyBXFxk1WKVCDUVkbm6s+NBXOp6FzHGP6uIuAGEaxCrCSSgk9AB7UiSrvz6E
         tS5HcIp5+zvbPGv/sa+VkozbjHlF4URr5EEHOnmHzBYM2hTAYA5pvQM1erSI18XBtZYN
         hB/wh3PR2OurAdWH1doBf0tis36dGRorAT+WQz0d1LeaBIP7iFFnMNetUCuw46pvJerP
         /zaAPzJ1rjvUS6fLTOUQjfUDqj8XiLe275zXnYnF853TttCHhO+JUuo/SRsErn2HAYur
         9r/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hOcwL1O+;
       spf=pass (google.com: domain of kernel-hardening-return-12730-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12730-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hOcwL1O+;
       spf=pass (google.com: domain of kernel-hardening-return-12730-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12730-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180310001021.6437-4-labbott@redhat.com>
References: <20180310001021.6437-1-labbott@redhat.com> <20180310001021.6437-4-labbott@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 11:09:16 +0200
Message-ID: <CACRpkdbahPzpDpruGz3zrGvG-xskjp_YnVAadkqS1iPU=1NAXw@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: Remove VLA from xra1403 driver
To: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Nandor Han <nandor.han@ge.com>,
	Semi Malinen <semi.malinen@ge.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507318656304803?=
X-GMAIL-MSGID: =?utf-8?q?1595990762917397063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 1:10 AM, Laura Abbott <labbott@redhat.com> wrote:

> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621)
>
> This patch replaces a VLA with an appropriate call to kmalloc_array.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Patch applied with Nandor's review tag.

Yours,
Linus Walleij
