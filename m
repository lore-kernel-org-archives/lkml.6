Return-Path: <kernel-hardening-return-12589-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv6bix8g+ARKAORC5ChcEZlAbC5xnQzOMsJfo25rJG4vGRDRxmoPmwsVbV+yWyKJFraLnLB
ARC-Seal: i=1; a=rsa-sha256; t=1521031729; cv=none;
        d=google.com; s=arc-20160816;
        b=uPhOCyIkwyG+uECDLpq51jaCQ9UVavQujzjfJj9VelYOh7ZJVZeHzUAxKLfDipy+sa
         sOw8eCo21DAcNoiAXQbSZyQ4moQa9cKTHZ5833T0U+2jFwAenTccPNzfXzKv1fae6/Nb
         crhAsAdFRJDMbak/QbyJr83NCwn3NvcRO6v2987JvfQh1PX6vGwsRlpcOkaAU4IVocmo
         M+FanNjSKM99w9h3Ip+1/sqHWEBybrW6uRq5g87vHaYlhqJ7LlaIXQs1l4MVCGdHe9EO
         iEZAq0GwbXDbRSkbJnWAIk3iaIDz9BaRWxpJ4s1CyohGL0u3yuY7lZkRNUpBmE4vKKqs
         gQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=1lc7xweNiYIMiwzVHfRJT8uiDXyeuQK54B+aS1wbUfs=;
        b=sxTJi0YWtlmpMlOZOdqqkhz/NlzIR20U0zWqGuLHLXwJM4nED9Dx3fVWgC5sRj3nix
         HuYRmmOMmoVMbF9HZnv//edzDsBlRwBj9yD/+vZicPkFpu16fFiI8xbms18GRuvdotKL
         eAm1vblrgvg1HQPQvJBXI+ucVuM+KEb/qwKt5r2eYgWje8MnURQ61/oYOPbFqpwbdytb
         VNVSTwiLizQV2AdlU5azLfQIeqZl5gCDgFb7Va106MLr6nVriyswPD/5cjQyb1egmy7s
         Jx+0o+JXSyX5aARn9m+/i2F0f0G/CaBFzCfqoFsTIot7e5RlWO+Kxj0iFVZTteALEdTu
         SNzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qfsa3x6g;
       spf=pass (google.com: domain of kernel-hardening-return-12589-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12589-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qfsa3x6g;
       spf=pass (google.com: domain of kernel-hardening-return-12589-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12589-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <9843d23677af411aa75a5fb24df3c97b@AcuMS.aculab.com>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
 <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <CAJHCu1JCCkkoL92tL+Zpx6te1A=-B1dNbAFu4sFEHiHa4vB6BQ@mail.gmail.com> <9843d23677af411aa75a5fb24df3c97b@AcuMS.aculab.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Wed, 14 Mar 2018 13:48:10 +0100
Message-ID: <CAJHCu1LB1wPErEB0xNd_9=_8dmOn=VFXmzu=-U5Eg3zTeT4b6g@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: drop some VLAs in switch.c
To: David Laight <David.Laight@aculab.com>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1594917367444844067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-14 12:24 GMT+01:00 David Laight <David.Laight@aculab.com>:
> Isn't using DECLARE_BITMAP() completely OTT when the maximum size is less
> than the number of bits in a word?

It allocates ceiling(size/8) "unsigned long"s, so yes.
