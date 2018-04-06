Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Neu0Sihf8Hfn+Y1ankvsMO9UZnTphqWXAjPvTddO+8BKqrHU+/2y72Oiv5XgNmntobus6
ARC-Seal: i=1; a=rsa-sha256; t=1523021834; cv=none;
        d=google.com; s=arc-20160816;
        b=i997tPNxkp4cxp78Z1hF/VdoUTIJhxx+EDOyJlomTTow5mUoZ6EjKjjvE7HbCbNH+4
         5MwUqIBQSjROIfURVbcYSLQ4hY41ctueTyAHQAIq3/tDCZal+cSz6Ml85riW5Uc3T7SG
         0yQcjrS+pTrQUlpCOortxEMT5KDneVh7JCd2WFR8uVym8u97oQ4WPI0fxo3axNlJA2xi
         QsWgNrf26I6rWNogmkpH+UfIouVUtXqWGN2khMNQ7U+KWFv6EAmsoXSa4M+U+L5XvGJh
         dm12E456IyrO1jWToSC0z2Gmv44OlCTWpjPjUtVbK6hp9zFtJOBPbXlE/xY1f75rgzbZ
         F2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nYicn7DikX0I//mPz5fzd8/YY0ZgyZq1uzrgEgxlHHA=;
        b=YE60ciAMwhiFTMoNaDVNM1ioS2hB+djDFtHnJOpW+DrqEw4StFStfHCvC5SLqtxA+7
         leiFK0sb426Zmjr5rmIsgEld0A09mQPenZcz6V8kRGj/u9z6s/TTcuoCNV2SG+uGTGc9
         JcZ507OzOIk/H58Up0g/wWGMS1JFYUEi/iDiNqTWbNtUQ3Hn8WyHGwaSHo3uvbojyfPz
         iFT4Fe+eoiGWogU7Q4VMR3f9pVqa4Tk+QeV3kf0vguudcthIFdy3XgDyqU3vGauEDNes
         4o7796t6J+4LTJJFHd/oMSuFAimpETgQdds7Ofb04WROeHyzoD49KHg1DgdzrF2UxAVf
         fiZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jayachandran C <jnair@caviumnetworks.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 070/102] arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
Date: Fri,  6 Apr 2018 15:23:51 +0200
Message-Id: <20180406084341.318303099@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004143267389340?=
X-GMAIL-MSGID: =?utf-8?q?1597004143267389340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>

commit 0d90718871fe upstream.

Add the older Broadcom ID as well as the new Cavium ID for ThunderX2
CPUs.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cputype.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -81,6 +81,7 @@
 
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 #define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
+#define CAVIUM_CPU_PART_THUNDERX2	0x0AF
 
 #define BRCM_CPU_PART_VULCAN		0x516
 
@@ -88,6 +89,8 @@
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
+#define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
+#define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
 
 #ifndef __ASSEMBLY__
 
