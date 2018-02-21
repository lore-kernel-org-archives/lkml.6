Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225KwAKYldlcYz7zmmaxAdMHN7XixcMm8aC5xz6fV/2LqyWKCM5ePMdgpCgNvL4duKMAcAMU
ARC-Seal: i=1; a=rsa-sha256; t=1519217819; cv=none;
        d=google.com; s=arc-20160816;
        b=lhGI6UnJU5nVvUBmdxaqacCW+hTY4/MKBTxcLIEFWstdN6dTknNFrjT9ncnRdmaIkg
         Cwv+Sgp5ECnmqejirMNLuAjkS0NtxLnkDOyRTvz0OzV8t6yeZuYiDQg9hSyzNFzqa4XW
         G5pen7n6Fz4bypESI3ScWTFQLHTVPC0aLLw9jNVwIX9wsGYix1x2wpXQYc4VrBW1zXsr
         66DCncwXN/nI0EG8OAjtUnad2d0xLMlHJosVLI2r5HT2j+GkGw9QCFwzqijrN/K74Pc4
         ZWaUQnzpMfRbPLvHS7YMYSqvU98vJy4eEtgVWTL20vsr5Y6ltu/P5h2o3bGTHZAbv1v6
         xVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Nrg6SK5pQln0VGu3wWdJvszVCMb+87hRH72Jifrc1Hs=;
        b=iwVS11t+iChja4O1GwMS/U5xsBT2+NLY1UMElcqPxy6LuZcFlVJoh4oN6jIkOvpo5s
         sP1G7msgsKlaU0QHrUlzMP5+f2MQZJfEZdzUf1ZNNHPPuOG2YSRtCZFylaTe0+azSW0o
         dnvyw4jQAeZVO+NSgy0utmfQPL24HTAgoEfc8ww0MPYxRoNgqB6HaQ+fXzchrx2NmpR6
         B/DosIgcjrk0/oWbAY/4+zo+sjvEKU+6V5sheRpkFxFeGj68faXEcTh3hg4hMbqiLJla
         6Ir4YFGYjQdl/ufeRwqZqW/SAg7jqed53woee1rz4N2k/NbjDkUWDgo10Fm/bKmnwkDM
         r5Jw==
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
Subject: [PATCH 4.9 66/77] x86/cpu: Change type of x86_cache_size variable to unsigned int
Date: Wed, 21 Feb 2018 13:49:15 +0100
Message-Id: <20180221124434.993910471@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014675451742666?=
X-GMAIL-MSGID: =?utf-8?q?1593015343979455239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -113,7 +113,7 @@ struct cpuinfo_x86 {
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
@@ -1144,7 +1144,7 @@ static void identify_cpu(struct cpuinfo_
 	int i;
 
 	c->loops_per_jiffy = loops_per_jiffy;
-	c->x86_cache_size = -1;
+	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -1132,7 +1132,7 @@ static struct microcode_ops microcode_in
 
 static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
-	u64 llc_size = c->x86_cache_size * 1024;
+	u64 llc_size = c->x86_cache_size * 1024ULL;
 
 	do_div(llc_size, c->x86_max_cores);
 
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -87,8 +87,8 @@ static int show_cpuinfo(struct seq_file
 	}
 
 	/* Cache size */
-	if (c->x86_cache_size >= 0)
-		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
+	if (c->x86_cache_size)
+		seq_printf(m, "cache size\t: %u KB\n", c->x86_cache_size);
 
 	show_cpuinfo_core(m, c, cpu);
 	show_cpuinfo_misc(m, c);
