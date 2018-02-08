Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2260uoLeZ46xTfw9BuxL3bVEN4OO10fu7gg/R2cbdVi5IX4vqHuFuQAy1bfwxLjGe5YT6kNX
ARC-Seal: i=1; a=rsa-sha256; t=1518106812; cv=none;
        d=google.com; s=arc-20160816;
        b=NSrZJJ2iKDsPQdufT64ScdBgue723+zBGOpMw+cj9dD5mE58nqfuq186Z/kT9m1Npg
         Di4DR8nemE26YQaO+uTUqbBHx/dGMdDR/0QRzOMVBcm+HlBUrtF/uHZ172RFOSKUbF4K
         LAmkdSarjpdnvK4sEgUC4uOHZSk/sY8djuikhsOUUd+HcGG0xRtj17nNVvALY6voI9sR
         /jZ3KZ7euMU5yOvFmUo9lzMD1IOwTnL3foaT+hx0iyTIaIeKmSlNxCsk20vnPCMwXHLx
         wrgr8SEe1G64FZX2ICZJ04y4ZxdxVWF2Ply/zX5RommpKhGH5n37ioWSINRDAEkEaur0
         QHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=vjBn6qmZtO3pYXfyXNULY3CphaqOCdqNsvaqSKBMzkE=;
        b=Z5ou3AsUdqcznCGeSHE/nuOeOJH/WfxgkpeXIDq5HhP/Wl+oEl4KNJdFtC13xJpFtk
         EB7P3Z/Tx5s5gL0tu9qkNWjWqO23ntmmiFY/1207h6ytzbO0YM1Jc8Xjx//VI3WAc7Ix
         4ASmYTBYg7r+dTfiLtbMN67GozWivWvxu+gCIoOvcl+N6/Kky7WspfZTw3b5TOVgF0zl
         iHl+7LU0Lw0GT/rIkFs8AMUM/x/FKBI8Jw2JI511ZCY0Tp1kkbLzDjvnTvEumQevMkVK
         cpYzEPxO3BVkxzvbIkVqBmLBv1WIYtz3vm8opBUU0Y2HUEnIrVrJS4yKvPKQtniy/M4d
         vJBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=M6acOxXq;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=M6acOxXq;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w18GJP1I021191
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] kconfig: add basic environments to evaluate C flags in Kconfig
Date: Fri,  9 Feb 2018 01:19:11 +0900
Message-Id: <1518106752-29228-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368790219309?=
X-GMAIL-MSGID: =?utf-8?q?1591850368790219309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add minimum environments to start with.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 init/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 64f9dd2..31fbc6e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -25,6 +25,14 @@ config CC_VERSION_TEXT
 	  text does not match, silentoldconfig will be invoked because we need
 	  to re-compute compiler capabilities and symbols that depends on them.
 
+config srctree
+	string
+	option env="srctree"
+
+config CC
+	string
+	option env="CC"
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4
