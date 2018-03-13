Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsZPT8Vsr7RFHZUeBVGlrXRx4c8s+GfP6ZDYLmSgwMUNurDFOY3q23IhtLvImfi9bOEwLJy
ARC-Seal: i=1; a=rsa-sha256; t=1520955077; cv=none;
        d=google.com; s=arc-20160816;
        b=aweqzSB3mx/4WacmW3zg9WpEXzvGns3uNJbTM+Xe34MNPGkFImsyyiQPQCgUXEcGAC
         Dm9ikTB26gkg3E51xUSd84IsXqSlgNvzzoh3jsOlXqLsWGI9tT9clFGq8pEJX4b0jD+z
         WXJMcTBd8jqNW8oNEncRzSv2gxuV8S+O6HD5DnLahSdvoPgRR0b3CxUIpebfNVLMqjYr
         gN4nm5HuT4hDsU8yONpzykP+iu5glSsZf9V3Kv740IOYukCawsfAQQKTtJk3zXpRDFj9
         9L9kp7qwAUc1BPFEEgOLdBRSRiFpMxIf7ZXtLxYhO7WApM/j8non6mMVoBoCWNuNkrpp
         k4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Yv7ufM4ugw4KWdYmYza5M6i/yfBOsbuQYvRwujwMKVc=;
        b=oYcxfWZ90YclykbXTGciY0DLQZttami9keWg3LpJ7+S2POnzkij2K9dpTIC03WqlHt
         Z1YCtZk6eFO00p6/GLriGhhEoji1iapucM0hg1vTGzjAPrH5N1h/sXMgzhalF92snOVG
         HmbYMLgS0Spj1uSTJznk+46eq73wAQxnENYscS7R6Um/bpYeKi6duoezvZG0z6/0AlXT
         nVRuiTaUVod7TPDYJ5FUe7vUOlmyrxraxH2b4cZ9pbql73coPcve5EiCpcpVKd/vMHVr
         iaIuNjiCO2yjfo5lSYNcJze0ibGFY9uY0v3kWPr+HojurgKpQT4p+F3da43Py1jBj44K
         /O5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will.deacon@arm.com>,
	linux-arch@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 081/146] nospec: Include <asm/barrier.h> dependency
Date: Tue, 13 Mar 2018 16:24:08 +0100
Message-Id: <20180313152327.044053693@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836991288310180?=
X-GMAIL-MSGID: =?utf-8?q?1594836991288310180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit eb6174f6d1be16b19cfa43dac296bfed003ce1a6 upstream.

The nospec.h header expects the per-architecture header file
<asm/barrier.h> to optionally define array_index_mask_nospec(). Include
that dependency to prevent inadvertent fallback to the default
array_index_mask_nospec() implementation.

The default implementation may not provide a full mitigation
on architectures that perform data value speculation.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/151881605404.17395.1341935530792574707.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/nospec.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -5,6 +5,7 @@
 
 #ifndef _LINUX_NOSPEC_H
 #define _LINUX_NOSPEC_H
+#include <asm/barrier.h>
 
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
