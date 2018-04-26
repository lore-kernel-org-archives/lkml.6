Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx4+ePy+Sc0DX1ke92tPR232erOKSzKu7BPzX2yJiqHYBQS61HpqcVIPuwhycx3sr7KcTEJiP
ARC-Seal: i=1; a=rsa-sha256; t=1524779549; cv=none;
        d=google.com; s=arc-20160816;
        b=hSKWV13EIunoGu5zf35x8F7mgmzlqRb/ukFnig1E/b9uZ8emFONqWeUVgkE3NQSH07
         aCBazripHPDNu5FA3+MZF3PYjoGa5OsDbRoHdRIDLOTLlsbk4uiHkbAYHU0jYZmtOJFH
         +kBIjIU2sLoMMh+sXqMAr+qsWDZrZGTcpqHqaET9x/MP11XTgDzrcMw5HR7mtrg6xFON
         jiQDMP8s1mdFecQsq54Isze/5oFDwX3FIrB66UxDeeEl1fN8FY6tGGsbuEQ/bI9xswKh
         RBD03R/85FmJ3FGbQ1IaCss3Fkt257gis1AmpBW7LjPaGOcXIKzULOSlMjcDhoPBv5rN
         R7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:dkim-signature
         :arc-authentication-results;
        bh=mvm5UgovDn0rTZ5+XfW5GP3jLsWdmfMMzSNUMzCPBbQ=;
        b=edFkuH+yR7Q4NIQ/pzyiNDaUzj6giDo0TFzd5aBvN0o2Ev6guAHA21PouBEkjReSXa
         lgSgCeinW+FXc76hUAUHjBNXKxXMwYR2PCN8y7WzYPZxM+0/O3JMpoTa3tTVTm9UyYp+
         nFpNxhE5oOaFRohZqs3wW1+QHpg3C7ew4KE85nBXsenj/iFK0rsdBgBQ5hCvWR6ySYYk
         Kivhx9YfjQzUjxsWXjyZu1r3i881n6QkapS+FWC26dNAGI8bv3PyF8sS3Pyz3KKWGT7+
         CN7xzEpXWqbTM8p3cGB3n24rJkW6Z5CGF3/xKQCy8+fG+0Re46p0w1M4YXeZYfXSdzp6
         MT4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=U1mV1GNI;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=U1mV1GNI;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Mikhail Nosov <drdeimosnn@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: stable 4.16.5 hmm build error
Message-ID: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
Date: Thu, 26 Apr 2018 14:52:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598847241183995427?=
X-GMAIL-MSGID: =?utf-8?q?1598847241183995427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=199515

kernel/fork.o: In function `__mmdrop':
/kernel/build_kernel/linux-4.16.4/kernel/fork.c:600: undefined reference to `hmm_mm_destroy'

"It is also reproduced in linux-4.16.5"


There have been a few attempts to fix this build error.  The kernel mainline
repo seems to have it fixed, but it looks to me like Arnd's latest patch
(9d8a463a7016e: "mm/hmm: fix header file if/else/endif maze, again")
was mis-merged to 4.16.5 stable.

Please take a look.  Do you already have a fixup for this?

thanks,
-- 
~Randy
