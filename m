Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525727938; cv=none;
        d=google.com; s=arc-20160816;
        b=CaHVoN31lOb7TXaPN8HP1/La83GpVAq+9CLdIaYVaOyPuuT2n/cEHRFyN6QPmsjWtT
         WEieNXHiIsT5YHujUbRsC2bYWZh8h/iKFl+UVoMOwm68SdsBO0Dm2CdmRFRPwAe2rI0C
         GEvgyrmUp8ymr0+KKUl6JOn9k4OQfw50UPiAV3OKfeh5DcyovkwyLJwpLinhRKXn8rhK
         PvrK9Wcninv/N/fnDOcZCdFnGxTBIKQU2wIKlEdbLr0RvwhbhwacD69AoWKTGCZdNzjr
         DFeB9jy6t7VCgKFD6g77XLffWVUYBcW8c6m/WcxZxrOz657fbX6r+XhYjfU/cP7YySdx
         vLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=934J5myvKgY8hw1K2PJpRHALc09+msTVy00glGw4t3Y=;
        b=miO765FGKYxJv8MQ2xCWXlSE2Sx4EmatuhEGFBM1oLdozoXnENk2KIWRBmBYl0rX9L
         xMypQwjkuQuXJpv0IInyFVBmrspNzodUrHpq6ZOCMSU+8xn7eZkNVCWdAGVEZQDsIE7k
         5FFiFUCCyvW22XinzAUTw/52QUnJmQBRxkLQNzZXc2APw/SWKHh5Bssb1o8cwT+M7kgC
         2QbopupYMLMQukO6bUi0HA9s9H0wjUkjQyl3Ougx94vBLyO0QOuHNw2xx61E5W3svGPF
         qqWXO1qCI/p9uKtw78vWGQVnYB4TYvC5aUmSr/3G5vS4uwsc8DBQiccwIxLVOCyLw6n5
         b9Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n20Hn1CR;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n20Hn1CR;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZrGV5pczBd5e73Mh00vakGYNiBVCJwMFUQB63biHM9Pf/VDhqfwdKMorJEGOUAkZmGCjiVSBjLamS2j/VXAFTY=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525682212.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525682212.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 7 May 2018 17:18:57 -0400
X-Google-Sender-Auth: HHC7zavDtcXp1cilpu5kVZLxnqM
Message-ID: <CAK8P3a3Wk+1Emz2g55vb7U7yPU=pPAQYg7ibwj7g4kGZWmmuKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] MIPS: Convert read_persistent_clock() to read_persistent_clock64()
To: Baolin Wang <baolin.wang@linaro.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
	James Hogan <jhogan@kernel.org>, chenhc@lemote.com,
	Kate Stewart <kstewart@linuxfoundation.org>, gregkh <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>,
	Mark Brown <broonie@kernel.org>, Paul Burton <paul.burton@mips.com>,
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797073537984267?=
X-GMAIL-MSGID: =?utf-8?q?1599841698882401590?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 7, 2018 at 5:28 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> Since struct timespec is not y2038 safe on 32bit machines, this patch
> converts read_persistent_clock() to read_persistent_clock64() using
> struct timespec64, as well as converting mktime() to mktime64().
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
