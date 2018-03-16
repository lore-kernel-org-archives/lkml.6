Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELts9T8zZU6SIrTa2scSa6pbduNaxL/JdLy3r1QB50B9oZKXL8NWKIM1ef4ggLx/k3qHk/j4
ARC-Seal: i=1; a=rsa-sha256; t=1521214316; cv=none;
        d=google.com; s=arc-20160816;
        b=yWF2mQ7V3szJcMVknBmWGKNF7l1NxRFaIApN9urcEhYI7ymQ/1ukdVCvqZArfTDunR
         2VuThxqhKcB6hfelsyYjzQPPtzYQ3CSYYEKP68BJlSYuy7o+PIcYnH/t7qxzvIE0qCrs
         hhyZU/qwmpy8e/yZ7dJ+7VvWICvVdwydV0SncsPbofA5KARlaGxncaIC3AjDJgnjXSjC
         nF/y6EEMLkyFIydov9NPJnf5ciVSqsLCuvUroF88P6a65Iwmose7hcasy8j/hM4RzlX6
         ti90Wj3fKfqqbvcVJCo3ObCsfSa2ntOJ8Cv2NFu7JJOehGf3BC8GHSo5zh063jDZ6oXk
         upGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Jer0p39QTM0yYE70//mKIqJj1FaBkSEZLI3hXbRkv8s=;
        b=yCPqEvt0GQeEOnvyzRKHfSYYwOleX3d/jQK1SKrgowGVPaeUCL7egKRGiftBfanHrz
         Znq6UyK9K3UvoT2ybk17LyMKnyk8vtWGRNOGTQyhC4lw0TKPsULDYFSNm/QwuB5KfZsi
         096Rlmby9/QF28WnX4KwLM8NEhlQeqSacRc3dujZLDMEF1KjlcSyYmhXJknNWxFy8KNf
         DeLEhpy4ZUbv5kzFABkM8ESJuScLNx5JADPPY3q8qrb0R72GbZo/nvraFG/wUNAXOX3I
         wmWEmizi48+feu9dD9PwnECC+fs9De8Jm4pyLCAB9gXPylU7N6xp3Ku+WiKOlYmrQYk8
         IJCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 44/86] x86/boot, objtool: Annotate indirect jump in secondary_startup_64()
Date: Fri, 16 Mar 2018 16:23:07 +0100
Message-Id: <20180316152320.444560453@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108823278614581?=
X-GMAIL-MSGID: =?utf-8?q?1595108823278614581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit bd89004f6305cbf7352238f61da093207ee518d6 upstream.

The objtool retpoline validation found this indirect jump. Seeing how
it's on CPU bringup before we run userspace it should be safe, annotate
it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/head_64.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -22,6 +22,7 @@
 #include <asm/nops.h>
 #include "../entry/calling.h"
 #include <asm/export.h>
+#include <asm/nospec-branch.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -200,6 +201,7 @@ ENTRY(secondary_startup_64)
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
 
