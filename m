Return-Path: <kernel-hardening-return-12567-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuUJ8AVrPDC4hc3Bybp0rBZ5sWNzvwjRePLhU0NWyLkeormp7ekNH/hfzwjBYwrgPIywR0H
ARC-Seal: i=1; a=rsa-sha256; t=1520990347; cv=none;
        d=google.com; s=arc-20160816;
        b=sFtmGV6A6fWRhZIDPggkfPAIGVgzuZkFIWkxjSGK0q1IRZ6wrd3vT/CbFcvFjFZkes
         qFOhtq7ukikBFiHWYqqBL7nWbc83h8GUM0WdYbHYkpnYylrpHilgL/ab/rHiWPjmF7T3
         3a/QEP5g3JXwFdXwZWi7VrhiQmumROMkYCzTHzFjUX282A4w8IJQIgJFNdmASn07ksPr
         AiDnnT48Pv8cty9EVGhX8chhFv7+qFbGSRELlrxge9/b+GzZ8wI6wpJD+Yq74D+LNB7o
         QD7IpJ2QRu547Lfpi8F2KYamcmFr9tlGuftu8FANTLhnMATvBLCIyPuAKhCoiztJVY1S
         jnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=JRkuCtiO2q99zk6TMZ1olV8cgEf7p4M6E1DtDTFheuo=;
        b=EsHYkZaGsQTNFRj5NXMoZQCqg/zLw0To3jVkodNNFcKIlu6ORL/j+amEtSkjj0F0cG
         7CmnN2xS3B5vjyVds1kzeffxgnF3KzdEH0lzisHHT+QBW8fyTWOI2rSYV47EbwW9/t9U
         XpnV70nFbXj6+SB0flzzariJSJrylPh9yF4k77MaBaEMUecJSBA9aIaDIY9nJqZlfefo
         JN/h6tb48P5idG9veerpVCj/vWoTSeaHZ/z30M5Q6tyfCLT0ac9DXgbaEfXG6ERriaXE
         3zq5S++UecTSQCqQLQrNMOSJImXJrQB8bkgIcwgRevuP4am6GmYl/WYo75hsoA7HI4FU
         /NYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pZVLaGtv;
       spf=pass (google.com: domain of kernel-hardening-return-12567-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12567-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pZVLaGtv;
       spf=pass (google.com: domain of kernel-hardening-return-12567-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12567-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <423b529d48c54eba9f7ed51922814d46@AcuMS.aculab.com>
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
 <5AA464DE.90100@broadcom.com> <CA+DvKQ+hbMoWJdOuQB5n+eVF4ePf=kVuRiMbdtTUZ8ars4Pz4A@mail.gmail.com>
 <423b529d48c54eba9f7ed51922814d46@AcuMS.aculab.com>
From: Daniel Micay <danielmicay@gmail.com>
Date: Tue, 13 Mar 2018 21:18:45 -0400
Message-ID: <CA+DvKQK9jRe5YOk_K4DzBYkh2VUys56XbaYZRGs0fn2WJNT+nQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
To: David Laight <David.Laight@aculab.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Andreas Christoforou <andreaschristofo@gmail.com>, Kees Cook <keescook@chromium.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>, Kalle Valo <kvalo@codeaurora.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594873974699814506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No, it's undefined behavior to write to a const variable. The `static`
and `const` on the variable both change the code generation in the
real world as permitted / encouraged by the standard. It's placed in
read-only memory. Trying to write to it will break. It's not
"implemented defined" to write to it, it's "undefined behavior" i.e.
it's considered incorrect. There a clear distinction between those in
the standard.

You're confusing having a real `const` for a variable with having it
applied to a pointer. It's well-defined to cast away const from a
pointer and write to what it points at if it's not actually const. If
it is const, that's broken.

There's nothing implementation defined about either case.

The C standard could have considered `static const` variables to work
as constant expressions just like the C++ standard. They borrowed it
from there but made it less useful than const in what became the C++
standard. They also used stricter rules for the permitted implicit
conversions of const pointers which made those much less usable, i.e.
converting `int **` to `const int *const *` wasn't permitted like C++.
I don't think the difference between C and C++ const pointer
conversions, it's a quirk of them being standardized on different
timelines and ending up with different versions of the same thing. On
the other hand, they might have left out having ever so slightly more
useful constant expressions on purpose since people can use #define.
