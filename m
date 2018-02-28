Return-Path: <jinb.park7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519828156; cv=none;
        d=google.com; s=arc-20160816;
        b=FF8MOwQp4usc+rdP3R/AurIiy5sN0eSzenduof16j1HHxsF0bspKcnoU3kWIgR+u7K
         YXI4ehnxMilAZUypayCJOcxLqaB07tD8kerBIo15LPqu1F4DsHaF9EryxVKlH24DNfXe
         yqvx6gFFzjmT5vNm2ut+Lar8zitHzYcjK1rofppMeVYGQ4hDZWl9RNq4RafGMR/+rwvM
         WdqFUr3IeKR7y7Qsvw9h/E1YR42tFlcIJJ6kVrYsN4u0RR0O36MxHvc677q3HGTOM18/
         Bb6x3uVEdkuUeBxjnyhzA9qP1YISqPyeKdEzr+pFBhBOBOX2mMThGrUcRLkycwpqaKcH
         pgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=I5EOd8baM4xOCrqX0Jdbzj+xDF6hSR1De1lJ/u6E1Yo=;
        b=jt1mRSmBpAKOtNPFZBuVO93pG1Ef3tTODPOkWAqbgiwY9nXHmXW+KM3QVNJ0Y6aHmz
         wU4HAUPho1cq3VyrS6YEjcgg3N58yVSTCmAcaE/m7YJxqsps2DvgkOP5IhuFAGGMQK1b
         /q+aplDPmd2fuVVZo9vCtxiomNANRZzqHm+AszaMq1b0vGPVz6Iinz1CCwaEDbDnoxru
         h4xHdL6r2DhaugSNYdJjCnGTKRUK5NOq/Jp3Gkf/Gye1PKnAROekirsOU/VaBgraFDt3
         N3jgWpAxTYPyMTSGbwDSKdRcllazjVTcMECn6mG64gRCw48/5ouGlsGeftIxIVU38pNn
         0eBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jhdJtdjj;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jhdJtdjj;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224djG9NOR/9cV38TqUzs7tv69U6r933BaI2/QiVp8z6Tn2Urlnhykm92Ewt8yocz8r+3wdkZQ==
Date: Wed, 28 Feb 2018 23:29:09 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Cc: pombredanne@nexb.co, gregkh@linuxfoundation.org, tglx@linutronix.de,
	kstewart@linuxfoundation.org, luto@amacapital.net,
	dsafonov@virtuozzo.com, keescook@chromium.org, will.deacon@arm.com,
	mark.rutland@arm.com, danielmicay@gmail.com, arnd@arndb.de,
	catalin.marinas@arm.com
Subject: [kernel-hardening] [PATCH 0/2] arm: Add ARCH_HAS_FORTIFY_SOURCE
Message-ID: <20180228142909.GA3113@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593655329592806231?=
X-GMAIL-MSGID: =?utf-8?q?1593655329592806231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This patch series are to select ARCH_HAS_FORTIFY_SOUCE on arm.
A lot of architectures already select ARCH_HAS_FORTIFY_SOURCE
to support CONFIG_FORTIFY_SOURCE that detects overflows at compile-time.
(6974f0c4555e ("include/linux/string.h:
add the option of fortified string.h functions)
ARM can be built and run with CONFIG_FORTIFY_SOURCE.

Additionally, modify vdso.c to remove compile-error that happens
when built arm kernel with CONFIG_FORTIFY_SOURCE.

Jinbum Park (2):
  arm: mm: Define vdso_start, vdso_end as array
  arm: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE

 arch/arm/Kconfig            |  1 +
 arch/arm/include/asm/vdso.h |  2 --
 arch/arm/kernel/vdso.c      | 12 +++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

-- 
1.9.1
