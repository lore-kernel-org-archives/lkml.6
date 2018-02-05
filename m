Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224dKZYVR0ejqitlgsWs25ZqS/TPTo9Htc9ZRyUNQ02gfgBX6ZkDbEAdHeqp1cgugcB2DJWV
ARC-Seal: i=1; a=rsa-sha256; t=1517855164; cv=none;
        d=google.com; s=arc-20160816;
        b=vgP7zrFoVGODj68wwoLb6vyZmO3LRiJZQaxxpQs5Usg28uJkH0voCkjlUu4YSn2Ipq
         L8YdZtzEaPg8AU6BKN2/85ikno4qnu+klT9v5WmPhZVii8cDBoGocZi1i/y6lYj8tUZ0
         W+4fgy9K1nhZiS7Dhf+bzJdqcc4ghsASLK8d87k4+xNqrc8mRMrD7mMduJHvsN2SUPdh
         D3DupLaBAfeOXhWtX6gsFi7UoXxzsATa9CZ6DBvd+eQL0yG9QcNmyHKvEg2rKqOxDsjT
         Kk6979KBBvdy6LFo8XhmgOEGthSyH13OZu+jKgnuPS4cyElB15yOkM5E8JEL6RutGu/r
         5WAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uf1cdP+LO/sksZnLqMycFEl2zJBIQzYAEMWuY8/BOcQ=;
        b=mHk/JuEvYHqEKzguI2rNAde5Xz4GUrrigVW7gRygoDad2nY0hfkAaLwaUoviXFXYbO
         +MCGNlWvNbd8nqEa4EsT6hThW2RAb1e78fcfzcZfXGoBNWEIKThEhdO1kLpcPIepWxI2
         khkr4V2U1BXVTtAyHhuW+k6NIKdaDfeaWF3e3GDi99RfrvEwgXmRihSbjBbgiS/paVGn
         UY1bkG6m1FXCubUiEwjnw7vJjY3BkNqFuOU98NdMAgI6Ip+g2CoTcYKg7swVW/p8omU9
         T+Ab3qkznI2z2du6PLjbNcWarSmkpUepBr/vtuW1345Z1CeFwYF3xjNle/070AE3uzVE
         1gjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.15 53/60] x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL
Date: Mon,  5 Feb 2018 10:23:26 -0800
Message-Id: <20180205182216.639155003@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586401088854671?=
X-GMAIL-MSGID: =?utf-8?q?1591586496574575383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darren Kenny darren.kenny@oracle.com

commit af189c95a371b59f493dbe0f50c0a09724868881

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/nospec-branch.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -150,7 +150,7 @@ extern char __indirect_thunk_end[];
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
  * retpoline and IBRS mitigations for Spectre v2 need this; only on future
- * CPUs with IBRS_ATT *might* it be avoided.
+ * CPUs with IBRS_ALL *might* it be avoided.
  */
 static inline void vmexit_fill_RSB(void)
 {
