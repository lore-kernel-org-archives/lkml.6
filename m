Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvM2Ryf7dv2q+N/SxUX8wF9cBfofS3WaD3lH+zB+IiQ0S+dXH5TNPdkzxz30p1pc/r7Cpaf
ARC-Seal: i=1; a=rsa-sha256; t=1520824075; cv=none;
        d=google.com; s=arc-20160816;
        b=e0nA39fAGLnYOWCObByn1olsIw75LV+MaUyrXvKfjO7HASbYCMMxC9Focy539eVOSg
         7oNEoHd0fMT2OSeQwRTRrcpeqMI6lHhs3yP4Q8ku8yM7x6jXAZhBHN12dZorHtQb8pC8
         OvqvAPgmFx4MyIzyqsyw+dRJcIOnUeEIYUSgR6rcghlgAf+KAe13vFqwVKm9a6T2kPZF
         /FhThErFlgzkJ5FeGwgQKjgiiwlwQPA8/SBXNIqb1qlIEwDbV9wth7EB1VDB0H9s4y8f
         3f7p8XVMAbCpk45WgBS6lXntW4nu4HhVqBFta/H1eV/YRDTMabWZK0LuPzLsulW0gQbq
         slaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=6eQlss2n0dgZ5hN3dMrbJSUlHziQZjrPz840a8teMfo=;
        b=STCW1AAEUPcAlwb5CBYjWPU6hstE97L5wpIOiOVtkkanDoMsvApck9HE+7OF42+9Rr
         ZN1eb0746L2lNSdkUVV9o26QsAPDl+FIEVnWrufG/WMo8ALRmExoaesSsOUO18b8vj1M
         L+2mgITWnqecgyVpu1Py3s3rUXGvhXs4bVdmYWuaIYffEUJCsXG2M6Odfv6NsKxr59TI
         MyFXFzUzpceOVGpRpHI/FWN+rB9DTrD8r37ZrC9tctDsiYERK/6kRZpKo5XyW3xRTL2E
         rgyXs4wnUzdOUKZpAIQiEO3JEK2HI98+tZ+w0GkRzCBJiG98BrAW/5+vrqwfPsRWeQ4L
         Oyog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Andy Lutomirski" <luto@kernel.org>,
 "Will Deacon" <will.deacon@arm.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Christian Borntraeger" <borntraeger@de.ibm.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-arch@vger.kernel.org,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.664773192@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 70/76] nospec: Include <asm/barrier.h> dependency
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699611670700523?=
X-GMAIL-MSGID: =?utf-8?q?1594699625606201727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/nospec.h | 1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -5,6 +5,7 @@
 
 #ifndef _LINUX_NOSPEC_H
 #define _LINUX_NOSPEC_H
+#include <asm/barrier.h>
 
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
