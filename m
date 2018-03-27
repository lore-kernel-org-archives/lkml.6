Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49arN7P/5D3Y0e3MpenCIk0TaMeKqeKYbOsFrSY1eGArWaeJ7+owjLVRpIDnIDnF6rnFaKu
ARC-Seal: i=1; a=rsa-sha256; t=1522168426; cv=none;
        d=google.com; s=arc-20160816;
        b=O1JFLQh1JL4DzHSTi652QaXAkRxdSmghjJuNKH73UHt6l7A1lciX9njHGwfjYXKjY+
         Av51st3y3mmOxTMBh0ENk9BMTO2oAqY6un1R5YoGUAPXM/4WAAxCkiJy1m+vL9uf1rzX
         47HfK0nFOD4hnSHtaiZth4/phTSxyd9d5MF1iundG0FZ4H0e+T01rca8+bytDX5t0kJm
         FiTrwKa4qpjqONAV5Vrn0l8cKnjsIO6F0GQNol7TJblIm6FuNAWgic0+RORu1L5+FCaN
         cBeJveVyd7/9QxvpsPL3w6dUMo1EuZJszPRdAEMEwfa1xnFr8DTabJA/jQpqKJGOUkgt
         cXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FOQAZ+rFyCHYHbphgi6WWyXHQuDFNY3A/e93f5idgWE=;
        b=m9MTrRf6xJu49tva1KfR2KTKyHm/lhI1lqNCR5iubRxftICu6eIbsBPGInFsh+YIXL
         +xsX6ujebp6BXSRMg4vafdoH7vRlC9DM8wY2elwpI4JRWtZW0ellhmGKRDN38qWZXV3J
         T/aji0ucfciVw3FXEP8YS2kb+wAJVv0o/IjpQ1MHMa1vstOD8o6KDca0+iGRmyvz2i5f
         e942RFmNd4on5YSzFOyXjEbvnW5p/3lG8sq1UKTA2il0PaYhrd5cCIeQXv2iZ26mnVUw
         e6RAV5t7Y7v3P/LjQDkukN8x8IajU9qyTSMMfT83+chmuy1f/LMc/9aOyjHFvi0V3HEh
         blaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 63/67] x86/pkeys/selftests: Rename si_pkey to siginfo_pkey
Date: Tue, 27 Mar 2018 18:27:55 +0200
Message-Id: <20180327162731.138946120@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109279559846402?=
X-GMAIL-MSGID: =?utf-8?q?1596109279559846402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 91c49c2deb96ffc3c461eaae70219d89224076b7 upstream.

'si_pkey' is now #defined to be the name of the new siginfo field that
protection keys uses.  Rename it not to conflict.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171111001231.DFFC8285@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/protection_keys.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -249,7 +249,7 @@ void signal_handler(int signum, siginfo_
 	unsigned long ip;
 	char *fpregs;
 	u32 *pkru_ptr;
-	u64 si_pkey;
+	u64 siginfo_pkey;
 	u32 *si_pkey_ptr;
 	int pkru_offset;
 	fpregset_t fpregset;
@@ -291,9 +291,9 @@ void signal_handler(int signum, siginfo_
 	si_pkey_ptr = (u32 *)(((u8 *)si) + si_pkey_offset);
 	dprintf1("si_pkey_ptr: %p\n", si_pkey_ptr);
 	dump_mem(si_pkey_ptr - 8, 24);
-	si_pkey = *si_pkey_ptr;
-	pkey_assert(si_pkey < NR_PKEYS);
-	last_si_pkey = si_pkey;
+	siginfo_pkey = *si_pkey_ptr;
+	pkey_assert(siginfo_pkey < NR_PKEYS);
+	last_si_pkey = siginfo_pkey;
 
 	if ((si->si_code == SEGV_MAPERR) ||
 	    (si->si_code == SEGV_ACCERR) ||
@@ -305,7 +305,7 @@ void signal_handler(int signum, siginfo_
 	dprintf1("signal pkru from xsave: %08x\n", *pkru_ptr);
 	/* need __rdpkru() version so we do not do shadow_pkru checking */
 	dprintf1("signal pkru from  pkru: %08x\n", __rdpkru());
-	dprintf1("si_pkey from siginfo: %jx\n", si_pkey);
+	dprintf1("pkey from siginfo: %jx\n", siginfo_pkey);
 	*(u64 *)pkru_ptr = 0x00000000;
 	dprintf1("WARNING: set PRKU=0 to allow faulting instruction to continue\n");
 	pkru_faults++;
