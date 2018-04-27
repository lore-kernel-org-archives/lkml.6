Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpbo9DRZ/3ebnk68vkfmpY52phWHIEP/bjHenB++4UQZzXMZ9ahnoNFxhuJKmgO/1/Bw5/V
ARC-Seal: i=1; a=rsa-sha256; t=1524837661; cv=none;
        d=google.com; s=arc-20160816;
        b=HpKL45EKqDpxh59SC4R+LIsCW1VUnRkh5u/crXUI0MathIZn+cssS6D4k6N2AjDjSz
         YBq68QHMcWzVG6TQtfHlwLRJoh9pHPT3CPkq7WgSGaNgQj7QgbJwteyFYVjyHSLqKlKD
         ynqNii6WQIfzfb2kk78s7bN7qkKL+qXtJL0ZQprZlVpTAR+6csZUoIvRN7eBqAUspxPB
         +sDJ6BvrQKSORp/ouJJaKVoXe8T4XKND8o0dwynod9fNlSADXkesXSiKDC1o5TGE8fAd
         hNVx41lr5vQKvWpdNoOLabhxLZZy/RusMAsAF7jhnD9G5FHlNHwgf9ULEKdJMCQSlK/3
         FgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xvT5130txbvI08n4ZQKr9KM8AWlRbzxVCf6/JNs6M0k=;
        b=VlE5oxdT1mmhBlzQP/lr1dIE7WDEHUrjmPWrb3uFT/W9IxcZBXT51/06KPTtSGacaO
         nj7/uvE+PgqFqJh7NbWzFCPFQWLrXFCTIfXs4Ycmyp183dnnDI1qONQ06IL/eUDPLBcN
         IfkfJepcLKO0bSTcctYsP+70qg/AcQ0t9+gVzIOL1Sj+qe5duXSE/dsXLyDLohWgysxC
         sxnjwitk0Rjgl4JzUZt6Q3e02ckQph8f9RKrDw6AeqmkvTzhfexc1BYdAUeWq+XVed7/
         6JElx0cFJBWLVm7SdVCOjSkmzS2UirPaIW+3ICSSxQb13pwHgYL8J8ZFD1VT0QEDwLn6
         g77g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF1A21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 4.4 19/50] s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_*)
Date: Fri, 27 Apr 2018 15:58:21 +0200
Message-Id: <20180427135656.851589812@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908176269129901?=
X-GMAIL-MSGID: =?utf-8?q?1598908176269129901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


From: Eugeniu Rosca <erosca@de.adit-jv.com>

[ Upstream commit 2cb370d615e9fbed9e95ed222c2c8f337181aa90 ]

I've accidentally stumbled upon the IS_ENABLED(EXPOLINE_*) lines, which
obviously always evaluate to false. Fix this.

Fixes: f19fbd5ed642 ("s390: introduce execute-trampolines for branches")
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/nospec-branch.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -3,8 +3,8 @@
 #include <asm/facility.h>
 #include <asm/nospec-branch.h>
 
-int nospec_call_disable = IS_ENABLED(EXPOLINE_OFF);
-int nospec_return_disable = !IS_ENABLED(EXPOLINE_FULL);
+int nospec_call_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
+int nospec_return_disable = !IS_ENABLED(CONFIG_EXPOLINE_FULL);
 
 static int __init nospectre_v2_setup_early(char *str)
 {
