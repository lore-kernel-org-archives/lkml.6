Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuVVfTmo2C9BcXnJ3fyqCCG8C6DuPvfaUZjVm6kadOOZLRpUYjVJbaprSgNS2eX4YtgunJV
ARC-Seal: i=1; a=rsa-sha256; t=1521214285; cv=none;
        d=google.com; s=arc-20160816;
        b=ArNxpy865wxWYnxar2pJx/BthzCi0sOynLjeC9HzyiooCfpAIcVo+2CGQTloqFVgBw
         41ICXBM0OrTc6gp0yOZqVFuwD7jrDALHp9v/5c4xFQQ4Rjg4yY7w6/eE2Jdap20mFxC4
         2mAE9cHqV9bYNhIcnN3v5wJGSL3Frj9DqsHxE6WZ7NvttNCHftChtk//Fzea25oWYU9M
         Oz286WW+FMWAOx0ykCPhv7brH8bxyOnzFfl2t9MNWFo4HuYIs91ZYCAzsVdLlguDMRiE
         WEwt+efVAZ8ooJWrIlzGYi8yZNHSIKb921urikAnuHocn3C+FO7/4zmyivkD/ZZouCSS
         cE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gytr+Xd5NT33+Ni6t3/IRQ6h6n60GaacKJiswXljZqU=;
        b=FY/0osFyYkC4YbTDEJ6rIDYvWNNDtlt2K45hKNQtd0WJnIAEPwh0nsewGn8Uu/IOVL
         aMq1CYet/DZDioq6oPQjMaWVKaFHth1iRsX22m5OXZ3oCkW8db+JxDBXXKSR9zCgdQWi
         UDQ6UrhQitpHndQjiXiaLIe2wqTEUSxQFmQczINuL/Z+UWy6EYdRXQTerCSa16xllHdS
         /eQ0KJDN6B0GyRDeiJ/s+oDqkS5PoPJWjcF121dyXP9aLFzcDGYtnA+JMMqbLCWB2Qll
         dhOJcE95YPXOF92j5itYfWvWaPnDTJwOIWNqz7/gIXPf7r137RxS7kfNcqU5/m1gjL5Y
         39Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.9 39/86] nospec: Include <asm/barrier.h> dependency
Date: Fri, 16 Mar 2018 16:23:02 +0100
Message-Id: <20180316152320.039234992@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108559026857789?=
X-GMAIL-MSGID: =?utf-8?q?1595108790801741788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
