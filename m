Return-Path: <lionel.debieve@st.com>
X-Google-Smtp-Source: AH8x225Vetexk0vDpSLoorpJWnc8ws0ezcNOe9HcW5jktTwDCZ91UUa4SBPoKTM9He2JoOoh9gGz
ARC-Seal: i=1; a=rsa-sha256; t=1518699812; cv=none;
        d=google.com; s=arc-20160816;
        b=iGyhb0wZTK4oaU3qheErClod3H44s45z+abySLzVUjmdIBKHdOW54pwhWHcPtEeFzZ
         eFBYf2GiLtabpiIWubRb/9AqG2UlDfoUI+HmUjI8OyeVjzVaMyRzbUlynt5AjvZwsNJz
         AABmcLsxJ3pFYxAScGn+DITAGvBVuvCkuTGhfmOtA80WyV6jZQJ/ZPyo6sXDS1laIy4k
         9PP7PdVbpcywe5p2nOLPu5IrZhctzd7JhxTBF6hX1DKx8tSTZkQqSv6vnkTLrledAuC0
         hl4adcuEbTk6EBpVMKEEb/DaX3nANi6X6qpStiL1ixy0FQpJHBHG49+AfO4q+jJQ51MD
         eMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=j/XMjcIORc8yAi41cBwmi8vzYSfj9SsqNFF8IC++17w=;
        b=hsPaIVITovTKxsa9S8SXk7cNumyeFq4SbfAYANxXoqRZ6B9SLWanCRdQpKq1RWAExm
         IeBcXfQI0zxBlP9Xmiiq/V6+4eJ+f0K3L2KAr/3VU0uKv6uYop4vsXnRyU2/x9D8guX4
         KwATOy98V6xNvspgEoO7T9WEfH+eBkvSxOSG+Ot2z+7RcEAGkr1hDJ5imfMmgk545338
         pggPZbXsR/RQtHQZLvEGDF/aQ1+dh2u/I8lzEAv9BsRDrrSds/4boS5k6nu5aOk7m50A
         muX4pFg8JHk/WxIP0/zWDKMmvUsT24FVqM8aBHwdQBRS5enxteZfHcFyNBmXz5OfIgHI
         SVog==
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
Subject: [PATCH Resend 0/5] hwrng: stm32 - Improvement for stm32-rng 
Date: Thu, 15 Feb 2018 14:03:07 +0100
Message-ID: <20180215130312.23612-1-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472174804694074?=
X-GMAIL-MSGID: =?utf-8?q?1592472174804694074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This set of patches add extended functionalities for stm32 rng
driver.
Patch #1 includes a reset during probe to avoid any error status
which can occur during bootup process and keep safe rng integrity.

Patch #3 adds a new property to manage the clock error detection
feature which can be disabled on specific target.

Patch #5 rework the timeout calculation for read value that was
previously defined based on loop operation and is now based on
timer.

Lionel Debieve (5):
  hwrng: stm32 - add reset during probe
  dt-bindings: rng: add reset node for stm32
  hwrng: stm32 - allow disable clock error detection
  dt-bindings: rng: add clock detection error for stm32
  hwrng: stm32 - rework read timeout calculation

 .../devicetree/bindings/rng/st,stm32-rng.txt       |  4 ++
 drivers/char/hw_random/stm32-rng.c                 | 44 ++++++++++++++--------
 2 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.15.1
