Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224zDBAl6go7wHq5uuUZrJhhBv4Sd2BqJfKMdY2wbrvgqRlZAZOihmNfGQAjhU5c0ny6llLF
ARC-Seal: i=1; a=rsa-sha256; t=1518709300; cv=none;
        d=google.com; s=arc-20160816;
        b=unfVwVO0ze4qsUTiv/UvDf0IDuwKtFEAb/AALhTKTvphbq7J/gMDbD3rDvmJ/3yGfi
         Q46FtNWCUxrtHVOgYS7Coar4wDdNyF7pkcop7s51uEDDgbiECz+Vv5Obr+gdXCsNHpyZ
         9nJaSXgeymXbly0lwNgKnKTwX+HAHIVawk/zoSJSys8zOmwO0PAwF+wtzJFb4ShXiQJj
         yMZ810POte7D4ogb1i9mBHZfZvwGXHsahSuC5HJSvYq4ugKclVK+PDOEpqlop+s8Lsji
         sMxG4Si1LbvjX5JK0q87er1azJmTBIREBIw6ok36W4x8F0Sr067K4letfTWNAnwIjkOX
         SDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=W/aWI8I1t9zUECJPHuZQUAkvF0GtJTuqGeG8LVwFv2E=;
        b=rZQrlxFuhBpLRN0UfyJsX6p6l5CdQA6o9/eykc52E6qFjT81+QJd9LMBkM2IsoK6wO
         7eLdP+uecTkq6It8e/FylplGnJvJnrbT91X+VAMVp13biXCzCzkYU9eha3xAf8VAUVVH
         zY7CWrtFNJXmVWIHqGBJcD9y1rm2TGFopMnoH0QiSOUelsFDi/I5/2lYGSBlmwwU0mFB
         cnqkO3ZsmZ4V6hRacVtOCkVMDouJ5nmwlvDLFdck8ux8fGMlkf4xDXKnu4mxzhRVlrXo
         V+9mkGtwoeEuIOa9psPXX66tdvP+PIBxCt9LOFHRSr/Bzaf9mOh8f6qlTwm1t1jepOwN
         U6Ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 068/202] [Variant 2/Spectre-v2] arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
Date: Thu, 15 Feb 2018 16:16:08 +0100
Message-Id: <20180215151717.049519091@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481570981857704?=
X-GMAIL-MSGID: =?utf-8?q?1592482123720396348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit a65d219fe5dc upstream.

Hook up MIDR values for the Cortex-A72 and Cortex-A75 CPUs, since they
will soon need MIDR matches for hardening the branch predictor.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cputype.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -79,8 +79,10 @@
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
 #define ARM_CPU_PART_CORTEX_A57		0xD07
+#define ARM_CPU_PART_CORTEX_A72		0xD08
 #define ARM_CPU_PART_CORTEX_A53		0xD03
 #define ARM_CPU_PART_CORTEX_A73		0xD09
+#define ARM_CPU_PART_CORTEX_A75		0xD0A
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -97,7 +99,9 @@
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
+#define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
 #define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
+#define MIDR_CORTEX_A75 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A75)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
