Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr4jkNudYTWOqQIN9XVOV4qF5cXCmCnijTY+4ok+Te9zu+rAJn41LN0+BxH7dKwMCENsZP8
ARC-Seal: i=1; a=rsa-sha256; t=1524838319; cv=none;
        d=google.com; s=arc-20160816;
        b=Emqcrkj96XCob6F7R9Ds72JFonjENRKF08ioq+XSeje6Lg3OzKdtEySnJBCyitFO1Y
         l6g58PNKHtON1ayfZVFlXr/s+ed3AzDicoQvAkdu6qsNQ731POfqwrm26eSt72WC7h10
         XjdcCiCeVADR6eHmE6m0Znh+N68QzCXV3p7huAnvIuxANTlB2mpfoAULiv0hVqdJkBv3
         czrLHbyMKcCuY08sbRytPmUr4J6aOQhAvrZ3bflaEVDyps3Bs/ATLGiW4/N18WKMADQe
         cVu7u1MGZQUQ1IEjLOcoCFoveDiYEpvji7x5iTVCCIV7Wa0j7CxK9Mv/Z6/Gs0iliWXI
         H+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=aBszZKiSpYzOg0zn6WMjJOVn0n4rDvtAxftJN0FlWf0=;
        b=apHerWS4L0wxvpKLSVbaT63Smn1y8zNXBsxDDSi6ut0+Y+4KjpIq1Z7djaMbhrMy78
         TmzeoDV4hN2zrMx2Pf9Q1vU/ClEzKTKZLr9w82GaJXe20MAey/y2FpdOsw1BuOW+Hva3
         MDer9XcVkCUHN9cDGNfQN1w4TCUSHXYrmoScW9yVWaDxBGEbcATHg5P3tyDaj6gIjwzC
         dFx2zFj3P76zoyQOrQIMshlh5sbeaQ6PTCbdyUGkF1iVXmts52PZR5boqt+uhx1JiLov
         FaJWdbldro21eHzfXpUwFWJt95u1vnTaUsHY2j6faZe0n8hflySjsgmmaDSdDWW+9tqI
         M9ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CA621864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB=20=D0=9D=D0=BE=D1=81=D0=BE=D0=B2?= <drdeimosnn@gmail.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Balbir Singh <bsingharora@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralph Campbell <rcampbell@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Evgeny Baskakov <ebaskakov@nvidia.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 60/81] Revert "mm/hmm: fix header file if/else/endif maze"
Date: Fri, 27 Apr 2018 15:59:02 +0200
Message-Id: <20180427135746.867987823@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908642933021781?=
X-GMAIL-MSGID: =?utf-8?q?1598908865719198475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 25df8b83e867dcfb660123e9589ebf6f094fcdd3 which is
commit b28b08de436a638c82d0cf3dcdbdbad055baf1fc upstream.

There are still build errors with this patch applied, and the upstream
patches do not seem to apply anymore, so reverting this patch seems like
the best thing to do at this point in time.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Михаил Носов <drdeimosnn@gmail.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hmm.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -498,16 +498,23 @@ struct hmm_device {
 struct hmm_device *hmm_device_new(void *drvdata);
 void hmm_device_put(struct hmm_device *hmm_device);
 #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
+#endif /* IS_ENABLED(CONFIG_HMM) */
 
 /* Below are for HMM internal use only! Not to be used by device driver! */
+#if IS_ENABLED(CONFIG_HMM_MIRROR)
 void hmm_mm_destroy(struct mm_struct *mm);
 
 static inline void hmm_mm_init(struct mm_struct *mm)
 {
 	mm->hmm = NULL;
 }
+#else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
+static inline void hmm_mm_destroy(struct mm_struct *mm) {}
+static inline void hmm_mm_init(struct mm_struct *mm) {}
+#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
+
+
 #else /* IS_ENABLED(CONFIG_HMM) */
 static inline void hmm_mm_destroy(struct mm_struct *mm) {}
 static inline void hmm_mm_init(struct mm_struct *mm) {}
-#endif /* IS_ENABLED(CONFIG_HMM) */
 #endif /* LINUX_HMM_H */
