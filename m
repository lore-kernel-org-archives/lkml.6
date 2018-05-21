Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp56R1BhvDbly9J6wybIX8uvXNPhe3VRW7kwRTzlv3qx0TQYBMKXMsyFzzPFRcfaZQr5DIE
ARC-Seal: i=1; a=rsa-sha256; t=1526937937; cv=none;
        d=google.com; s=arc-20160816;
        b=xqd/PUpvLi6iQ+48Xjr1xqEGeaTzBkZj7stPsV1oi6Q6k885PTRs8ouqxbkXizXOmz
         ljDsoV9o/5Q7Zn18Hc9UuOB7CqsZ6qYfmyZ8rcsYAeuAJT0vequ1dGu6mFHRA3Qkqe1C
         jE/raO6KMVyHkzSF4TylzlEpyjYqwXukfkNochMGAdUBluRuLQ/BQui4ZXgy8Klyh50Z
         HP1vOTTlwHtDDCvxb6mfI93hun1eX0FSDnxx0ebzkHz3aCnV+kcnbYJ72pgvOca5gg0p
         kz6bVJfKhMjwQzDCbaJ6wsOmWo1jyeLsJ1bM8nDJFebBO+/QxLxUGL1dhM5JnT3s5fbj
         9KkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wLTyQXI+WMKGdmzm+z7UZ7ym9jMYUfvKOG/YujwPtmE=;
        b=NTy1cvspCqvAmv1Kt0CfcevHDDqGte/rUOTFQbIAdHtIOsffo5YPCpmIrfi/8h8asO
         wWM2ksHgyIS2gKPXg+vPG+8Opw4yHDuZNDyoy8PpB69Fnw1oumiZSPP1nhUt8DwJxed5
         yFHmDXHXsfm4DUiFtYQ3WnJjpdvAlvgz6mZX8GlxKHa95uBA2mFprLpl9dzbQoEywjuw
         Hjd0oSt81OaIYydDHIA2Hg/ao0TuTWXHn0RMSpTH6lrEaStw6GoRea98rZakazvfCEtZ
         Bl6tq/LJ90I22745c4z95SrfJ6OOER9meOwj7ke0nnogFiSMzjk8LQef6OtwUx921W+h
         1QNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VROeeg8B;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VROeeg8B;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 081/110] x86/bugs: Make boot modes __ro_after_init
Date: Mon, 21 May 2018 23:12:18 +0200
Message-Id: <20180521210513.417039784@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109978852317350?=
X-GMAIL-MSGID: =?utf-8?q?1601110474811676615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit f9544b2b076ca90d887c5ae5d74fab4c21bb7c13 upstream

There's no reason for these to be changed after boot.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -129,7 +129,8 @@ static const char *spectre_v2_strings[]
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
-static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
+static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
+	SPECTRE_V2_NONE;
 
 void x86_spec_ctrl_set(u64 val)
 {
@@ -407,7 +408,7 @@ retpoline_auto:
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
-static enum ssb_mitigation ssb_mode = SPEC_STORE_BYPASS_NONE;
+static enum ssb_mitigation ssb_mode __ro_after_init = SPEC_STORE_BYPASS_NONE;
 
 /* The kernel command line selection */
 enum ssb_mitigation_cmd {
