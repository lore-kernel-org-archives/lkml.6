Return-Path: <lionel.debieve@st.com>
X-Google-Smtp-Source: AIpwx48BCUq2q3amlC1AwQ7glGqjuZ+3dSmhiuAjAFZ5rhWpRKuV6kcfR8e3f4ldae8nMhEPTo0R
ARC-Seal: i=1; a=rsa-sha256; t=1524496272; cv=none;
        d=google.com; s=arc-20160816;
        b=Aae2nROl008LApua/WW8r/7qIVRsV3biBvDvqAh/APN3I69QS1xElxC/Wv/eAY9xj0
         Kk1xZDEyvINprnERBWKkKmAsrRjNXBHw3j/m7njioB5YYu2ERRRHMdIVMFA/KnNYL0Rp
         MjDEZ6kA2ptNDjAKYfVquMEpQPQt9kZyxp3OVQNkbVotgjB19O9L9qm0JLE0+PoUytTj
         dxiWdImCB3YZRiU54fNUjC0T/QGVoambvTINznxvXnkaqQ52FFAI6MoQre/sOSjDVC5d
         nSafcPaiTari121jqdTuHZKgR32gfGysVygXPGf7bYi7y/QrbReAnPcwLkWaNfBjBHL4
         kGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=QbxuvY1ru4B5tUSF45A36aqaMtilieCQ/G6NKamJVGc=;
        b=oXvQkGw0eXHlB/xKZlWctrAwqsIOVp8IVB/NYs4Jyv+FSucgH9zfYi+iQsCA0xkPZ7
         rn4HURW4jHsoQrcY86Sg2w3GiNARaZ6LYWixbPpvbzEkuY7XP7Fi+IKQX1qqHHnAiLMI
         K6jAJMMb43WsYC4Z/FBQaa89Rhl9S3E+COp0O5CY51UJd1INtwWfpeuREkvm9Znb8m4n
         ZNetHGSYqAdbCnyX8aczkTTFhi4aAeDxHplx7KrrGaXsI/PWX+P2Ef/PrO5qly0Yw390
         c8lBw+4pbIZR1ERy5jKmYLFZTuOhyjQsOFfa9I5HHsSn9nK/zDfDi+ENOV3FHEVvh3B8
         /lsQ==
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
Subject: [PATCH 1/2] hwrng: stm32 - define default state for rng driver
Date: Mon, 23 Apr 2018 17:04:25 +0200
Message-ID: <20180423150426.22198-2-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180423150426.22198-1-lionel.debieve@st.com>
References: <20180423150426.22198-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550203649884132?=
X-GMAIL-MSGID: =?utf-8?q?1598550203649884132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Define default state for stm32_rng driver. It will
be default selected with multi_v7_defconfig

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/char/hw_random/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index d53541e96bee..c34b257d852d 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -347,6 +347,7 @@ config HW_RANDOM_STM32
 	tristate "STMicroelectronics STM32 random number generator"
 	depends on HW_RANDOM && (ARCH_STM32 || COMPILE_TEST)
 	depends on HAS_IOMEM
+	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on STM32 microcontrollers.
-- 
2.15.1
