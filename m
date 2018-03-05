Return-Path: <jinb.park7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520248637; cv=none;
        d=google.com; s=arc-20160816;
        b=OGfQQL706TyMTpJYAR1ImvWQNzaK5ctV8GL4h1JoP7M1RaZKNbgnCVBOqg28igtDHm
         02wypbh7BkkjcDjytWLrFlwb9aV4Mw0roZymf20q4q3AlF2v9DzujSyfbvTGNySJN5AK
         qdZ/RNv06WzRGbTkG8qJhfnyvGPisGOpGFY8DW0vSrAFgRHEGcNn15ReX+FNf33QNICV
         m7gRPcOBm+52yJfWmNPfJMufeCLkzztxbtuD0zJcXi0WNX1oxzHhgNNisvhhQaqlvjTX
         lUIzm4a31BRkMDep13s+C0MwqNbuiFATjR6GdHhm9zqipSVV287iKfrj7Usnse10k3cK
         GJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=AxCs+t8ha0dyC9MctSyNmsJg930VyANFbevM6d9RDb0=;
        b=pqYZLmIgDMRkmuJnztLJJw3SGp7/B5qBCvByUVIOjF4e9Csyllvbzl823eVM8NFb+w
         FuRdCtLjrcBe3AZJsyMI1sZlZutDE+xRga1IM/qieqhGyAQ+VMth2ArWxGY/A1HQCEfW
         liw2z4WqsfNhtJKjYHv1m+v2bVCxqP+/Lr5IoZZyeBMQsR/iTZMCHOL1/YTwr8tTu4v0
         ekTBL8BDA2OO2YSFcqK4VKH7wBraZfxUpA3d3GSz18gBI8gDY8VczG5fjp5M3f/UKsAG
         HxM8IzBccwMHvdQ3Au8RhZFd5YZlLto0E2nEy6255zjUSCUyegh7OdbXzivw+JcZBOlW
         JW5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ne9XRXQ3;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ne9XRXQ3;
       spf=pass (google.com: domain of jinb.park7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jinb.park7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuGNGdfWFL4PPNf/ucSf4aLPnffqTtgK0DQm0qcXqawYcANpmaXeXNVkFqhx9XGcsJG9zHBxA==
Date: Mon, 5 Mar 2018 20:17:08 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de,
	kstewart@linuxfoundation.org, luto@amacapital.net,
	dsafonov@virtuozzo.com, keescook@chromium.org, will.deacon@arm.com,
	mark.rutland@arm.com, danielmicay@gmail.com, arnd@arndb.de,
	catalin.marinas@arm.com
Subject: [PATCH v2 0/2] arm: Add ARCH_HAS_FORTIFY_SOURCE
Message-ID: <20180305111708.GA4156@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594096235248085597?=
X-GMAIL-MSGID: =?utf-8?q?1594096235248085597?=
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

v2 : 
Fix build error reported by kbuild test robot.
- Add fortify_panic() in arch/arm/boot/compressed/misc.c,
  because arch/arm/boot/compressed/* can't find that function.

Jinbum Park (2):
  arm: mm: Define vdso_start, vdso_end as array
  arm: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE

 arch/arm/Kconfig            |  1 +
 arch/arm/include/asm/vdso.h |  2 --
 arch/arm/kernel/vdso.c      | 12 +++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

-- 
1.9.1
