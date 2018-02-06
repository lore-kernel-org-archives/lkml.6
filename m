Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517959452; cv=none;
        d=google.com; s=arc-20160816;
        b=DA5pGofHMm3HeN9B2pvyfBm4q6VWV9lKama/l3jyajuoUC0gWF3ntQ54CXgU3DxA1n
         RGygDYz03V0iO5Dj3EBJGDTmxW8DRkTmwC7Uu7M/yP+3xtBz5BYYJ+FhCwE3BTrCaAhn
         CVd3EUxQ9DHVXEkbgCDuc6EpUQI8GBUo6+Qq9fmdznN2OzdccBf+EmeLqRrqB3xeywsq
         VbSM+XuRjUWlK7Uy0X+K0rKBsfZebOHHoofMgKrBWbIPkG2PP4oDd0K6FPmVbVerm1Q4
         qsUpbEzXGFBAwefAUCuae6RuFuWcbj4Yi0yAJ7scw4oqvO8q0Qcb5aEsQlXO0LTB0mGW
         z94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=iq0AlYYquXrxGdLK3G/vIKPslNLdHIMS4Rch9JSMe04=;
        b=agTAeRJVlwdDDwQop5SB83vUUKB1gBrVTNttwQQabvQqR7xJSb22V+2/AG27WSKeIv
         LnIixhi5kEjliTZOfFw9Cev8IA1zZye9f0GivlH1YZ1oLuihvA1HUB+a+iIMXaIhPKsM
         P5eU8HREXf6NhGt5tatf7LugRJ6EkT8bpdF2zW6Ov7HiY4wvQXkw0y+Kt1SQMqvwEtDN
         HlGNcrgkZL90fEmuYHL3zQY3VoHToq5pD7wt3gusRhRxnXxxL9fMKEIwq6DJuFIrA27q
         ozOOInAmiPdT5lnMTwecN2fPOQnbuxs2XZXu6NjtQJgZw10V6omrIVOVW9EZQZfUBios
         VjVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cpdNAGwX;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cpdNAGwX;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x225wRnLQLSR65bz2MAcis12WFN0t2gKPEhb1e7l8jsWAca2xsQ2ITlmJb0ASYtAucNcZulX8KcMPY2xaezCOkV0=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180206221226.10511-1-alexandre.belloni@bootlin.com>
References: <20180206221226.10511-1-alexandre.belloni@bootlin.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Feb 2018 00:24:11 +0100
X-Google-Sender-Auth: md_YV5zDuuYQRDyJlHUdP_iny5Y
Message-ID: <CAK8P3a3=DKk9XZN7mPCrVgH=uSmC6kVQc8DAbp4nCoWxTpQ+eA@mail.gmail.com>
Subject: Re: [PATCH] char: rtc: remove unused rtc_control() API
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591691353805740704?=
X-GMAIL-MSGID: =?utf-8?q?1591695850894297011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 11:12 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Since commit 34ce71a96dcb ("ALSA: timer: remove legacy rtctimer"), the
> rtc_register/rtc_control/rtc_unregister API is unused. As it is highly
> unlikely to be needed again, remove it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

I forgot what's stopping us from removing the rest of that driver ;-)
Since we can only build it on alpha and mips/loongson64 these
days, is there anything that this driver does that the normal
one doesn't? If it's just a question of testing, we could probably
just move it to staging and see if anyone notices a difference.
