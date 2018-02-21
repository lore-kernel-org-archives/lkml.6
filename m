Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226/KN5qXYo+JswhfRIU3ufKaWJmewoVRk+fumZcpNmLWKh7V8GoUAU7I9CrdIjXW1JkarFP
ARC-Seal: i=1; a=rsa-sha256; t=1519218115; cv=none;
        d=google.com; s=arc-20160816;
        b=lGrrZdBsAnvkhhlqL9mfXIvx4jslzmcW+0vY6/H0fmk1IrE5x3qH6qVEemzpR9cDtB
         gM6rDI22457UZW7vGZfTV22bkkixo5wMIEy6YGv8qs9l9s7eHDbE6rHSEa+g40z6W2R6
         R++bBS7E19RsEa6aGneNtoaS7XMkFq5JlNUi1i00C1UTCGw7wPKaFN9CkiJSKidEZp4j
         WgHTjM4XEn7p1aIwNGdJ7Mmh+EG+kX1U92fkQevZTD3+n873VF51q/lmmPfmH9jTGyTH
         1Za0+F6Hqkz2GklCJv/ppp/wWsT/9X+cZjRDDMfKvXyxLlBx0Fexo0cB+mE1dDtSI2fP
         UD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=seE5bcKzqnBpAgQbz0DY2fuS8qYgxzZNwNINwCPmh2E=;
        b=1Gfsrrbe05ZOfJuGC1j/JgNw6mZphAk9YHYUKNgw4aQ+bhULe4OLXGUH7It6ObiZlS
         Uuopadg/epphLMMPFelXDHxz+hl1qn744gpZFgCj6FU3eZnaeqq9si+YmoSHI//orew+
         Te3I3FTTMI07tMVxam+mQu7vdIRIAdN0NsoXUmpKJt/VZ1eCKLjmW464oGLdjmK1ErkP
         aQZAeNPJYQFdx7gtM4dO3CU8fc6wPGP3Afj6lmhVlfY/eKhfSnA+GWgu3Gm4pQ6NfwUk
         G5qeCvME6/Fvjle5hLMlNh1NQ6sM8hZ7KQ73dckr6i5caMvgVnTbMfbhntWtTWhXbc40
         qHOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 088/167] x86/cpu: Change type of x86_cache_size variable to unsigned int
Date: Wed, 21 Feb 2018 13:48:19 +0100
Message-Id: <20180221124529.208569839@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014675451742666?=
X-GMAIL-MSGID: =?utf-8?q?1593015654480394278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <garsilva@embeddedor.com>

commit 24dbc6000f4b9b0ef5a9daecb161f1907733765a upstream.

Currently, x86_cache_size is of type int, which makes no sense as we
will never have a valid cache size equal or less than 0. So instead of
initializing this variable to -1, it can perfectly be initialized to 0
and use it as an unsigned variable instead.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Addresses-Coverity-ID: 1464429
Link: http://lkml.kernel.org/r/20180213192208.GA26414@embeddedor.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/processor.h      |    2 +-
 arch/x86/kernel/cpu/common.c          |    2 +-
 arch/x86/kernel/cpu/microcode/intel.c |    2 +-
 arch/x86/kernel/cpu/proc.c            |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -109,7 +109,7 @@ struct cpuinfo_x86 {
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
-	int			x86_cache_size;
+	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
 	/* Cache QoS architectural values: */
 	int			x86_cache_max_rmid;	/* max index */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1160,7 +1160,7 @@ static void identify_cpu(struct cpuinfo_
 	int i;
 
 	c->loops_per_jiffy = loops_per_jiffy;
-	c->x86_cache_size = -1;
+	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -982,7 +982,7 @@ static struct microcode_ops microcode_in
 
 static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
-	u64 llc_size = c->x86_cache_size * 1024;
+	u64 llc_size = c->x86_cache_size * 1024ULL;
 
 	do_div(llc_size, c->x86_max_cores);
 
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -91,8 +91,8 @@ static int show_cpuinfo(struct seq_file
 	}
 
 	/* Cache size */
-	if (c->x86_cache_size >= 0)
-		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
+	if (c->x86_cache_size)
+		seq_printf(m, "cache size\t: %u KB\n", c->x86_cache_size);
 
 	show_cpuinfo_core(m, c, cpu);
 	show_cpuinfo_misc(m, c);
