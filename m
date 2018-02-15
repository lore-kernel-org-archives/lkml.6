Return-Path: <lionel.debieve@st.com>
X-Google-Smtp-Source: AH8x224Eqf+bVDuHNT3/UxfZsaXpiDxS1ePJnx/MlsL86NXQSIdxyFJWCGT+Ji9dLUsFuzYLX99L
ARC-Seal: i=1; a=rsa-sha256; t=1518699814; cv=none;
        d=google.com; s=arc-20160816;
        b=blCFuesskYmxyhjtJQcpq8bhvuWCz5sqiFEcbQLo0o5KWTFQViBY0SZar9KDKR5u7P
         F0J7W6O8z8Jke0SwyFSqkcSn6qY8Op8WwRjO2kVRfwiJAF6i4/uSYk4cGdINFdGhE7FU
         wFyYgSWEwKyUga9GEczoiuizuQU+nwmTWDwKqCQVBQ+mMDQQaT6gHNhNZUE2KDS5z350
         u6gDQdx/QkoO/xaI6+bd7KpmTL0fOqRFRcl6lQWGkHS0qEe3Q9fqiHf9xmPZ2Y+zpzR+
         hvZqV4Q4FXgDesNusVybx4IcDrVicsPviLbpVSugLGGfIY88/zCkpulD4jerSyH5/9jl
         NLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=PGFcC4Jom+Z8b7sJLRkQfnaKgsostsSTCmLlw4rbVdk=;
        b=Mgdb9LNhX0cxwsY/FwC9MzJ3a9YBSnAykpfX6lGYPGTDDt3psIR1E5VXag65kSq/gY
         pr1RvE9O4vtowvvHb/R7u6RY8QGGdGQjufju62I62TL2EH6qSzmr/Rj4hpwlpoOEOmar
         onelzLrtfJHEb0vk9Sf8Ztw8lDHbNFFtINl9ECIWuUlT6Vpmd+LHhoG2IvhFDFEaaeMz
         Xm7WqLjrbs7PhGob5SMwMqDlylnVsh2QYn4WS7GhM9s1aVB9mXmy1qq14OIOX8K17Lo1
         wrDvNPMIlfdODKuZt1EsdSnNBvRpvyXJ1B/MHogMr/oMIBOVcu5Zg8lsn6hZzgZcZHnV
         FR1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lionel.debieve@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=lionel.debieve@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lionel.debieve@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=lionel.debieve@st.com
From: Lionel Debieve <lionel.debieve@st.com>
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring
	<rob.herring@linaro.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ludovic Barre
	<ludovic.barre@st.com>
Subject: [PATCH Resend 4/5] dt-bindings: rng: add clock detection error for stm32
Date: Thu, 15 Feb 2018 14:03:11 +0100
Message-ID: <20180215130312.23612-5-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215130312.23612-1-lionel.debieve@st.com>
References: <20180215130312.23612-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472176946703345?=
X-GMAIL-MSGID: =?utf-8?q?1592472176946703345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add optional property to enable the clock detection error
on rng block. It is used to allow slow clock source which
give correct entropy for rng.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 Documentation/devicetree/bindings/rng/st,stm32-rng.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/st,stm32-rng.txt b/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
index cb7ca78135ff..1dfa7d51e006 100644
--- a/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
+++ b/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
@@ -13,6 +13,7 @@ Required properties:
 
 Optional properties:
 - resets : The reset to properly start RNG
+- clock-error-detect : Enable the clock detection management
 
 Example:
 
-- 
2.15.1
