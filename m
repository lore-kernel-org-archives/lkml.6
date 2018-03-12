Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvTmw9SvswBTC0kNFu+7a/TttqvIlgCVWMhjAi8cH8wE9xF/stnywPqANTrN76njVAiEU8+
ARC-Seal: i=1; a=rsa-sha256; t=1520824060; cv=none;
        d=google.com; s=arc-20160816;
        b=V91mPOvgFXylDZbjFWoIGz3+u3VmjBEIn6Ghn9WLuE6QNuQMyMHz4LeqELbCiFivQW
         NiOz0W+awAbDkLG5Cm01RHprpSlf3Te5IQC/4b2HfQj9+jeU7Pc1h6ONVgbXgEVpL8ET
         ASidmIffsteSVB1tQYZeJ77VWSTDMZxBAsM7xmrEycUotsHXHjvLKwZL6ePU8EJQ3wNL
         QeSeFaSm1a8cX51dS6Ic9ltx2QO58EO5M16yQNOM65sUXMOoN7DzJ4bDqvaJ/5aEtjDb
         I3W/WPY5wuNzFc4NRO194TCPnETi1hCDueW2XlSLn4MqelImhAqnlUw2OvixMd28nW9S
         bWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=mavnszmK86PT2iamtOmHgfgsiO24cW1Ze8DxIqaV9pc=;
        b=ZgLmfmcTFaOV/D9dkeqGtjxg0wjD/TTiHn6CHJcjGRdNuzVg2NnQMMPR7IIW+qJ9cf
         lyPmpBpidanyFV2A51tLFSIlBw4FMkj4GdHDeLuEssrlPe2p/NzcWazchSDuzzwc3c/+
         XdHMOL7BrN1wILdGuheQlg19LStpYKfSuyJhhUmwThC/ikOIaG42uC7c2bcDOpCZayuA
         TAXMEDYVmB7oXaSPiHYLVNzz1icY53glmBsvAwkTBi+1SnIUwcme7grd13B2I0p2QCFq
         Z9yKsf6l2YdfqCwCvRr9+aX7hKT7OFhjh8FeLjEUCRxXUu5BmAmmG4m7hcH8qIXY4cmE
         90Ng==
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
 "David Woodhouse" <dwmw@amazon.co.uk>,
 kernel-janitors@vger.kernel.org,
 "Borislav Petkov" <bp@suse.de>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Colin Ian King" <colin.king@canonical.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.368865130@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 090/104] x86/spectre: Fix spelling mistake:
 "vunerable"-> "vulnerable"
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699609906663728?=
X-GMAIL-MSGID: =?utf-8?q?1594699609906663728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -245,7 +245,7 @@ bool retpoline_module_ok(bool has_retpol
 	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
 		return true;
 
-	pr_err("System may be vunerable to spectre v2\n");
+	pr_err("System may be vulnerable to spectre v2\n");
 	spectre_v2_bad_module = true;
 	return false;
 }
