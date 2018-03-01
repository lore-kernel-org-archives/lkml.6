Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELvaRwNm22LciHjkRyGQzFUY6XwZ1DJzY4yfJ8oWcb+PPZbXrKDVtwSaNIZUHfNKl9atlk/G
ARC-Seal: i=1; a=rsa-sha256; t=1519947249; cv=none;
        d=google.com; s=arc-20160816;
        b=JeKqWgqGADlaJSosIu7NIRxBGtihaanTK5uvFJPAiUP4/KcJXwooiPtmXgTmGVD5O1
         JqskutIwub9adujCe0WDwm8kkE2+QC0MzCFoQShAqL2u+rJbA4uNR1b3E++vzmEzRx/h
         m6VlBW+/f5BvsYipiTL6g3iD6kASyEPfsAEJASZ/mTJHrrD/h13i/lH96saBeIqKlAbm
         Mcpkyp2cUE8154nv8mhasJ0eZw+s1lwBfWcuFOXdwRZxgXD+W4mLPPFIL2CXrRgHrYXX
         JaJaO5eT1q5HrjfKFR7Jvj4wYQ98AaB/ObrqrE4MYLJqJTJqZgL9wN0FskwCxvq4z2MC
         wWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=KAnxQu8YuYRlu7bBvB+MC1MZI59PlA4i2lnHhA4gcpM=;
        b=ZoZEpGdB7JCK/mQnT3MwTe4fENy2FLu2T3kW3rs1ioXnag6YTV6jH8RXux5GlRJfcu
         pxZYIecgYdVO5yx1dcyZ585mUkDZp7x1m2n47RCoNtzJGl0kM1jilDguKpFyXTr2QnEY
         qugFQwC+Mx+vYL+Oe/5ot9LhhJhqSJ9jJLjC0hzW+rJYCZnjWRSpf3dgXsKSbg2PKnyw
         qZvkb8wAKfnXv/yoJeyvJ/6ut8EQ7XFZG5YGZzq65vb3kaZa9KVY9kRz6MQjanHDYfjX
         db0q4R5xApxnJSsXmH8kN0MvzzAqeuT04kfK55Ep7UTcaGAdOqYQyjMenluVS6no08gC
         ukqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 16/17] staging: lustre: allow monolithic builds
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708561.7628.11951662173369388423.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780207006562731?=
X-GMAIL-MSGID: =?utf-8?q?1593780207006562731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove restriction the lustre must be built
as modules.  It now works as a monolithic build.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lnet/Kconfig   |    2 +-
 drivers/staging/lustre/lustre/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lnet/Kconfig b/drivers/staging/lustre/lnet/Kconfig
index 6bcb53d0c6f4..ad049e6f24e4 100644
--- a/drivers/staging/lustre/lnet/Kconfig
+++ b/drivers/staging/lustre/lnet/Kconfig
@@ -1,6 +1,6 @@
 config LNET
 	tristate "Lustre networking subsystem (LNet)"
-	depends on INET && m
+	depends on INET
 	help
 	  The Lustre network layer, also known as LNet, is a networking abstaction
 	  level API that was initially created to allow Lustre Filesystem to utilize
diff --git a/drivers/staging/lustre/lustre/Kconfig b/drivers/staging/lustre/lustre/Kconfig
index 90d826946c6a..c669c8fa0cc6 100644
--- a/drivers/staging/lustre/lustre/Kconfig
+++ b/drivers/staging/lustre/lustre/Kconfig
@@ -1,6 +1,6 @@
 config LUSTRE_FS
 	tristate "Lustre file system client support"
-	depends on m && !MIPS && !XTENSA && !SUPERH
+	depends on !MIPS && !XTENSA && !SUPERH
 	depends on LNET
 	select CRYPTO
 	select CRYPTO_CRC32
