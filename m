Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvp8LGAkeejhdjUyjxHvix+b3NvABZnAyxasfuYxSFMUxm94f37a0nLNdFQCNZHKr4XBeSV
ARC-Seal: i=1; a=rsa-sha256; t=1521484200; cv=none;
        d=google.com; s=arc-20160816;
        b=pDUvtlxJTTcnWqf0lMwo+SXjuDsAQFvUCPFWHz0FS6ZVNPKTx9BGBUJhpRagl3k0Aq
         fKIv3d1Kl64LUgp4B44Kg27T+pK+wD6CJBIdAbpZ7t1sXHiL5LUjkmJnKPwzgzDDae9h
         +jRq5GOzQg9JoEWLauqw+itavjH6ffJWVhFUbBZ3Fh/yCxSjKPFKb9Mg/kg3WCG8ZJDI
         wWALFJKgMQPcSoQ5iy9Ej62icxoRe42JGZYnOma+w5V/VISdYKvhx0Kl9ZhZGPgorJJz
         u1xXcYBKfeL4rkXiKaWCwznCZZwyYvP/uo38sMnDJHELhBF/Bap+8ArPEgmBGIcyiyfK
         gtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y22J1skcRRyJBNG1LE3ElH+ezDLCkVI9z2IijPpwZog=;
        b=idR7Ohq+XztsRfCF6HJmxQOtg2MbflwXUaORgQbQhamn9OMWF7ovb1hGjRfAl4ohc3
         Hy/WAV1rl5g/E9rAS4lM9aeF84wlLaUcg2CrBBMlrvR5uQCAD8Omyu8u4HkitM58UZ9M
         /MKrD+deVgLJZUrXfSkwbP1dlFSs9ts0RoF21xBHt2Z56WLEmPZLTa8NY2IkVIDKccwj
         UdEq8xZqmCDgBE18CszGiXKGhZCpwynYh4aJxXkizy21sQZUQb8KLeUQWmeGxXEk87o2
         6DmqP1SC+XTdWwGtynIz2U507lKujY2+f63cq6TrVuRa3zvj97HNEaQp7BMEWstdwVGo
         djNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 08/41] x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels
Date: Mon, 19 Mar 2018 19:08:08 +0100
Message-Id: <20180319180732.770446117@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391744762419603?=
X-GMAIL-MSGID: =?utf-8?q?1595391816454575195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Whitcroft <apw@canonical.com>

commit a14bff131108faf50cc0cf864589fd71ee216c96 upstream.

In the following commit:

  9e0e3c5130e9 ("x86/speculation, objtool: Annotate indirect calls/jumps for objtool")

... we added annotations for CALL_NOSPEC/JMP_NOSPEC on 64-bit x86 kernels,
but we did not annotate the 32-bit path.

Annotate it similarly.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180314112427.22351-1-apw@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/nospec-branch.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -183,7 +183,10 @@
  * otherwise we'll run out of registers. We don't care about CET
  * here, anyway.
  */
-# define CALL_NOSPEC ALTERNATIVE("call *%[thunk_target]\n",	\
+# define CALL_NOSPEC						\
+	ALTERNATIVE(						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
 	"       .align 16\n"					\
 	"901:	call   903f;\n"					\
