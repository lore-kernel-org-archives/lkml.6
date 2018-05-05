Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZqaIfW2jGVgQRv5BSXyzHm0vIGHgeEJ1PvMhwrKH+5T9056Pv+EC/44Z7d0BAsTWTKTNcvB
ARC-Seal: i=1; a=rsa-sha256; t=1525515441; cv=none;
        d=google.com; s=arc-20160816;
        b=X5GQsF1N1ObyqUbqHsQ7pR+eVkwSNPVLdN2VdjCwmN2bAOIWMDt4dD789W5g/0ZwAF
         hSzjI+tf7QMUqeboNd3KR5xn4/7ujt8iu52hJZ+N7JFowvYMUausiWr+xRYQjBN4oHgH
         +bmUksVuq3anNGgIvaMx5xV6cYqqzkW/mPYn1kQ+uwYCxYwuqT1DrCq1MUP/zyY7476L
         zZDrs82VZNyw1RxobtR0z3RHyHKwODKDeg/122Ul5EjfQNIoX6lWsfvpp+qX873FvINZ
         MvUuezSURBYoYdX0gJPH0fpvxoOdqsD6ZhVpRQXPyEDGcktOrwxKOVhkNXolGM3OL0dF
         hHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :dkim-filter:arc-authentication-results;
        bh=ObLjelU2pM1ELEKn0GZpF8dj+Shl5YyeJhWs5iHDwyY=;
        b=x5q7BtTbpu2PJPohCJaqwkRF3ijtOc+5kWzbhBEjvDPb6i09hf3rEyS6tYERs6Xg1f
         m47oEuWpSjCG2IorvIV1ausnaBEDhQMGlNbBB8hTvm/ovFl8Gi1llhNoqwMQsUiI4bx1
         MUfmoFRrRjgYKUu+D9nZkniWngEuKe/8ZmhK3BmAGnfD52TPa+2oBW1FI4UyZaOhLNmF
         9vnXM2x1yNETz5xsJERl0ZbwSxgsVZ4VI2YTC3RnW+czvjkcf2OuXMg5vJmO+k6IcMje
         JwIKsRYuA2TQGoqD0BqKULVN3PJXI9B6wnradJeA10dZ9yndUFFnSzufka/5crLClo01
         Iuqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=hWVgV8Jc;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=hWVgV8Jc;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w45AGsmT027121
X-Nifty-SrcIP: [209.85.213.44]
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 5 May 2018 19:16:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
Message-ID: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
Subject: [RFC] Removal of CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Miao <realmz6@gmail.com>, James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599618878977275794?=
X-GMAIL-MSGID: =?utf-8?q?1599618878977275794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi.


CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected
by BLACKFIN and METAG.

Now that both architectures removed in the previous
merge window, there is no more user of this CONFIG option.


My question is,
is it OK to remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX entirely?


In other words,
  - Is there possibility to revive Blackfin/Metag support?
  - Do future architectures need HAVE_UNDERSCORE_SYMBOL_PREFIX?

I guess (hope) they are unlikely to happen.



If we can remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX,
several tools (modpost, genksyms, adjust_autoksyms.sh, etc.)
will be simplified.

Also, VMLINUX_SYMBOL() in include/asm-generic/vmlinux.lds.h
can be removed.  So, the linker script will become more readable.


Is it OK to move forward the clean-ups?
Comments are appreciated.


-- 
Best Regards
Masahiro Yamada
