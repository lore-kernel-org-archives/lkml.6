Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227xsAPiBtyzO7m13gV5Fbk6gh26LqHAOpQ2zrpDPsmdeYEMdPOxUwf1ldG6Mv7m1F+s7Lvh
ARC-Seal: i=1; a=rsa-sha256; t=1517855072; cv=none;
        d=google.com; s=arc-20160816;
        b=kwZhb+rYnKWYmRHNInQfD49YMQziq1vCxZc1tIn0iJmjCKoKUeYIRbqAjHS76TyYG0
         gBVdJo8EQnbmgopkN0AHVI0eHlMrdnWquFdST6QxEfeVjGkH7PrIUq7/DHNUzJU36Jm5
         ijqRVKgyVCCrMi6nVATvEwsDk7wMcFCafgCZlS92Zl5nj2pHMuLKa+TF6wHYNQ6DI8C+
         8vNZmU6A4c1mTWuZ9SvnscdMf8o+MR1m2DnSF127cTXw4sfh7q3DWK4uVKVKumzZ2IOI
         llgAD+fi9iKBKV3fwi69w8Il5Py/JSd3U2bETOeMfEV/9TeLkv9ojqvdvji1+AC9ToU0
         KO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pveBboIOx+Vg6gGkX4w3pApchEvjKxF/ybgYf0Ax8iA=;
        b=obzfzaeJnEorYlSo7NPN+qjm9IUiK5cG3d9up527a0vWQyt83y2CjwISTabA7xQSYX
         X7ebEiA7p/Q3vx8PMo70mBbGXK17+yf73Loe2PpT9g1OOeNlUULoTUMYYiayqXZ6gYOk
         fcRnkURP5D6FxZLHter/OX+bK6Lzgoz4TT9XGlZH5t1XZB9h0P+xlKFALVLbn90tBuI8
         f6d47iB+BIWsTtt/iGGdiARr7u2DXrEReXx92+zPf5PYo9Xwpc9WdkkyA7TYoQAQwDP4
         8gBe/HUg/uvjo5vLeKbnjMZ+OS62QdPjraEv+Xxr1E5POL9pWxXQBoRHNvSo0R284J82
         8ivg==
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
Subject: [PATCH 4.14 57/64] x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL
Date: Mon,  5 Feb 2018 10:23:16 -0800
Message-Id: <20180205182140.919464937@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586401088854671?=
X-GMAIL-MSGID: =?utf-8?q?1591586401088854671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
