Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225t8EOVPDzibBflIEC2FR79u+/PjIEWW8FKNLiQVmdEl9AcgA2CQR5+2UT9NTwxQ9Vm2FiU
ARC-Seal: i=1; a=rsa-sha256; t=1517855032; cv=none;
        d=google.com; s=arc-20160816;
        b=IrcJ2gHLo4BWten2RTW611iMyGAL/5JEgUYGmTLnMZOU/YPULw68x+7N4/5BYpHeLl
         0Y3JHzHk1h1iRPRLDrv47jMtTCDBTEWek5ARPZHeCq7ElOjIMG0AOHgJRj6rzUJUZWg3
         iQNsOFhi1UHafliurFtjeC7krnBn1rKfNuTcBs1XDsImDcjA8ZFPWjlFv+Irp0mZ6vec
         c0qIaTDj8tPH5k7EqRqiJTp1RtUXiqflpiFoOxRpBIXFx7HuBA7tNVBTVaGWeN0cjhAw
         NSmBzd0YfiCmrYZWvYxxPN0RuvxwnIgwdm7uT82y8eA4EUfpil3W2LdHZd0GP0vXQWSH
         DNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZZubJTTOLhLL1OsXqj2oHrbesRtDuFeanKjVAPe6Sm4=;
        b=XUNYxiXzpsVgfssdxTnGmpFSbVBvNP863cdFcaFhJOab4sU312uz6I3158TWOaCdzH
         fyg5kNoy7qEoXPUB1JLWAP4JfIGrJ4PvYLUh3BGGLf1ME/oa04rCGALPSo0kgjec9uSq
         w+9JpJv/ZRDCUmqVMpJCqhMNpVEArz1Lk4yVhZ5X61UsFTl+uelgNoMHUAje/124JPO2
         F5rRPQRGUXPI9bOygSHhSN5sFUkiepMblikOjIfk14sso6jWyC71uPQGpD2nGD79Uel6
         QjtPcZ4W9HmDbwoHTo2deyBLk/UcabiMwcsMaGN9fUXEanDtCLEnSawVhq29nq9tr8bJ
         KqpQ==
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
Subject: [PATCH 4.14 30/64] objtool: Warn on stripped section symbol
Date: Mon,  5 Feb 2018 10:22:49 -0800
Message-Id: <20180205182139.819380740@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586358442456996?=
X-GMAIL-MSGID: =?utf-8?q?1591586358442456996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
