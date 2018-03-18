Return-Path: <kernel-hardening-return-12690-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtIHK2yOjFmKQFDQaLPRFyCIu2xUi4PUNF4ZAZylfiRbIijPQpS7WgpkY261U7tvZPm7bXf
ARC-Seal: i=1; a=rsa-sha256; t=1521382119; cv=none;
        d=google.com; s=arc-20160816;
        b=AOC79yaA9ylHRNpHKcAzGg+1FKyLCG5BkYXxgsm1myF3dBbXxkCUrdao4O1g15vw2g
         lP8VRht0XwBHWf36fG+r0bIKv31gfis24S3v4BkE6ljY2Co15HnZw2p1EdNhmqt5fnqy
         hXXtK3/hZEZ3We+oDgAnMMgNWRirMPIHB46vnUpxVOOOmmTrjioIAr37EK9VOM+xYtUJ
         0sL+DNM+lsAUtxXmPSdMk+0W1Ws+Xj37X+ReyTp//LwXSIurrMKm6U3llOaDOjXKlKuT
         RtWer5wCRzLtrAAg3u8E8ty16qlpA5DR8j7ewBEQDdWw4zzBCbode2v5QKF2PQCNFP7D
         pZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=UAcAt7U3r9IlOFi9ehLlv1CYiYxT59PoEfu+SP242MQ=;
        b=H6hCusckQQK6IaHFT8ixz7jisquSFYcNP53Kg3hxWvADz5dUyO5aq6UN/dHzgnzzu3
         8ZnlT6HdiLc9tAyIXOLr0zqkcMT9V26ffC3uM5jIUDtXC4lCDX4fpBawtIV/thmBpf+p
         Wo5tVWzCv6OKtWgZfNkahZ6SRC5XztSRFd+MvDkMURumkeGI3t8p2Dj4NYKapmdlpUb/
         wuyN42OUHwcQADkNT8SV71PnOKZce4J4cyN+KbUwkq5PRvMxfutDOaViGVJbWRmKjpd5
         3p20rhrL633OTsIvKShLwd/l8PkzuBbDvGTHEym9woUEEwnm61SqRLlXuFhin0/E6H0Z
         Kqtg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nf198fZl;
       spf=pass (google.com: domain of kernel-hardening-return-12690-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12690-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nf198fZl;
       spf=pass (google.com: domain of kernel-hardening-return-12690-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12690-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAJHCu1LB1wPErEB0xNd_9=_8dmOn=VFXmzu=-U5Eg3zTeT4b6g@mail.gmail.com>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
 <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <CAJHCu1JCCkkoL92tL+Zpx6te1A=-B1dNbAFu4sFEHiHa4vB6BQ@mail.gmail.com>
 <9843d23677af411aa75a5fb24df3c97b@AcuMS.aculab.com> <CAJHCu1LB1wPErEB0xNd_9=_8dmOn=VFXmzu=-U5Eg3zTeT4b6g@mail.gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sun, 18 Mar 2018 15:08:01 +0100
Message-ID: <CAJHCu1LmixGLhpsp39yxcU=XEzWARZyYjYPAz5R=sG2YK=QHMg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595284777775384819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-14 13:48 GMT+01:00 Salvatore Mesoraca <s.mesoraca16@gmail.com>:
> 2018-03-14 12:24 GMT+01:00 David Laight <David.Laight@aculab.com>:
>> Isn't using DECLARE_BITMAP() completely OTT when the maximum size is less
>> than the number of bits in a word?
>
> It allocates ceiling(size/8) "unsigned long"s, so yes.

Actually I meant ceiling(size/8/sizeof(unsigned long))
I'm sorry for the typo.

Salvatore
