Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2265mDvFzDlk4wwsBYcTIiwYDWwrXn/JEzA1TS6izW1elmv2CRxJ0BNfQG7M7ys4JwwhxqlZ
ARC-Seal: i=1; a=rsa-sha256; t=1519218112; cv=none;
        d=google.com; s=arc-20160816;
        b=CpISjz22572KW6QRTgki35DfougpaTS91hJRR1KZoY9k28c2nTXYcQFYe09G9EmNZf
         xOG3AjHckSgEfKF1oaHSvXaS5iilqFR2lZMa0VHy5G+pCBxYFF6z13AxMnCDMNluqlX9
         E+hRX8zArPkzSj7YN/uKA8TWAPCNYEapejFcRjmVvsoY2zKFkG/vD+uQ+OfFQFOvSl6o
         V8scLDFNuswMgpc3zKTzLB3PkKZ65BNIvsZ7WzZ3bmX1COwghVAt5uuqAUE5FR6RCjY/
         lJdzZZGIojSBBccCyrP14KIR4bS/ZnnXeLC5s+J7qAcXNO/nWS33iNg2U5pOtH06uoz+
         Y6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lJeCkG6iDumcP6g3HU5Rz5z1m6b29uGhB8AWLkpIkhQ=;
        b=Daual2KNY7yI4tZpX+t2XTA80aUGiSrc+1oYY3SD6sxqDpJnHSTsnH2Apb3DrlMZzi
         gtLyUjtwsrt6otDR11Sj+Ka+bmWsXm6lCoOs3gfFv+fRSR1/VtNYP0gI7ZHmmH2Yxv8e
         lVNuK/F8eeMeTXvRTmgdWosB5uKvVItavkwJDrf1f0l8a6FcwveCGhYpV0+H8dKMK0cE
         QmsTxhcOaTLJEdbDiJRupFZQEjLtrCpgqy9hiCBNjieNprvoBFi6ZoEiRKCNS+ngfkzG
         e9nuXtYk0MPMGomQnpl+65QjVEfzOEa143dLNvNoSeQrrPu2lKG6OzKnHkVZ3qwyiRv/
         AoVw==
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
Subject: [PATCH 4.14 087/167] x86/spectre: Fix an error message
Date: Wed, 21 Feb 2018 13:48:18 +0100
Message-Id: <20180221124529.159324497@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015341628696897?=
X-GMAIL-MSGID: =?utf-8?q?1593015651652494235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -174,7 +174,7 @@ static enum spectre_v2_mitigation_cmd __
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
