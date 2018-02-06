Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2241BH6UyXzo5rvdZNPGeQw3U8kL5MRFvJ1W1Kraofbn53vfxUPckmK1VQvLsnQLI+C9Bgrw
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=d8x+/YhH/4+ALZszLWFJNUEDAr0bZ0sRb5PW6ORCaJI97ecr2U/3/TmTFPTZk5kn8q
         cw8yY3rcHsszDSldqDhkqEFd4t4EkuXcz0VKUuHBDMKW8wxDV4VvP7D63F+gpFtbo0k/
         NxiDkS+UDpjI83Pmr10E506ZkN3NUqSxzS0BahzWx7YcKFgOpLvRcDW/x5EeDytAgV6n
         60AwWTeR8wYTKUJIq1MbAMxsKYm9hSKpyKiQMhxdrTa2CRvrLGXpDoF406iSzAwB0fTi
         vxqqXrrmNoDU72/sQdmqThsa+S7behdprpWv7Ajq17QEU1mygU4xXFXHCAvpRwdbHlip
         mZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=FpDmM6nkuUt2dyxIaCfbFjcP7kfXRyAs/NTglnLJiro=;
        b=gowlcjw2tPvHwfiIQ/Jemlci6nGTdbOWLjWkYf7ss6CEGA1/xOQpihw1upkKO9m1dH
         sS2LyDrNMiY3yFDX19gD1MHtyOR+vmUmV5hoLIxxif3hb5CuC3TQ5SXxfu3vYoqnBZTg
         yARiJGtNzzj4xQAJ/4SvW6/Ba+1BC0VUIfJ532bUvxdz4TYQT5m8oIkYJh2atVtyrx09
         4p/2bloQiEsTaVJ4PWuJ1Gz8Gmw6Y4sO0A6o0DAlXQ/V2IM9NdACOow9jbvj6+S+/Vdl
         zSX7RbGb14oDipyxDDhumNO+LnBdoY6V5KvV2qb+M3AS2Yu1kkQ5LpGvFC3pAIXr972U
         Cl9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=lL2UTAV0;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=lL2UTAV0;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAk011351
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] kconfig: remove 'config*' pattern from .gitignnore
Date: Tue,  6 Feb 2018 09:34:45 +0900
Message-Id: <1517877294-4826-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778319723045?=
X-GMAIL-MSGID: =?utf-8?q?1591609778319723045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I could not figure out why this pattern should be ignored.
Checking commit 1e65174a3378 ("Add some basic .gitignore files")
did not help.

Let's remove this pattern, then see if it is really needed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/.gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index 51f1c87..a76856e 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -1,7 +1,6 @@
 #
 # Generated files
 #
-config*
 *.lex.c
 *.tab.c
 *.tab.h
-- 
2.7.4
