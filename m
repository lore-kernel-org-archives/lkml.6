Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227doYedt/d+Z+kqZ7v7CKzhDHIqbUCvvLVgRnMCaBosgTVe24uaZQeW8nfWDTrX/kDtt8pT
ARC-Seal: i=1; a=rsa-sha256; t=1517855116; cv=none;
        d=google.com; s=arc-20160816;
        b=RzeKvC5EjvCV0GM1kJi5PqhGY7gyEB1Qkyp2FV4p8eBnFeSbWnT+hxuQny19qdcFNb
         u3ZIZ1iqHI2zRpG2NNY8Tl5X24Ko7jxOsagBPwWc7oMdoaS6wlqU/aCJUcw2dBLmws2Y
         RvfvKxMWMC+jwW/QXhilSyX6j0XHbAk5uyGb//4TIX5Axrp+IJWT+k20AV4ANcpjb9Do
         huaU7gT7Iu09Ma0ZpSte1G6VV4sc1LLLWTbhayUx/HN6JUAI1Be/CQEvf3dJnVzNInJ0
         IDkACkjZ3qwufSoXNaTD+YprWogVdZmbYnNMhrqxfR/Te93BPowutMW39X3EppgLENVT
         lHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QC8CmJtr9On8iO48MgQqt5+WlhG/pxTZU81TfxMjAdc=;
        b=rUoPkanuVOo279IF4/d6QujrfDxuD/ZvljeBD5og6xrs4Q3A88Ic95AI9/yFnjdUnM
         +tVVfO9bayC1cMlB4uuth7GcRFXDeyRn9VWKWsM1Y3plZIKWgattxxCg0iH+m6irr4VS
         3mVpYTQ/e0PQsTMTw07O/5Fmd+AuAtxSNYEg/We3eJstYz9jSs7NSmAw1oM/WwHs9lmj
         xVnva9/dr0fCiECIzvTLTZN5vqSVS4SKbuDSc5Jk6z5x34cDDsE2N1HYARQjSdS82UhV
         UMFjNypFPaF2Elct5qK8ejV4fLczD30hbWBg2tBy1NzFjG6Dwb1uvVQE+38F73EQkRWC
         odKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.15 26/60] objtool: Warn on stripped section symbol
Date: Mon,  5 Feb 2018 10:22:59 -0800
Message-Id: <20180205182215.006306181@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586358442456996?=
X-GMAIL-MSGID: =?utf-8?q?1591586446897585461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf jpoimboe@redhat.com

commit 830c1e3d16b2c1733cd1ec9c8f4d47a398ae31bc

With the following fix:

  2a0098d70640 ("objtool: Fix seg fault with gold linker")

... a seg fault was avoided, but the original seg fault condition in
objtool wasn't fixed.  Replace the seg fault with an error message.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/dc4585a70d6b975c99fc51d1957ccdde7bd52f3a.1517284349.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/orc_gen.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -98,6 +98,11 @@ static int create_orc_entry(struct secti
 	struct orc_entry *orc;
 	struct rela *rela;
 
+	if (!insn_sec->sym) {
+		WARN("missing symbol for section %s", insn_sec->name);
+		return -1;
+	}
+
 	/* populate ORC data */
 	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
