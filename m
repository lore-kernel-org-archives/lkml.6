Return-Path: <lionel.debieve@st.com>
X-Google-Smtp-Source: AIpwx49DWUpg8144F3eEMz1PWCDU9/AUsBommcleDs9aigLulTTOWChTCdO4YLFVcO9Uveqq14k0
ARC-Seal: i=1; a=rsa-sha256; t=1524496272; cv=none;
        d=google.com; s=arc-20160816;
        b=CuEDMh1iT7pcRbuVHElnpn8bgDzRG2e/vTKliZ/9XY8nwiLf2DZLnhxaUv1ZQ+0qnk
         rmL5iwWcWi1Nt0CiY+qewxowEFMpf9UpAb9GOSaoSP/jvjzV8MSINpCvC7DPiPlixOpj
         rNmEpUyCqoDZ5auCQSFQuktZSwPfEG63OoPek/yyovPNLOX6kLV2cCodZAFV2oIs+6dq
         KzMP5lX+3CCKmHR2FObttIFp0aQ3TTUjbx5UJb07ItwSLMDUFhHCOC7gq2AItJwtb4Ms
         XhsLeJwApcOTUFKpPTKgRs6QGsK+49fEmHUAFORudEZ1gBQgacsoNQBidrI/OcBnBZdN
         WecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UJsSytGSXZGMVxZ5XXHMWWlGHSiXJDwwRmRlv6CT4Eo=;
        b=JilAg4oHOkon0gL6I+dtWoRMUSVro4pSdU9/ZnayxSDAcbqQXGE2X7Y7+6sCCgIhni
         9qJTt1kLUBk057ktZ6LCRMzKmMWmsEucGQq1RuSYb1v26lLLa4vMhiMcVBbtY1xV7Ppr
         8vCvUSXQO1pXl73B2n+gfeEkmewWFZD6UqQfbtSg9XLxBGVwZ0Em3r8UjAWYM3M6x636
         DmLWxYgQdNFnBWQTvcbqJer7YU0HZg7VAqfUqz4NhaxSIpdYeSRxxUrnMRfrwfV6Nfsp
         HXbLJv2nYSSAWRqjJ0BbH0mVNQbNsuh65HkY8cdDbRrWpUsPTIL+AIE06W2aqDK1Glrt
         n7zw==
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
Subject: [PATCH 0/2] Fix stm32-rng for default state and suspend
Date: Mon, 23 Apr 2018 17:04:24 +0200
Message-ID: <20180423150426.22198-1-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550203771458980?=
X-GMAIL-MSGID: =?utf-8?q?1598550203771458980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series are fixing the default build state for stm32-rng that
activate the driver with arm multi_v7_defconfig.
Second patch is fixing the power suspend/resume behavior which was
not working.

Lionel Debieve (2):
  hwrng: stm32 - define default state for rng driver
  hwrng: stm32-rng: Fix pm_suspend issue

 drivers/char/hw_random/Kconfig     | 1 +
 drivers/char/hw_random/stm32-rng.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.15.1
