Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/OZjTg0pwEBufC6R1EjWYskWvz0YBcVsS2ByCfvXLOO+Ni51WL04b27yL71tbxUpeKEzWo
ARC-Seal: i=1; a=rsa-sha256; t=1522297650; cv=none;
        d=google.com; s=arc-20160816;
        b=pt/OPVgjiB6G51AnZvBgujq8m5h4E6RcVabUBflJGK9w/EJqBeBXhEGrqzjpPtI1QM
         nOjfIN7MJOru+Vnp3oZPCaPJNutO3776fOzBG+DwAwxuEc4q+QBG8YpxOuuNfyp0UHMN
         y53vIHPJoKlMz6L2SkbxRYtvHOCKiitbfsjOciuSkOUZe0+ViJ+85ZJyQ6ts4EzwiQzm
         Nf9Hv0qczuJgh2VekZwmDxCICbiWv8QMPGLAgQV1u44oA25/qr9/dylC4pQj5GLHQ8bR
         eas9yX4Uo3KCSaUCKWBlqJSEz/Y7I9ATjbYDNLrz+CX8/ampUG8J1hZzemLhZkyzExqM
         wyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=gyykOkFYC3vzFvd1T2vnG8jX9DiRk0sBi/6CLKoGe1w=;
        b=ZOpoSy2YCLzgcxmzJ0LsR/nZNwn+MxHFYQw8vgIegs2OEoW1qofH5UR8grrPOY7x05
         KFf9vlTsx7za4Jv7P9irjezHR7J63Tby3is0NpdWHR8F0n4uEXrunvNt/LIaZWUuoXH/
         mCzkT7sWsJZdNvkqaR4w6mAFCgrLS6l3G4QsQVnkpjYDxWQZCY0R6RS2xPOURoUb9f4k
         +6eWOVZZEaAv4RjBlCRKS4RhKovx8arbTe/BlRJ6b4w08DyBlAH5kdQCjU1VQ72UjlPy
         qH4qlP7V25eFyHVdYdIPW77PD8kUuIB9qv709bJ1eGfnh0kr2M2SswwhVZKTPIWSHTdS
         qreg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 29 Mar 2018 15:26:48 +1100
Subject: [PATCH 03/17] staging: lustre: LNET excludes USERIO
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760832.27689.17304570282712555631.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244781744369072?=
X-GMAIL-MSGID: =?utf-8?q?1596244781744369072?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

LNET_MINOR and USERIO_MINOR are the same value, so
they cannot both be used in the same kernel.
Until this is resolved, don't allow them to be built
together.  This saves automatic testing from noticing this
known problem.

Reported-by: kernel test robot <fengguang.wu@intel.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lnet/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lnet/Kconfig b/drivers/staging/lustre/lnet/Kconfig
index ad049e6f24e4..fe4b24acf075 100644
--- a/drivers/staging/lustre/lnet/Kconfig
+++ b/drivers/staging/lustre/lnet/Kconfig
@@ -1,6 +1,6 @@
 config LNET
 	tristate "Lustre networking subsystem (LNet)"
-	depends on INET
+	depends on INET && !USERIO
 	help
 	  The Lustre network layer, also known as LNet, is a networking abstaction
 	  level API that was initially created to allow Lustre Filesystem to utilize
