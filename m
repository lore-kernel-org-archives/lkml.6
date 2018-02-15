Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ctyBrCTRhbBr7IiXqIPe6eJYHRg8eUjtYH2kMyGM5uMi5BT0haglQpj72JNQ57QC6Fg/5
ARC-Seal: i=1; a=rsa-sha256; t=1518708719; cv=none;
        d=google.com; s=arc-20160816;
        b=q/4SRmMfqvBBAXAnUsWEQWXlbwLz+bQ7ClCjbq7d+Sq/jawQLS/fV5Stmv7OrF68OL
         /tvqiUILvyVCTlPmX780SDzMc5rUN4u9JiPJLSRryQDhsAI8nujuHty4QpSyxcOqfG1F
         zkkkfVe0rC1774SchKYyjstCaecWFiD596+7iCaxZwS+9Y3DULGxaOUO3mw0mMQNLxcv
         gIIpDyWU2ouem/gjHVYgNvYa/l4fxWEEWNo32F1VWB0rZamcMKcpaJ2MS3uIZ8azK4G1
         KPWbuEDjLwk1lqKik5kfgXHCmv24MsMJJNLdMAexSLkiR9mS3nQpIsif1xzssfgx1fmH
         YunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UerAKAiHtYecZSlLe+6AVyhsLsFNUs36FgwB5yKQQ8c=;
        b=A+TGWokshTJAgbpkOjYu6z9KZZ4s2VASBjhtDL8P42s55NeHtevNKbXmo8VlWpaHBG
         s7kyaM42d9GQSzFFLZ6uaWibbHSp9I48z/8d0ch/6FM64961e0ri3m8juM+qvo6OaFoc
         bIDDnZXZS6ib9KICjoLiJm4fSjR2n/CBA3nurLhqhS9yqxz8S1pm5qNVLmshzXsq3roa
         rbnuQ2oF/j9rps31+b0pHiI40pbVSdQhngNtIQEHCbWC84+34H1t7PfDMN6gWHA4sXmA
         Kq3LdvYXzVYl4/R/sht03ByTJl3Cr+KVbHhFaDzJdaF2Q+0txw1f8dHeFsk6uNGuhhro
         Y/Eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jayachandran C <jnair@caviumnetworks.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 048/195] [Variant 3/Meltdown] arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
Date: Thu, 15 Feb 2018 16:15:39 +0100
Message-Id: <20180215151708.133706586@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481514543992610?=
X-GMAIL-MSGID: =?utf-8?q?1592481514543992610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>


Commit 0d90718871fe upstream.

Add the older Broadcom ID as well as the new Cavium ID for ThunderX2
CPUs.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cputype.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -87,6 +87,7 @@
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 #define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
 #define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
+#define CAVIUM_CPU_PART_THUNDERX2	0x0AF
 
 #define BRCM_CPU_PART_VULCAN		0x516
 
@@ -100,6 +101,8 @@
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
+#define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
+#define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
 #define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
