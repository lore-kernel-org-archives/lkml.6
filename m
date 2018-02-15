Return-Path: <lionel.debieve@st.com>
X-Google-Smtp-Source: AH8x227Quu9wpwSifFgEomJF3YiQwbkgyLWwzbKl0jXdT0vJzq9NMKrfJNEFpsjz3UixAxnLmWkb
ARC-Seal: i=1; a=rsa-sha256; t=1518699812; cv=none;
        d=google.com; s=arc-20160816;
        b=XOKzlJff9rygQ7w8KOVg+gtePF3i8Uisw9pr5kVZZhrYTFL1R7VyrgMJns5V3+s9fa
         ZwapTiMUgrtKSzjLnp1i1A99LzSgI/59SPYaG3JqSntxsjyv/qqq+yOJ7bk8al4BRuL6
         SH8Oi+wzwQh0eSjwcZgE/6zfIVAvWhj4pB9EZcQfflUuUswUd29yyPWzG0hzDju0XFmn
         8bcwzLHUMlcvkPjU2ZWAuTfnCSjo724RXg3kiZX/WnkhdbH1sQrDJI7+WWXbHwzKNkWR
         NwtmQDDeneMhSx94taUac6bBWeCGiGWG8Ti8yD9jelt7kIxtpsia4hPQpMj4TA8BtBEi
         E78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=8U5JYGpdslPWkF8KduHDtywIGODBeXJS5E1sFIdP6y0=;
        b=aGZ3bCYD5XtfecAu0MQ1VWI59DvyqAf41jLvD9rlrqNAivL01NYv7XsrsN1WodmSP3
         7CZrr+ix6zjzp2gNnneepdjnwc3XyljSpD2JycEu1zQ4B59zZg6FgKe18+EQdOgxt/7L
         NmHGlyCrd5BnWoXxd8QC2+ai0kM/kSOPL/OJN4pZ1Nr4zltmDCTRmwN2D/XnEyaKqsWA
         ojcGferjFnYy2gHPn6Wp7yyTvfqRCg1d/6n/Wi9jf2YwT7ud2ALmF8d2cefgKWQEEBVY
         TZWkfSx0g2VrIZn7drLpDWAvR8vqo5/puMPc0lJv3x2vaI3wCQFzhT5qdHdZpQOnlr0T
         A0xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lionel.debieve@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=lionel.debieve@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lionel.debieve@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=lionel.debieve@st.com
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
Subject: [PATCH Resend 2/5] dt-bindings: rng: add reset node for stm32
Date: Thu, 15 Feb 2018 14:03:09 +0100
Message-ID: <20180215130312.23612-3-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215130312.23612-1-lionel.debieve@st.com>
References: <20180215130312.23612-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472174803644404?=
X-GMAIL-MSGID: =?utf-8?q?1592472174803644404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding optional resets property for rng.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 Documentation/devicetree/bindings/rng/st,stm32-rng.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rng/st,stm32-rng.txt b/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
index 47f04176f93b..cb7ca78135ff 100644
--- a/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
+++ b/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
@@ -11,6 +11,9 @@ Required properties:
 - interrupts : The designated IRQ line for the RNG
 - clocks : The clock needed to enable the RNG
 
+Optional properties:
+- resets : The reset to properly start RNG
+
 Example:
 
 	rng: rng@50060800 {
-- 
2.15.1
