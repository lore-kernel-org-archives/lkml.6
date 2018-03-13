Return-Path: <kernel-hardening-return-12577-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt33ep5dFLr0gFOvhwCQbBm9peLN94fjDc/B7P5eMLI12bfAGQIn3gkFdt+JyqLCNs+kium
ARC-Seal: i=1; a=rsa-sha256; t=1521022535; cv=none;
        d=google.com; s=arc-20160816;
        b=zhTtztY9Iz4CXuTREDmw3uPPcrNRpwOpXKtwoAuU3gsj03Y3CMPbMTLfiTvKV+0xKb
         zspvf/AZfZPoRX1YV+BfvZRBm8j4g2KGrLR9rgwom4yuLNE33pUMbP2rg1I/KAqnRIh9
         cqA4KrfK4dAcW/aovy4dHMaC7ANCttT6DXmaR+hpVkdg9Mn/Y5v7bDdy1T1iIjOdY1Ac
         reKrTG/h+/AYuNCgqaARAi9/QQn8liYH6d6gyjzXLtMvhweFcRuAhOwaTpy4jdoDmIww
         sGlWqEyKDQjXpo5LIajEa0PoR1fwUE35qhLL+5LyG5nYcoSbo+hilI6gDh1/cV+Kxg7f
         uQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=sG6nlAh8pEMfUVozNmov8xXCHxcqYJN6dHVD6nxfXEw=;
        b=A2iT9ieNmhW76M11SuFoWRvUxwC5Ep9vueNY9jD+mYMN6AS1Ss2vwv8k7D++Pu3Wgl
         Vjt051jtMWd8W0ZH8/OJFx4pHMPGl5VWf/u4LuVj63tyIuvEO0/OFdIOSwZUo02KnMz/
         yxX2RHN9OY3zWsnDnxQkKnQAqXe57Rwzz8uNbAr/s9NqvbWmeqS/C5qAj/VxraIhmIJB
         hDQwEZOpzCCMkIwbRTq11KF/MRNl7U9JaWWmrrEf1R6BJt2BugovIz2oRNFRvjDk5s4T
         lSlP5fdytOUZhCiyA1ahAqqbyD8umgs/K9rU/BfdFvPcAfqis1OxATZCvKW9rSkgJFw6
         bxFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aoit/lmZ;
       spf=pass (google.com: domain of kernel-hardening-return-12577-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12577-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aoit/lmZ;
       spf=pass (google.com: domain of kernel-hardening-return-12577-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12577-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180313201757.GK8631@eros>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
 <20180312094606.8192B6081A@smtp.codeaurora.org> <20180313201757.GK8631@eros>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 23:00:47 +0200
Message-ID: <CAHp75VeM1zNyNtHvsn0=rg_xibcitVHREY73cAk=KCSK3Ti3vw@mail.gmail.com>
Subject: Re: [RESEND] rsi: Remove stack VLA usage
To: tcharding <me@tobin.cc>
Cc: Kalle Valo <kvalo@codeaurora.org>, kernel-hardening@lists.openwall.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	"open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>, Tycho Andersen <tycho@tycho.ws>,
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594907726238514034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 10:17 PM, tcharding <me@tobin.cc> wrote:
> On Mon, Mar 12, 2018 at 09:46:06AM +0000, Kalle Valo wrote:
>> tcharding <me@tobin.cc> wrote:

I'm pretty much sure it depends on the original email headers, like
above ^^^ =E2=80=94 no name.
Perhaps git config on your side should be done.

--=20
With Best Regards,
Andy Shevchenko
