Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsDv6taNOH707RkIfP93mVZ31V7bnTVH1+G/iWMnuxz7dwEQzc4oUONLK5yhjGM+6CdpiQ2
ARC-Seal: i=1; a=rsa-sha256; t=1520824075; cv=none;
        d=google.com; s=arc-20160816;
        b=KY2ylFrmexBgbJa0v39DT9eANIf7Y8oTP9xKi6Jd06wYFGm8PB1OmzSPO1AyPsGgnF
         M0gpTh0C9lwUJ9OmUSklaDbEa1ZN2h5qIkNeg4HS6dRF5yHjkRVz1ZsML3Vste97NKO1
         zWtxjTdVuCTgmTF3zX//higOQbVCgY7fIDdvtqSZ28m9pVUvZU7Hu7n3aHwQaKDKHrhC
         RU+gXJoxij1zAb64yTELRICwaCMA9eSgV049Qk20EtUcqPXDD90oGgSXDSRrcJz2eNZO
         AfrmWgpDR2nBHfZYLVvXSA6gTMb08FcZh1nlmBSSvcgVu8HkbEjH1jkI9lV9mhUBzoII
         NJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=0Tt4pbzt75ZgmRh9teC3KeHNsyOPJmQzycQESdpe6Ms=;
        b=blqVMohQtsd9siVdnIREXMrxiD+YCVPXCN/6ZKQDTmzduBQ8ZGO2GBHdsFmZiJvTVr
         i6HF6RFFzVT8CfcEijyLsLTdo7WbWNn2054Z6T6pF63h6j549ngInc20BpcQFThL/1GT
         zVURjzAxFz42o5hhxsq5kkBs58OvxqiIGNgymPdpikhtoYKKKIyepUqnNx6bWTy2xEme
         3rvdDH/4FLOkryzvzaQjHupBjqOyGOZUlBm9CtC3bWosRj/iU8q6QwTA+1e7QkDrINPB
         vpDr3lZc/Zx9NDEGnN5uLjzO5WyF43VkBW65rQirvBPkvx5m6QcBBP60GQiZhJvgJb3b
         68DQ==
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
 "Andi Kleen" <ak@linux.intel.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Colin Ian King" <colin.king@canonical.com>,
 "Borislav Petkov" <bp@suse.de>,
 kernel-janitors@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.477750558@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 60/76] x86/spectre: Fix spelling mistake:
 "vunerable"-> "vulnerable"
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699609906663728?=
X-GMAIL-MSGID: =?utf-8?q?1594699625247012414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit e698dcdfcda41efd0984de539767b4cddd235f1e upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -165,7 +165,7 @@ bool retpoline_module_ok(bool has_retpol
 	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
 		return true;
 
-	pr_err("System may be vunerable to spectre v2\n");
+	pr_err("System may be vulnerable to spectre v2\n");
 	spectre_v2_bad_module = true;
 	return false;
 }
