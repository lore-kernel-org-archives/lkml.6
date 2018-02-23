Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226dJzTw2mXjutbYA5mEtelctAfy3uWT9nZWbKYq8HlAg2P7C3z01cP9iu+L7Gfd0Tv2uANT
ARC-Seal: i=1; a=rsa-sha256; t=1519411077; cv=none;
        d=google.com; s=arc-20160816;
        b=gziFms0k629ecb8VkdzFv/m+aG68GR+gNv4EKj9e8EtmM+OrcSOdKOnQ1Flqbc721x
         l1vM616h7+6veymzy7N02COeNEwBplV9VYo1cM/8o/dUpBPMOZu8iCz6ncJz+Q9nD8He
         j3ZfOKRkF3Vbo0yUW4Nltkcx0MeFet3bvZhRURuUKXkLkEcZrtGisYS8xRhrhCUYdXdc
         uWbRLJDywhhTSSdm6TGODOEqXmYKGw9LSC8TcU2781+ikaev+EjYEYBr99sg/aR/ZmsT
         9XLkCmMXOt2fJ86sIq4UvN+G5QisLuzGmpAFvv5ub7K1eASgs6eugys7S4KO+ZtgAbxS
         SrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fGBfNzUHSS5sXTDA+6wsUzZZSR+266G/+yLrnmKJTy8=;
        b=a06wX4hw4iJEB0vsVFh0uOoy/9qSFuoNtATyVxGLVMhx0gIog6pSm2MPkLH13TOL4M
         llVXd7SxyMqPyuSIenCybB5gx7rA5JEWILHz1cZatuNYkxdrQ3RIbwgsl9ujGWq6J7GB
         93Pyl5rNdUCAj74WaxoroFIbJHSs2q65w0a8I0pOivjiytn/8r1ULEMovUsbwnisWQhb
         DMe4FS77cb73DoTs/LYaVJv8jDml6fiRcfqDYEvpKf2eMU0JJfgG+OHk2jInSJ3kmY2a
         Q0PWtTn2f4YCwJYwjyBCS34BMYrw6Uqf3sdVST2qaGmEgTFkZrXCO6iFNWrievBgwuoW
         l/WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 076/193] x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG
Date: Fri, 23 Feb 2018 19:25:09 +0100
Message-Id: <20180223170337.929638064@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217990527842136?=
X-GMAIL-MSGID: =?utf-8?q?1593217990527842136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d689c64d189e43d782fec5649fb0afe303c5b3f9 upstream.

The IOSF_MBI option requires PCI support, without it we get a harmless
Kconfig warning when it gets selected by PUNIT_ATOM_DEBUG:

  warning: (X86_INTEL_LPSS && SND_SST_IPC_ACPI && MMC_SDHCI_ACPI && PUNIT_ATOM_DEBUG) selects IOSF_MBI which has unmet direct dependencies (PCI)

This adds another dependency to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170719125310.2487451-8-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -391,6 +391,7 @@ config X86_DEBUG_FPU
 
 config PUNIT_ATOM_DEBUG
 	tristate "ATOM Punit debug driver"
+	depends on PCI
 	select DEBUG_FS
 	select IOSF_MBI
 	---help---
