Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227msyoQTjlX4MeuNhDqjv5EmU+0EVTBM50pZGBStFbHfZvQQbJkusQ/RZRF3OVPxbcil70n
ARC-Seal: i=1; a=rsa-sha256; t=1519218528; cv=none;
        d=google.com; s=arc-20160816;
        b=PvbtWKBkSB7zLCuF4FHKFKJa9HMg7gBlJtIPd+dNXtlCwtdankG6HCEJiGYQUZ7m0U
         +qN/KoRdI57kO5AdKJ6cSlGjrjQn6xt1Pk2g7ffh+HfkdcorFYhP/vi+aCO/gLvmOH00
         HSmCTU0Trg8QEdZus6mdpjYON3E2UNtJNi8UtWpgAPQCxzIcrEjytPEEUw32/tn1pO9y
         yDzh/VoaOpyuGA2OFkN9sQIbLUkPGdUih/GGvY2dcHSy2v5pvhdkaBLaa0kIWTJM9pZS
         gjI/lbLz52CV3u4pMjsxvm2suO/mBSiLw2W+BWMiUd/Bk7wkbnE2xQanMVL+uBCBpXpb
         G+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=51uDIkuAcO4LROAke0bL18Hh9Tvi+7HzWsz6jbvFLMk=;
        b=UZvUkQMRc0v4+hZKMa/HZYooBX2Ku5Qc/SVB7Oo4N5F4sDzdaZsFGHC1RQwk9XaBHa
         VBueF0ZO1CAd7+EAPI9nykLA95PSiYAqLfaJv/VvVXxKfVkTN7yGz4H5Es+9q1SBrB6v
         Jr6T6I3zXdRZavaZKRhP4SkTw0uvvXQ26GENPTBH1sOF6gX03CAP+aSz8kTOq6Csvap7
         zlD4MbH3TxWRrtJplpsJX5WWXyLFUR6o6wC1E6A3NrGJIhtTYpl5KvlbpCTrMnYTx7b3
         pRQjmzELHJAcH3Uk42AoOuheKV6Yw2AeE3LqmLp8cG/5QNl5C6IlprbmwM6TdrHLboV+
         lG5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 072/163] selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c
Date: Wed, 21 Feb 2018 13:48:21 +0100
Message-Id: <20180221124534.459673249@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015323232886251?=
X-GMAIL-MSGID: =?utf-8?q?1593016087735785566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 2cbc0d66de0480449c75636f55697c7ff3af61fc upstream.

On 64-bit builds, we should not rely on "int $0x80" working (it only does if
CONFIG_IA32_EMULATION=y is enabled).

Without this patch, the move test may succeed, but the "int $0x80" causes
a segfault, resulting in a false negative output of this self-test.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211111013.16888-4-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/test_mremap_vdso.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -90,8 +90,12 @@ int main(int argc, char **argv, char **e
 			vdso_size += PAGE_SIZE;
 		}
 
+#ifdef __i386__
 		/* Glibc is likely to explode now - exit with raw syscall */
 		asm volatile ("int $0x80" : : "a" (__NR_exit), "b" (!!ret));
+#else /* __x86_64__ */
+		syscall(SYS_exit, ret);
+#endif
 	} else {
 		int status;
 
