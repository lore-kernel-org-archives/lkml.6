Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp6evQe9wxBpHJ9UK5TlzHBevBnNxvbqAAPnY6XzMiQcZpTccsB8KachNp41/GyB67rcNiY
ARC-Seal: i=1; a=rsa-sha256; t=1524838107; cv=none;
        d=google.com; s=arc-20160816;
        b=kNgBVXD+MSbRHNmegPiWNy/YiGxVzR8DV0XxDGML3oHbPVzwXE7gO4uAEt1d23EkJA
         RZN/oNsn0Ba+DCb7kKGtTcyZozkPQNdsFBhkBJXxIKfZE4HB/gv+lFQwoBdEw4EefQHZ
         8kLYUEANWmtpa6qKcAr7hXrPJP58ZkMnw4dWz/uryGkrXXGo0KwRdSU7XrvsK8mgsWlA
         lgjRegECM/KbHeCPqgOGHJWIFiKaNHyuGoNHe4GqZobR5SrAXSLQffInOMEKWUG42MtM
         Yu4i74i35NGCmks5N9wF2I9+RUhpSU1ty7gbWKiAUpFK5d5cNq15IjbYPwbVKao2kisj
         skPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=sNSoEt4rW74wIO6UEem0r0MCmXzS7ZmAOGilYutwXDg=;
        b=Gg9T6GPsL1vS25CRGZCuoBom4n7+8HBfSdiY4NJnscwUdQ2+kYsOkc9czKHrKsHkjg
         nqXKQvYD7M4lQk4tR0UkBy+e3gqV7gtErXXEsaGWHJpLIdzjWEWgMxGjfe8sCU9QSO+1
         yrDMQtrViIDX6D2emQBX6fgFh1BQtyPf845SGY7tXo6Juk1rT95A2U30it2HNnp0GnLA
         EldU1YeCEx+S5mU59t/COlVdvyQB1irxjFZGh/AOVopKHZjoJMPLehaSPOQgeZ1gLUzj
         Ip9iUPSHku347gh1zjAgiOvmZjMOlgepiwzmKzx/2kRJYMzbp2olDZPmiepQMEHgDh8h
         BYWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFFC21864
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
Subject: [PATCH 4.14 63/80] Revert "mm/hmm: fix header file if/else/endif maze"
Date: Fri, 27 Apr 2018 15:58:56 +0200
Message-Id: <20180427135736.159082523@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908642933021781?=
X-GMAIL-MSGID: =?utf-8?q?1598908642933021781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
