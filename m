Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224bp8VoZTplynb1myKt+N2G7Zc7xGNl56Wn+LV8HN4VDnn1eDIQYCz3nDdskoBIh/fnloLi
ARC-Seal: i=1; a=rsa-sha256; t=1518708671; cv=none;
        d=google.com; s=arc-20160816;
        b=VmtBgXLDLkhVk4OntJR48ss8czpM7sKz0sTE0L48RMuriIv1ZCFoeBR4JnQ3f0ZlGa
         BDLvBaBhcHPnoqMc3E5m0RYsCsVdO8382h4SBk7v7hRphDiJBYtiU1i7Os9rOm4r99UD
         6qEgvb3fJTswCaD8xY11YMYmZTtKZSSwukNLhvTMXkxhvCUwpeMEvCbid25VugxhLBgM
         TW1zK4Dl2GKBbYk4PYyY3gEx34Shd9Fj5WynYRferAcHvSaKBBqIXuJRHtAQL5fBge41
         OabbsXgML95GRfUbGTU2Q08xm/0UsIeehjO+Cbjx9HUMNsegOTTMgyP40au463ocwnkp
         Gc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qNT09Q7PnG0TxpfKP02PcwY+HHjjst1N1GRJROGx4XM=;
        b=vsTtQDt0N0ihT3G+sbFxTIrAXgOwbFe21aPpY+94Rgbg7MUROKqXjL0qMn1nhDJrAe
         I9z9eI2E+V4uAAGNZ1zsry9Qwq/K2PYN8U1ArmjS1Fc6gQJGi6r8SlGKL3+hZ4MJmu0Y
         zWizWQRnpYp368jOF/EtFleWsnVtjOIDpMhoVB1NGArjmQJcJso7hDpERJs7ldb/eDEt
         Fq8G/H65+OMHy5evyXZkrV9zpqDH3/7/8up+iVcXp4h0WP530k0gL058sjulxWoh+XHf
         qLAE6pKk5kCSi2nQ6c889vt6iEele/qkhDzfenmVodq4Yc2FNapQpfsAnxF8DkR8qm3W
         oJOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Timur Tabi <timur@codeaurora.org>
Subject: [PATCH 4.14 010/195] arm64: Define cputype macros for Falkor CPU
Date: Thu, 15 Feb 2018 16:15:01 +0100
Message-Id: <20180215151706.265085527@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481463849630108?=
X-GMAIL-MSGID: =?utf-8?q?1592481463849630108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shanker Donthineni <shankerd@codeaurora.org>

commit c622cc013cece073722592cff1ac6643a33b1622 upstream.

Add cputype definition macros for Qualcomm Datacenter Technologies
Falkor CPU in cputype.h. It's unfortunate that the first revision
of the Falkor CPU used the wrong part number 0x800, got fixed in v2
chip with part number 0xC00, and would be used the same value for
future revisions.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/cputype.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -91,6 +91,7 @@
 #define BRCM_CPU_PART_VULCAN		0x516
 
 #define QCOM_CPU_PART_FALKOR_V1		0x800
+#define QCOM_CPU_PART_FALKOR		0xC00
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
@@ -99,6 +100,7 @@
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
+#define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
 
 #ifndef __ASSEMBLY__
 
