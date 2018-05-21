Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqvEcPss7kAzqoEqs38NOZ3WLGuyoc7sMrbKJngoZwCXAiTwvKTu0DerJ4JdJ8u46qgQhLm
ARC-Seal: i=1; a=rsa-sha256; t=1526937396; cv=none;
        d=google.com; s=arc-20160816;
        b=QnBiy/acRinJAerwQj9nLten4eF8XmA1VRQpklY8LPi9MK7erRWshBiKVvQk1w9/ev
         IMKBHeLKA7Hfa7BNqOj5azhSBsEVmMzxutjvszMEEDKFOlBfVISoiyBXjKHBeCkssmLG
         /qCer/f7VUiKsj1bNnW99yPoNbvMVBmik5+Fr1y/sTWY/0faLbgJ4az08N7eS5SNgiX2
         ltZqWvoxuXjHLMH5yUSCv7OaDNu0avVLXUTHhqmpqSVlZAy3CTaNAfbfJO+6rVMjF91B
         ah9YnIPcttmRN2oNR1S8dQBSusXAnCapWY5waCoBfQOmiEGfue+imu53PnwUp+rGPcF3
         tleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=94PwRE5RbuvWYObCmGvtf0RZAMzq2blWKEPDjSWGcQ8=;
        b=nGVkvTIO0TTyHjz+bwADO5LDFoxyr39gNP8LxYkYkfEGHllKJ4rQhmJg3uIB6A5Izy
         MfImEpxJigVamZzbH4Vtj9/460UeMNmLxf8UoDspAkpOiU7H1o+37MKP/4gN/bIKSZ9U
         u1yhKhdwM3g9tMdMVQwWlX9fYybZS/ctX7coJw3cch3FJlyP6MpnLVfrEtZJVQWocsTr
         uSI7GvcK27z7sUlhvJbE7b4jVfJtll4YjwqEi1/E7cK47PxKqUMKUQiCF7TjvCtjYQfU
         G0DskXnXn8PyG+t/2FtDfb+LegDjHI3W5UHGlgpEF5roCJqDEZfd1O9bw/OJDMqIUyKj
         pKXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EYUDoYkL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EYUDoYkL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 67/87] x86/bugs: Fix __ssb_select_mitigation() return type
Date: Mon, 21 May 2018 23:11:43 +0200
Message-Id: <20180521210426.022697821@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109906725705241?=
X-GMAIL-MSGID: =?utf-8?q?1601109906725705241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit d66d8ff3d21667b41eddbe86b35ab411e40d8c5f upstream

__ssb_select_mitigation() returns one of the members of enum ssb_mitigation,
not ssb_mitigation_cmd; fix the prototype to reflect that.

Fixes: 24f7fc83b9204 ("x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -467,7 +467,7 @@ static enum ssb_mitigation_cmd __init ss
 	return cmd;
 }
 
-static enum ssb_mitigation_cmd __init __ssb_select_mitigation(void)
+static enum ssb_mitigation __init __ssb_select_mitigation(void)
 {
 	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
 	enum ssb_mitigation_cmd cmd;
