Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226mhOU9M9+Slwzg4U1FEpsPvEIY2Tfs3KMy6wxnLTGMUK1tNAzyyeDIe4upicu3jv/QE8LO
ARC-Seal: i=1; a=rsa-sha256; t=1519217730; cv=none;
        d=google.com; s=arc-20160816;
        b=cXnTS5KIwevbE3nNzKRWRfE1brVJjfTEcy2CLgo3F6TfEM2j5FlPrxd7Vs27uSiF9I
         JTRjy/u1eoQynprU9W4TKU41y4Orv2lJkvWknN+F+XHx/IkP1E+SQKG/U4YDqZxQ6MSq
         VifQTweZdwR4MMQYGNXm3pWOFmQUbSeKcHEK/P1H2xnlxua53n6dLsKxx02DN5wya1d7
         gAAIvfGmpYKBnKb6TaL68QZAnF2rj1wl0VPMeawsrH6b3zcCp9dRgJ2Kfly5Fti75bLx
         WoQ9OmZEiX5TQ0OKZJ+7AWx2khhWD6SRyKfi0kEFG0O9Hwr4Y7hiCc9jnf3gp8TElMRZ
         ie+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pN+f9bnwmuLRfyR481BL0/pxTSbZAtnltnl+dYrRMdU=;
        b=DdtTJQ8wvVUR3bCsaQaUexdItTIc2Bd/+yeB2yTzAs4L/UltHW6/HGi4+IXPAzPCon
         rZbiykP3oEhXLT3rwQGKHAdqhJG3gyMyyCJ085Y0qR/BkOf4xbD063nf09gO85hRB1a7
         8JG0lQbxAvehKJ17AwZYryxCAulNuxzGtRyMqpMSCWYCVuqs/kG/NCax32cC7K8Qya1f
         0iEO3RrB3nRtSWb8sqR37oGyLNKW4OQ/dOOWovDgzSB0FpLLAVhRpn8Ga2ybRTbTLFLR
         x8DhgQNewfLrWVGpmF0Z3x0neS5eoFJ0i4c+Cdh/q2chdiJxWcIGuIg0vdQ9tGKQmXYY
         jJJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Yves-Alexis Perez <corsac@debian.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
Date: Wed, 21 Feb 2018 13:48:43 +0100
Message-Id: <20180221124433.618725458@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015251280374527?=
X-GMAIL-MSGID: =?utf-8?q?1593015251280374527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

This is just the first chunk of commit
222f20f140623ef6033491d0103ee0875fe87d35 upstream.

to fix a build error in the powerpc tree due to other backports
happening (and this full patch not being backported).

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Yves-Alexis Perez <corsac@debian.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Yves-Alexis Perez <corsac@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/entry_64.S |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -39,6 +39,11 @@
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/exception-64s.h>
+#else
+#include <asm/exception-64e.h>
+#endif
 
 /*
  * System calls.
