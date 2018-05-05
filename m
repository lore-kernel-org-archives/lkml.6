Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525535446; cv=none;
        d=google.com; s=arc-20160816;
        b=m9IwmyzpSs39Bsw45w2TIYvypvVDQmNxY8cQsnr8uWX4Pc6gSIju6965gahtVWMhF9
         IGeoRger76LibIm8dqaggw04tvGYSggPvvsFF3vF2/ZB42jYFq32WRLzp6s9NDj9E1i6
         eQ7dXtOrncn534cMiXyGuSJil3vlu/f68dhg2AdzlFMrTpNUwxyIG5Tsuv0ZiAdmYmks
         SRt7vkXRZWxYQq9DlP04dvzdRjnLvaUVfl0DHc23zS9CmvJw14b0lo9Hz1RNwAaKNdFQ
         YSJpfo/lB6EKJfeWTtBTZuSdvYstPTSGFdRNnyOWk1vc+E8pDANFcO9CThRgQQjDXy2w
         BIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=x7CUpwm6zTN35+4BWjjLlgUOiVMKOq9dO2POAR75FPE=;
        b=kkxZ2IOqetfrq28N2OQVM1MTjJJMLOefTCvwIOa9deriGXJeHqV9/lyJZgEm3HLeQ0
         kzbNOx0hJRizXb40ecFfd6BZ4LGdhcsESCNOwBJ1IVNDe415UV3KSYYMBIO6M1iyFTZS
         Vt3tyhHg92OnGas3pIB4oHvs800AHyqMQBzzzpgbCkdgrEbWfi0GCrEXUoTW/PlpUWOU
         gBfBZv1OCOBGOXHIXUiuGSHYf47cFz7/IcHkTeCsKWwrsx9OKDDuO28+yoZxhwvBYeFP
         dZ2Cf8isFPVjcEKj3NrUm4pJsDkLyIck4TGWD263B3w243NrznErQsiBHofrIN9cEKIT
         iQbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=FdAboMIu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=FdAboMIu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AB8JxZrHNPT5uKkutO97LFZYq4SAbLChh80r88Z9bt2u0/+X1stSj697Mg26SATlr5TapE7mkEOnXBRgRAHIll0jx3s=
MIME-Version: 1.0
References: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
In-Reply-To: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 05 May 2018 15:50:35 +0000
Message-ID: <CA+55aFzX9CeRr3HZtVN5XKK2Ema5TjXo4FCgD8ukWz6Waz=pZw@mail.gmail.com>
Subject: Re: [RFC] Removal of CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Steven Miao (Steven Miao)" <realmz6@gmail.com>, James Hogan <jhogan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599618878977275794?=
X-GMAIL-MSGID: =?utf-8?q?1599639856646467819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 5, 2018 at 12:17 AM Masahiro Yamada <
yamada.masahiro@socionext.com> wrote:

> My question is,
> is it OK to remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX entirely?

Absolutely. Let's not keep legacy stuff that complicates things around
unless necessary.

Even if there might be some unlikely future reason why it might be revived
some day, let's not use "what if" as an argument to keep unused code around.

              Linus
