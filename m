Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELscb2W1aD+1hg31+s+UxR9knFUM5sSZQw3+zNqQ+OfuRm6tLLaGZ1GnUPe0mNo4QtTWLGGJ
ARC-Seal: i=1; a=rsa-sha256; t=1519411281; cv=none;
        d=google.com; s=arc-20160816;
        b=e47jM/xcgy4D2+E7OEK+srHjjP9k/QQcVNwmYzVYQytjjdwsqV7ko+lKPdIs8Wh9F+
         ZNzvBDi+N7znaPOI33vL1DN6NIes+SeA5b2jDylpN/2L5Hsj4UPh3VMlXnlZkUVi411b
         so0tWJ60DfdLfK/aC3mJHt43bGHdi5rGgS5ZX/Q3x8nr1yZhX4eW1RAvOLAyi/6uy7bF
         YT1NbDh7tnkIZChFmZt5pDiO+LyYJ/JIsY/5jOWjCsElyrNnHLJcbIMvIo1GQhIDWPDx
         RYcLDrlLTaJrFdkKtc79JKA8vhm/Bqg8cZpjLgZ607lTGtZeYsYi47JiYxFOI6F4zuVv
         wzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gkBm6haRVvqdtjx+vzoanzht5XcDN3k0xJdnksICsog=;
        b=e8iTwISfPp1Hyp7U3R05SdKMRxl1SY3yJVYgNQWTZsms1UeIdICpbLLc33vH31WEFA
         oKwkX6v4lzKTmvmetkmYdYTj1Wri/7xnooTyrA/JvIsQJt39mUCJE/ZBAHomXQDDpoz+
         OGmnfQzN+dF5y03/9t1HBRsn09W34l4NnUfitraMpVFb0TfW6YFrt+Dbjyel13N8AkGw
         fPX0qdm6OeYmqg/1J8vWyHcWmAU/E2x9jnpQ6X8cfRov8mMtmotgyFueiOfvCJbav714
         a+dUyFCweOEkj0/ud/ZCypgo3E4ulLVouti0TPdE3Q8sUd3oHnG38Kan3TgDHVLekcr4
         Sy9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 182/193] x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"
Date: Fri, 23 Feb 2018 19:26:55 +0100
Message-Id: <20180223170354.686167921@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218203987300230?=
X-GMAIL-MSGID: =?utf-8?q?1593218203987300230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

(cherry picked from commit e698dcdfcda41efd0984de539767b4cddd235f1e)

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
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
