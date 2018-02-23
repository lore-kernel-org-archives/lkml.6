Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224CIO0xuyI4rQe3pmPZiOPfwdCaTCLIESiXlT2evPzhxeomb8r2BNLuJ89W7h+YV3u5ozH2
ARC-Seal: i=1; a=rsa-sha256; t=1519411240; cv=none;
        d=google.com; s=arc-20160816;
        b=tR20ajDz+6IgM8DnovcejDtjQjT5oWn2P8R9wNdMmg7PTM6WXjP/qQg8gLmMbuUt/W
         pkmQTAXgIStFbPzEmScJeMTrAA2mYUeAceAQMMv+kLZLCzrOlZH6gJoNLZ5394bgWFhN
         zH/DT9YXXJTq6EDUAGf8wJIkGHlxMKQyKoTxeZ9pknynsxEtyBxXrANM9wR8BXewuEIB
         GxAyc7WZ3L9pRqDYElWPDrKiExBMz/j5nFNARUG9Oi/kSadShUf4/7mzZFNo1rtDBzAi
         mCNMezulwFG8Xqji3UezuH0m8OEtp0SSPDAUUuamAxFM/57DOkFANBKyO9HawNGdcmX6
         fS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2DVtwH5tlQvATW3ziZUpm0I4vJ/v+x+ltVzG15MLh9U=;
        b=0T/Bb/XSO6YUe0BL1aT4MxGmJCu646O58g0AmevYVlUOVI1XdCIBQ5zzNNqbYYj4Zp
         vaq3ZWFfHXU2C0pkH7XyqqYXi+zpYgNm1eGP6kaP/OFOodUaxPezliMpxEfDeIGNbXM0
         1F7iMFUmHL4QIROuzEqFpddGeUmb670xq80gtH9I+JTzhiC8y55LL50/wic92uG3YxSP
         p6y36zmUl/WttfDa68hC53NVLLlfs7+PCP/2sV+2nUOensNjz5DS3RTDMNkxSxY+htlN
         PLzOuZczM0wAB1S5z6k6wsg4ePRZ8m1lL6X2TNMk+hGcdmRY9BMT+61dl5dWWUbqQKtv
         3cDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	riel@redhat.com,
	ak@linux.intel.com,
	peterz@infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	jikos@kernel.org,
	luto@amacapital.net,
	dave.hansen@intel.com,
	torvalds@linux-foundation.org,
	keescook@google.com,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	tim.c.chen@linux.intel.com,
	pjt@google.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 170/193] x86/bugs: Drop one "mitigation" from dmesg
Date: Fri, 23 Feb 2018 19:26:43 +0100
Message-Id: <20180223170352.649818604@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218160873278595?=
X-GMAIL-MSGID: =?utf-8?q?1593218160873278595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

(cherry picked from commit 55fa19d3e51f33d9cd4056d25836d93abf9438db)

Make

[    0.031118] Spectre V2 mitigation: Mitigation: Full generic retpoline

into

[    0.031118] Spectre V2: Mitigation: Full generic retpoline

to reduce the mitigation mitigations strings.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-5-bp@alien8.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: port to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -90,7 +90,7 @@ static const char *spectre_v2_strings[]
 };
 
 #undef pr_fmt
-#define pr_fmt(fmt)     "Spectre V2 mitigation: " fmt
+#define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 
