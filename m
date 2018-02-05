Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2278bN6bLfP3w/GFr/9LaxNsZSL73taGF4i6QJkR6c7pouQrcAiFDMBN7JVIYXxtMDSxzwcl
ARC-Seal: i=1; a=rsa-sha256; t=1517855015; cv=none;
        d=google.com; s=arc-20160816;
        b=Rc6wxaTjP4PKByVnJ/p587XT146irHc8wizXE2dPxJmoYm19jBCp2+UsFVinScfGn/
         c8SCf48XzRqUF/cvJVYFqfiA8Ee+hSMsiViA3+ggIyGOKJimjRLZFwMJ4iR7y6Bd4ecD
         iyxZFuY/CgWg1ZJeDqr6kYWCfEbU1MYVvXFUpV+WK095MLch3YtYbINJdK4AWfJeKdF5
         amVoWXEKNJ+llj7HLVv8eEHhAk5wchiqsyftekxsg7GSMT1Hoh0zrPYGi1MNTLwGdiPA
         2ujKhL0QxQLxLkbbry0waZaQ3CkSxr5Az4Pk+cqBFgh4DEzLZgwbHba1B75vx1fDeypH
         C66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V0Mjd0QZsTygTPzdB5lsao7x4HWvWh5AfCDQiBrSi9c=;
        b=xkDcKg/rFhZmniFjW1UK7btcDzWQU7wNY+TrOWbk1yFhxwAAhThnvDkauVpFn4OUmC
         nnPV9LYKP7IQbe0PTiTMpsOL32D8zNb+7n+VIQsNqeyGf2Nag0Gs2Z49I7eM9E4uIUVV
         4z+n3g7IqHWIu8cIGUX3KRk0QYkSq0rzqfuVgA9FH4MjZPlKpjbwv3c8WIP9RcBrHiqM
         PS/9/iO+0JTKRZEpxXtMbpHiwnYxoDNiRT0PZOHW9cqkZAS2SB/8Acq/1PoNKl42asTo
         Rm82USkj+OvvazsyrHskb1t5UCybKH/ODvWb4fqSjYIUpS7gUjvKdyTVEiuTc9NhAkWx
         IwYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
	pjt@google.com
Subject: [PATCH 4.14 17/64] x86/bugs: Drop one "mitigation" from dmesg
Date: Mon,  5 Feb 2018 10:22:36 -0800
Message-Id: <20180205182139.271236875@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586340397070487?=
X-GMAIL-MSGID: =?utf-8?q?1591586340397070487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov bp@suse.de

commit 55fa19d3e51f33d9cd4056d25836d93abf9438db

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -91,7 +91,7 @@ static const char *spectre_v2_strings[]
 };
 
 #undef pr_fmt
-#define pr_fmt(fmt)     "Spectre V2 mitigation: " fmt
+#define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 static bool spectre_v2_bad_module;
