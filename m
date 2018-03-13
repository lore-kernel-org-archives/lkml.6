Return-Path: <kernel-hardening-return-12562-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtdHU+4+iMijMk8NA1UaRJJDxEG5fBVeUPig5OUcyqmdTQ+moJwblDQJmD4BpBOqqKFVVaz
ARC-Seal: i=1; a=rsa-sha256; t=1520978504; cv=none;
        d=google.com; s=arc-20160816;
        b=P+GEbwMcMZeE1tTWo5imEw/zir3/L66Xw7f0upvhOvVgCU1I7kCrxdyoZtw1Iq0/Qj
         iR7Buc30oTj0OzvuyPx5T9KhFy4FSqJW83l2t44kgGk3yRrF1HG6znhchwKo7zR62AbF
         V7qxBGceLi0hAwtpVTqJRbODJkBYn/dEGPSfPCEYiNLYNd6BpcCXSilsH4RovxtbxNEA
         wBuaOb8FxdrqNN0K7jTWqjmOfR/hJHq/dnV/N1YgoN5ui7iqUQtRcp+PM5GO7O9gi3Gp
         Oodv+yNPD64K5dqPPmljATZ22xGQqRRmX/5DRB25f0YKvKajue8DTyoVauUx63Wl2S9w
         W6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=AFSbdhcE8Sfw3CtsxMnEziJ9HRWW8pTys6cp0oxdoPI=;
        b=YXHFppqUGCxbhHttxRTv5OenyUrso6nSR303W20tzzF5lh5YbKJxjoQyxSCxS2VRW5
         rMD9xyKtr5vCEyeOSw/PkjMxllw/gudbGSHPjyJmCs4naETKdmxVpexLtHOiHnC06sxx
         DkdHYJ7s0yJyQIxC5ennHJYJbtVMwmbxStUh3jWKI8uQF1sY2DXiF81xGkNqAvPWGlzY
         kmUufMzE+/E0ZjSSh2PRI7CcuD/l8/muoo0mDfyOqD2rE5wwW5L8JaHfk6D/erBm/26I
         +9fKJESCpj6ibNv4UpFF/y4c6Z6gnZ64evdDr1MVo/G+C4rO7Wnm3Hms8sNlLlTjyMyj
         3znw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YsylSi0P;
       spf=pass (google.com: domain of kernel-hardening-return-12562-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12562-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YsylSi0P;
       spf=pass (google.com: domain of kernel-hardening-return-12562-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12562-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com> <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Tue, 13 Mar 2018 23:01:05 +0100
Message-ID: <CAJHCu1JCCkkoL92tL+Zpx6te1A=-B1dNbAFu4sFEHiHa4vB6BQ@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: drop some VLAs in switch.c
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1594861556352485614?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-13 20:58 GMT+01:00 Vivien Didelot <vivien.didelot@savoirfairelinux.com>:
> Hi Salvatore,

Hi Vivien,

> Salvatore Mesoraca <s.mesoraca16@gmail.com> writes:
>
>> dsa_switch's num_ports is currently fixed to DSA_MAX_PORTS. So we avoid
>> 2 VLAs[1] by using DSA_MAX_PORTS instead of ds->num_ports.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>
> NAK.
>
> We are in the process to remove hardcoded limits such as DSA_MAX_PORTS
> and DSA_MAX_SWITCHES, so we have to stick with ds->num_ports.

I can rewrite the patch using kmalloc.
Although, if ds->num_ports will always be less than or equal to 12, it
should be better to
just use DSA_MAX_PORTS.

Thank you,

Salvatore
