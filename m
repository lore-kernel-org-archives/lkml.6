Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrDqdnsqiP2mXRjsvKZMx7MkdlZ1ZI2vf5CdpsB4cOa0w8lPFKTqG/qNxNXLzVAfRThtzQZ
ARC-Seal: i=1; a=rsa-sha256; t=1526937464; cv=none;
        d=google.com; s=arc-20160816;
        b=Xq2EIlWcg7jwEUxYqXCl58m9IWMwAQZpI1oj5zJBh4I1vFXXeUNsm391lsvYlwHq5u
         muFa7rTUVzC5MhQQXPkEZgh9TX+/wd521mtFKMIQii/t6iaSeey2TUjGhSYIZQZxfVZg
         aWQ5AmJU+eN80rfwtohrNB6VDUtV4oGRVSjpqZpjd6vIfsxZnyadwvaG1SP7CjoY0Lh0
         5l8zpyGxjJANl6MEM/FfCZsshqLsP2AAOiZ4SqShdTeHu7oEKYhwVHdPKyAEmC8EC+fX
         23mjiLk+xY9hcE6sU10hS7GBOkaqpDfOCwQM5TvoNsDcKL4JdqTyQNQUiJ4Pfn8enKmv
         kLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Osp5fIiBqkxJ+6fbrC9txzDDwfCEiA6UYl0JOkhX5wI=;
        b=IBOPYubsGBDh+1gB3Qd5cg9zLCk754A760/nJKYlr7XfUyVSAvVJxgZv8Bws6ZkcBN
         G31JCPqnJdN7TvRo7V93i+8fJSZ9HZG01coAovph8VUedQDQLAdBmiJdC6RqWtV5NGbA
         ugqZ+PwduV5wMJpXGGVS89hqUdjnh5x0/EGzWIZ/KmZSDc0iP1KFQObmPdq2CKtH8k20
         ISOHV0M6EzJAxbazOWBQ2TrbvrUXLv6T6t7g/9zPFeAncKsxCktRi3JLvYQXu3T43yPc
         ipabwuMa+73NJaxy+51shlzW1L7brZjC+Opcsdv9w6+3/v5l+FxlBJBvcyfn7i471fIE
         xgdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pIA1i19E;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pIA1i19E;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 58/87] x86/bugs: Make boot modes __ro_after_init
Date: Mon, 21 May 2018 23:11:34 +0200
Message-Id: <20180521210425.408013198@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109978852317350?=
X-GMAIL-MSGID: =?utf-8?q?1601109978852317350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit f9544b2b076ca90d887c5ae5d74fab4c21bb7c13 upstream

There's no reason for these to be changed after boot.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -128,7 +128,8 @@ static const char *spectre_v2_strings[]
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
-static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
+static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
+	SPECTRE_V2_NONE;
 
 void x86_spec_ctrl_set(u64 val)
 {
@@ -406,7 +407,7 @@ retpoline_auto:
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
-static enum ssb_mitigation ssb_mode = SPEC_STORE_BYPASS_NONE;
+static enum ssb_mitigation ssb_mode __ro_after_init = SPEC_STORE_BYPASS_NONE;
 
 /* The kernel command line selection */
 enum ssb_mitigation_cmd {
