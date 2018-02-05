Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225+LOtZyrE6Q0A4XlT6aQi+nq02pufGAJR3eG+jgSQEjC9D9GTnheab7LRCZ8RI59LGFlbu
ARC-Seal: i=1; a=rsa-sha256; t=1517855150; cv=none;
        d=google.com; s=arc-20160816;
        b=ErrYJCRT59SaI+0jXTxf7q4qa9UwZNBoCB4tk/9EbMIWxYPouruKjx2n+KcyCys5qt
         OwR9BF4ogagiFBJOO7zDv6RqvQOB8C3Y33b0Bf75yhPqSq5y5U8g9FULc1tJ1ScmlgBv
         94WHK/LSomb/CQVSdLWXrE/ikUkIaUUVkkcmdOWARclxuGq84dslqVb+2pMYl+8Dx2Lb
         qsPyHyDRtW7H0ZuWC0D0SKA7zLxdPPYWPfJ9cpsVlbRR8FTr6i9vyaZEWT7R5i/pkYHv
         zTc7H1ES516j4l46YA/Wk7TpXlKoAxSBAvtlPPXXWwUrTU7x7Nnymx6PH37ZCrXFG3s0
         BeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vNpWLpvqN5ADT2UNETX2aKzg7d1TSA/4MP6lVfdfZGQ=;
        b=G4VF3EQtAldC6AO6oK4DMG4gyz2rN7nQoUi9/jg8FcnZKe988jSRq3pC5o2WLEnDKs
         WbOmoYKTsKfPvQMhwY2oUiA+evJSbRfs6jwqY7OjGURQBzxVQgh69TUEP1q1pm/hCjMP
         SPswibVoEMM3Kk1rMz5CWkdWrCcmkh1mt9cKtwdFMjpYzzMRgjW7JM2xwknl/LDSfXxi
         Ba2RHUnCNacYZGiGNyjE3QvSLlMabYDkTnKwbf/7epCwDe9GnoByVXFejla56lIm9veV
         RwC9WknDd8fxwi6tPAzgdIZ9jLqw3NiIe9eWMq8rJH1GjH3gBKV9XlG5f/Lo+WNbXp/B
         i6rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andi Kleen <ak@linux.intel.com>,
	kernel-janitors@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@suse.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.15 44/60] x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"
Date: Mon,  5 Feb 2018 10:23:17 -0800
Message-Id: <20180205182215.788719112@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586390342782683?=
X-GMAIL-MSGID: =?utf-8?q?1591586482089191290?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King colin.king@canonical.com

commit e698dcdfcda41efd0984de539767b4cddd235f1e

Trivial fix to spelling mistake in pr_err error message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180130193218.9271-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -103,7 +103,7 @@ bool retpoline_module_ok(bool has_retpol
 	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
 		return true;
 
-	pr_err("System may be vunerable to spectre v2\n");
+	pr_err("System may be vulnerable to spectre v2\n");
 	spectre_v2_bad_module = true;
 	return false;
 }
