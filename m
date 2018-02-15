Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227KvUkwUik2XJ2B5cv6M8FXdpJ3el0WYFdB0PNK9p433YhaJb0jh140dB3+inXjmqKvkfBS
ARC-Seal: i=1; a=rsa-sha256; t=1518708773; cv=none;
        d=google.com; s=arc-20160816;
        b=ppMSXuIJwJYujNLiszy/Pnv8MOl2wse1IgdU/THgozu1sbic/XM/shTNTcvZbH3RBa
         +hIjyYrGUzROTQTnqCeFr4rCZTS3u7B8gAxdUxD4/rkywl96Dx0zeVQOcmBiiVNaNM4H
         mvx8BVZinyxkJjWb53viX9dBBxTo4WQbZTyOuXCqt/WNJS/XgbfY4NpC7D2DRBbuOCq+
         MQnA2cGaYiQ60K/0ujiUNhPbuYWIeS5fSdX2iSQqO97g8NGjKmtepocMfiOVBmKq5KmO
         pIjc3gPRq7HSaEkSfdTvYuVXntQy09UTdD8lM5G5w5Rrc3uOxk8k+vD+BEsCxUlyE2PK
         npSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fUu2rpCJ5eybf6B3/3is0kSOqNZ8nMky7P6baL7Y2/Y=;
        b=n4BAk214Y9ZMHkgID/RW5zHlzXx2HwENtQ9iDFrz7ZG+ON3FgcvPwxI4ynlq9QFb9n
         MraYCavDcT5zD+cHjfxQE+9zGht2MD9dd4lVA1XUXd17pDszyJCBWCMbl82WNsfbusCt
         dmK8OZDp4k7YqnZL+BnWa5i5K0rVADLo6yXqhbqr0k1VXKHZIJ6+sTfZtYtjl5j3Ra+a
         eESCQvZN63zk/v7wbrkAKOBnriX8ZkKpwEZsWS4GcLip6qe09dbOwMhYAoh+9dOgd0px
         DJukqhwEKgYWHLbFcdOCYbjud2qI5sYMuLPjQO35c8phftyrleB5/4jpoz29FiVSHnXf
         bexQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 075/195] [Variant 2/Spectre-v2] arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
Date: Thu, 15 Feb 2018 16:16:06 +0100
Message-Id: <20180215151709.455947320@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481570981857704?=
X-GMAIL-MSGID: =?utf-8?q?1592481570981857704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit a65d219fe5dc upstream.

Hook up MIDR values for the Cortex-A72 and Cortex-A75 CPUs, since they
will soon need MIDR matches for hardening the branch predictor.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
