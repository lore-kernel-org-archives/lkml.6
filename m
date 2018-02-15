Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226PHDy18pVgzdkQHh4BKDvuMUHdbtbTm2I7xmXNkKluYAJ5aEHnDCjDVZX/hbqqeBUS6k7t
ARC-Seal: i=1; a=rsa-sha256; t=1518709224; cv=none;
        d=google.com; s=arc-20160816;
        b=URojjDW8e9D4wXlDUhheHh3KEPsb1R5KJndt9AEIBH8U7BdVZJ5BMqgxeRJoSlmlfu
         C9lUyr/umyiH9Rwr/WKYAmP/tWSq1dvhvG6voaWcTSvvqEzH/V6Ef3qH+0w3cgu2XxLK
         y6Hk5OWQf23yYEd2zwyQvDGfLXz58mk4R3rvA9jNcFCqviDGAY2Wr5f0Q3fxSn8VNpaG
         lgoORoQmIf1WdRPRsimb23krTm0Zf+9GJMK+HrmWsWkc7BZ5Bgo2Lnt3C5sjqHSqhoJc
         iUGiJ6672ZSvsgHRYCGcXh+SUwmfptGWVuxIy64rHnvcvUAnC/Nfk2D3mzmp8YX+isyl
         C5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+q8gFu8yoA309Uj0I8Hw7p0zK94fLlIzo67gYpvZ/yU=;
        b=QTyAb9gUdyoGPAwN7WqX9/PXTzODs0o3neD6q+grgH8d+uout0UcnpuxByvE50IZN2
         hY6NL0hinHXek9rmxaY0Y9AB7vkImPDL27bFIUZpdjwPBHf5jKEgFtetwHJ+7UDYaEBY
         1ELTYTFZCCvGhyx7bsbs+oRuJo9D5Fc82TDCTnUzU6VbtgabGFC9eKulLdlKJW/d9huZ
         Mk9mz3RdshDkFe6SAx69SinXHpzgtf8kEEV/J5I0tKB72pFhtdhOW6rxrwT3PB+NbPVz
         hnrjuDVbzEfKqlKmXzhAvaEqbLA150hHiCfAekrSGC7LSJNiQidDqzV38x8I3J3PxITk
         Me5Q==
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
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 040/202] [Variant 3/Meltdown] arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
Date: Thu, 15 Feb 2018 16:15:40 +0100
Message-Id: <20180215151715.253396030@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481514543992610?=
X-GMAIL-MSGID: =?utf-8?q?1592482044171200905?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>


Commit 0d90718871fe upstream.

Add the older Broadcom ID as well as the new Cavium ID for ThunderX2
CPUs.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
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
