Return-Path: <paweldembicki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522316866; cv=none;
        d=google.com; s=arc-20160816;
        b=lBOHFFfWY8me9RLXP6Dw/c0AKOSeZKkkndm8rk8fscb1sigKEdTZuLxdz6dFaJok/Z
         HiOm6LTtRZo91RRsiBqNoCJTAeqH3ath9GKCSjLjITU5sQqUcmazqHe9kML1Fl4Ax2wU
         U5WYXOFLiqq+EBEk+34/FrllOJbKCoy1/X1DVBVyVXXY4UZUh2FJwZXyoayvnazF2bFZ
         1HnpEx77JrhF+XP2p3Kn5g9qE2gR/mCoyQGwJlBc8vQCyBNhrtQ6bioq+ztMtS2/R9eN
         Gflw8s6+CIhjLP4TfzftvazlUVXNfURJWZAKOfrzBirTfS/fjZkqwoG73Xg3DfHY5zvn
         ILEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=+yqz8QqLwlf7EPZRWl9CglqpFRLhrX/y2sY/K0dl+KE=;
        b=xXrA+jEQ/mV+/LS2eBNTyuj0tTDIJWCqtrmgNFGmIcYWz8b2UIFDenbymuGfTonM8P
         0HLJMaq5NFH4A45p+ITQiJfm+I6fwKln50T2ysgb/Y4hxj5Jgp1v4ODdMZ4rAk8RlFzL
         kHFD4e1m2L5fQiwUXUq1Ny5ikbVS1b5YgLZio4dxZk6CXau033nf7LfgOxr4mG9YpJH0
         gDmYe1JkEm+1URIEjIPNzS8mvOyNb8X+F/roGYfQlPB9127jLd9NdUnwN61+vmr16H+B
         LDb1BBLAHGv9yM39juthyxZrqX3qqkLkNBGiTxPQldSOGylO226waX7hmOEzv5rsTjlt
         q2Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RM9TdUS0;
       spf=pass (google.com: domain of paweldembicki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=paweldembicki@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RM9TdUS0;
       spf=pass (google.com: domain of paweldembicki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=paweldembicki@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48rJvy2mNdrNQEncQbq+dQt5MW/YlULKQLfpr7x4KmKIF3K2wzxLbH82k9AEVKyyIO7SxFaPzImcemR252Fdms=
MIME-Version: 1.0
In-Reply-To: <20180317115556.GA17545@kroah.com>
References: <20180218170629.6045-1-paweldembicki@gmail.com>
 <20180218171927.6414-1-paweldembicki@gmail.com> <20180314135902.GA21622@kroah.com>
 <CAJN1Kkzsys9XAJcDS2-CvE5+Z+z=kkvi6YN96G+kufqh9xakag@mail.gmail.com> <20180317115556.GA17545@kroah.com>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Thu, 29 Mar 2018 11:47:25 +0200
Message-ID: <CAJN1KkyrJLBVtzjnE69v-NNed3rjrXt+o46ALnN+wurHzecPTw@mail.gmail.com>
Subject: Re: [PATCH] w1: gpio: fix problem with platfom data in w1-gpio
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>, "Andrew F. Davis" <afd@ti.com>,
	Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592760094452875892?=
X-GMAIL-MSGID: =?utf-8?q?1596264930953044820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-17 12:55 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

> Where is this patch supposed to go?  Is this a stable backport patch, or
> something to go into Linus's tree?

I tested it in 4.9 and 4.14 kernels in OpenERT. So it is a stable
backport patch.

In current release this bug is fixed because w1-gpio use gpiod.

>
> totally confused,
>

Sorry. This was my first patch.

> greg k-h

-- 
Pawel Dembicki
