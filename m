Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2265FhTaX2kQlqBGlKyz1aofeIepH6KFeXybkCUQVPctw264YMN1aF2SOFkS6x8EadKmNLcX
ARC-Seal: i=1; a=rsa-sha256; t=1519217816; cv=none;
        d=google.com; s=arc-20160816;
        b=HxiB7ZiEKuqx/Hqjn2CXsFjtisTN5ZHQC9cwbX7J3Jbre4VOGWyFwye/EJDcWKDQel
         T7e9O81lVKr7Uiwcp1GzSC7ZwC0C7waT/epnFkltODSm9XZJXFFqzIF2Ol/IcWkpYxj6
         x1kNe1V18qzbx0QfSpVL4iKykQhXyVaEuycs5aApQUdDB1fjNeSrJxW2fysfNbe/M23P
         qpmVMIR+gwMNnKH7B3gr7n8rGXXHSoIKHJW81ptW0cMKDbI5o2HZR4My/05zAXXnxLko
         5D7o/VoKKJi2ZaIKviuGvsawARA2OWpQ9wqvF8EwbZmNBr3sPQ8qYZc12gQbnwDnl9gg
         hkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hTd2SkcZfUbYvMxoxZ96XQdbKR63JPzdBYXQ4WpJCcE=;
        b=YN8coMB3hxe0zV8HROch5SQB/i8G1Pg8uwasTGxFvEJN9FBdNO7W8nJNa4FPOdU3Tb
         1TCATqwJ7CnkNhTx4SK8QHyWY5txPKOoVprPDjRaj36UoFZaxVbGlE2VsnPb4XhBaqUG
         fZ6mgpwyBRc1awON2Qz6dagFEiJCKxyeYZPAvuJESojBgfHqRNSjMu4iyu98xvXR4spr
         MaibKT474pCKsavpOsqhdVc17D6TZtgnOVqyxZNhuNGD916s+81Kwzww+5Y1jf6p/R4g
         eWIqiSjwmC+lBgdYaig6jyd72O2InXL1Imkp4UPT/T9+hdeAdGvj7m5+E2CyvFTbFMfF
         zTRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@suse.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	KarimAllah Ahmed <karahmed@amazon.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kernel-janitors@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 65/77] x86/spectre: Fix an error message
Date: Wed, 21 Feb 2018 13:49:14 +0100
Message-Id: <20180221124434.946852327@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015341628696897?=
X-GMAIL-MSGID: =?utf-8?q?1593015341628696897?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 9de29eac8d2189424d81c0d840cd0469aa3d41c8 upstream.

If i == ARRAY_SIZE(mitigation_options) then we accidentally print
garbage from one space beyond the end of the mitigation_options[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Fixes: 9005c6834c0f ("x86/spectre: Simplify spectre_v2 command line parsing")
Link: http://lkml.kernel.org/r/20180214071416.GA26677@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -173,7 +173,7 @@ static enum spectre_v2_mitigation_cmd __
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
