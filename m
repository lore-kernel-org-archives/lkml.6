Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227MNzJJ3Xuz6BXqNQ1kcdHhqyj/6TVtjTuSetzI513qDIyUkVOKXEah8KUVVRIGb4vC/Ty3
ARC-Seal: i=1; a=rsa-sha256; t=1519411297; cv=none;
        d=google.com; s=arc-20160816;
        b=sJyrK8FS3WO9ten95pMFX2eLrYmSFzUqsuuu85bjqZP1Opv/b2bbcEaCmEBDg7IMXP
         4MVaRXzy6Z3Xla7OkmOPdJr+7IWZtcWo4IzW8dWO/8N0/rIy4KuHbZMowwyQ/T5sPNra
         l3HzIE/wzbu140ZGCbwVi3g6afuPALuG5wd8n67CRO1erTYL+fGplbiROBhII1e2Nn3K
         Ludnaf37YHkweIxAuv0JJ9MYxvmfMsuGMTYERKtFzFyVgWlqH4nmEeSPf+F5r8uXqkQS
         IYYP1Ug9UJe7kRHpURXCi2skDCgQVM476LSw9YmeAzOrz8EV4fFJ8TYcNAazulvcKiM3
         kCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lhmburIWO9BBbau0vcyRcENk3IaBYJJJuPe5SUKftPE=;
        b=ek2OKepkHcYrRlHDz9VXaNvXQsI5zhk936tabX/CltvBIKKqCzZfMU6BuMX/WLRUr5
         IUreBCDQ7i+7ImjJkdXvKKAkmwSG6r5W9hqMOqGn9pClm6EITsAxUkBb7xYOb85SY/AI
         0pSmlHPPxyZOLFpmTjfUBRYolX5bGunWEkefZlD6FgRusN8umeF4dwByyvIvqY9xJWkM
         2L4IoCVzBlZ/CKRAcFQgFNY9aA53lkRAsYyAw9PTlvx5+03TsVgMZEpqb8e2siaQ3ihl
         gzqhqL4y5S934wYsTHRuhVvhRvhsHcsymgNzZI1b4PHfbSDV0mkpCTGcrJmBmkLRL5WG
         KsqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Darren Kenny <darren.kenny@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andi Kleen <ak@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 187/193] x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL
Date: Fri, 23 Feb 2018 19:27:00 +0100
Message-Id: <20180223170355.509844048@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218221312772129?=
X-GMAIL-MSGID: =?utf-8?q?1593218221312772129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darren Kenny <darren.kenny@oracle.com>

(cherry picked from commit af189c95a371b59f493dbe0f50c0a09724868881)

Fixes: 117cc7a908c83 ("x86/retpoline: Fill return stack buffer on vmexit")
Signed-off-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180202191220.blvgkgutojecxr3b@starbug-vm.ie.oracle.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -178,7 +178,7 @@ extern char __indirect_thunk_end[];
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
  * retpoline and IBRS mitigations for Spectre v2 need this; only on future
- * CPUs with IBRS_ATT *might* it be avoided.
+ * CPUs with IBRS_ALL *might* it be avoided.
  */
 static inline void vmexit_fill_RSB(void)
 {
