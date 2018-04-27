Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp07bDjTi+6KMlMzMbi8BrA1TDTINkmL+ZIArh62p3EZyMw7iKXtvsczO1dVmx5Q4V/KskT
ARC-Seal: i=1; a=rsa-sha256; t=1524837846; cv=none;
        d=google.com; s=arc-20160816;
        b=OjLFlPjcpDJD94VLez+MamtGt6hCmkGzizo4+ULJk4RTisRLJN0xbHSort6KeRhBi7
         Mn0rjUFdYE3lkmav6EgSKyTfw5FQDcj/Qm1v5ErOVywZSe86ItAQzb+QxCZyLE7x+HAx
         kpECkmNOJm2BQpPI3ri63XQ10V/Qrg21tQm2LWl+jtlYy30CI9HbScAVtGgMfDlMoI7a
         dwVuVc9uZwLM2HFLQlOkoB+ZnfUlBUT4cPb5oMe1U+pLPRm/mTEmrzeaeONH3oDZw+8V
         mtXf4RHJQ2IqnEOpWT9OxSnjzl42A6cXm6XxEczbhgTft8v4RAZYqRr8+IhaVm4doZk6
         6jqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=owVIk2/j3C9K7tip0eoqDTwZJXFlCPHy5+LyMSIIr20=;
        b=hVe+Bdu+tubSMiJmaoLR8SZ3TCs6KWIoBRCxK9A+i0fMK6pLtxuiV3BC9SrwTwQe//
         NP1op793e829bVRgY/1Jw6vir/qMf2fz8dNDUOQ7USy+hOZZol1jG0HSARYR9t2iTabS
         691VaMkO/qm1S9wmvidOuzEm1fmRlfZZX4djB6jvtr0zuL6KYntrMytbLD6nAR/lzrbz
         CCdr87LzszpqgrHO0L2bmeMzBxAA3gftAxuRbKlFznIb9MLtywS0UOeRGynyImqzkSTC
         I2K+p2wTFsuxf1gXEz5I4ywJ4+vNC2pWhRrfSH+BQwWi4V82uXSmIaUacyxsD5fuvSee
         QZcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFED721890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 4.9 38/74] s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_*)
Date: Fri, 27 Apr 2018 15:58:28 +0200
Message-Id: <20180427135711.508604985@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908176269129901?=
X-GMAIL-MSGID: =?utf-8?q?1598908369473616707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
